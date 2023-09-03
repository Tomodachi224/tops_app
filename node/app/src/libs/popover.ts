'use strict';

declare let bootstrap: any;

export function initPopover (): void {
  const popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));
  const options = {
    html: true,
    sanitize: false
  };
  popoverTriggerList.map(function (popoverTriggerEl) {
    return new bootstrap.Popover(popoverTriggerEl, options);
  });
}
