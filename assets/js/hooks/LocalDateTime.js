import { updateLocalDateTimeHookElement } from '../date';

const LocalDateTime = {
  mounted() {
    updateLocalDateTimeHookElement(this.el);
  },

  updated() {
    updateLocalDateTimeHookElement(this.el);
  }
};

export default LocalDateTime;
