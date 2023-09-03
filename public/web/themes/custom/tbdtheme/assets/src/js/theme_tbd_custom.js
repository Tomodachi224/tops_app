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
      theme.homepageMapToggleData();
      theme.stepsGuide();
      theme.fixedSidebar();
    },
    homepageMapToggleData: () => {
      $(".btn-map-data-button").on('click',
        function (d) {
          const currentElement = $(d.currentTarget);
          const type = currentElement.data('type');
          console.log('type', type);
          var dataObj = {data : []};
          if (type === 'health') {
            dataObj = {
              "data": [
                  {
                      "country": "Papua New Guinea",
                      "lat": "-6.47264867",
                      "long": "145.1965381",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.07,
                      "size": 10,
                      "year": "2018",
                      "color": "blue"
                  },
                  {
                      "country": "Maldives",
                      "lat": "3.600679586",
                      "long": "73.42723242",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.12,
                      "size": 10,
                      "year": "2017",
                      "color": "blue"
                  },
                  {
                      "country": "Pakistan",
                      "lat": "29.94256937",
                      "long": "69.32404667",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.16,
                      "size": 10,
                      "year": "2017",
                      "color": "blue"
                  },
                  {
                      "country": "Philippines",
                      "lat": "11.76622348",
                      "long": "122.8632691",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.14,
                      "size": 10,
                      "year": "2017",
                      "color": "orange"
                  },
                  {
                      "country": "Tajikistan",
                      "lat": "38.52056929",
                      "long": "70.99960074",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.13,
                      "size": 10,
                      "year": "2017",
                      "color": "orange"
                  },
                  {
                      "country": "Nepal",
                      "lat": "28.24053821",
                      "long": "83.89433938",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.17,
                      "size": 10,
                      "year": "2016",
                      "color": "orange"
                  },
                  {
                      "country": "Armenia",
                      "lat": "40.28096895",
                      "long": "44.91053563",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.19,
                      "size": 10,
                      "year": "2016",
                      "color": "orange"
                  },
                  {
                      "country": "India",
                      "lat": "22.87874934",
                      "long": "79.59244751",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.14,
                      "size": 10,
                      "year": "2016",
                      "color": "orange"
                  },
                  {
                      "country": "Timor-Leste",
                      "lat": "-8.838046529",
                      "long": "125.8339555",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.12,
                      "size": 10,
                      "year": "2016",
                      "color": "orange"
                  },
                  {
                      "country": "Afghanistan",
                      "lat": "33.82513149",
                      "long": "65.98371654",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.07,
                      "size": 10,
                      "year": "2015",
                      "color": "orange"
                  },
                  {
                      "country": "Cambodia",
                      "lat": "12.71240061",
                      "long": "104.891231",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.17,
                      "size": 10,
                      "year": "2014",
                      "color": "blue"
                  }
              ]
            };
          } else if (type === 'children') {
            dataObj = {
              "data": [
                  {
                      "country": "Papua New Guinea",
                      "lat": "-6.47264867",
                      "long": "145.1965381",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.59,
                      "size": 10,
                      "year": "2018",
                      "color": "red"
                  },
                  {
                      "country": "Maldives",
                      "lat": "3.600679586",
                      "long": "73.42723242",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.43,
                      "size": 10,
                      "year": "2017",
                      "color": "red"
                  },
                  {
                      "country": "Pakistan",
                      "lat": "29.94256937",
                      "long": "69.32404667",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.67,
                      "size": 10,
                      "year": "2017",
                      "color": "red"
                  },
                  {
                      "country": "Philippines",
                      "lat": "11.76622348",
                      "long": "122.8632691",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.82,
                      "size": 10,
                      "year": "2017",
                      "color": "green"
                  },
                  {
                      "country": "Tajikistan",
                      "lat": "38.52056929",
                      "long": "70.99960074",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.16,
                      "size": 10,
                      "year": "2017",
                      "color": "orange"
                  },
                  {
                      "country": "Nepal",
                      "lat": "28.24053821",
                      "long": "83.89433938",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.19,
                      "size": 10,
                      "year": "2016",
                      "color": "orange"
                  },
                  {
                      "country": "Armenia",
                      "lat": "40.28096895",
                      "long": "44.91053563",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.43,
                      "size": 10,
                      "year": "2016",
                      "color": "green"
                  },
                  {
                      "country": "India",
                      "lat": "22.87874934",
                      "long": "79.59244751",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.21,
                      "size": 10,
                      "year": "2016",
                      "color": "green"
                  },
                  {
                      "country": "Timor-Leste",
                      "lat": "-8.838046529",
                      "long": "125.8339555",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.71,
                      "size": 10,
                      "year": "2016",
                      "color": "green"
                  },
                  {
                      "country": "Afghanistan",
                      "lat": "33.82513149",
                      "long": "65.98371654",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.70,
                      "size": 10,
                      "year": "2015",
                      "color": "green"
                  },
                  {
                      "country": "Cambodia",
                      "lat": "12.71240061",
                      "long": "104.891231",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.51,
                      "size": 10,
                      "year": "2014",
                      "color": "red"
                  }
              ]
            };
          } else if (type === 'other') {
            dataObj = {
              "data": [
                  {
                      "country": "Papua New Guinea",
                      "lat": "-6.47264867",
                      "long": "145.1965381",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.14,
                      "size": 10,
                      "year": "2018",
                      "color": "red"
                  },
                  {
                      "country": "Maldives",
                      "lat": "3.600679586",
                      "long": "73.42723242",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.56,
                      "size": 10,
                      "year": "2017",
                      "color": "green"
                  },
                  {
                      "country": "Pakistan",
                      "lat": "29.94256937",
                      "long": "69.32404667",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.16,
                      "size": 10,
                      "year": "2017",
                      "color": "red"
                  },
                  {
                      "country": "Philippines",
                      "lat": "11.76622348",
                      "long": "122.8632691",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.27,
                      "size": 10,
                      "year": "2017",
                      "color": "orange"
                  },
                  {
                      "country": "Tajikistan",
                      "lat": "38.52056929",
                      "long": "70.99960074",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.16,
                      "size": 10,
                      "year": "2017",
                      "color": "blue"
                  },
                  {
                      "country": "Nepal",
                      "lat": "28.24053821",
                      "long": "83.89433938",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.19,
                      "size": 10,
                      "year": "2016",
                      "color": "blue"
                  },
                  {
                      "country": "Armenia",
                      "lat": "40.28096895",
                      "long": "44.91053563",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.73,
                      "size": 10,
                      "year": "2016",
                      "color": "green"
                  },
                  {
                      "country": "India",
                      "lat": "22.87874934",
                      "long": "79.59244751",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.21,
                      "size": 10,
                      "year": "2016",
                      "color": "red"
                  },
                  {
                      "country": "Timor-Leste",
                      "lat": "-8.838046529",
                      "long": "125.8339555",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.71,
                      "size": 10,
                      "year": "2016",
                      "color": "green"
                  },
                  {
                      "country": "Afghanistan",
                      "lat": "33.82513149",
                      "long": "65.98371654",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.23,
                      "size": 10,
                      "year": "2015",
                      "color": "orange"
                  },
                  {
                      "country": "Cambodia",
                      "lat": "12.71240061",
                      "long": "104.891231",
                      "indicator": "Any type of violence against women (over past 12 months)",
                      "group_access": 0.25,
                      "size": 10,
                      "year": "2014",
                      "color": "orange"
                  }
              ]
            };
          }

          const mapElement = document.getElementById('home-page-map');
          mapElement.setAttribute('bubble-data', JSON.stringify(dataObj));
        });
    },
    stepsGuide: () => {
        $(document).ready(function(){
            theme.updateSidebar();
            let check = $(".menu-item--active-trail").find(".menu-item--active-trail");
            if(check.length == 0) {
                $(".intro").addClass('active')
            }
            // else  $(".steps-title").addClass('active')
            $('.accordion-collapse').on('shown.bs.collapse', function(e) {
                var $panel = $(this).closest('.accordion');
                $('html,body').animate({
                  scrollTop: $panel.offset().top - 120
                }, 500);
              });
              
        });

    },
    handleScroll: (elem1, elem2, className, bodyelem) => {
        if (elem1.length <= 0) return;
        if(bodyelem.height() < elem2.height()) return;
        console.log('handleScroll', bodyelem.height(), elem2.height())

        var scrollTop = $(window).scrollTop();
        var elementOffset = elem1.offset().top;
        var distance = (elementOffset - scrollTop);

        if (distance < 100) {
          elem2.addClass(className);
        } else {
          elem2.removeClass(className);
        }
      },
    handleScrollV2: () => {
        $.fn.isInViewport = function () {
            if ($(this) && $(this).offset()) {
              var elementTop = $(this).offset().top;
              var elementBottom = elementTop + $(this).outerHeight();
              var viewportTop = $(window).scrollTop() + 80; // add the fixed menu height
              var viewportBottom = viewportTop + $(window).height();
              return elementBottom > viewportTop && elementTop < viewportBottom;
            }
          }
        
        let elem1 = $(".booktoc");
        let elem2 = $(".booktoc-sidebar");
        let className = 'position-fixed';
        let className2 = 'sidebar-postion'; // 'position-absolute';
        let initialClass = 'initial-postion';
        // if the height if the conent is less than the available screen space do no stick to top
        // if($("article").height() < ($(window).height()-$("article").offset().top + 100)) return;
       
        elem2.removeClass(initialClass);
        if ($('.breadcrumb').isInViewport()) {
            elem2.addClass(initialClass);
        }

        let viewportWidth = window.innerWidth;
        if (viewportWidth <= 768) {
            elem2.removeClass(className);
            return; // return if small screen
        }
        elem1.addClass('position-relative');
        if (elem1.length <= 0) return;
        var scrollTop = $(window).scrollTop();
        var elementOffset = elem1.offset().top;

        var element = document.querySelector('#footer-area');
            var position = element.getBoundingClientRect();
        var footerVisible = false;
        // checking for partial visibility
        if(position.top < window.innerHeight && position.bottom >= 0)footerVisible = true;
        else footerVisible= false;

        var distance = (elementOffset - scrollTop);
        if (distance < 100 && footerVisible == false) {
            elem2.addClass(className);
            elem2.removeClass(className2);
        } 
        else if (footerVisible == true) {
            elem2.addClass(className2);
            elem2.removeClass(className);
        } else {
            elem2.removeClass(className);
            elem2.removeClass(className2);
        }
    },
    // checkActiveSection: () => {
    //     var fromTop = jQuery(window).scrollTop(); // 264
    //     var actualTop = parseInt(fromTop);
    //     // console.log('check active section');
    //     // console.log(fromTop, actualTop);
    //     $('.regional-title-container h4').each(function () {
    //     //   console.log($(this).html());
    //       var xtop;
    //       if (true) {
    //         if ($(this).hasClass('active')) $(this).removeClass('active');
    //         xtop =$(this).offset().top;
    //         // console.log(xtop, actualTop);
    //         if (xtop <= actualTop) {
    //             $(this).addClass('active');
    //             return false;
    //         }
    //       }
    //     });
    // },
    updateSidebar: () => {
        var width = $(".booktoc").width() - 10;
        $(".booktoc-sidebar").width(width);
    },
    fixedSidebar: () => {
        $(window).on('load resize', function () {
            theme.updateSidebar();
        });
        $(window).on('scroll', function () {
            theme.handleScrollV2()
        //   theme.handleScroll($(".booktoc"), $(".booktoc-sidebar"), 'position-fixed', $("article"));
        });
      },
      
  }
  /**
   * Init theme core
   */
  theme.init();
//   $(window).on('scroll', function () {
//     theme.checkActiveSection();
//   });
})(jQuery);
