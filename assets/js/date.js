import format from "../vendor/small-date"

export function updateLocalDateTimeHookElement(el) {
  const date = new Date(el.getAttribute('datetime'));
  const targetedFormat = el.dataset.format;
  const container = el.firstElementChild;

  container.innerHTML = format(date, targetedFormat);
}

export function updateAllLocalDateTimeHookElements() {
  const elements = document.querySelectorAll('time[phx-hook="LocalDateTime"]');
  elements.forEach(updateLocalDateTimeHookElement);
}
