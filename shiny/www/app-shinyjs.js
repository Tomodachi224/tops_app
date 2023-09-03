// ShinyJS

shinyjs.return = function() {
  window.scrollTo(0,0);
}

shinyjs.init = function(){
  $('#navbar li a[data-value=childbenefit_tab]').hide();
  $('#navbar li a[data-value=disabilitybenefit_tab]').hide();
  $('#navbar li a[data-value=oldagebenefit_tab]').hide();
  $('#navbar li a[data-value=hhbenefit_tab]').hide();
}

// whenever the user navigates with the previous/next buttons in the browser,
// tell the Shiny app to restore the history based on the URL navigated to
shinyjs.init = function() {
  window.onpopstate = function (event) {
    Shiny.onInputChange('navigatedTo', location.search);
  } 
}

// update the URL to reflect the current state 
shinyjs.updateHistory = function(params) {
  var queryString = [];
  for (var key in params) {
    queryString.push(encodeURIComponent(key) + '=' + encodeURIComponent(params[key]));
  }
  queryString = '?' + queryString.join('&');
  history.pushState(null, null, queryString)
}