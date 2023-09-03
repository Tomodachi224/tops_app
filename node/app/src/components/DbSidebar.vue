<template>
  <div
    class="dashboard-sidebar-container">
    <div class="d-flex flex-column flex-md-row">
      <!-- Title -->
      <div v-if="showToolbar === false">
        <button
          class="btn btn-sm bg-orange-btn text-white d-flex align-items-center py-0 px-2 rounded-0 rounded-bottom fw-light"
          @click="onClick()">
          Show Data Explorer
          <i class="uil uil-angle-double-down fs-20"></i>
        </button>
      </div>
      <div class="d-flex flex-column">
        <div v-if="showToolbar === false" class="d-flex flex-row">
          <span v-if="showToolbar === false && mode === 'comparative'" class="fw-light title-text px-2"><strong>Scenario A:</strong></span>
          <span v-if="toolbarType === 'normal'" v-html="title.scenario1" class="fw-light title-text px-2"></span>
          <span v-if="toolbarType === 'detail'" v-html="title.scenario1_detail_obj.title" class="fw-light title-text px-2"></span>
        </div>
        <div v-if="showToolbar === false && mode === 'comparative'" class="d-flex flex-row">
          <span class="fw-light title-text px-2"><strong>Scenario B:</strong></span>
          <span v-if="toolbarType === 'normal'" v-html="title.scenario2" class="fw-light title-text px-2"></span>
          <span v-if="toolbarType === 'detail'" v-html="title.scenario2_detail_obj.title" class="fw-light title-text px-2"></span>
        </div>
      </div>
      <!-- /Title -->
    </div>
    <div v-if="toolbarType === 'normal'">
      <!-- Toolbar Phase2 -->
      <div v-if="showToolbar === true" class="h-100 w-100 m-0">
        <div class="d-flex flex-row justify-content-between align-items-center">
          <div>
            <button
              class="btn btn-sm bg-orange-btn text-white d-flex align-items-center py-0 px-2 rounded-0 rounded-bottom fw-light"
              @click="onClick()">
              Hide Data Explorer
              <i class="uil uil-angle-double-up fs-20"></i>
            </button>
          </div>
          <div class="form-check form-switch ms-1 me-3">
            <input
              class="form-check-input px-4"
              type="checkbox"
              id="toggleToDetail"
              v-on:change="changeToolbarType('detail')"
              :checked="toolbarType==='detail'">
            <label class="form-check-label px-1 fw-light" for="toggleToDetail">Set your own parameters</label>
          </div>
        </div>
        <div class="d-flex flex-column flex-md-row">
          <!-- Country container -->
          <div class="country-selection-container d-flex flex-row flex-sm-row flex-md-column border border-light-blue-grey1 border-1 border-top-0 border-start-0 border-bottom-0">
            <div class="selection-container d-flex flex-row align-items-center">
              <filter-panel
                :space="4"
                :selected-object="filterPanelInputs.scenario1.selectedObject"
                :filters="filterPanelInputs.scenario1.countryFilters"
                @selectedChanged="setSidebarSelection()">
              </filter-panel>
              <div v-if="mode === 'combined'" class="mt-2 me-2 custom-tooltip">
                <span class="tooltiptext mb-2">Click to add a comparison scheme</span>
                <button
                  type="button"
                  class="add-btn border-0 rounded-1 bg-light-blue-grey3"
                  @click="changeMode('comparative', '')">
                  <i class="uil uil-plus text-white" style="font-size: 18px;"></i>
                </button>
              </div>
              <div v-if="mode === 'comparative'" class="d-flex align-items-center mt-2 me-2">
                <button
                  type="button"
                  class="close-btn border-0"
                  @click="changeMode('combined', 'scenario1')">
                  <i class="uil uil-multiply text-primary" style="font-size: 18px;"></i>
                </button>
              </div>
            </div>
            <div
              class="selection-container d-flex flex-row"
              v-if="mode === 'comparative'">
              <filter-panel
                :space="4"
                :selected-object="filterPanelInputs.scenario2.selectedObject"
                :filters="filterPanelInputs.scenario2.countryFilters"
                @selectedChanged="setSidebarSelection()">
              </filter-panel>
              <div class="d-flex align-items-center mt-2 me-2">
                <button
                  type="button"
                  class="close-btn border-0"
                  @click="changeMode('combined', 'scenario2')">
                  <i class="uil uil-multiply text-primary" style="font-size: 18px;"></i>
                </button>
              </div>
            </div>
          </div>
          <div class="p-0 border border-light-blue-grey1 border-1 border-top-0 border-start-0 border-bottom-0">
            <filter-panel
              :space="12"
              :selected-object="filterPanelInputs.pageLevel.selectedObject"
              :filters="filterPanelInputs.pageLevel.filters"
              @selectedChanged="setSidebarSelection()">
            </filter-panel>
          </div>
          <div class="p-0 d-flex flex-row flex-md-column">
            <div class="selection-container d-flex flex-row">
              <filter-panel
                :space="4"
                :selected-object="filterPanelInputs.scenario1.selectedObject"
                :filters="filterPanelInputs.scenario1.filters"
                @selectedChanged="setSidebarSelection()">
              </filter-panel>
            </div>
            <div class="selection-container d-flex flex-row" v-if="mode === 'comparative'">
              <filter-panel
                :space="4"
                :selected-object="filterPanelInputs.scenario2.selectedObject"
                :filters="filterPanelInputs.scenario2.filters"
                @selectedChanged="setSidebarSelection()">
              </filter-panel>
            </div>
          </div>
          <!-- <div class="col col-md-1 p-0 d-flex align-items-center">
            <div
              v-if="mode === 'combined'"
              class="m-auto">
              <button
                @click="changeMode('comparative', '')"
                class="btn btn-sm bg-blue-grey4 text-white fw-light add-scenario-button p-0 px-1 rounded-0"
                type="button">Add scenario
              </button>
            </div>
          </div> -->
        </div>
      </div>
      <!-- /Toolbar Phase2 -->
    </div>
    <div id="detail-toolbar" v-if="toolbarType === 'detail' && detailFilterInputs.scenario1">
      <!-- Toolbar Phase3 -->
      <div v-if="showToolbar === true" class="h-100 w-100 m-0">
        <div class="d-flex flex-row justify-content-between align-items-center">
          <div>
            <button
              class="btn btn-sm bg-orange-btn text-white d-flex align-items-center py-0 px-2 rounded-0 rounded-bottom fw-light"
              @click="onClick()">
              Hide Data Explorer
              <i class="uil uil-angle-double-up fs-20"></i>
            </button>
          </div>
          <div class="form-check form-switch ms-1 me-3">
            <input
              class="form-check-input px-4"
              type="checkbox"
              id="toggleToNormal"
              v-on:change="changeToolbarType('normal')"
              :checked="toolbarType==='detail'">
            <label class="form-check-label px-1 text-link-text fw-bold" for="toggleToNormal">Return to dashboard</label>
          </div>
        </div>
        <div class="d-flex flex-column flex-lg-row">
          <div class="country-selection-container d-flex flex-row flex-lg-column border border-light-blue-grey1 border-1 border-top-0 border-start-0 border-bottom-0">
            <div class="d-flex flex-row">
              <filter-panel
                :space="4"
                :selected-object="detailFilterInputs.scenario1.selectedObject"
                :mode-status="detailFilterInputs.scenario1.modeStatus"
                :filters="detailFilterInputs.scenario1.countryFilters"
                @selectedChanged="setSidebarSelection()">
              </filter-panel>
              <div
                v-if="mode === 'combined'"
                class="d-flex align-items-center mt-2 me-2 custom-tooltip">
                <span class="tooltiptext">Click to add a comparison scheme</span>
                <button
                  type="button"
                  class="add-btn border-0 rounded-1 bg-light-blue-grey3"
                  @click="changeMode('comparative', '')">
                  <i class="uil uil-plus text-white" style="font-size: 18px;"></i>
                </button>
              </div>
              <div v-if="mode === 'comparative'" class="d-flex align-items-center border border-light-blue-grey1 border-1 border-top-0 border-start-0 border-bottom-0 border-0 me-2 mt-2">
                <button
                  type="button"
                  class="close-btn border-0"
                  @click="changeMode('combined', 'scenario1')">
                  <i class="uil uil-multiply text-primary" style="font-size: 18px;"></i>
                </button>
              </div>
            </div>
            <div class="d-flex flex-row" v-if="mode === 'comparative'">
              <filter-panel
                :space="4"
                :selected-object="detailFilterInputs.scenario2.selectedObject"
                :mode-status="detailFilterInputs.scenario2.modeStatus"
                :filters="detailFilterInputs.scenario2.countryFilters"
                @selectedChanged="setSidebarSelection()">
              </filter-panel>
              <div class="d-flex align-items-center border border-light-blue-grey1 border-1 border-top-0 border-start-0 border-bottom-0 border-0 me-2 mt-2">
                <button
                  type="button"
                  class="close-btn border-0"
                  @click="changeMode('combined', 'scenario2')">
                  <i class="uil uil-multiply text-primary" style="font-size: 18px;"></i>
                </button>
              </div>
            </div>
          </div>
          <toolbar-table
            :selected-object-a="detailFilterInputs.scenario1.selectedObject"
            :mode-status-a="detailFilterInputs.scenario1.modeStatus"
            :filters-a="detailFilterInputs.scenario1.filters"
            :selected-object-b="detailFilterInputs.scenario2.selectedObject"
            :mode-status-b="detailFilterInputs.scenario2.modeStatus"
            :filters-b="detailFilterInputs.scenario2.filters"
            :mode="mode"
            @selectedChanged="setSidebarSelection()">
          </toolbar-table>
          <!-- <div class="col col-md-1 p-0 d-flex align-items-center">
            <div
              v-if="mode === 'combined'"
              class="m-auto">
              <button
                @click="changeMode('comparative', '')"
                class="btn btn-sm bg-blue-grey4 text-white fw-light add-scenario-button p-0 px-1 rounded-0"
                type="button">Add scenario
              </button>
            </div>
          </div> -->
        </div>
      </div>
      <!-- /Toolbar Phase3 -->
    </div>
  </div>
