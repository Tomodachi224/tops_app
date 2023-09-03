'use strict';

declare let window: any;

export function initCarousel (ele: Element): void {
  window.jQuery(ele).each(function (index: number, _ele: Element) {
    const $bslider = window.jQuery(_ele);
    const options: any = {
      items: 1,
      nav: $bslider.data('nav'),
      navText: ['<i class="uil-arrow-left"></i>', '<i class="uil-arrow-right"></i>'],
      dots: $bslider.data('dots'),
      dotsEach: true,
      autoHeight: $bslider.data('auto-height'),
      loop: false,
      margin: $bslider.data('margin'),
      responsive: {
        0: { items: 1 },
        400: { items: 2 },
        600: { items: 3 },
        1000: { items: 5 }
      },
      stageClass: $bslider.data('stageclass')
    };
    if ($bslider.data('auto-width') === true) {
      options.autoWidth = $bslider.data('auto-width');
    }
    $bslider.owlCarousel(options);
  });
}
