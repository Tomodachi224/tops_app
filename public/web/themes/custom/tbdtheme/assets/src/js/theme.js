;
(function ($) {
  'use strict';
  var theme = {
    /**
     * Theme's components/functions list
     * Comment out or delete the unnecessary component.
     * Some components have dependencies (plugins).
     * Do not forget to remove dependency from src/js/vendor/ and recompile it.
    */
    init: () => {
      theme.stickyHeader();
      theme.sticksy();
      theme.dropdownAnimation();
      theme.headerButtons();
      theme.isotope();
      theme.onepageHeaderOffset();
      theme.onepageNavLinks();
      theme.anchorSmoothScroll();
      theme.svgInject();
      theme.backgroundImage();
      theme.backgroundImageMobile();
      theme.backgroundVideo();
      theme.imageHoverOverlay();
      theme.rellax();
      theme.scrollCue();
      theme.showMoreItems();
      theme.owlCarousel();
      theme.heroSlider();
      theme.animatedCaptions();
      theme.lightGallery();
      theme.plyr();
      theme.progressBar();
      theme.pageProgressForLanding();
      theme.pageProgress();
      theme.pageLoading();
      theme.counterUp();
      theme.bsCollapseRelative();
      theme.closeCollpaseWhenClickOutside();
      theme.bsTooltips();
      theme.bsPopovers();
      theme.bsModal();
      theme.iTooltip();
      theme.greenSock();
      theme.dotNavForLanding();
      theme.sTooltip();
      theme.checkCountrySelectionForButtonDDL();
      theme.onCountryDDLChange();
      theme.simulatorBtns();
    },
    /**
     * Sticky Header
     * Enables sticky behavior on navigation on page scroll
     * Requires assets/js/vendor/headhesive.min.js
    */
    stickyHeader: () => {
      if ($('.navbar-sticky').length) {
        var options = {
          offset: 350,
          offsetSide: 'top',
          classes: {
            clone: 'banner--clone fixed ',
            stick: 'banner--stick',
            unstick: 'banner--unstick'
          },
          onStick: function () {
            $($.SmartMenus.Bootstrap.init);
            var $language_dropdown = $('.navbar:not(.fixed) .language-select .dropdown-menu');
            $language_dropdown.removeClass('show');
          },
          onUnstick: function () {
            var $language_sticky_dropdown = $('.navbar.fixed .language-select .dropdown-menu');
            $language_sticky_dropdown.removeClass('show');
          }
        };
        new Headhesive('.navbar-sticky', options);
      }
      $(function () {
        $('.navbar .navbar-nav:not(.navbar-nav-other)').bind({
          'show.smapi': function (e, menu) {
            $(menu).removeClass('hide-animation').addClass('show-animation');
          },
          'hide.smapi': function (e, menu) {
            $(menu).removeClass('show-animation').addClass('hide-animation');
          }
        }).on('animationend webkitAnimationEnd oanimationend MSAnimationEnd', 'ul', function (e) {
          $(this).removeClass('show-animation hide-animation');
          e.stopPropagation();
        });
      });
    },

    /**
     * sticksy
     * Enables sticky behavior on element
     * Requires assets/js/vendor/sticksy.min.js
    */
    sticksy: () => {
      if ($('.sticky-element').length) {
        var options = {
          listen: true,
          topSpacing: 40,
        };
        var stickyEl = new Sticksy('.sticky-element', options);
        stickyEl.refresh();
        stickyEl.onStateChanged = function (state) {
          if (state === 'fixed') stickyEl.nodeRef.classList.add('widget--sticky')
          else stickyEl.nodeRef.classList.remove('widget--sticky')
        }
      }
    },

    /**
     * Dropdown Animation
     * Adds a custom animation to dropdown menus
    */
    dropdownAnimation: () => {
      $('.navbar .navbar-nav:not(.navbar-nav-other)').bind({
        'show.smapi': function (e, menu) {
          $(menu).removeClass('hide-animation').addClass('show-animation');
        },
        'hide.smapi': function (e, menu) {
          $(menu).removeClass('show-animation').addClass('hide-animation');
        }
      }).on('animationend webkitAnimationEnd oanimationend MSAnimationEnd', 'ul', function (e) {
        $(this).removeClass('show-animation hide-animation');
        e.stopPropagation();
      });
    },
    /**
     * Header Buttons
     * Open/close offcanvas menus on click of header buttons
    */
    headerButtons: () => {
      var $header_hamburger = $('.hamburger.animate');
      var $language_select = $('.language-select .dropdown-menu');
      var $navbar_offcanvas = $('.offcanvas-nav');
      var $navbar_offcanvas_toggle = $('[data-toggle="offcanvas-nav"]');
      var $navbar_offcanvas_close = $('.offcanvas-nav-close');
      var $info_offcanvas = $('.offcanvas-info');
      var $info_offcanvas_close = $('.offcanvas-info-close');
      var $info_offcanvas_toggle = $('[data-toggle="offcanvas-info"]');
      $header_hamburger.on("click", function () {
        $header_hamburger.toggleClass("active");
      });
      $navbar_offcanvas_toggle.on("click", function (e) {
        e.stopPropagation();
        $navbar_offcanvas.toggleClass('open');
      });
      $navbar_offcanvas.on("click", function (e) {
        e.stopPropagation();
      });
      $navbar_offcanvas_close.on("click", function (e) {
        $navbar_offcanvas.removeClass('open');
        $header_hamburger.removeClass('active');
      });
      $info_offcanvas_toggle.on("click", function (e) {
        e.stopPropagation();
        $info_offcanvas.toggleClass('open');
      });
      $info_offcanvas.on("click", function (e) {
        e.stopPropagation();
      });
      $(document).on('click', function () {
        $navbar_offcanvas.removeClass('open');
        $info_offcanvas.removeClass('open');
        // $header_hamburger.removeClass('active');
      });
      $info_offcanvas_close.on("click", function (e) {
        $info_offcanvas.removeClass('open');
      });
      $('.onepage .navbar li a.scroll').on('click', function () {
        $navbar_offcanvas.removeClass('open');
        $header_hamburger.removeClass('active');
      });
    },
    /**
     * Isotope
     * Enables isotope grid layout and filtering
     * Requires assets/js/vendor/isotope.pkgd.min.js
     * Requires assets/js/vendor/imagesloaded.pkgd.min.js
    */
    isotope: () => {
      // for each container
      $('.grid').each(function (i, gridContainer) {
        var $gridContainer = $(gridContainer);
        // init isotope for container
        var $grid = $gridContainer.find('.isotope').imagesLoaded(function () {
          $grid.isotope({
            itemSelector: '.item',
            layoutMode: 'masonry',
            percentPosition: true,
            masonry: {
              columnWidth: $grid.width() / 12
            },
            transitionDuration: '0.7s'
          })
        });
        $(window).resize(function () {
          $grid.isotope({
            masonry: {
              columnWidth: $grid.width() / 12
            }
          });
        });
        $(window).on("load", function () {
          $grid.isotope({
            masonry: {
              columnWidth: $grid.width() / 12
            }
          });
        });
        // initi filters for container
        $gridContainer.find('.isotope-filter').on('click', 'a', function () {
          var filterValue = $(this).attr('data-filter');
          $grid.isotope({
            filter: filterValue
          });
        });
      });
      $('.isotope-filter').each(function (i, buttonGroup) {
        var $buttonGroup = $(buttonGroup);
        $buttonGroup.on('click', 'a', function () {
          $buttonGroup.find('.active').removeClass('active');
          $(this).addClass('active');
        });
      });
    },
    /**
     * Onepage Header Offset
     * Adds an offset value to anchor point equal to sticky header height on a onepage
    */
    onepageHeaderOffset: () => {
      var header_height = $('.navbar:not(.banner--clone)').outerHeight();
      var shrinked_header_height = 75;
      var shrinkedStyle = {
        'padding-top': '' + shrinked_header_height + 'px',
        'margin-top': '-' + shrinked_header_height + 'px'
      };
      $('.onepage section').css(shrinkedStyle);
      var unshrinkedStyle = {
        'padding-top': '' + header_height + 'px',
        'margin-top': '-' + header_height + 'px'
      };
      $('.onepage section:first-of-type').css(unshrinkedStyle);
    },
    /**
     * Onepage Nav Links
    */
    onepageNavLinks: () => {
      var empty_a = $('.onepage .navbar ul.navbar-nav a[href="#"]');
      empty_a.on('click', function (e) {
        e.preventDefault();
      });
    },
    /**
     * Anchor Smooth Scroll
     * Adds smooth scroll animation to links with .scroll class
     * Requires assets/js/vendor/smoothscroll.js
     */
    anchorSmoothScroll: function () {
      const header_height = document.querySelector('.navbar').offsetHeight;
      const links = document.querySelectorAll('.scroll');
      for (const link of links) {
        link.addEventListener('click', clickHandler);
      }
      function clickHandler(e) {
        e.preventDefault();
        this.blur();
        const href = this.getAttribute('href');
        const offsetTop = getOffsetTop(document.querySelector(href)) - 100;
        document.getElementById(href.replace('#', '')).scrollIntoView({
          behavior: 'smooth'
        });
      }
      function getOffsetTop(e) {
        let offsetTop = 0;
        while (e) {
          offsetTop += e.offsetTop;
          e = e.offsetParent;
        }
        return offsetTop;
      }

      document.querySelectorAll('.scroll').forEach((item) => {
        const i = item.getAttribute('href');
        const e = document.getElementById(i.replace('#', ''));
        if (!i || !e) return;

        // Up case
        new Waypoint({
          element: document.getElementById(i.replace('#', '')),
          handler: function (direction) {
            if (direction === 'up') {
              document.querySelectorAll('.scroll.highlight[href="' + i + '"]').forEach((tt) => {
                document.querySelectorAll('.scroll.highlight').forEach((i1) => {
                  i1.classList.remove('active');
                  i1.parentNode.classList.remove('active');
                });
                tt.classList.add('active');
                tt.parentNode.classList.add('active');
              });
            }
          },
          offset: 84
        });

        // Down case
        new Waypoint({
          element: document.getElementById(i.replace('#', '')),
          handler: function (direction) {
            if (direction === 'down') {
              document.querySelectorAll('.scroll.highlight[href="' + i + '"]').forEach((tt) => {
                document.querySelectorAll('.scroll.highlight').forEach((i1) => {
                  i1.classList.remove('active');
                  i1.parentNode.classList.remove('active');
                });
                tt.classList.add('active');
                tt.parentNode.classList.add('active');
              });
            }
          },
          offset: 85
        });
      });
    },
    /**
     * SVGInject
     * Replaces an img element with an inline SVG so you can apply colors to your SVGs
     * Requires assets/js/vendor/svg-inject.min.js
    */
    svgInject: () => {
      SVGInject(document.querySelectorAll("img.svg-inject"));
    },
    /**
     * Background Image
     * Adds a background image link via data attribute "data-image-src"
    */
    backgroundImage: () => {
      $(".bg-image").css('background-image', function () {
        var bg = ('url(' + $(this).data("image-src") + ')');
        return bg;
      });
    },
    /**
     * backgroundImageMobile
     * Adds .mobile class to background images on mobile devices for styling purposes
    */
    backgroundImageMobile: () => {
      var isMobile = (navigator.userAgent.match(/Android/i) || navigator.userAgent.match(/webOS/i) || navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPad/i) || (navigator.platform === 'MacIntel' && navigator.maxTouchPoints > 1) || navigator.userAgent.match(/iPod/i) || navigator.userAgent.match(/BlackBerry/i)) ? true : false;
      if (isMobile) {
        $('.image-wrapper').addClass('mobile');
      }
    },
    /**
     * Background Video
     * Turns an HTML5 video into a background, scaling to aspect ratio.
    */
    backgroundVideo: () => {
      $('.video-wrapper video').backgroundVideo({
        $outerWrap: $('.video-wrapper'),
        pauseVideoOnViewLoss: false,
        parallaxOptions: {
          effect: 6
        }
      });
    },
    /**
     * Image Hover Overlay
     * Adds span.bg inside .overlay for simpler markup and styling purposes
    */
    imageHoverOverlay: () => {
      $('.overlay:not(.caption) > a, .overlay:not(.caption) > span').prepend('<span class="bg"></span>');
    },
    /**
     * Rellax.js
     * Adds parallax animation to shapes and elements
     * Requires assets/js/vendor/rellax.min.js
    */
    rellax: () => {
      if ($(".rellax").length) {
        window.onload = function () {
          var rellax = new Rellax('.rellax', {
            speed: 2,
            center: true,
            breakpoints: [576, 992, 1201]
          });
          $('.projects-overflow').imagesLoaded(function () {
            rellax.refresh();
          });
        }
      }
    },
    /**
     * scrollCue.js
     * Enables showing elements by scrolling
     * Requires assets/js/vendor/scrollCue.min.js
    */
    scrollCue: () => {
      scrollCue.init({
        interval: -400,
        duration: 700,
        percentage: 0.8
      });
      scrollCue.update();
    },
    /**
     * Show More Items
     * Loads more elements for lists
     * Requires assets/js/vendor/showMoreItems.min.js
    */
    showMoreItems: () => {
      $('.show-more').each(function () {
        var $showmore = $(this);
        $showmore.showMoreItems({
          startNum: $showmore.data("showstart"),
          afterNum: $showmore.data("showafter"),
          moreText: 'Show More',
          after: function () {
            theme.isotope();
            theme.rellax();
            theme.scrollCue();
          }
        });
      });
    },
    /**
     * Owl Carousel
     * Creates carousel sliders
     * Requires assets/js/vendor/owl.carousel.min.js
    */
    owlCarousel: () => {
      $('.basic-slider').each(function () {
        var $bslider = $(this);
        $bslider.owlCarousel({
          items: 1,
          nav: $bslider.data("nav"),
          navText: ["<i class='uil-arrow-left'></i>", "<i class='uil-arrow-right'></i>"],
          dots: $bslider.data("dots"),
          dotsEach: true,
          autoHeight: true,
          loop: true,
          margin: $bslider.data("margin"),
          responsive: {
            0: {
              items: 1
            },
            600: {
              items: 3
            },
            1000: {
              items: 5
            }
          }
        });
      });
      $('.carousel').each(function () {
        var $carousel = $(this);
        $carousel.owlCarousel({
          autoHeight: false,
          nav: $carousel.data("nav"),
          navText: ["<i class='uil-arrow-left'></i>", "<i class='uil-arrow-right'></i>"],
          dots: $carousel.data("dots"),
          dotsEach: true,
          loop: $carousel.data("loop"),
          margin: $carousel.data("margin"),
          autoplay: $carousel.data("autoplay"),
          autoplayTimeout: $carousel.data("autoplay-timeout"),
          responsive: $carousel.data("responsive")
        });
      });
    },
    /**
     * Hero Slider
     * Creates hero sliders with animated captions
     * Requires assets/js/vendor/owl.carousel.min.js
    */
    heroSlider: () => {
      $('.hero-slider').each(function () {
        var $hslider = $(this);
        $hslider.owlCarousel({
          items: 1,
          nav: $(this).data("nav"),
          navText: ["<i class='uil-arrow-left'></i>", "<i class='uil-arrow-right'></i>"],
          dots: $(this).data("dots"),
          dotsEach: true,
          autoHeight: false,
          loop: true,
          autoplay: $hslider.data("autoplay"),
          autoplayTimeout: 5000,
          onInitialized: function () {
            $hslider.trigger('stop.owl.autoplay');
            setTimeout(function () { $hslider.trigger('play.owl.autoplay') }, 3000)
          },
          autoplayHoverPause: true,
          margin: 0,
          animateIn: 'fadeIn',
          animateOut: 'fadeOut'
        });
        $hslider.on("changed.owl.carousel", e => {
          $(".owl-item.active").find(".animated-caption").each(function (index, value) {
            $(this).removeClass("animate__animated").removeClass($(this).data("anim"));
          });
          var $currentOwlItem = $(".owl-item").eq(e.item.index);
          $currentOwlItem.find(".animated-caption").each(function (index, value) {
            var a = $(this).data("anim-delay");
            var b = $(this).data("anim-duration");
            $(this).addClass("animate__animated").addClass($(this).data("anim")).css({
              "animation-delay": a + "ms",
              "animation-duration": b + "ms"
            });
          });
        });
        $hslider.trigger("refresh.owl.carousel");
      });
    },
    /**
     * Animated Captions
     * Enables data attributes "data-anim-delay" and "data-anim-duration" for .animated-caption
     * Requires assets/css/vendor/animate.css
    */
    animatedCaptions: () => {
      var $animatedCaptions = $(".animated-captions");
      $animatedCaptions.find(".animated-caption").each(function () {
        var a = $(this).data("anim-delay");
        var b = $(this).data("anim-duration");
        $(this).addClass("animate__animated").addClass($(this).data("anim")).css({
          "animation-delay": a + "ms",
          "animation-duration": b + "ms"
        });
      });
    },
    /**
     * Lightgallery
     * Enables lightbox functionality
     * Requires assets/js/vendor/lightgallery.min.js
    */
    lightGallery: () => {
      var $lg = $('.light-gallery-wrapper');
      $lg.lightGallery({
        thumbnail: false,
        selector: '.lightbox',
        mode: 'lg-fade',
        download: false,
        autoplayControls: false,
        zoom: false,
        fullScreen: false,
        videoMaxWidth: '1000px',
        loop: false,
        counter: false,
        hash: false,
        closable: true,
        mousewheel: true,
        videojs: true,
        videoAutoplay: true,
        share: false
      });
    },
    /**
     * Plyr
     * Enables media player
     * Requires assets/js/vendor/plyr.js
    */
    plyr: () => {
      var players = Plyr.setup('.player', {
        loadSprite: true,
      });
    },
    /**
     * Progressbar
     * Enables animated progressbars
     * Requires assets/js/vendor/progressbar.min.js
    */
    progressBar: () => {
      var $pline = $('.progressbar.line');
      $pline.each(function (i) {
        var line = new ProgressBar.Line(this, {
          strokeWidth: 3,
          trailWidth: 3,
          duration: 3000,
          easing: 'easeInOut',
          text: {
            style: {
              color: 'inherit',
              position: 'absolute',
              right: '0',
              top: '-30px',
              padding: 0,
              margin: 0,
              transform: null
            },
            autoStyleContainer: false
          },
          step: function (state, line, attachment) {
            line.setText(Math.round(line.value() * 100) + ' %');
          }
        });
        var value = ($(this).attr('data-value') / 100);
        $pline.waypoint(function () {
          line.animate(value);
        }, {
          offset: '100%'
        })
      });
    },
    /**
     * Page Progress
     * Shows page progress on the bottom right corner of pages
     */
    pageProgress: function () {
      var progressWrap = document.querySelector('.progress-wrap');
      var progressPath = document.querySelector('.progress-wrap path');
      var sidenav = document.querySelector('.side-nav');
      var offset = 50;
      if (progressWrap != null) {
        var pathLength = progressPath.getTotalLength();
        progressPath.style.transition = progressPath.style.WebkitTransition = 'none';
        progressPath.style.strokeDasharray = pathLength + ' ' + pathLength;
        progressPath.style.strokeDashoffset = pathLength;
        progressPath.getBoundingClientRect();
        progressPath.style.transition = progressPath.style.WebkitTransition = 'stroke-dashoffset 10ms linear';
        window.addEventListener('scroll', function (event) {
          var scroll = document.body.scrollTop || document.documentElement.scrollTop;
          var height = document.documentElement.scrollHeight - document.documentElement.clientHeight;
          var progress = pathLength - (scroll * pathLength) / height;
          progressPath.style.strokeDashoffset = progress;
          var scrollElementPos = document.body.scrollTop || document.documentElement.scrollTop;
          if (scrollElementPos >= offset) {
            progressWrap.classList.add('active-progress');
            if (sidenav) sidenav.classList.add('active');
          } else {
            progressWrap.classList.remove('active-progress');
            if (sidenav) sidenav.classList.remove('active');
          }
        });
        progressWrap.addEventListener('click', function (e) {
          e.preventDefault();
          window.scroll({
            top: 0,
            left: 0,
            behavior: 'smooth',
          });
        });
      }
    },
    pageProgressForLanding: function () {
      const parent = document.querySelector('.magnet');
      if (parent) {
        var progressWrap = document.querySelector('.progress-wrap');
        var progressPath = document.querySelector('.progress-wrap path');
        var sidenav = document.querySelector('.side-nav');
        var offset = 50;
        if (progressWrap != null) {
          var pathLength = progressPath.getTotalLength();
          progressPath.style.transition = progressPath.style.WebkitTransition = 'none';
          progressPath.style.strokeDasharray = pathLength + ' ' + pathLength;
          progressPath.style.strokeDashoffset = pathLength;
          progressPath.getBoundingClientRect();
          progressPath.style.transition = progressPath.style.WebkitTransition = 'stroke-dashoffset 10ms linear';
          parent.addEventListener('scroll', function (event) {
            var scroll = parent.scrollTop;
            var height = parent.scrollHeight - parent.clientHeight;
            var progress = pathLength - (scroll * pathLength) / height;
            progressPath.style.strokeDashoffset = progress;
            var scrollElementPos = parent.scrollTop
            if (scrollElementPos >= offset) {
              progressWrap.classList.add('active-progress');
              if (sidenav) sidenav.classList.add('active');
            } else {
              progressWrap.classList.remove('active-progress');
              if (sidenav) sidenav.classList.remove('active');
            }
          });
          progressWrap.addEventListener('click', function (e) {
            e.preventDefault();
            parent.scroll({
              top: 0,
              left: 0,
              behavior: 'smooth',
            });
          });
        }
      }
    },
    /**
     * Page Loading
     */
    pageLoading: () => {
      $('.page-loading').delay(350).fadeOut('slow');
      $('.page-loading .status').fadeOut('slow');
    },
    /**
     * Counter Up
     * Counts up to a targeted number when the number becomes visible
     * Requires assets/js/vendor/counterup.min.js
     * Requires assets/js/vendor/jquery.waypoints.min.js
    */
    counterUp: () => {
      var counterUp = window.counterUp["default"]; // import counterUp from "counterup2"
      var $counters = $(".counter");
      /* Start counting, do this on DOM ready or with Waypoints. */
      $counters.each(function (ignore, counter) {
        var waypoint = new Waypoint({
          element: $(this),
          handler: function () {
            counterUp(counter, {
              duration: 1000,
              delay: 50
            });
            this.destroy();
          },
          offset: 'bottom-in-view',
        });
      });
    },
    /**
     * Bootstrap Collapse Next
     * The modifield version that will collapse in the same parent
    */
    bsCollapseRelative: () => {
      $('body').on('click', '[data-bs-toggle="collapse-relative"]', (e) => {
        const $this = $(e.currentTarget);
        const targetRootSelector = $this.attr('data-bs-target-root');
        if (targetRootSelector === undefined) { return; }

        const $root = $this.closest(targetRootSelector);
        if ($root === undefined) { return; }

        const $target = $root.find($this.attr('data-bs-target'));
        if ($target === undefined) { return; }

        new bootstrap.Collapse($target[0]);
        // collapse.show();
      });
    },
    /**
     * Bootstrap Tooltips
     * Enables Bootstrap tooltips
     * Requires Poppers library
    */
    bsTooltips: () => {
      var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
      var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl)
      })
    },
    /**
     * Bootstrap Popovers
     * Enables Bootstrap popovers
     * Requires Poppers library
    */
    bsPopovers: () => {
      var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
      var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
        return new bootstrap.Popover(popoverTriggerEl)
      })
    },
    /**
     * Bootstrap Modal
     * Enables Bootstrap modals and modal popup
    */
    bsModal: () => {
      var scr_size = window.innerWidth;
      var scr_avail = $('body').innerWidth();
      var pad_right = scr_size - scr_avail;
      var myModalEl = document.querySelectorAll('.modal');
      myModalEl.forEach(myModalEl => {
        myModalEl.addEventListener('show.bs.modal', function (e) {
          $('.navbar.fixed').css('padding-right', pad_right);
          $('.progress-wrap').css('margin-right', pad_right);
        })
        myModalEl.addEventListener('hidden.bs.modal', function (e) {
          $('.navbar.fixed').css('padding-right', '');
          $('.progress-wrap').css('margin-right', '');
        })
      });
      if ($('.modal-popup').length > 0) {
        var myModalPopup = new bootstrap.Modal(document.querySelector('.modal-popup'));
        var myModalEl2 = document.querySelector('.modal-popup');
        setTimeout(function () {
          myModalPopup.show();
        }, 200);
      }
    },
    /**
     * iTooltip
     * Enables custom tooltip style for image hover docs/elements/hover.html
     * Requires assets/js/vendor/itooltip.min.js
    */
    iTooltip: () => {
      var tooltip = new iTooltip('.itooltip')
      tooltip.init({
        className: 'itooltip-inner',
        indentX: 15,
        indentY: 15,
        positionX: 'right',
        positionY: 'bottom'
      })
    },
    /**
     * Greensock
     * A robust JavaScript toolset for programmaticaly create animation
     * Requires: 
     * assets/js/vendor/gsap.min.js
     * assets/js/vendor/ScrollTrigger.min.js
     */
    greenSock: () => {
      gsap.registerPlugin(ScrollTrigger);
      ScrollTrigger.defaults({ scroller: ".magnet" });
      const elements1 = gsap.utils.toArray('.gsap-slide-right');
      elements1.forEach(el => {
        gsap.to(el, {
          x: 300,
          duration: 2,
          scrollTrigger: {
            trigger: el,
            toggleActions: 'restart none none none'
          }
        });
      });

      const elements2 = gsap.utils.toArray('.gsap-fade-in');
      elements2.forEach(el => {
        gsap.to(el, {
          opacity: 1,
          duration: 2,
          scrollTrigger: {
            trigger: el,
            toggleActions: 'restart none none none'
          }
        });
      });
    },
    closeCollpaseWhenClickOutside: () => {
      $(document).on('click', event => {
        const collapseClassName = 'collapse';
        if (!$(event.target).is(`.${collapseClassName} *`)) {
          const $collapses = $(`.${collapseClassName}.show`);
          for (const collapse of $collapses) {
            const $collapse = $(collapse);
            $collapse.collapse('hide');
            const $source = $($collapse.data('bs-source'));
            if ($source) {
              $source.removeClass('active');
            }
          }
        }
      })
    },
    /**
     * dotNavForLanding
     */
    dotNavForLanding: () => {
      const sidedots = document.querySelectorAll('.dot-nav .circle-wrapper a');
      for (const sidedot of sidedots) {
        sidedot.addEventListener('mouseenter', function (event) {
          sidedot.parentNode.querySelector('.stooltip-box').classList.add('visible');
        });
        sidedot.addEventListener('mouseleave', function (event) {
          sidedot.parentNode.querySelector('.stooltip-box').classList.remove('visible');
        });
      }
      const container = document.querySelector('.magnet');
      const elements = document.querySelectorAll('.magnet-item');
      const dotNav = document.querySelector('.dot-nav');
      if (dotNav) {
        const observer = new IntersectionObserver(function (entries, observer) {
          const activated = entries.reduce(function (max, entry) {
            return (entry.intersectionRatio > max.intersectionRatio) ? entry : max;
          });
          if (activated.intersectionRatio > 0) {
            const i = activated.target.getAttribute('id') ? activated.target.getAttribute('id') : 'section10';
            if (i !== 'section01') {
              dotNav.classList.add('active');
            } else {
              dotNav.classList.remove('active');
            }
            document.querySelectorAll('.dot-nav .circle-wrapper .dot-link[href="#' + i + '"]').forEach((tt) => {
              document.querySelectorAll('.dot-nav .circle-wrapper .circle').forEach((i1) => {
                i1.classList.remove('active');
                i1.classList.remove('pulse');
              });
              tt.parentNode.querySelector('.circle').classList.add('active');
              tt.parentNode.querySelector('.circle').classList.add('pulse');
              tt.parentNode.previousElementSibling.classList.add('active');
              tt.parentNode.nextElementSibling.classList.remove('active');
            });
          }
        }, {
          root: container, threshold: 0.5
        });
        let elementIndices = {};
        for (let j = 0; j < elements.length; j++) {
          elementIndices[elements[j].getAttribute('id')] = j;
          observer.observe(elements[j]);
        }
      }
    },
    /**
     * sTooltip
     */
    sTooltip: () => {
      const sidedots = document.querySelectorAll('.side-nav .circle-wrapper a');
      for (const sidedot of sidedots) {
        sidedot.addEventListener('mouseenter', function (event) {
          sidedot.parentNode.querySelector('.stooltip-box').classList.add('visible');
        });
        sidedot.addEventListener('mouseleave', function (event) {
          sidedot.parentNode.querySelector('.stooltip-box').classList.remove('visible');
        });
      }

      document.querySelectorAll('.side-nav .circle-wrapper a.dot-link').forEach((item) => {
        var i = item.getAttribute('href');
        new Waypoint({
          element: document.getElementById(i.replace('#', '')),
          handler: function () {
            document.querySelectorAll('.side-nav .circle-wrapper .dot-link[href="' + i + '"]').forEach((tt) => {
              document.querySelectorAll('.side-nav .circle-wrapper .circle').forEach((i1) => {
                i1.classList.remove('active');
                i1.classList.remove('pulse');
              });
              tt.parentNode.querySelector('.circle').classList.add('active');
              tt.parentNode.querySelector('.circle').classList.add('pulse');
              tt.parentNode.previousElementSibling.classList.add('active');
              tt.parentNode.nextElementSibling.classList.remove('active');
            });
          },
        });
      });
    },
    /**
     * For button-ddl in simulation landing
     */
    checkCountrySelectionForButtonDDL: () => {
      const btnDdls = document.querySelectorAll('.button-ddl');
      for (const btnDdl of btnDdls) {
        const btnDataCountry = btnDdl.getAttribute('data-country');
        const ddlSelection = document.querySelector(`#${btnDataCountry} option:checked`).value
        if (ddlSelection === '') {
          btnDdl.classList.add('disabled');
        } else {
          btnDdl.classList.remove('disabled');
        }
      }
    },
    /**
     * For country ddl in simulation landing
     */
    onCountryDDLChange: () => {
      const countryDDLs = document.querySelectorAll('.country-ddl');
      for (const countryDDL of countryDDLs) {
        countryDDL.addEventListener('change', e => {
          const ddlName = e.target.getAttribute('name');
          const ddlValue = e.target.value
          const matchBtnDDLs = document.querySelectorAll(`.button-ddl[data-country="${ddlName}"]`);
          for (const matchBtnDDL of matchBtnDDLs) {
            if (ddlValue !== '') {
              const href = matchBtnDDL.getAttribute('href');
              const searchRegExp = /(5\d)\w+/g;
              const dynamicHref = href.replace(searchRegExp, ddlValue);
              matchBtnDDL.setAttribute('href', dynamicHref);
              matchBtnDDL.classList.remove('disabled');
            } else {
              matchBtnDDL.classList.add('disabled');
            }
          }
        });
      }
    },
    simulatorBtns: () => {
      $('.country-ddl-overlay').on("mouseover mouseleave", function() {
        let temp = $(this).siblings( ".disabled" ).length;
        if (temp>0) $(this).parent().siblings().find( "select" ).toggleClass('highlight');
      });
    }

  }
  /**
   * Init theme core
   */
  theme.init();
})(jQuery);