</template>

<script>
import axios from '@axios';
import _ from 'lodash';
import { RAPI_DOMAIN, RAPI_VERSION_URL } from '@/environment';
import { mapState, mapGetters, mapActions } from 'vuex';
import FilterPanel from '@/components/FilterPanel.vue';
import ToolbarTable from '@/components/ToolbarTable.vue';
import { getTextFromTemplate } from '../helper';
import { filterPanelInputs, detailFilterInputs } from '../data';

export default {
  props: {
    mode: { type: String, default: 'comparative' },
    inputParams: { type: Object, default: undefined }
  },
  components: {
    FilterPanel,
    ToolbarTable
  },
  computed: {
    ...mapGetters('analysis', [
      'getIndicators',
      'getCountries',
      'getValueTypes',
      'getLabels',
      'getSchemes',
      'getBenefitLevels',
      'getPovertyMeanTesteds',
      'getDashboardConfigs',
      'getDashboardToolbarType',
      'getShowToolbar'
    ]),
    ...mapGetters('user', [
      'getuserData'
    ]),
    ...mapState('analysis', [
      'compareConfigs',
      'indicators',
      'parameters',
      'dashboardToolbarType',
      'showToolbar'
    ])
  },
  data: function () {
    return {
      loopBackApiPath: `${RAPI_DOMAIN}${RAPI_VERSION_URL}`,
      filterPanelInputs: {},
      detailFilterInputs: {},
      toolbarType: 'normal', // normal , detail
      showToolbar: false,
      title: {
        scenario1: '',
        scenario2: '',
        scenario1_detail_obj: {},
        scenario2_detail_obj: {}
      }
    };
  },
  mounted: function () {
    this.initialize();
  },
  watch: {
    dashboardToolbarType: function () {
      // console.log(this.dashboardToolbarType);
      this.toolbarType = _.cloneDeep(this.getDashboardToolbarType);
      this.maintainSelection();
    },
    showToolbar: function () {
      this.showToolbar = _.cloneDeep(this.getShowToolbar);
    }
  },
  methods: {
    ...mapActions('analysis', [
      'fetchIndicators',
      'fetchCountries',
      'fetchValueTypes',
      'fetchLabels',
      'fetchSchemes',
      'fetchBenefitLevels',
      'fetchPovertyMeanTesteds',
      'fetchBackgroundInfos',
      'fetchDetailCharts',
      'updateDashboardConfigs',
      'updateDashboardToolbarType',
      'updateShowToolbar',
      'updateCountries',
      'getBenefitCurrencyData'
    ]),
    ...mapActions('user', [
      'fetchUserData'
    ]),
    initialize: function () {
      this.filterPanelInputs = _.cloneDeep(filterPanelInputs);
      this.detailFilterInputs = _.cloneDeep(detailFilterInputs);
      this.showToolbar = this.getShowToolbar;
      this.fetchListData();
      this.updateToolbarText();
    },
    // onMouseOver () {
    //   this.showToolbar = true;
    // },
    // onMouseLeave () {
    //   this.showToolbar = false;
    // },
    onClick () {
      this.showToolbar = !this.showToolbar;
      this.updateShowToolbar(this.showToolbar);
    },
    async fetchListData () {
      await this.fetchUserData();
      await this.fetchIndicators();
      await this.fetchCountries();
      await this.fetchValueTypes();
      await this.fetchLabels();
      await this.fetchSchemes();
      await this.fetchBenefitLevels();
      await this.fetchPovertyMeanTesteds();
      await this.fetchBackgroundInfos();
      await this.fetchDetailCharts();
      this.setListDataByPermission();
      this.setDropdownItemFromTaxonomies();
      this.setFirsLoadSelection();
      this.setSidebarSelection();
    },
    setListDataByPermission () {
      const userData = _.cloneDeep(this.getuserData);
      if (!userData) {
        const countryList = _.cloneDeep(this.getCountries);
        const filteredCountries = _.filter(countryList, (d) => { return d.field_is_public === 'True'; });
        this.updateCountries({ data: filteredCountries });
      }
    },
    setFirsLoadSelection () {
      const inputParams = _.cloneDeep(this.inputParams);
      let inputShowToolbar;
      const countryList = _.cloneDeep(this.getCountries);
      if (this.inputParams && Object.keys(this.inputParams).length) {
        this.mode = inputParams.mode ? inputParams.mode : this.mode;
        this.filterPanelInputs.pageLevel.selectedObject = inputParams.pageLevel ? inputParams.pageLevel : this.filterPanelInputs.pageLevel.selectedObject;
        this.filterPanelInputs.scenario1.selectedObject = inputParams.scenario1 ? inputParams.scenario1 : this.filterPanelInputs.scenario1.selectedObject;
        this.filterPanelInputs.scenario2.selectedObject = inputParams.scenario2 ? inputParams.scenario2 : this.filterPanelInputs.scenario2.selectedObject;
        this.detailFilterInputs.scenario1.selectedObject = inputParams.detailScenario1 ? inputParams.detailScenario1 : this.detailFilterInputs.scenario1.selectedObject;
        this.detailFilterInputs.scenario2.selectedObject = inputParams.detailScenario2 ? inputParams.detailScenario2 : this.detailFilterInputs.scenario2.selectedObject;

        inputShowToolbar = inputParams.showToolbar !== undefined ? inputParams.showToolbar : undefined;
        this.verifyAvailableFilter();
      } else {
        // set firstload country
        if (countryList.length) {
          const firstLoadCountry = _.orderBy(countryList, 'name')[0];
          this.filterPanelInputs.scenario1.selectedObject.country = firstLoadCountry.tid;
          this.filterPanelInputs.scenario2.selectedObject.country = firstLoadCountry.tid;
          this.detailFilterInputs.scenario1.selectedObject.country = firstLoadCountry.tid;
          this.detailFilterInputs.scenario2.selectedObject.country = firstLoadCountry.tid;
        }
      }

      if (inputShowToolbar !== undefined) {
        this.showToolbar = inputShowToolbar;
        this.updateShowToolbar(inputShowToolbar);
      }

      this.updateBenefitFirstLoad();
    },
    verifyAvailableFilter () {
      // Verify available filter
      const countryList = _.cloneDeep(this.getCountries);
      const firstLoadCountry = _.orderBy(countryList, 'name')[0];

      this.filterPanelInputs.scenario1.selectedObject.country = _.find(countryList, (d) => { return d.tid === this.filterPanelInputs.scenario1.selectedObject.country; }) ? this.filterPanelInputs.scenario1.selectedObject.country : firstLoadCountry.tid;

      this.filterPanelInputs.scenario2.selectedObject.country = _.find(countryList, (d) => { return d.tid === this.filterPanelInputs.scenario2.selectedObject.country; }) ? this.filterPanelInputs.scenario2.selectedObject.country : firstLoadCountry.tid;

      this.detailFilterInputs.scenario1.selectedObject.country = _.find(countryList, (d) => { return d.tid === this.detailFilterInputs.scenario1.selectedObject.country; }) ? this.detailFilterInputs.scenario1.selectedObject.country : firstLoadCountry.tid;

      this.detailFilterInputs.scenario2.selectedObject.country = _.find(countryList, (d) => { return d.tid === this.detailFilterInputs.scenario2.selectedObject.country; }) ? this.detailFilterInputs.scenario2.selectedObject.country : firstLoadCountry.tid;
    },
    updateBenefitFirstLoad () {
      const countryList = _.cloneDeep(this.getCountries);
      // Add benefit currency, benefit_ppp
      const countryNameAObj = countryList.find(c => c.tid === this.detailFilterInputs.scenario1.selectedObject.country);
      const countryNameBObj = countryList.find(c => c.tid === this.detailFilterInputs.scenario2.selectedObject.country);
      this.detailFilterInputs.scenario1.selectedObject.scheme_details.map(async d => {
        const benefitCurrencyObj = await this.getBenefitCurrencyObj(countryNameAObj.name, d.benefit_percent);
        d.benefit_currency = this.getRoundNumber(benefitCurrencyObj.local_currency, 2);
        d.benefit_ppp = benefitCurrencyObj.ppp_equivalent;
        return d;
      });

      this.detailFilterInputs.scenario2.selectedObject.scheme_details.map(async d => {
        const benefitCurrencyObj = await this.getBenefitCurrencyObj(countryNameBObj.name, d.benefit_percent);
        d.benefit_currency = this.getRoundNumber(benefitCurrencyObj.local_currency, 2);
        d.benefit_ppp = benefitCurrencyObj.ppp_equivalent;
        return d;
      });
    },
    getRoundNumber (num, precision) {
      return Number(Math.round(num + 'e+' + precision) + 'e-' + precision);
    },
    getBenefitCurrencyObj: async function (countryName, percentage) {
      const benefitCurrencyTemp = await this.getBenefitCurrencyData({ countryName, percentage });
      const benefitCurrency = JSON.parse(benefitCurrencyTemp[0]);
      return benefitCurrency;
    },
    getBenefitPercentageObj: async function (countryName, currencyAmount) {
      const benefitPercentageTemp = await this.getBenefitPercentageData({ countryName, currencyAmount });
      const benefitPercentage = JSON.parse(benefitPercentageTemp[0]);
      return benefitPercentage;
    },
    setDropdownItemFromTaxonomies () {
      // Set country
      const countryList = _.cloneDeep(this.getCountries);
      const mappedCountry = _.map(countryList, (d) => {
        return {
          label: d.name,
          value: d.tid
        };
      });

      this.filterPanelInputs.scenario1.countryFilters[0].items = mappedCountry;
      this.filterPanelInputs.scenario2.countryFilters[0].items = mappedCountry;
      this.detailFilterInputs.scenario1.countryFilters[0].items = mappedCountry;
      this.detailFilterInputs.scenario2.countryFilters[0].items = mappedCountry;
    },
    getArticleBenefitLevel (text) {
      let fullText = '';
      if (text === 'OECD Average') {
        fullText = `an <strong>${text}</strong>`;
      } else {
        fullText = `a <strong>${text}</strong>`;
      }
      return fullText;
    },
    getSchemeText (arr) {
      const schemeText = arr.length > 1 ? 'schemes' : 'scheme';
      const schemesLabels = arr.map(d => this.filterPanelInputs.pageLevel.filters[0].items.find(d2 => d2.value === d).label);
      let schemesLabelText = schemesLabels.join(', ');
      if (arr.length > 1) {
        const last = schemesLabels.pop();
        schemesLabelText = schemesLabels.join(', ') + ' and ' + last;
      }

      return `<strong>${schemesLabelText}</strong> ${schemeText}`;
    },
    async getTitle (obj) {
      const titleTemplate = 'In <strong>[[country]]</strong>, introducing universal [[schemes]] at [[benefitLevel]] benefit level would:';
      const sc1Data = {
        country: '',
        schemes: '',
        benefitLevel: '',
        pmt: ''
      };
      const sc2Data = {
        country: '',
        schemes: '',
        benefitLevel: '',
        pmt: ''
      };

      // Scenario 1
      const sc1CountryArr = this.filterPanelInputs.scenario1.countryFilters[0].items.filter(d => d.value === obj.scenario1.country);
      sc1Data.country = sc1CountryArr.length > 0 && sc1CountryArr[0].label ? sc1CountryArr[0].label : obj.scenario1.country;

      const schemesArr = obj.pageLevel.scheme;
      const schemesLabelText = this.getSchemeText(schemesArr);
      sc1Data.schemes = schemesLabelText;

      const sc1BenefitLevelArr = this.filterPanelInputs.scenario1.filters[0].items.filter(d => d.value === obj.scenario1.benefit_level);
      sc1Data.benefitLevel = sc1BenefitLevelArr.length > 0 && sc1BenefitLevelArr[0].label ? this.getArticleBenefitLevel(sc1BenefitLevelArr[0].label) : obj.scenario1.benefit_level;

      const sc1PmtArr = this.filterPanelInputs.scenario1.filters[1].items.filter(d => d.value === obj.scenario1.poverty_mean_tested);
      sc1Data.pmt = sc1PmtArr.length > 0 && sc1PmtArr[0].label ? sc1PmtArr[0].label : obj.scenario1.poverty_mean_tested;

      // Scenario 2
      const sc2CountryArr = this.filterPanelInputs.scenario2.countryFilters[0].items.filter(d => d.value === obj.scenario2.country);
      sc2Data.country = sc2CountryArr.length > 0 && sc2CountryArr[0].label ? sc2CountryArr[0].label : obj.scenario2.country;
      sc2Data.schemes = schemesLabelText;

      const sc2BenefitLevelArr = this.filterPanelInputs.scenario2.filters[0].items.filter(d => d.value === obj.scenario2.benefit_level);
      sc2Data.benefitLevel = sc2BenefitLevelArr.length > 0 && sc2BenefitLevelArr[0].label ? this.getArticleBenefitLevel(sc2BenefitLevelArr[0].label) : obj.scenario2.benefit_level;

      const sc2PmtArr = this.filterPanelInputs.scenario2.filters[1].items.filter(d => d.value === obj.scenario2.poverty_mean_tested);
      sc2Data.pmt = sc2PmtArr.length > 0 && sc2PmtArr[0].label ? sc2PmtArr[0].label : obj.scenario2.poverty_mean_tested;
      this.title.scenario1 = await getTextFromTemplate(titleTemplate, sc1Data);
      this.title.scenario2 = await getTextFromTemplate(titleTemplate, sc2Data);
    },
    async getDetailTitle (obj) {
      const sc1Data = {};
      const sc2Data = {};
      const childObj1 = obj.detailScenario1.scheme_details.filter(s => s.scheme === '70001')[0];
      const disObj1 = obj.detailScenario1.scheme_details.filter(s => s.scheme === '70002')[0];
      const oldObj1 = obj.detailScenario1.scheme_details.filter(s => s.scheme === '70003')[0];
      const formatObj1 = {
        child: childObj1,
        disability: disObj1,
        old_age: oldObj1
      };

      const childObj2 = obj.detailScenario2.scheme_details.filter(s => s.scheme === '70001')[0];
      const disObj2 = obj.detailScenario2.scheme_details.filter(s => s.scheme === '70002')[0];
      const oldObj2 = obj.detailScenario2.scheme_details.filter(s => s.scheme === '70003')[0];
      const formatObj2 = {
        child: childObj2,
        disability: disObj2,
        old_age: oldObj2
      };

      const schemes = ['child', 'disability', 'old_age'];
      const vals = ['benefit_percent', 'age', 'pmt', 'admin_cost', 'is_selected'];

      for (const s of schemes) {
        for (const v of vals) {
          if (v === 'age') {
            sc1Data[`${s}_${v}`] = formatObj1[s][v].join('-');
            sc2Data[`${s}_${v}`] = formatObj2[s][v].join('-');
          } else {
            sc1Data[`${s}_${v}`] = formatObj1[s][v];
            sc2Data[`${s}_${v}`] = formatObj2[s][v];
          }
        }
      }

      // Scenario 1 country
      const sc1CountryArr = this.filterPanelInputs.scenario1.countryFilters[0].items.filter(d => d.value === obj.detailScenario1.country);
      sc1Data.country = sc1CountryArr.length > 0 && sc1CountryArr[0].label ? sc1CountryArr[0].label : obj.detailScenario1.country;

      // Scenario 2 country
      const sc2CountryArr = this.filterPanelInputs.scenario2.countryFilters[0].items.filter(d => d.value === obj.detailScenario2.country);
      sc2Data.country = sc2CountryArr.length > 0 && sc2CountryArr[0].label ? sc2CountryArr[0].label : obj.detailScenario2.country;

      // Title text Phase 3
      const titleTemplatePhase3 = 'In <strong>[[country]]</strong>, introducing [[schemesText]] at selected benefit levels would:';
      const schemeArrS1 = obj.detailScenario1.scheme_details.filter(d => d.is_selected).map(d => d.scheme).sort();
      sc1Data.schemesText = this.getSchemeText(schemeArrS1);

      const schemeArrS2 = obj.detailScenario2.scheme_details.filter(d => d.is_selected).map(d => d.scheme).sort();
      sc2Data.schemesText = this.getSchemeText(schemeArrS2);

      sc1Data.title = await getTextFromTemplate(titleTemplatePhase3, sc1Data);
      sc2Data.title = await getTextFromTemplate(titleTemplatePhase3, sc2Data);

      this.title.scenario1_detail_obj = sc1Data;
      this.title.scenario2_detail_obj = sc2Data;
    },
    setSidebarSelection () {
      this.maintainSelection();
      const pageLevelConfig = _.cloneDeep(this.filterPanelInputs.pageLevel.selectedObject);
      const scenario1Config = _.cloneDeep(this.filterPanelInputs.scenario1.selectedObject);
      const scenario2Config = _.cloneDeep(this.filterPanelInputs.scenario2.selectedObject);
      const scenario1DetailConfig = _.cloneDeep(this.detailFilterInputs.scenario1.selectedObject);
      const scenario2DetailConfig = _.cloneDeep(this.detailFilterInputs.scenario2.selectedObject);
      const updateObj = {
        mode: this.mode,
        pageLevel: pageLevelConfig,
        scenario1: scenario1Config,
        scenario2: scenario2Config,
        detailScenario1: scenario1DetailConfig,
        detailScenario2: scenario2DetailConfig
      };
      this.getTitle(updateObj);
      this.getDetailTitle(updateObj);
      this.updateDashboardConfigs({
        ...this.getDashboardConfigs,
        ...updateObj
      });
      this.updateToolbarText();
    },
    maintainSelection () {
      const pageLevelConfig = _.cloneDeep(this.filterPanelInputs.pageLevel.selectedObject);

      const scenario1Config = _.cloneDeep(this.filterPanelInputs.scenario1.selectedObject);
      const scenario2Config = _.cloneDeep(this.filterPanelInputs.scenario2.selectedObject);

      let scenario1DetailConfig = _.cloneDeep(this.detailFilterInputs.scenario1.selectedObject);
      let scenario2DetailConfig = _.cloneDeep(this.detailFilterInputs.scenario2.selectedObject);

      if (this.toolbarType === 'normal') {
        // Set selected Scenario
        const selectedScheme = pageLevelConfig.scheme;
        _.each(this.detailFilterInputs.scenario1.selectedObject.scheme_details, (scd, i) => {
          let bool = true;
          if (selectedScheme.indexOf(scd.scheme) === -1) {
            bool = false;
          }
          this.detailFilterInputs.scenario1.selectedObject.scheme_details[i].is_selected = bool;
          this.detailFilterInputs.scenario2.selectedObject.scheme_details[i].is_selected = bool;
        });

        // Set Country
        const s1Country = scenario1Config.country;
        const s2Country = scenario2Config.country;
        this.detailFilterInputs.scenario1.selectedObject.country = s1Country;
        this.detailFilterInputs.scenario2.selectedObject.country = s2Country;

        // Set Benefit Level
        const s1Benefit = scenario1Config.benefit_level;
        const s2Benefit = scenario2Config.benefit_level;
        const benefitArr30002 = [4, 14, 16];
        const benefitArr30003 = [4, 23, 22];
        const s1benefitAssign = s1Benefit === '30003' ? benefitArr30003 : benefitArr30002;
        const s2benefitAssign = s2Benefit === '30003' ? benefitArr30003 : benefitArr30002;

        // Set Coverage
        const s1Poverty = scenario1Config.poverty_mean_tested;
        const s2Poverty = scenario2Config.poverty_mean_tested;
        const s1PovertyAssign = s1Poverty === '80002' ? 40 : 100;
        const s2PovertyAssign = s2Poverty === '80002' ? 40 : 100;

        _.each(this.detailFilterInputs.scenario1.selectedObject.scheme_details, (scd, i) => {
          this.detailFilterInputs.scenario1.selectedObject.scheme_details[i].benefit_percent = s1benefitAssign[i];
          this.detailFilterInputs.scenario2.selectedObject.scheme_details[i].benefit_percent = s2benefitAssign[i];
          this.detailFilterInputs.scenario1.selectedObject.scheme_details[i].pmt = s1PovertyAssign;
          this.detailFilterInputs.scenario2.selectedObject.scheme_details[i].pmt = s2PovertyAssign;
          this.detailFilterInputs.scenario1.selectedObject.scheme_details[i].admin_cost = 5;
          this.detailFilterInputs.scenario2.selectedObject.scheme_details[i].admin_cost = 5;
        });
      } else if (this.toolbarType === 'detail') {
        // Set Scenario
        const filteredActive = _.filter(scenario1DetailConfig.scheme_details, (d) => {
          return d.is_selected;
        });

        // Case all scenario1 are inactive
        if (filteredActive.length === 0 && this.mode === 'comparative') {
          this.detailFilterInputs.scenario1.selectedObject = _.cloneDeep(scenario2DetailConfig);
          this.detailFilterInputs.scenario2.selectedObject = _.cloneDeep(detailFilterInputs.scenario2.selectedObject);
          this.mode = 'combined';
          scenario1DetailConfig = _.cloneDeep(this.detailFilterInputs.scenario1.selectedObject);
          scenario2DetailConfig = _.cloneDeep(this.detailFilterInputs.scenario2.selectedObject);
        }

        this.filterPanelInputs.pageLevel.selectedObject.scheme = _.map(filteredActive, 'scheme');

        // Set country
        const s1DCountry = scenario1DetailConfig.country;
        const s2DCountry = scenario2DetailConfig.country;
        this.filterPanelInputs.scenario1.selectedObject.country = s1DCountry;
        this.filterPanelInputs.scenario2.selectedObject.country = s2DCountry;

        // Set Coverage
        const s1DCoverage = (scenario1DetailConfig.scheme_details[0].pmt === 100) || (scenario1DetailConfig.scheme_details[1].pmt === 100) || (scenario1DetailConfig.scheme_details[2].pmt === 100);
        const s2DCoverage = (scenario2DetailConfig.scheme_details[0].pmt === 100) || (scenario2DetailConfig.scheme_details[1].pmt === 100) || (scenario2DetailConfig.scheme_details[2].pmt === 100);
        this.filterPanelInputs.scenario1.selectedObject.poverty_mean_tested = s1DCoverage ? '80001' : '80002';
        this.filterPanelInputs.scenario2.selectedObject.poverty_mean_tested = s2DCoverage ? '80001' : '80002';
      }
    },
    changeMode (nextMode, removedScenario) {
      this.mode = nextMode;
      const scenario2Config = _.cloneDeep(this.filterPanelInputs.scenario2.selectedObject);
      const scenario2DetailConfig = _.cloneDeep(this.detailFilterInputs.scenario2.selectedObject);
      if (removedScenario === 'scenario1') {
        this.filterPanelInputs.scenario1.selectedObject = scenario2Config;
        if (this.toolbarType === 'detail') {
          this.detailFilterInputs.scenario1.selectedObject = scenario2DetailConfig;
        }
      }
      this.setSidebarSelection();
    },
    changeToolbarType (type) {
      this.updateDashboardToolbarType(type);
      this.setSidebarSelection();
    },
    updateToolbarText () {
      if (this.mode === 'combined') {
        this.filterPanelInputs.scenario1.countryFilters[0].label = 'Select country:';
        if (this.toolbarType === 'detail') {
          this.detailFilterInputs.scenario1.countryFilters[0].label = 'Select country:';
        }
      } else if (this.mode === 'comparative') {
        this.filterPanelInputs.scenario1.countryFilters[0].label = 'Scenario A:';
        if (this.toolbarType === 'detail') {
          this.detailFilterInputs.scenario1.countryFilters[0].label = 'Scenario A:';
        }
      }
    }
  },
  setup () {
    return {
    };
  }
};
</script>

