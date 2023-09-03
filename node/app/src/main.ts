// Library
import '@/libs/axios';
import Vue from 'vue';
import App from './App.vue';
// Internal
import AnalysisApp from './apps/AnalysisApp.vue';
import CompareApp from './apps/CompareApp.vue';
import CrossCountryApp from './apps/CrossCountryApp.vue';
import DashboardApp from './apps/DashboardApp.vue';
import GridPageApp from './apps/GridPageApp.vue';
import KpApp from './apps/KpApp.vue';
import MapDashboardApp from './apps/MapDashboardApp.vue';
import MethodologyApp from './apps/MethodologyApp.vue';
import RegionalCompApp from './apps/RegionalCompApp.vue';
import store from './store';

// import router from './router';

Vue.config.productionTip = false;

let vueApp;

// Path pattern: /page-name/params1/params2
const splitPathname = location.pathname.split('/');
const pathname = splitPathname[1];
console.log('pathname', pathname);
if (pathname === 'vue-app') {
  vueApp = new Vue({
    // router,
    store,
    render: (h) => h(App)
  }).$mount('#app');
} else if (pathname === 'analysis-app') {
  // Path pattern: /analysis-app/country/scheme
  const country = decodeURI(splitPathname[2]);
  const scheme = decodeURI(splitPathname[3]).split('_');
  vueApp = new Vue({
    store,
    render: (h) => h(AnalysisApp, { props: { country, scheme } })
  }).$mount('#app');
} else if (pathname === 'explore') {
  vueApp = new Vue({
    store,
    render: (h) => h(KpApp)
  }).$mount('#app');
} else if (pathname === 'compare-app') {
  const mode = decodeURI(splitPathname[2]);
  const params = {};

  if (mode === 'combined') {
    // const country = decodeURI(splitPathname[3]);
    // const benefitLevel = decodeURI(splitPathname[4]);
    // const poverty = decodeURI(splitPathname[5]);
    // const scheme = decodeURI(splitPathname[6]).split('_');
    // const paramObject = {
    //   country: country,
    //   benefit_level: benefitLevel,
    //   poverty_mean_tested: poverty,
    //   scheme: scheme
    // };
    // Object.assign(params, paramObject);
    const searchString = decodeURI(location.search.replace('?filter=', ''));
    if (searchString) {
      const paramsObject = JSON.parse(searchString);
      Object.assign(params, paramsObject);
    }
  } else if (mode === 'comparative') {
    const searchString = decodeURI(location.search.replace('?filter=', ''));
    if (searchString) {
      const paramsObject = JSON.parse(searchString);
      Object.assign(params, paramsObject);
    }
  }

  vueApp = new Vue({
    store,
    render: (h) => h(CompareApp, { props: { mode, params } })
  }).$mount('#app');
} else if (pathname === 'grid-app') {
  vueApp = new Vue({
    store,
    render: (h) => h(GridPageApp)
  }).$mount('#app');
} else if (pathname === 'dashboard-app') {
  const mode = splitPathname[2] ? decodeURI(splitPathname[2]) : 'combined';
  const toolbarMode = splitPathname[3] ? decodeURI(splitPathname[3]) : 'normal';
  const params = {};
  const searchString = decodeURI(location.search.replace('?filter=', ''));
  if (searchString) {
    const paramsObject = JSON.parse(searchString);
    Object.assign(params, paramsObject);
  }

  vueApp = new Vue({
    store,
    render: (h) => h(DashboardApp, { props: { mode, toolbarMode, params } })
  }).$mount('#app');
} else if (pathname === 'map-dashboard-app') {
  const params = {};

  vueApp = new Vue({
    store,
    render: (h) => h(MapDashboardApp)
  }).$mount('#app');
} else if (pathname === 'cross-country-app') {
  const params = {};

  vueApp = new Vue({
    store,
    render: (h) => h(CrossCountryApp)
  }).$mount('#app');
} else if (pathname === 'regional-comparison-app') {
  const params = {};

  vueApp = new Vue({
    store,
    render: (h) => h(RegionalCompApp)
  }).$mount('#app');
} else if (pathname === 'methodology-app') {
  vueApp = new Vue({
    store,
    render: (h) => h(MethodologyApp)
  }).$mount('#app');
}

if (vueApp !== undefined) {
  console.log('Vue mounted!!!');
}
