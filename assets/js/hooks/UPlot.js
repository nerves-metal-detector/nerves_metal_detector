import uPlot from '../../vendor/uPlot';
import mergeDeep from '../util/mergeDeep';
import getTextWidth from '../util/getTextWidth';
import findInsertIndex from '../util/findInsertIndex';

const paths = uPlot.paths.stepped({align:  1});
const defaultChartOpts = {
  select: {
    show: true,
  },
  legend: {
    show: true,
    isolate: true,
  },
  focus: {
    alpha: 0.2,
  },
  cursor: {
    focus: {
      prox: 5,
    }
  },
  pxAlign: 0,
};
const defaultSeriesConfig = {
  spanGaps: true,
  width: 3,
  pxAlign: 0,
  paths,
};

const defaultXAxisValues = [
  // tick incr          default           year                               month    day                        hour     min             sec       mode
  [3600 * 24 * 365,   "{YYYY}",           null,                              null,    null,                      null,    null,           null,        1],
  [3600 * 24 * 28,    "{MMM}",            "\n{YYYY}",                        null,    null,                      null,    null,           null,        1],
  [3600 * 24,         "{MMM} {DD}",       "\n{YYYY}",                        null,    null,                      null,    null,           null,        1],
  [3600,              "{HH}:{mm}",        "\n{MMM} {DD}, {YYYY}",            null,    "\n{MMM} {DD}",            null,    null,           null,        1],
  [60,                "{HH}:{mm}",        "\n{MMM} {DD}, {YYYY}",            null,    "\n{MMM} {DD}",            null,    null,           null,        1],
  [1,                 ":{ss}",            "\n{MMM} {DD}, {YY}, {HH}:{mm}",   null,    "\n{MMM} {DD}, {HH}:{mm}", null,    "\n{HH}:{mm}",  null,        1],
  [0.001,             ":{ss}.{fff}",      "\n{MMM} {DD}, {YYYY}, {HH}:{mm}", null,    "\n{MMM} {DD}, {HH}:{mm}", null,    "\n{HH}:{mm}",  null,        1],
];
const defaultXLegendValueFormat = "{MMM} {DD}, {YYYY}, {HH}:{mm}:{ss}";

const UPlot = {
  mounted() {
    this.handleEvent(`uPlot:${this.el.id}:render_chart`, this.handleRenderChart.bind(this));
    this.handleEvent(`uPlot:${this.el.id}:new_data_set`, this.handleAddDataSet.bind(this));
    this.handleEvent(`uPlot:${this.el.id}:new_data_point`, this.handleAddDataPoint.bind(this));

    this.liveInterval = this.el.dataset['liveInterval'] ? Number(this.el.dataset['liveInterval']) : false;
    this.updateBuffer = [];
    this.zoom = undefined;
  },
  handleRenderChart(payload) {
    const chartOpts = payload.data.chart_opts || {};
    this.data = payload.data.data || [];

    let series = (chartOpts.series || []).map((s, i) => {
      s = mergeDeep(defaultSeriesConfig, s);

      if (i === 0 && !s.value) {
        s.value = defaultXLegendValueFormat;
      }

      if (i !== 0 && !s.value) {
        s.value = (self, value, seriesIdx, idx) => {
          return value !== null ? value : findPreviousValue(self, seriesIdx, idx);
        };
      }

      if (s.currency) {
        s.value = (self, value, seriesIdx, idx) => {
          value = value !== null ? value : findPreviousValue(self, seriesIdx, idx);

          const formatter = new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: s.currency,
          });
          return formatter.format(value);
        };
      }

      if (s.value_mapping) {
        s.value = (self, value, seriesIdx, idx) => {
          if (value === null && !s.value_mapping[value]) {
            return s.value_mapping[findPreviousValue(self, seriesIdx, idx)];
          }

          return s.value_mapping[value];
        };
      }

      return s;
    });
    delete chartOpts.series;

    let axes = (chartOpts.axes || [{}]).map((a, i) => {
      if (i === 0 && !a.values) {
        a.values = defaultXAxisValues;
      }

      if (i !== 0) {
        a.size = (self, vals, axisIdx) => {
          if (!vals) {
            return 0;
          }
          const longest = vals.reduce((acc, x) => {
            return Math.max(acc, (getTextWidth(x, self.axes[axisIdx].font[0]) / uPlot.pxRatio));
          }, 0);
          return Math.max(50, longest + 17 + 20)
        };
      }

      if (a.currency) {
        a.values = (self, vals) => {
          const formatter = new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: a.currency,
          });
          return vals.map(v => {
            return formatter.format(v);
          });
        };
      }

      return a;
    });
    delete chartOpts.axes;

    let opts = mergeDeep(
      defaultChartOpts,
      {
        id: `${this.el.id}-chart`,
        width: this.el.offsetWidth,
      },
      chartOpts,
      {
        series,
        axes,
      },
      {
        hooks: {
          init: [
            (chart) => {
              chart.over.ondblclick = e => {
                this.zoom = false;
              };
            },
          ],
          setSelect: [
            (chart) => {
              let min = chart.posToVal(chart.select.left, 'x');
              let max = chart.posToVal(chart.select.left + chart.select.width, 'x');

              if (this.zoom !== undefined) {
                this.zoom = {min, max};
                chart.setSelect({width: 0, height: 0}, false);
              } else {
                this.zoom = false;
              }
            },
          ],
        },
      },
    );

    if (this.updateBuffer.length > 0) {
      this.data  = this.updateBuffer.reduce((acc, {type, payload}) => {
        switch (type) {
          case 'addDataSet':
            return addDataSet(acc, payload);
          case 'addDataPoint':
            return addDataPoint(acc, payload, series);
        }
      }, this.data);

      this.updateBuffer = [];
    }

    this.el.innerHTML = "";
    this.chart = new uPlot(opts, this.data, this.el);

    this.destroyResizeObserver();
    this.createResizeObserver(chartOpts.height || 300);
    this.startLiveUpdate();
  },
  handleAddDataSet(payload) {
    if (!this.chart && !this.data) {
      this.updateBuffer.push({
        type: "addDataSet",
        payload,
      });
      return;
    }

    const newData = addDataSet(this.data, payload);

    this.setData(newData);
  },
  handleAddDataPoint(payload) {
    if (!this.chart && !this.data) {
      this.updateBuffer.push({
        type: "addDataPoint",
        payload,
      });
      return;
    }

    const newData = addDataPoint(this.data, payload, this.chart.series);

    this.setData(newData);
  },
  setData(newData) {
    this.data = newData;
    if (this.chart) {
      if (this.liveInterval !== false) {
        const ts = (new Date()).getTime() / 1000;

        const updatedData = newData.map((s, i) => {
          if (i === 0) {
            return [...s, ts];
          }

          return [...s, null];
        });
        this.chart.setData(updatedData);
      } else {
        this.chart.setData(newData);
      }

      if (this.zoom) {
        this.chart.setScale('x', this.zoom);
        this.chart.setSelect({width: 0, height: 0}, false);
      }
    }
  },
  createResizeObserver(height) {
    this.chartResizeObserver = new ResizeObserver(entries => {
      if (this.chart) {
        this.chart.setSize({
          width: this.el.offsetWidth,
          height: height,
        });
      }
    });

    this.chartResizeObserver.observe(this.el);
  },
  destroyResizeObserver() {
    if (this.chartResizeObserver) {
      this.chartResizeObserver.disconnect();
    }
  },
  startLiveUpdate() {
    if (this.liveInterval !== false) {
      this.liveRef = setInterval(() => {
        this.setData(this.data);
      }, this.liveInterval);
      window.requestAnimationFrame(() => {
        this.setData(this.data);
      });
    }
  },
  stopLiveUpdate() {
    if (this.liveRef) {
      clearInterval(this.liveRef)
      this.liveRef = undefined;
    }
  },
  destroyed() {
    this.destroyResizeObserver();
    this.stopLiveUpdate();
  },
};

