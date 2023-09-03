/**
 * @file
 * A JavaScript file for the theme.
 *
 * In order for this JavaScript to be loaded on pages, see the instructions in
 * the README.txt next to this file.
 */

// JavaScript should be made compatible with libraries other than jQuery by
// wrapping it with an "anonymous closure". See:
// - https://drupal.org/node/1446420
// - http://www.adequatelygood.com/2010/3/JavaScript-Module-Pattern-In-Depth
(function ($, Drupal) {
  // 'use strict';
  // To understand behaviors, see https://drupal.org/node/756722#behaviors
  Drupal.behaviors.assessment_tool_behavior = {
    attach: function (context, settings) {
      // Place your code here.
    } // end of attach
  };

  Raphael.fn.pieChart = function (cx, cy, r, segment) {
    var paper = this,
      rad = Math.PI / 180,
      chart = this.set();
    function sector(cx, cy, r, startAngle, endAngle, params) {
      var x1 = cx + r * Math.cos(-startAngle * rad),
        x2 = cx + r * Math.cos(-endAngle * rad),
        y1 = cy + r * Math.sin(-startAngle * rad),
        y2 = cy + r * Math.sin(-endAngle * rad);
      return paper.path(["M", cx, cy, "L", x1, y1, "A", r, r, 0, +(endAngle - startAngle > 180), 0, x2, y2, "z"]).attr(params);
    }
    if (segment == 'children') { chart.push(sector(cx, cy, r, 120, 180, {fill: '#76C7A0', stroke: 'white'})); }
    else if (segment == 'working') { chart.push(sector(cx, cy, r, 60, 120, {fill: '#B12E6A', stroke: 'white'})); }
    else if (segment == 'older') { chart.push(sector(cx, cy, r, 0, 60, {fill: '#6B4DA0', stroke: 'white'})); }
    return chart;
  };

  Raphael.fn.Donut = function(x, y, innerRadius, outerRadius) {
    y -= outerRadius;
    return this.path('M'+x+' '+y+'a'+outerRadius+' '+outerRadius+' 0 1 0 1 0m-1 '+(outerRadius - innerRadius)+'a'+innerRadius+' '+innerRadius+' 0 1 1 -1 0').attr({fill: "#00AACD", stroke: "none"});
  };

  //Initialize Raphael Pie Chart | donut 171-227, pie 0-143
  var paper = Raphael('diagram', 460, 230),
    pieHealth = paper.Donut(231, 230, 171, 185),
    pieChildren = paper.pieChart(231, 230, 35.75, 'children'),
    pieWorking = paper.pieChart(231, 230, 35.75, 'working'),
    pieOlder = paper.pieChart(231, 230, 35.75, 'older');

  function transDonut(x, y, innerRadius, outerRadius) {
    y -= outerRadius;
    return 'M'+x+' '+y+'a'+outerRadius+' '+outerRadius+' 0 1 0 1 0m-1 '+(outerRadius - innerRadius)+'a'+innerRadius+' '+innerRadius+' 0 1 1 -1 0';
  };

  // Initialize the iCheck
  $('#assessment input').iCheck({
    checkboxClass: 'icheckbox_flat-yesno',
    radioClass: 'iradio_flat-yesno'
  });

  // *************************************
  // **             HEALTH              **
  // *************************************

  // Default options
  $('#control-health-4 input').iCheck('check');
  $('#control-health-2 input').iCheck('check');
  $('#control-health-4').hide();
  $('#control-health-2').hide();
  var health_count4 = 5;
  var health_count2 = 5;

  $('#opt-health-4').on('ifChecked', function(){
    if ($('#control-health-2').hasClass('active')) {
      $('#control-health-2').slideUp('slow', function(){
        $(this).removeClass('active').hide();
      });
      $('#control-health-4').delay(700);
    }
    if (!$('#control-health-4').hasClass('active')){
      $('#control-health-4').addClass('active').slideDown('slow');
    }
    pieHealth.stop().animate({path: transDonut(231, 230, 171, 227)}, 500, "linear");
  });

  $('#opt-health-4').on('ifClicked', function(){
    $('#opt-health-4').iCheck('check');
    $('#control-health-4 input').iCheck('check');
  });

  $('#opt-health-3').on('ifChecked', function(){
    if ($('#control-health-2').hasClass('active')) {
      $('#control-health-2').slideUp('slow', function(){
        $(this).removeClass('active').hide();
      });
      $('#control-health-4').delay(700);
    }
    if (!$('#control-health-4').hasClass('active')){
      $('#control-health-4').addClass('active').slideDown('slow');
    }
    pieHealth.stop().animate({path: transDonut(231, 230, 171, 213)}, 500, "linear");
  });

  $('#opt-health-3').on('ifClicked', function(){
    $('#opt-health-3').iCheck('check');
    $('#control-health-4 input').iCheck('check');
  });

  $('#opt-health-2').on('ifChecked', function(){
    if ($('#control-health-4').hasClass('active')) {
      $('#control-health-4').slideUp('slow', function(){
        $(this).removeClass('active').hide();
      });
      $('#control-health-2').delay(700);
    }
    $('#control-health-2').addClass('active').slideDown('slow');
    pieHealth.stop().animate({path: transDonut(231, 230, 171, 199)}, 500, "linear");
  });

  $('#opt-health-2').on('ifClicked', function(){
    $('#opt-health-2').iCheck('check');
    $('#control-health-2 input').iCheck('check');
  });

  $('#opt-health-1').on('ifChecked', function(){
    $('#tab-health .active').slideUp('slow', function(){
      $(this).removeClass('active').hide();
    });
    pieHealth.stop().animate({path: transDonut(231, 230, 171, 185)}, 500, "linear");
  });

  // Count Control question 4
  $('#cq-health-45').on('ifChecked', function(){ health_count4 = health_count4 + 1; health_counter4(); });
  $('#cq-health-45').on('ifUnchecked', function(){ health_count4 = health_count4 - 1; health_counter4(); });
  $('#cq-health-44').on('ifChecked', function(){ health_count4 = health_count4 + 1; health_counter4(); });
  $('#cq-health-44').on('ifUnchecked', function(){ health_count4 = health_count4 - 1; health_counter4(); });
  $('#cq-health-43').on('ifChecked', function(){ health_count4 = health_count4 + 1; health_counter4(); });
  $('#cq-health-43').on('ifUnchecked', function(){ health_count4 = health_count4 - 1; health_counter4(); });
  $('#cq-health-42').on('ifChecked', function(){ health_count4 = health_count4 + 1; health_counter4(); });
  $('#cq-health-42').on('ifUnchecked', function(){ health_count4 = health_count4 - 1; health_counter4(); });
  $('#cq-health-41').on('ifChecked', function(){ health_count4 = health_count4 + 1; health_counter4(); });
  $('#cq-health-41').on('ifUnchecked', function(){ health_count4 = health_count4 - 1; health_counter4(); });

  function health_counter4() { 
    //Promote or demote level
    if (health_count4 == 4) { $('#opt-health-3').iCheck('check'); }
    else if (health_count4 == 2) { $('#opt-health-2').iCheck('check'); }
  }

  // If Control question 2 doesn't meet the requirements, demote to level 2
  $('#cq-health-25').on('ifChecked', function(){ health_count2 = health_count2 + 1; health_counter2(); });
  $('#cq-health-25').on('ifUnchecked', function(){ health_count2 = health_count2 - 1; health_counter2(); });
  $('#cq-health-24').on('ifChecked', function(){ health_count2 = health_count2 + 1; health_counter2(); });
  $('#cq-health-24').on('ifUnchecked', function(){ health_count2 = health_count2 - 1; health_counter2(); });
  $('#cq-health-23').on('ifChecked', function(){ health_count2 = health_count2 + 1; health_counter2(); });
  $('#cq-health-23').on('ifUnchecked', function(){ health_count2 = health_count2 - 1; health_counter2(); });
  $('#cq-health-22').on('ifChecked', function(){ health_count2 = health_count2 + 1; health_counter2(); });
  $('#cq-health-22').on('ifUnchecked', function(){ health_count2 = health_count2 - 1; health_counter2(); });
  $('#cq-health-21').on('ifChecked', function(){ health_count2 = health_count2 + 1; health_counter2(); });
  $('#cq-health-21').on('ifUnchecked', function(){ health_count2 = health_count2 - 1; health_counter2(); });

  function health_counter2() {
    //Promote or demote level
    if (health_count2 < 5 && health_count2 > 0) { $('#opt-health-2').iCheck('check'); }
    else if (health_count2 == 0) { $('#opt-health-1').iCheck('check'); }
  }

  // *************************************
  // **           CHILDREN              **
  // *************************************

  // Default options
  $('#control-children-4 input').iCheck('check');
  $('#control-children-2 input').iCheck('check');
  $('#control-children-4').hide();
  $('#control-children-2').hide();
  var children_count4 = 3;
  var children_count2 = 3;

  $('#opt-children-4').on('ifChecked', function(){
    if ($('#control-children-2').hasClass('active')) {
      $('#control-children-2').slideUp('slow', function(){
        $(this).removeClass('active').hide();
      });
      $('#control-children-4').delay(700);
    }
    if (!$('#control-children-4').hasClass('active')){
      $('#control-children-4').addClass('active').slideDown('slow');
    }
    pieChildren.stop().animate({transform: "s4 4 " + 231 + " " + 230}, 500, "linear");
  });

  $('#opt-children-4').on('ifClicked', function(){
    $('#opt-children-4').iCheck('check');
    $('#control-children-4 input').iCheck('check');
  });

  $('#opt-children-3').on('ifChecked', function(){
    if ($('#control-children-2').hasClass('active')) {
      $('#control-children-2').slideUp('slow', function(){
        $(this).removeClass('active').hide();
      });
      $('#control-children-4').delay(700);
    }
    if (!$('#control-children-4').hasClass('active')){
      $('#control-children-4').addClass('active').slideDown('slow');
    }
    pieChildren.stop().animate({transform: "s3 3 " + 231 + " " + 230}, 500, "linear");
  });

  $('#opt-children-3').on('ifClicked', function(){
    $('#opt-children-3').iCheck('check');
    $('#control-children-4 input').iCheck('check');
  });

  $('#opt-children-2').on('ifChecked', function(){
    if ($('#control-children-4').hasClass('active')) {
      $('#control-children-4').slideUp('slow', function(){
        $(this).removeClass('active').hide();
      });
      $('#control-children-2').delay(700);
    }
    $('#control-children-2').addClass('active').slideDown('slow');
    pieChildren.stop().animate({transform: "s2 2 " + 231 + " " + 230}, 500, "linear");
  });

  $('#opt-children-2').on('ifClicked', function(){
    $('#opt-children-2').iCheck('check');
    $('#control-children-2 input').iCheck('check');
  });

  $('#opt-children-1').on('ifChecked', function(){
    $('#tab-children .active').slideUp('slow', function(){
      $(this).removeClass('active').hide();
    });
    pieChildren.stop().animate({transform: "s1 1 " + 231 + " " + 230}, 500, "linear");
  });

  // Count Control question 4
  $('#cq-children-43').on('ifChecked', function(){ children_count4 = children_count4 + 1; children_counter4(); });
  $('#cq-children-43').on('ifUnchecked', function(){ children_count4 = children_count4 - 1; children_counter4(); });
  $('#cq-children-42').on('ifChecked', function(){ children_count4 = children_count4 + 1; children_counter4(); });
  $('#cq-children-42').on('ifUnchecked', function(){ children_count4 = children_count4 - 1; children_counter4(); });
  $('#cq-children-41').on('ifChecked', function(){ children_count4 = children_count4 + 1; children_counter4(); });
  $('#cq-children-41').on('ifUnchecked', function(){ children_count4 = children_count4 - 1; children_counter4(); });

  function children_counter4() { 
    //Promote or demote level
    if (children_count4 == 2) { $('#opt-children-3').iCheck('check'); }
    else if (children_count4 == 1) { $('#opt-children-2').iCheck('check'); }
  }

  // If Control question 2 doesn't meet the requirements, demote to level 2
  $('#cq-children-23').on('ifChecked', function(){ children_count2 = children_count2 + 1; children_counter2(); });
  $('#cq-children-23').on('ifUnchecked', function(){ children_count2 = children_count2 - 1; children_counter2(); });
  $('#cq-children-22').on('ifChecked', function(){ children_count2 = children_count2 + 1; children_counter2(); });
  $('#cq-children-22').on('ifUnchecked', function(){ children_count2 = children_count2 - 1; children_counter2(); });
  $('#cq-children-21').on('ifChecked', function(){ children_count2 = children_count2 + 1; children_counter2(); });
  $('#cq-children-21').on('ifUnchecked', function(){ children_count2 = children_count2 - 1; children_counter2(); });

  function children_counter2() {
    //Promote or demote level
    if (children_count2 < 3 && children_count2 > 0) { $('#opt-children-2').iCheck('check'); }
    else if (children_count2 == 0) { $('#opt-children-1').iCheck('check'); }
  }


  // *************************************
  // **           WORKING AGE           **
  // *************************************

  // Default options
  $('#control-working-4 input').iCheck('check');
  $('#control-working-2 input').iCheck('check');
  $('#control-working-4').hide();
  $('#control-working-2').hide();
  var working_count4 = 3;
  var working_count2 = 3;

  $('#opt-working-4').on('ifChecked', function(){
    if ($('#control-working-2').hasClass('active')) {
      $('#control-working-2').slideUp('slow', function(){
        $(this).removeClass('active').hide();
      });
      $('#control-working-4').delay(700);
    }
    if (!$('#control-working-4').hasClass('active')){
      $('#control-working-4').addClass('active').slideDown('slow');
    }
    pieWorking.stop().animate({transform: "s4 4 " + 231 + " " + 230}, 500, "linear");
  });

  $('#opt-working-4').on('ifClicked', function(){
    $('#opt-working-4').iCheck('check');
    $('#control-working-4 input').iCheck('check');
  });

  $('#opt-working-3').on('ifChecked', function(){
    if ($('#control-working-2').hasClass('active')) {
      $('#control-working-2').slideUp('slow', function(){
        $(this).removeClass('active').hide();
      });
      $('#control-working-4').delay(700);
    }
    if (!$('#control-working-4').hasClass('active')){
      $('#control-working-4').addClass('active').slideDown('slow');
    }
    pieWorking.stop().animate({transform: "s3 3 " + 231 + " " + 230}, 500, "linear");
  });

  $('#opt-working-3').on('ifClicked', function(){
    $('#opt-working-3').iCheck('check');
    $('#control-working-4 input').iCheck('check');
  });

  $('#opt-working-2').on('ifChecked', function(){
    if ($('#control-working-4').hasClass('active')) {
      $('#control-working-4').slideUp('slow', function(){
        $(this).removeClass('active').hide();
      });
      $('#control-working-2').delay(700);
    }
    $('#control-working-2').addClass('active').slideDown('slow');
    pieWorking.stop().animate({transform: "s2 2 " + 231 + " " + 230}, 500, "linear");
  });

  $('#opt-working-2').on('ifClicked', function(){
    $('#opt-working-2').iCheck('check');
    $('#control-working-2 input').iCheck('check');
  });

  $('#opt-working-1').on('ifChecked', function(){
    $('#tab-working .active').slideUp('slow', function(){
      $(this).removeClass('active').hide();
    });
    pieWorking.stop().animate({transform: "s1 1 " + 231 + " " + 230}, 500, "linear");
  });

  // Count Control question 4
  $('#cq-working-43').on('ifChecked', function(){ working_count4 = working_count4 + 1; working_counter4(); });
  $('#cq-working-43').on('ifUnchecked', function(){ working_count4 = working_count4 - 1; working_counter4(); });
  $('#cq-working-42').on('ifChecked', function(){ working_count4 = working_count4 + 1; working_counter4(); });
  $('#cq-working-42').on('ifUnchecked', function(){ working_count4 = working_count4 - 1; working_counter4(); });
  $('#cq-working-41').on('ifChecked', function(){ working_count4 = working_count4 + 1; working_counter4(); });
  $('#cq-working-41').on('ifUnchecked', function(){ working_count4 = working_count4 - 1; working_counter4(); });

  function working_counter4() { 
    //Promote or demote level
    if (working_count4 == 2) { $('#opt-working-3').iCheck('check'); }
    else if (working_count4 == 1) { $('#opt-working-2').iCheck('check'); }
  }

  // If Control question 2 doesn't meet the requirements, demote to level 2
  $('#cq-working-23').on('ifChecked', function(){ working_count2 = working_count2 + 1; working_counter2(); });
  $('#cq-working-23').on('ifUnchecked', function(){ working_count2 = working_count2 - 1; working_counter2(); });
  $('#cq-working-22').on('ifChecked', function(){ working_count2 = working_count2 + 1; working_counter2(); });
  $('#cq-working-22').on('ifUnchecked', function(){ working_count2 = working_count2 - 1; working_counter2(); });
  $('#cq-working-21').on('ifChecked', function(){ working_count2 = working_count2 + 1; working_counter2(); });
  $('#cq-working-21').on('ifUnchecked', function(){ working_count2 = working_count2 - 1; working_counter2(); });

  function working_counter2() {
    //Promote or demote level
    if (working_count2 < 3 && working_count2 > 0) { $('#opt-working-2').iCheck('check'); }
    else if (working_count2 == 0) { $('#opt-working-1').iCheck('check'); }
  }


  // *************************************
  // **         OLDER PERSON            **
  // *************************************

  // Default options
  $('#control-older-4 input').iCheck('check');
  $('#control-older-2 input').iCheck('check');
  $('#control-older-4').hide();
  $('#control-older-2').hide();
  var older_count4 = 3;
  var older_count2 = 3;

  $('#opt-older-4').on('ifChecked', function(){
    if ($('#control-older-2').hasClass('active')) {
      $('#control-older-2').slideUp('slow', function(){
        $(this).removeClass('active').hide();
      });
      $('#control-older-4').delay(700);
    }
    if (!$('#control-older-4').hasClass('active')){
      $('#control-older-4').addClass('active').slideDown('slow');
    }
    pieOlder.stop().animate({transform: "s4 4 " + 231 + " " + 230}, 500, "linear");
  });

  $('#opt-older-4').on('ifClicked', function(){
    $('#opt-older-4').iCheck('check');
    $('#control-older-4 input').iCheck('check');
  });

  $('#opt-older-3').on('ifChecked', function(){
    if ($('#control-older-2').hasClass('active')) {
      $('#control-older-2').slideUp('slow', function(){
        $(this).removeClass('active').hide();
      });
      $('#control-older-4').delay(700);
    }
    if (!$('#control-older-4').hasClass('active')){
      $('#control-older-4').addClass('active').slideDown('slow');
    }
    pieOlder.stop().animate({transform: "s3 3 " + 231 + " " + 230}, 500, "linear");
  });

  $('#opt-older-3').on('ifClicked', function(){
    $('#opt-older-3').iCheck('check');
    $('#control-older-4 input').iCheck('check');
  });

  $('#opt-older-2').on('ifChecked', function(){
    if ($('#control-older-4').hasClass('active')) {
      $('#control-older-4').slideUp('slow', function(){
        $(this).removeClass('active').hide();
      });
      $('#control-older-2').delay(700);
    }
    $('#control-older-2').addClass('active').slideDown('slow');
    pieOlder.stop().animate({transform: "s2 2 " + 231 + " " + 230}, 500, "linear");
  });

  $('#opt-older-2').on('ifClicked', function(){
    $('#opt-older-2').iCheck('check');
    $('#control-older-2 input').iCheck('check');
  });

  $('#opt-older-1').on('ifChecked', function(){
    $('#tab-older .active').slideUp('slow', function(){
      $(this).removeClass('active').hide();
    });
    pieOlder.stop().animate({transform: "s1 1 " + 231 + " " + 230}, 500, "linear");
  });

  // Count Control question 4
  $('#cq-older-43').on('ifChecked', function(){ older_count4 = older_count4 + 1; older_counter4(); });
  $('#cq-older-43').on('ifUnchecked', function(){ older_count4 = older_count4 - 1; older_counter4(); });
  $('#cq-older-42').on('ifChecked', function(){ older_count4 = older_count4 + 1; older_counter4(); });
  $('#cq-older-42').on('ifUnchecked', function(){ older_count4 = older_count4 - 1; older_counter4(); });
  $('#cq-older-41').on('ifChecked', function(){ older_count4 = older_count4 + 1; older_counter4(); });
  $('#cq-older-41').on('ifUnchecked', function(){ older_count4 = older_count4 - 1; older_counter4(); });

  function older_counter4() { 
    //Promote or demote level
    if (older_count4 == 2) { $('#opt-older-3').iCheck('check'); }
    else if (older_count4 == 1) { $('#opt-older-2').iCheck('check'); }
  }

  // If Control question 2 doesn't meet the requirements, demote to level 2
  $('#cq-older-23').on('ifChecked', function(){ older_count2 = older_count2 + 1; older_counter2(); });
  $('#cq-older-23').on('ifUnchecked', function(){ older_count2 = older_count2 - 1; older_counter2(); });
  $('#cq-older-22').on('ifChecked', function(){ older_count2 = older_count2 + 1; older_counter2(); });
  $('#cq-older-22').on('ifUnchecked', function(){ older_count2 = older_count2 - 1; older_counter2(); });
  $('#cq-older-21').on('ifChecked', function(){ older_count2 = older_count2 + 1; older_counter2(); });
  $('#cq-older-21').on('ifUnchecked', function(){ older_count2 = older_count2 - 1; older_counter2(); });

  function older_counter2() {
    //Promote or demote level
    if (older_count2 < 3 && older_count2 > 0) { $('#opt-older-2').iCheck('check'); }
    else if (older_count2 == 0) { $('#opt-older-1').iCheck('check'); }
  }

  // Showing Result
  var optHealth = $('#tool-end .list-health').data('option');
  if (optHealth == 4) { pieHealth.stop().animate({path: transDonut(231, 230, 171, 227)}, 500, "linear"); }
  else if (optHealth == 3) { pieHealth.stop().animate({path: transDonut(231, 230, 171, 213)}, 500, "linear"); }
  else if (optHealth == 2) { pieHealth.stop().animate({path: transDonut(231, 230, 171, 199)}, 500, "linear"); }
  else if (optHealth == 1) { pieHealth.stop().animate({path: transDonut(231, 230, 171, 185)}, 500, "linear"); }

  var optChildren = $('#tool-end .list-children').data('option');
  if (optChildren == 4) { pieChildren.stop().animate({transform: "s4 4 " + 231 + " " + 230}, 500, "linear"); }
  else if (optChildren == 3) { pieChildren.stop().animate({transform: "s3 3 " + 231 + " " + 230}, 500, "linear"); }
  else if (optChildren == 2) { pieChildren.stop().animate({transform: "s2 2 " + 231 + " " + 230}, 500, "linear"); }
  else if (optChildren == 1) { pieChildren.stop().animate({transform: "s1 1 " + 231 + " " + 230}, 500, "linear"); }

  var optWorking = $('#tool-end .list-working').data('option');
  if (optWorking == 4) { pieWorking.stop().animate({transform: "s4 4 " + 231 + " " + 230}, 500, "linear"); }
  else if (optWorking == 3) { pieWorking.stop().animate({transform: "s3 3 " + 231 + " " + 230}, 500, "linear"); }
  else if (optWorking == 2) { pieWorking.stop().animate({transform: "s2 2 " + 231 + " " + 230}, 500, "linear"); }
  else if (optWorking == 1) { pieWorking.stop().animate({transform: "s1 1 " + 231 + " " + 230}, 500, "linear"); }

  var optOlder = $('#tool-end .list-older').data('option');
  if (optOlder == 4) { pieOlder.stop().animate({transform: "s4 4 " + 231 + " " + 230}, 500, "linear"); }
  else if (optOlder == 3) { pieOlder.stop().animate({transform: "s3 3 " + 231 + " " + 230}, 500, "linear"); }
  else if (optOlder == 2) { pieOlder.stop().animate({transform: "s2 2 " + 231 + " " + 230}, 500, "linear"); }
  else if (optOlder == 1) { pieOlder.stop().animate({transform: "s1 1 " + 231 + " " + 230}, 500, "linear"); }


  // We pass the parameters of this anonymous function are the global variables
  // that this script depend on. For example, if the above script requires
  // jQuery, you should change (Drupal) to (Drupal, jQuery) in the line below
  // and, in this file's first line of JS, change function (Drupal) to
  // (Drupal, $)
})(jQuery, Drupal);
