import { DRUPAL_API_VERSION_URL, DRUPAL_DOMAIN, RAPI_DOMAIN, RAPI_VERSION_URL } from '@/environment';
import axios from '@axios';

const loopBackApiPath = `${RAPI_DOMAIN}${RAPI_VERSION_URL}`;
const drupalApiPath = `${DRUPAL_DOMAIN}${DRUPAL_API_VERSION_URL}`;
const pShinyApiPath = 'https://pshiny.thinkbluedata.com';

const state: any = {
  configs: {
    country: undefined,
    scheme: undefined
  },
  compareConfigs: {
    mode: undefined,
    params: undefined
  },
  dashboardConfigs: {
    mode: undefined,
    pageLevel: undefined,
    scenario1: undefined,
    scenario2: undefined,
    detailScenario1: undefined,
    detailScenario2: undefined
  },
  urlConfigs: {
  },
  country: undefined,
  dashboardToolbarType: undefined,
  showToolbar: false,
  countries: [],
  parameters: [],
  indicators: [],
  labels: [],
  valueTypes: [],
  schemes: [],
  benefit_levels: [],
  poverty_mean_testeds: [],
  background_infos: [],
  map_indicators: [],
  map_countries: [],
  detail_charts: [],
  defaultPShinyObj: {
    param_id: '',
    ind_id: '',
    country: '', // Country Name - Cambodia
    childbenefit: false,
    disabilitybenefit: false,
    oldagebenefit: false,
    childPercentage: 0,
    disabilityPercentage: 0,
    oldagePercentage: 0,
    scheme_id: '',
    benefit_level: 'Other benefit',
    childmeansA: false,
    disabmeansA: false,
    oldmeansA: false,
    childcovA: 0,
    disabcovA: 0,
    oldcovA: 0,
    poverty_mean_tested: 'No'
  },
  dashboardFetchTimestamp: 0
};
const getters = {
  getConfigs: (state: any) => state.configs,
  getCompareConfigs: (state: any) => state.compareConfigs,
  getDashboardConfigs: (state: any) => state.dashboardConfigs,
  getUrlConfigs: (state: any) => state.urlConfigs,
  getCountry: (state: any) => state.country,
  getDashboardToolbarType: (state: any) => state.dashboardToolbarType,
  getShowToolbar: (state: any) => state.showToolbar,
  getDefaultPShinyObj: (state: any) => state.defaultPShinyObj,
  getIndicators: (state: any) => state.indicators,
  getParameters: (state: any) => state.parameters,
  getCountries: (state: any) => state.countries,
  getLabels: (state: any) => state.labels,
  getValueTypes: (state: any) => state.valueTypes,
  getSchemes: (state: any) => state.schemes,
  getBenefitLevels: (state: any) => state.benefit_levels,
  getPovertyMeanTesteds: (state: any) => state.poverty_mean_testeds,
  getBackgroundInfos: (state: any) => state.background_infos,
  getMapIndicators: (state: any) => state.map_indicators,
  getMapCountries: (state: any) => state.map_countries,
  getDetailCharts: (state: any) => state.detail_charts,
  getDashboardFetchTimestamp: (state: any) => state.dashboardFetchTimestamp
};
const actions = {
  async fetchIndicators (context: any) {
    const tempData = await axios.get(drupalApiPath + '/analysis-indicator-taxonomies');
    context.commit('setIndicators', tempData);
  },
  async fetchParameters (context: any) {
    const tempData = await axios.get(loopBackApiPath + '/parameter');
    context.commit('setParameters', tempData);
  },
  async fetchCountries (context: any) {
    const tempData = await axios.get(drupalApiPath + '/analysis-country-taxonomies');
    context.commit('setCountries', tempData);
  },
  async fetchValueTypes (context: any) {
    const tempData = await axios.get(drupalApiPath + '/analysis-value-type-taxonomies');
    context.commit('setValueTypes', tempData);
  },
  async fetchLabels (context: any) {
    const tempData = await axios.get(drupalApiPath + '/analysis-label-taxonomies');
    context.commit('setLabels', tempData);
  },
  async fetchSchemes (context: any) {
    const tempData = await axios.get(drupalApiPath + '/analysis-scheme-taxonomies');
    context.commit('setSchemes', tempData);
  },
  async fetchBenefitLevels (context: any) {
    const tempData = await axios.get(drupalApiPath + '/analysis-benefit-level-taxonomies');
    context.commit('setBenefitLevels', tempData);
  },
  async fetchPovertyMeanTesteds (context: any) {
    const tempData = await axios.get(drupalApiPath + '/analysis-poverty-mean-tested-taxonomies');
    context.commit('setPovertyMeanTesteds', tempData);
  },
  async fetchBackgroundInfos (context: any) {
    const tempData = await axios.get(drupalApiPath + '/bg-info-taxonomies');
    if (tempData && tempData.data) {
      tempData.data = tempData.data.map((d: any) => {
        const bool = d.field_enable !== 'False';
        d.enable = bool;
        return d;
      });

      tempData.data = tempData.data.filter((d: any) => {
        return d.enable;
      });
    }
    context.commit('setBackgroundInfos', tempData);
  },
  async fetchMapIndicators (context: any) {
    const tempData = await axios.get(drupalApiPath + '/map-indicator-taxonomies');
    context.commit('setMapIndicators', tempData);
  },
  async fetchMapCountries (context: any) {
    const tempData = await axios.get(drupalApiPath + '/map-country-taxonomies');
    context.commit('setMapCountries', tempData);
  },
  async fetchDetailCharts (context: any) {
    const tempData = await axios.get(drupalApiPath + '/detail-chart-taxonomies');
    context.commit('setDetailCharts', tempData);
  },
  async getBackgroundDataByCountry (context: any, countryId: any) {
    const tempData = await axios.get(drupalApiPath + '/bg-info/' + countryId);
    return tempData.data;
  },
  async getPShinyDataByScheme (context: any, filterString: any) {
    const tempData = await axios.get(pShinyApiPath + '/process?' + filterString);
    return tempData.data;
  },
  async getPShinyExistingSchemeByCountry (context: any, countryName: any) {
    const tempData = await axios.get(pShinyApiPath + '/existing_schema?country=' + countryName);
    return tempData.data;
  },
  async getBenefitPercentageData (context: any, { countryName, currencyAmount }: any) {
    countryName = countryName === 'Türkiye' ? 'Turkey' : countryName;
    const tempData = await axios.get(`${pShinyApiPath}/local_currency?country=${countryName}&inputCurrency=${currencyAmount}`);
    return tempData.data;
  },
  async getBenefitCurrencyData (context: any, { countryName, percentage }: any) {
    countryName = countryName === 'Türkiye' ? 'Turkey' : countryName;
    const tempData = await axios.get(`${pShinyApiPath}/local_currency?country=${countryName}&inputPercentage=${percentage}`);
    return tempData.data;
  },
  async getBenefitMetadata (context: any, { childMinPercentage, childMaxPercentage, disabilityMinPercentage, disabilityMaxPercentage, oldAgeMinPercentage, oldAgeMaxPercentage }: any) {
    const tempData = await axios.get(`${pShinyApiPath}/benefit_metadata?child_min_percentage=${childMinPercentage}&child_max_percentage=${childMaxPercentage}&disability_min_percentage=${disabilityMinPercentage}&disability_max_percentage=${disabilityMaxPercentage}&oldage_min_percentage=${oldAgeMinPercentage}&oldage_max_percentage=${oldAgeMaxPercentage}`);
    const data = JSON.parse(tempData.data[0]);
    return data;
  },
  async getCountryById (context: any, countryCode: string) {
    const country = state.countries.find((c: any) => c.tid === countryCode);
    return country;
  },
  async getExclusion (context: any, { countryName, scheme, minAge, maxAge, pmt }: any) {
    countryName = countryName === 'Türkiye' ? 'Turkey' : countryName;
    const fieldNames: any = {
      70001: {
        minAge: 'childMinAge',
        maxAge: 'childMaxAge',
        pmt: 'childcovA'
      },
      70002: {
        minAge: 'disabMinAge',
        maxAge: 'disabMaxAge',
        pmt: 'disabcovA'
      },
      70003: {
        minAge: 'oldMinAge',
        maxAge: 'oldMaxAge',
        pmt: 'oldcovA'
      }
    };
    const tempData = await axios.get(`${pShinyApiPath}/exclusion_errors?country=${countryName}&${fieldNames[scheme].minAge}=${minAge}&${fieldNames[scheme].maxAge}=${maxAge}&${fieldNames[scheme].pmt}=${pmt}&childMeans=true&disabMeans=true&oldMeans=true`);
    const data = JSON.parse(tempData.data[0]);
    return data;
  },
  async fetchGlossaries (context: any) {
    const tempData = await axios.get(drupalApiPath + '/glossary-taxonomies');
    return tempData.data;
  },
  async updateCountry ({ commit }: { commit: any }, configs: any) {
    commit('setCountry', configs);
  },
  async updateCountries ({ commit }: { commit: any }, data: any) {
    commit('setCountries', data);
  },
  async updateDashboardToolbarType ({ commit }: { commit: any }, configs: any) {
    commit('setDashboardToolbarType', configs);
  },
  async updateShowToolbar ({ commit }: { commit: any}, configs: any) {
    commit('setShowToolbar', configs);
  },
  async updateConfigs ({ commit }: { commit: any }, configs: any) {
    commit('setConfigs', configs);
  },
  async updateCompareConfigs ({ commit }: { commit: any }, configs: any) {
    commit('setCompareConfigs', configs);
  },
  async updateDashboardConfigs ({ commit }: { commit: any }, configs: any) {
    commit('setDashboardConfigs', configs);
  },
  async updateUrlConfigs ({ commit }: { commit: any }, configs: any) {
    commit('setUrlConfigs', configs);
  },
  async updateDashboardFetchTimestamp ({ commit }: { commit: any }, configs: any) {
    commit('setDashboardFetchTimestamp', configs);
  }
};
const mutations = {
  setCountry (state: any, res: any) {
    state.country = res;
  },
  setIndicators (state: any, res: any) {
    state.indicators = res.data;
  },
  setParameters (state: any, res: any) {
    state.parameters = res.data;
  },
  setDashboardToolbarType: (state: any, configs: any) => (state.dashboardToolbarType = configs),
  setShowToolbar: (state: any, configs: any) => (state.showToolbar = configs),
  setCountries: (state: any, res: any) => (state.countries = res.data),
  setValueTypes: (state: any, res: any) => (state.valueTypes = res.data),
  setLabels: (state: any, res: any) => (state.labels = res.data),
  setSchemes: (state: any, res: any) => (state.schemes = res.data),
  setBenefitLevels: (state: any, res: any) => (state.benefit_levels = res.data),
  setPovertyMeanTesteds: (state: any, res: any) => (state.poverty_mean_testeds = res.data),
  setBackgroundInfos: (state: any, res: any) => (state.background_infos = res.data),
  setMapIndicators: (state: any, res: any) => (state.map_indicators = res.data),
  setMapCountries: (state: any, res: any) => (state.map_countries = res.data),
  setDetailCharts: (state: any, res: any) => (state.detail_charts = res.data),
  setConfigs: (state: any, configs: any) => (state.configs = configs),
  setCompareConfigs: (state: any, configs: any) => (state.compareConfigs = configs),
  setDashboardConfigs: (state: any, configs: any) => (state.dashboardConfigs = configs),
  setUrlConfigs: (state: any, configs: any) => (state.urlConfigs = configs),
  setDashboardFetchTimestamp: (state: any, configs: any) => (state.dashboardFetchTimestamp = configs)
};

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
};