function addDataSet(data, payload) {
  const [newTimestamp, ...newValueList] = payload.data;
  let [timestamps, ...values] = data;

  if (timestamps.includes(newTimestamp)) {
    // replacement
    const replaceIndex = timestamps.findIndex(x => x === newTimestamp);
    const newValues = values;
    newValues.forEach((v, i) => {
      v[replaceIndex] = newValueList[i];
    })

    return [
      timestamps,
      ...newValues,
    ];
  }

  if (timestamps.length === 0 || timestamps[timestamps.length - 1] < newTimestamp) {
    // append
    return [
      [...timestamps, newTimestamp],
      ...values.map((v, index) => ([...v, newValueList[index]])),
    ];
  }

  // inject at proper position
  const insertIndex = findInsertIndex(timestamps, newTimestamp);
  return [
    [...timestamps.slice(0, insertIndex), newTimestamp, ...timestamps.slice(insertIndex)],
    ...values.map((v, index) => ([...v.slice(0, insertIndex), newValueList[index], ...v.slice(insertIndex)])),
  ];
}
function addDataPoint(data, payload, chartSeries) {
  const targetSeries = payload.data.series;
  const targetIndex = chartSeries.findIndex(
    (s) => s.id === targetSeries || s.label === targetSeries
  ) - 1; // we don't care about the timestamp list, so we subtract 1 from the index
  if(targetIndex < 0) {
    return data;
  }

  const newTimestamp = payload.data.timestamp;
  const newValue = payload.data.value;

  let [timestamps, ...values] = data;

  if (timestamps.includes(newTimestamp)) {
    // replacement
    const replaceIndex = timestamps.findIndex(x => x === newTimestamp);
    const newValues = values;
    newValues[targetIndex][replaceIndex] = newValue;

    return [
      timestamps,
      ...newValues,
    ];
  }

  if (timestamps.length === 0 || timestamps[timestamps.length - 1] < newTimestamp) {
    // append
    return [
      [...timestamps, newTimestamp],
      ...values.map((v, index) => {
        if (index === targetIndex) {
          return [...v, newValue];
        }
        return [...v, null];
      }),
    ];
  }

  // inject at proper position
  const insertIndex = findInsertIndex(timestamps, newTimestamp);
  return [
    [...timestamps.slice(0, insertIndex), newTimestamp, ...timestamps.slice(insertIndex)],
    ...values.map((v, index) => {
      if (index === targetIndex) {
        return [...v.slice(0, insertIndex), newValue, ...v.slice(insertIndex)];
      }
      return [...v.slice(0, insertIndex), null, ...v.slice(insertIndex)];
    }),
  ];
}
function findPreviousValue(chart, seriesIdx, idx) {
  let searchIndex = idx - 1;
  let lastValue = null;

  while (searchIndex >= 0 && lastValue === null) {
    const v = chart.data[seriesIdx][searchIndex];

    searchIndex = searchIndex - 1;
    lastValue = v;
  }

  return lastValue;
}

export default UPlot;