<style lang="scss">
.dashboard-sidebar-container {
  font-size: 12px;
}
.form-label {
  margin-bottom: 0 !important;
}
.filter-container {
  text-align: left;
  width: 25%;
}
.vs__dropdown-menu {
  z-index: 9999 !important;
}
.v-select ul {
  padding: 0 !important;
  width: auto;
  min-width: 100%;
}
.v-select {
  background: white;
  // font-size: 10px;
}
.v-select input {
  position: absolute;
}
.vs__dropdown-toggle {
  cursor: pointer !important;
  // white-space: nowrap !important;
  overflow: hidden !important;
}

.close-btn, .add-btn {
  background: transparent;
  &:hover {
    i {
      color: #000000 !important;
    }
  }
}

.title-text {
  font-size: 160%;
}

// Popover
.popover {
  border-radius: 0;
  .popover-header {
    background: #EEF0F6;
  }
}

// detail
.detail-toolbar {
  min-height: 80px;
}
.table-header {
  font-size: 0.7rem;
}
.table-header-sm {
  font-size: 0.5rem;
}
.table-content {
  font-size: 0.8rem;
}
.table-content-sm {
  font-size: 0.5rem;
}

@media (max-width: 575px) {
  .selection-container {
    width: 50% !important;
  }
  // .dashboard-sidebar-container {
  //   font-size: 7px !important;
  // }
}

.custom-tooltip:hover .tooltiptext {
  visibility: visible;
}

.custom-tooltip .tooltiptext {
  visibility: hidden;
  width: 220px;
  background-color: white;
  color: darkgrey;
  padding: 5px 5px;
  border-radius: 6px;
  font-size: 13px;
  border: 1px solid darkgrey;
  position: absolute;
  z-index: 1;
  bottom: 75%;
  left: -100%;
  margin-left: -60px;
  text-align: left;
}

.custom-tooltip {
  position: relative;
  display: inline-block;
}

</style>
