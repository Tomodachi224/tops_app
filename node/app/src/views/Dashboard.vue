<template>
  <div class="dashboard-page-container">
    <div>
      <div class="content-container">
          <grid-layout
            v-if="layout && layout.length"
            class="grid-layout-container bg-white"
            :layout="layout"
            :col-num="4"
            :cols="{ lg: 4, md: 4, sm: 4, xs: 4, xxs: 4 }"
            :row-height="dynamicHeight"
            :margin="[5,5]"
            :is-draggable="draggable"
            :is-resizable="resizable"
            :responsive="responsive"
            :vertical-compact="true"
            :auto-size="true"
            :use-css-transforms="true">
              <grid-item
                v-for="(item, index) in layout"
                class="grid-item-container shadow rounded bg-white border-light-blue-grey3 border-1 m-0 d-flex align-items-stretch"
                v-bind:class="{
                  active: getActiveStatus(item.i),
                  clickable: getGridItemClass(item.i).includes('hoverable'),
                  isSectionDetail: (item.i === 'sectionDetail')
                }"
                :key="'grid-item-'+ index"
                :static="item.static"
                :x="item.x"
                :y="item.y"
                :w="item.w"
                :h="item.h"
                :i="item.i">
                  <div
                    @click="clickGridItem(item.i, $event)"
                    class="grid"
                    :class="getGridItemClass(item.i)"
                    style="width: -webkit-fill-available; height: -webkit-fill-available;">
                    <!-- <span class="text grid-num-text">{{item.i}}</span> -->
                    <div v-if="pageData[item.i] && pageData[item.i].isLoading" class="height-100">
                      <div class="spinner-box">
                        <loading-spinner></loading-spinner>
                      </div>
                    </div>
                    <div v-if="pageData[item.i] && !pageData[item.i].isLoading" class="height-100">
                      <button
                        v-if="item.i === 'sectionDetail'"
                        @click="clickGridItem('close', $event)"
                        type="button"
                        class="btn-close close-button-container text-white"
                        aria-label="Close"></button>
                      <components
                        class="component-container"
                        :is="pageData[item.i].type"
                        v-bind="pageData[item.i].data"
                        @clickNavigate="function (nvClicked) {clickGridItem(nvClicked.pageName, nvClicked.event)}"
                        @chartCustomFilterChanged="function (chartCustomFilter) {updateChartCustomFilter(chartCustomFilter)}"
                        @chartSelectedTabChanged="function (selectedTabChanged) {updateSelectedTab(selectedTabChanged)}"
                        >
                      </components>
                    </div>
                  </div>
              </grid-item>
          </grid-layout>
      </div>
    </div>
  </div>
</template>

<script>
import BackgroundInfo from '@/components/BackgroundInfo.vue';
import ChartSection from '@/components/ChartSection.vue';
import Infographic from '@/components/Infographic.vue';
import { RAPI_DOMAIN, RAPI_VERSION_URL } from '@/environment';
import axios from '@axios';
import LoadingSpinner from '@wc/loading-spinner/loading-spinner.vue';
import _ from 'lodash';
import { GridItem, GridLayout } from 'vue-grid-layout';
import { mapActions, mapGetters, mapState } from 'vuex';
import { chartSectionData, infoGraphicData, layoutData, sectionFilterData } from '../data';
import { getCsvDownloadData, getTextFromTemplate } from '../helper';

export default {
  components: {
    GridLayout,
    GridItem,
    ChartSection,
    Infographic,
    BackgroundInfo,
    LoadingSpinner
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
      'getBackgroundInfos',
      'getDashboardConfigs',
      'getDashboardToolbarType',
      'getShowToolbar',
      'getDefaultPShinyObj',
      'getDetailCharts',
      'getDashboardFetchTimestamp'
    ]),
    ...mapState('analysis', [
      'dashboardConfigs',
      'dashboardToolbarType',
      'showToolbar',
      'indicators',
      'parameters'
    ])
  },
  data: function () {
    return {
      loopBackApiPath: `${RAPI_DOMAIN}${RAPI_VERSION_URL}`,
      draggable: false,
      resizable: false,
      responsive: true,
      dynamicHeight: 0,
      layout: [
        { x: 0, y: 0, w: 16, h: 20 }
      ],
      responsiveLayouts: {
        lg: [
          { x: 0, y: 0, w: 16, h: 20 }
        ],
        sm: [
          { x: 0, y: 0, w: 16, h: 20 }
        ]
      },
      pageData: {},
      downloadedData: {},
      mode: 'combined',
      toolbarMode: 'normal',
      isShowToolbar: false,
      scenarioList: ['scenario1'],
      comparativeScenarioList: ['scenario1', 'scenario2'],
      sectionList: ['section1', 'section2', 'section3', 'section4', 'section5', 'section6'],
      infographicData: {}, // import from file to reduce line of code
      filterPanelInputs: {}, // import from file to reduce line of code
      chartSectionsData: {}, // import from file to reduce line of code
      currentPage: 'home',
      currentTopic: '',
      breadCrumb: ['home'],
      childrenList: {
        section1: 'poverty0',
        section2: 'inequality0',
        section3: 'cost0',
        section4: 'coverage0',
        section5: 'expenditure0'
      },
      redirectList: {
        small_info1: 'section1',
        small_info2: 'section2',
        small_info3: 'section3',
        small_info4: 'section4',
        small_info5: 'section5',
        section1: 'poverty0',
        section2: 'inequality0',
        section3: 'cost0',
        section4: 'coverage0',
        section5: 'expenditure0',
        sectionCompare1: 'scPoverty0',
        sectionCompare2: 'scInequality0',
        sectionCompare3: 'scCost0',
        sectionCompare4: 'scCoverage0',
        sectionCompare5: 'scExpenditure0'
      },
      parentList: [
        {
          name: 'home',
          children: ['section1', 'section2', 'section3', 'section4', 'section5', 'section6']
        },
        {
          name: 'home',
          children: ['poverty0', 'poverty1', 'poverty2', 'poverty3', 'poverty4', 'poverty5_comparison']
        },
        {
          name: 'home',
          children: ['inequality0', 'inequality1', 'inequality2_comparison']
        },
        {
          name: 'home',
          children: ['cost0', 'cost1', 'cost2', 'cost3', 'cost4', 'cost5_comparison']
        },
        {
          name: 'home',
          children: ['coverage0', 'coverage1', 'coverage2', 'coverage3', 'coverage4_comparison', 'coverage5_exclusion']
        },
        {
          name: 'home',
          children: ['expenditure0', 'expenditure1', 'expenditure2', 'expenditure3', 'expenditure4_comparison']
        }
      ],
      negativeValueCharts: [
        'section1', 'section2',
        'poverty0', 'poverty1', 'poverty2', 'poverty3', 'poverty4', 'poverty5_comparison',
        'inequality0', 'inequality1', 'inequality2_comparison',
        'sectionCompare1', 'sectionCompare2',
        'scPoverty0', 'scPoverty1', 'scPoverty2', 'scPoverty3', 'scPoverty4',
        'scInequality0', 'scInequality1'
      ],
      inequalityChart: [
        'section2',
        'inequality0', 'inequality1', 'inequality2_comparison',
        'sectionCompare2',
        'scInequality0', 'scInequality1'
      ],
      max50GroupSection: [
        'section2', 'section5', 'sectionCompare2', 'sectionCompare5',
        'inequality0', 'inequality1', 'inequality2_comparison',
        'expenditure0', 'expenditure1', 'expenditure2', 'expenditure3', 'expenditure4_comparison',
        'scInequality0', 'scInequality1',
        'scExpenditure0', 'scExpenditure1', 'scExpenditure2', 'scExpenditure3',
        'cost3'
      ],
      formatNoSchemeIndicator: ['40007', '40008', '40009', '40010', '40011'],
      formatExistingSchemeIndicator: ['40007', '40008', '40009', '40010', '40011'],
      phase3CustomFilter: {},
      isUseSpecialCoverage: false,
      glossaries: [],
      latestSelectedTab: '',
      latestSelectedCustomFilter: undefined
    };
  },
  mounted: function () {
    this.initialize();
    this.getDynamicHeight();
  },
  watch: {
    dashboardConfigs: function () {
      this.mode = this.getDashboardConfigs.mode;
      this.chartSectionData = this.getChartSectionData();

      // Comparative Section 3, Current year data
      const currentYear = String(new Date().getFullYear());
      const labelList = _.cloneDeep(this.getLabels);
      const labelId = labelList.filter(d => d.name === currentYear).length > 0 ? labelList.filter(d => d.name === currentYear)[0].tid : '';
      // this.filterPanelInputs.sectionCompare3.selectedObject.label = labelId;
      // this.infographicData.section3.filter.label = labelId;
      this.getDynamicHeight();
      this.fetchSectionList();
    },
    dashboardToolbarType: function () {
      this.toolbarMode = this.getDashboardToolbarType;
      this.getDynamicHeight();
    },
    showToolbar: function () {
      this.isShowToolbar = this.getShowToolbar;
      this.updateURLFromSelection();
      this.getDynamicHeight();
    }
  },
  methods: {
    ...mapActions('analysis', [
      'getBackgroundDataByCountry',
      'getPShinyDataByScheme',
      'updateDashboardToolbarType',
      'updateDashboardFetchTimestamp',
      'fetchGlossaries',
      'getExclusion'
    ]),
    initialize: async function () {
      this.filterPanelInputs = _.cloneDeep(sectionFilterData);
      this.chartSectionsData = _.cloneDeep(chartSectionData);
      this.infographicData = _.cloneDeep(infoGraphicData);
      this.glossaries = await this.fetchGlossaries();
    },
    getDynamicHeight () {
      const bodyH = document.body.offsetHeight;
      const headerH = 49;
      let buttonBarH = 38;
      let toolbarH = 80;

      if (this.isShowToolbar === false) {
        toolbarH = 0;
        if (this.mode === 'comparative') {
          buttonBarH = 65;
        }
      } else {
        toolbarH = 80;
        if (this.mode === 'comparative' || this.toolbarMode === 'detail') {
          toolbarH = 160;
        }
      }
      const footerH = 62;
      const gapH = 50;
      const contentH = bodyH - (headerH + buttonBarH + toolbarH + footerH + gapH);
      const rowNum = 9;
      this.dynamicHeight = (contentH / rowNum);
    },
    clickGridItem (itemId, event) {
      if (event) {
        // event.preventDefault();
        event.stopPropagation();
      }

      if (itemId === 'close') {
        const foundParentObj = _.find(this.parentList, (d) => {
          return d.children.indexOf(this.currentPage) > -1;
        });
        const parent = foundParentObj ? foundParentObj.name : 'home';
        itemId = parent;
      }

      if (this.redirectList[itemId]) {
        itemId = _.cloneDeep(this.redirectList[itemId]);
      }

      if (['sectionDetail'].indexOf(itemId) === -1) {
        this.currentPage = itemId;
        const tempChartSectionData = this.chartSectionsData ? this.chartSectionsData : chartSectionData;
        this.currentTopic = tempChartSectionData[itemId] ? tempChartSectionData[itemId].topic : '';
        this.breadCrumb = [itemId];
        this.fetchSectionList();
      }
    },
    getChartSectionData () {
      const result = this.chartSectionsData ? this.chartSectionsData : chartSectionData;
      const detailCharts = this.getDetailCharts;
      const keys = Object.keys(result);
      for (const k of keys) {
        const foundDetailChart = _.find(detailCharts, d => { return d.name === k; });
        if (foundDetailChart) {
          const title = foundDetailChart.field_title === '' ? undefined : foundDetailChart.field_title;
          result[k].title = title;
          result[k].tabTypes[0].insight = foundDetailChart.field_insight;
          result[k].tabTypes[0].pmt_insight = foundDetailChart.field_pmt_insight;
          result[k].tabTypes[0].insight2 = foundDetailChart.field_insight2;
          result[k].tabTypes[0].paragraph = foundDetailChart.field_paragraph;
          if (result[k].tabTypes[0] &&
            result[k].tabTypes[0].textOptions &&
            result[k].tabTypes[0].textOptions.xLabel) {
            result[k].tabTypes[0].textOptions.xLabel = foundDetailChart.field_x_label;
            result[k].tabTypes[0].textOptions.yLabel = foundDetailChart.field_y_label;
          }
        }
      }
      return result;
    },
    updateChartCustomFilter (chartCustomFilter) {
      // console.log('chartCustomFilter', chartCustomFilter);
      this.isUseSpecialCoverage = false;
      this.latestSelectedCustomFilter = _.cloneDeep(chartCustomFilter.selectedObject);
      this.phase3CustomFilter[chartCustomFilter.section].selectedObject = _.cloneDeep(chartCustomFilter.selectedObject);

      if (chartCustomFilter.selectedObject &&
        chartCustomFilter.selectedObject.page_id &&
        chartCustomFilter.selectedObject.page_id !== this.currentPage) {
        this.clickGridItem(chartCustomFilter.selectedObject.page_id, undefined);
      } else {
        const allSelectedObjectKeys = Object.keys(chartCustomFilter.selectedObject);
        if (allSelectedObjectKeys.indexOf('special_cov') > -1) {
          this.isUseSpecialCoverage = _.cloneDeep(chartCustomFilter.selectedObject.special_cov);
        }
        this.fetchSectionList();
      }
    },
    updateSelectedTab (selectedTab) {
      this.latestSelectedTab = _.cloneDeep(selectedTab);
    },
    async fetchSectionList () {
      const timestamp = new Date().getTime();
      this.updateDashboardFetchTimestamp(timestamp);
      this.updateLayout();
      const sectionList = this.sectionList;
      // @Todo : Hot fixed for detail section not get width properly
      await new Promise(resolve => setTimeout(resolve, 50));
      _.each(sectionList, (s) => {
        if (s === 'sectionDetail' && this.pageData[s]) {
          this.pageData[s] = undefined;
        }
        this.fetchChartData(s, timestamp);
      });

      this.updateURLFromSelection();
    },
    getActiveStatus (itemId) {
      let status = false;
      if (itemId === this.currentPage) {
        status = true;
      }
      return status;
    },
    getGridItemClass (itemId) {
      let classText = '';
      classText += this.filterPanelInputs[itemId] && this.filterPanelInputs[itemId].class ? this.filterPanelInputs[itemId].class : '';
      return classText;
    },
    updateURLFromSelection () {
      const mode = this.mode;
      const toolbarMode = this.toolbarMode;
      const showToolbar = this.getShowToolbar;
      let dashboardConfigs = _.cloneDeep(this.getDashboardConfigs);
      dashboardConfigs = _.merge(dashboardConfigs, { showToolbar: showToolbar });
      const newUrlIS = `${window.location.origin}/dashboard-app/${mode}/${toolbarMode}?filter=${JSON.stringify(dashboardConfigs)}`;
      history.pushState({}, null, newUrlIS);
    },
    updateLayout () {
      this.layout = undefined;
      // @Todo : default break point
      // default: { lg: 1200, md: 996, sm: 768, xs: 480, xxs: 0 }
      // lg screen

      const dbLayouts = _.cloneDeep(layoutData);
      let foundLayoutObj = _.find(dbLayouts, (d) => { return d.pages.indexOf(this.currentPage) > -1; });

      // @todo : handle when switch to comparemode with cannot find layout
      if (this.mode === 'comparative' && !foundLayoutObj.sectionListCompare) {
        this.currentPage = 'home';
        this.currentTopic = '';
        foundLayoutObj = _.find(dbLayouts, (d) => { return d.pages.indexOf(this.currentPage) > -1; });
      }

      const screenWidth = window.innerWidth;
      let drawLayout = _.cloneDeep(foundLayoutObj.layout.default);
      if (screenWidth <= 1000) {
        drawLayout = foundLayoutObj.layout.xs ? _.cloneDeep(foundLayoutObj.layout.xs) : drawLayout;
      }

      if (this.mode === 'combined') {
        this.sectionList = _.cloneDeep(foundLayoutObj.sectionList.default);
      } else if (this.mode === 'comparative') {
        this.sectionList = _.cloneDeep(foundLayoutObj.sectionListCompare.default);
      }

      if (this.currentPage !== 'home' && this.sectionList.indexOf(this.currentPage) === -1) {
        let pageList = [];

        if (this.mode === 'combined') {
          pageList = foundLayoutObj.childPageList ? foundLayoutObj.childPageList.default : [];
        } else if (this.mode === 'comparative') {
          pageList = foundLayoutObj.childPageList ? foundLayoutObj.childPageList.compare : [];
        }

        if (pageList.indexOf(this.currentPage) === -1) {
          this.currentPage = this.sectionList[0];
          if (this.redirectList[this.currentPage]) {
            this.currentPage = _.cloneDeep(this.redirectList[this.currentPage]);
          }
          this.currentTopic = chartSectionData[this.currentPage].topic;
        }
      }

      _.each(drawLayout, (d, i) => {
        drawLayout[i].i = _.cloneDeep(this.sectionList[i]);
        drawLayout[i].child = this.childrenList[drawLayout[i].i];
      });

      this.layout = _.cloneDeep(drawLayout);
    },
    async fetchChartData (sectionName, fetchTimestamp) {
      const tempSectionName = sectionName === 'sectionDetail' ? this.currentPage : sectionName;
      const sectionFilterObj = _.cloneDeep(this.filterPanelInputs[tempSectionName].selectedObject);
      let sectionType = this.filterPanelInputs[sectionName].type;
      const scenarioList = this.mode === 'comparative' ? this.comparativeScenarioList : this.scenarioList;
      const dashboardConfigs = _.cloneDeep(this.getDashboardConfigs);
      const chartSection = this.chartSectionsData[tempSectionName];
      const isRegionalComparison = chartSection && chartSection.isRegionalComparison ? chartSection.isRegionalComparison : undefined;
      const isExclusionChartType = chartSection && chartSection.isExclusionChartType ? chartSection.isExclusionChartType : undefined;
      const toolbarType = _.cloneDeep(this.getDashboardToolbarType);
      const filterObj = {
        scenario1: { where: {} },
        scenario2: { where: {} }
      };

      const isFormatNoScheme = this.filterPanelInputs[tempSectionName].selectedObject &&
        this.negativeValueCharts.indexOf(tempSectionName) > -1 &&
        this.formatNoSchemeIndicator.indexOf(this.filterPanelInputs[tempSectionName].selectedObject.indicator) > -1;

      const dataArr = {
        scenario1: [],
        scenario2: []
      };
      const rawDataArr = {
        scenario1: [],
        scenario2: []
      };
      let tempData1 = [];
      let tempData2 = [];

      if (sectionName === 'sectionDetail' && this.filterPanelInputs[tempSectionName].childSectionType) {
        sectionType = this.filterPanelInputs[tempSectionName].childSectionType;
      }

      if (['chart-section', 'infographic'].indexOf(sectionType) > -1) {
        // Normal case
        if (toolbarType === 'normal') {
          _.each(scenarioList, (scenario) => {
            const tempObj = _.chain(_.cloneDeep(sectionFilterObj))
              .merge(dashboardConfigs.pageLevel)
              .merge(dashboardConfigs[scenario])
              .value();

            _.each(Object.keys(tempObj), (d) => {
              const filterValue = tempObj[d];
              if (filterValue !== undefined) {
                if (d === 'scheme') {
                  let schemeArr = [];
                  if (filterValue.length > 1) {
                    schemeArr = _.concat(filterValue, [filterValue.sort().join('_')]);
                  } else {
                    schemeArr = filterValue;
                  }
                  filterObj[scenario].where[d] = { inq: schemeArr };
                } else if (d === 'special_cov') {
                  filterObj[scenario].where[d] = filterValue;
                  if (['sectionDetail'].indexOf(sectionName) > -1) {
                    filterObj[scenario].where[d] = _.cloneDeep(this.isUseSpecialCoverage);
                  }
                } else if (d === 'pension_tested') {
                  filterObj[scenario].where[d] = filterValue;
                } else if (d === 'country') {
                  if (!isRegionalComparison) {
                    filterObj[scenario].where[d] = { inq: filterValue.split('_') };
                  }
                } else {
                  filterObj[scenario].where[d] = { inq: filterValue.split('_') };
                }
              }
            });

            // Special case for some section that need to fetch both post reform and with no benefit
            if (this.formatNoSchemeIndicator.indexOf(filterObj[scenario].where.indicator.inq[0]) > -1) {
              filterObj[scenario].where.benefit_level.inq.push('30004');
            }
            // Special case for some section needed existing scheme;
            if (this.formatExistingSchemeIndicator.indexOf(filterObj[scenario].where.indicator.inq[0]) > -1) {
              filterObj[scenario].where.benefit_level.inq.push('30005');
            }
          });

          const URL1 = `${this.loopBackApiPath}/spp-data?filter=${JSON.stringify(filterObj.scenario1)}`;
          const checkKey1 = JSON.stringify(filterObj.scenario1);
          if (this.downloadedData[checkKey1]) {
            tempData1 = _.cloneDeep(this.downloadedData[checkKey1]);
          } else {
            this.pageData[sectionName] = { isLoading: true };
            tempData1 = await axios.get(URL1);
            this.downloadedData[checkKey1] = _.cloneDeep(tempData1);
          }

          dataArr.scenario1 = tempData1.data ? this.formatDataWithTaxonomy(tempData1.data, 'Scenario A') : [];
          if (this.mode === 'comparative') {
            const URL2 = `${this.loopBackApiPath}/spp-data?filter=${JSON.stringify(filterObj.scenario2)}`;
            const checkKey2 = JSON.stringify(filterObj.scenario2);
            if (this.downloadedData[checkKey2]) {
              tempData2 = _.cloneDeep(this.downloadedData[checkKey2]);
            } else {
              tempData2 = await axios.get(URL2);
              this.downloadedData[checkKey2] = _.cloneDeep(tempData2);
            }
            dataArr.scenario2 = tempData2.data ? this.formatDataWithTaxonomy(tempData2.data, 'Scenario B') : [];
          }

          // keep for use in some chart
          rawDataArr.scenario1 = _.cloneDeep(dataArr.scenario1);
          rawDataArr.scenario2 = _.cloneDeep(dataArr.scenario2);
          if (isFormatNoScheme) {
            dataArr.scenario1 = this.formatDataWithNoScheme(dataArr.scenario1);
            if (this.mode === 'comparative') {
              dataArr.scenario2 = this.formatDataWithNoScheme(dataArr.scenario2);
            }
          }
        } else if (toolbarType === 'detail') {
          // need to convert filter obj to string

          // if (isExclusionChartType) {
          //   const tempExclusionData = await this.getExclusionData(
          //     sectionName,
          //     dashboardConfigs.detailScenario1,
          //     'Scenario A');
          //   dataArr.scenario1 = tempExclusionData;
          // }
          const pShinyIndicator = this.filterPanelInputs[tempSectionName].selectedObject.indicator;
          const tempPShinyData = await this.getPShinyDataByFilterObject(
            sectionName,
            dashboardConfigs.detailScenario1,
            sectionFilterObj,
            pShinyIndicator,
            'Scenario A',
            fetchTimestamp);
          dataArr.scenario1 = tempPShinyData;
          // console.log('check dashboardConfigs', dashboardConfigs);

          if (this.mode === 'comparative') {
            const tempPShinyData2 = await this.getPShinyDataByFilterObject(
              sectionName,
              dashboardConfigs.detailScenario2,
              sectionFilterObj,
              pShinyIndicator,
              'Scenario B',
              fetchTimestamp);
            dataArr.scenario2 = tempPShinyData2;
          }

          if (isExclusionChartType) {
            dataArr.scenario1 = this.formatExclusionChartData(
              dataArr.scenario1,
              dashboardConfigs.detailScenario1);
          }

          // keep for use in some chart
          // console.log('dataArr.scenario1', tempSectionName, _.cloneDeep(dataArr.scenario1));
          rawDataArr.scenario1 = _.cloneDeep(dataArr.scenario1);
          rawDataArr.scenario2 = _.cloneDeep(dataArr.scenario2);
          if (isFormatNoScheme) {
            dataArr.scenario1 = this.formatDataWithNoScheme(dataArr.scenario1);
            if (this.mode === 'comparative') {
              dataArr.scenario2 = this.formatDataWithNoScheme(dataArr.scenario2);
            }
          }
        }

        const tempMergeData = _.concat(dataArr.scenario1, dataArr.scenario2);
        const tempMergeRawData = _.concat(rawDataArr.scenario1, rawDataArr.scenario2);

        if (sectionType === 'infographic') {
          const tempDataArr1 = _.cloneDeep(dataArr.scenario1);
          const topicName = chartSectionData[sectionName].topic;
          let infoGraphicData = await this.getInfoGraphicData(tempSectionName, tempDataArr1, undefined, this.childrenList[sectionName], topicName);
          if (this.mode === 'comparative') {
            const tempDataArr2 = _.cloneDeep(dataArr.scenario2);
            infoGraphicData = await this.getInfoGraphicData(tempSectionName, tempDataArr1, tempDataArr2, this.childrenList[sectionName], topicName);
          }

          this.setInfoGraphicObj(sectionName, infoGraphicData, fetchTimestamp);
        } else if (sectionType === 'chart-section') {
          this.formatChartData(tempSectionName, tempMergeData, tempMergeRawData, sectionName, fetchTimestamp);
        }
      } else if (['background-info', 'background-info-sub'].indexOf(sectionType) > -1) {
        const countryId = dashboardConfigs.scenario1.country;
        const bgCheckKey1 = 'bg_info_' + countryId;
        let rawBgInfoData = [];
        if (this.downloadedData[bgCheckKey1]) {
          rawBgInfoData = _.cloneDeep(this.downloadedData[bgCheckKey1]);
        } else {
          rawBgInfoData = await this.getBackgroundDataByCountry(countryId);
          this.downloadedData[bgCheckKey1] = _.cloneDeep(rawBgInfoData);
        }
        let countryName = this.getCountryField(countryId, 'name');
        let rawComInfoData = [];
        const countryCodes = [this.getCountryField(countryId, 'field_code')];
        if (this.mode === 'comparative' && dashboardConfigs.scenario2.country !== countryId) {
          const bgCheckKey2 = 'bg_info_' + dashboardConfigs.scenario2.country;
          if (this.downloadedData[bgCheckKey2]) {
            rawComInfoData = _.cloneDeep(this.downloadedData[bgCheckKey2]);
          } else {
            rawComInfoData = await this.getBackgroundDataByCountry(dashboardConfigs.scenario2.country);
            this.downloadedData[bgCheckKey2] = _.cloneDeep(rawComInfoData);
          }
          const compCountryName = this.getCountryField(dashboardConfigs.scenario2.country, 'name');
          countryName = countryName + ', ' + compCountryName;
          countryCodes.push(this.getCountryField(dashboardConfigs.scenario2.country, 'field_code'));
        }

        const bgInfoData = this.getBgInfoData(rawBgInfoData, rawComInfoData, sectionType);
        const chartData = {
          data: bgInfoData,
          country: countryName,
          codes: countryCodes,
          current_page: this.currentPage,
          section_name: sectionName,
          section_type: sectionType
        };
        if (sectionType === 'background-info') {
          chartData.source = 'World Social Protection Data (2021), ILO. Human Development Report (2021), UNDP.';
        }
        // console.log('chartData', chartData);
        const bgInfoMode = sectionType === 'background-info-sub' ? 'sub' : 'full';
        this.setBgInfoObj(sectionName, chartData, bgInfoMode);
      }
    },
    formatExclusionChartData (dataArray, filterObj) {
      const filteredDataArray = _.filter(_.cloneDeep(dataArray), (d) => {
        // return d.label_id !== '20011';
        return d;
      });
      const result = _.cloneDeep(filteredDataArray);
      let inclusionData = [];
      let exclusionData = [];
      const schemeDetailList = filterObj.scheme_details;
      const selectedScheme = _.filter(filterObj.scheme_details, (d) => { return d.is_selected; });
      const childSchemeObj = schemeDetailList[0];
      const disSchemeObj = schemeDetailList[1];
      const oldSchemeObj = schemeDetailList[2];

      const groupByScheme = _.groupBy(_.cloneDeep(filteredDataArray), 'scheme_id');
      const allLebels = ['20001', '20002', '20003', '20004', '20005', '20006', '20007', '20008', '20009', '20010', '20011'];

      const pmtList = {
        70001: childSchemeObj.pmt,
        70002: disSchemeObj.pmt,
        70003: oldSchemeObj.pmt,
        comb: 0
      };

      _.each(schemeDetailList, (sd) => {
        if (sd.is_selected && sd.pmt > pmtList.comb) {
          pmtList.comb = sd.pmt;
        }
      });

      _.each(groupByScheme, (gdata, key) => {
        const pmtVal = pmtList[key] !== undefined ? pmtList[key] : pmtList.comb;
        const maxIndex = (pmtVal === 0 || pmtVal === 100) ? 0 : Math.round(pmtVal / 10);
        const labelList = allLebels.slice(0, maxIndex);
        const mappedData = _.map(gdata, (d) => {
          if (labelList.indexOf(d.label_id) > -1) {
            d.value = 100 - d.value;
          } else {
            d.value = 0;
          }
          d.value_type = '% eligible excluded';
          return d;
        });
        exclusionData = exclusionData.concat(mappedData);
      });

      const mainDataGbScheme = _.groupBy(_.cloneDeep(result), 'scheme_id');
      _.each(mainDataGbScheme, (gdata, key) => {
        const pmtVal = pmtList[key] ? pmtList[key] : pmtList.comb;
        const maxIndex = (pmtVal === 0 || pmtVal === 100) ? 0 : Math.round(pmtVal / 10);
        const labelList = allLebels.slice(0, maxIndex);
        const mappedData = _.map(gdata, (d) => {
          if (labelList.indexOf(d.label_id) > -1) {
            d.value_type = '% eligible included';
          } else {
            d.value_type = '% ineligible included';
          }
          return d;
        });
        inclusionData = inclusionData.concat(mappedData);
      });

      const invertInclustion = _.map(_.cloneDeep(inclusionData), (d) => {
        if (d.value_type === '% eligible included') {
          d.value_type = '% ineligible included';
        } else {
          d.value_type = '% eligible included';
        }
        d.value = 0;
        return d;
      });
      inclusionData = inclusionData.concat(invertInclustion);
      inclusionData = inclusionData.concat(exclusionData);

      const orderIndex = [
        '% ineligible included',
        '% eligible included',
        '% eligible excluded'
      ];

      // @Todo: SPP-586 Filter out eligible included
      inclusionData = _.filter(inclusionData, (d) => {
        return d.value_type !== '% eligible included';
      });

      inclusionData = _.orderBy(inclusionData, (d) => {
        if (d.value_type === '% ineligible included' && d.value === 0) {
          return -Infinity; // Make sure to place value zero objects on top
        } else {
          return orderIndex.indexOf(d.value_type);
        }
      });

      return inclusionData;
    },
    getChartCustomFilter (dataArray, currentIndicatorId, realSectionName, sectionName, chartSection) {
      const customFilterResult = {};
      const valueTypeList = _.cloneDeep(this.getValueTypes);
      const toolbarType = _.cloneDeep(this.getDashboardToolbarType);

      // Value Type
      let allValueType = _.chain(dataArray).map('value_type_id').uniq().value();
      const valueTypeFilterObj = {
        id: 'custom_chart_filter_value_type',
        label: 'Select type:',
        key: 'value_type_id',
        items: [],
        class: '',
        style: '',
        order: 2
      };
      const noValueTypeSection = ['cost3', 'scCost3', 'coverage3', 'scCoverage3'];
      const isNoValueTypeOption = noValueTypeSection.includes(sectionName);
      const isUrbanRural = allValueType.includes('10002') && allValueType.includes('10003');
      if (isNoValueTypeOption === false) {
        if (isUrbanRural) {
          allValueType = _.without(allValueType, '10002', '10003');
        }
        _.each(allValueType, (vt) => {
          const foundValueType = _.find(valueTypeList, (v) => {
            return v.tid === vt;
          });
          const scObj = {
            label: foundValueType ? foundValueType.name : vt,
            value: vt
          };
          valueTypeFilterObj.items.push(scObj);
        });

        if (isUrbanRural) {
          valueTypeFilterObj.items.push({
            label: 'Urban-Rural',
            value: '10002:10003'
          });
        }
      }

      // Scheme
      const allScheme = _.chain(dataArray).map('scheme_id').uniq().value();
      const schemeFilterObj = {
        id: 'custom_chart_filter_scheme',
        label: 'Select benefit:',
        key: 'scheme_id',
        items: [],
        class: '',
        style: '',
        order: 1
      };

      const isAllSchemes = ['cost1'].includes(sectionName);
      if (isAllSchemes) {
        schemeFilterObj.items.push({
          label: 'All',
          value: '70001:70002:70003:70001_70002:70001_70003:70002_70003:70001_70002_70003'
        });
      }

      _.each(allScheme, (sc) => {
        const scObj = {
          value: sc
        };
        if (sc === '70001') {
          scObj.label = 'Child';
          scObj.order = 1;
        } else if (sc === '70002') {
          scObj.label = 'Disability';
          scObj.order = 2;
        } else if (sc === '70003') {
          scObj.label = 'Old Age';
          scObj.order = 3;
        } else {
          scObj.label = 'Combined';
          scObj.order = 4;
        }
        schemeFilterObj.items.push(scObj);
      });

      schemeFilterObj.items = _.orderBy(_.cloneDeep(schemeFilterObj.items), 'order');

      const selectedObj = {
        scheme_id: schemeFilterObj.items.length ? schemeFilterObj.items[schemeFilterObj.items.length - 1].value : ''
      };

      if (valueTypeFilterObj.items.length > 1) {
        selectedObj.value_type_id = valueTypeFilterObj.items[0].value;
      }

      customFilterResult.pageId = sectionName;
      customFilterResult.toolbarType = toolbarType;
      customFilterResult.section = realSectionName;
      customFilterResult.indicator = currentIndicatorId;
      customFilterResult.selectedObject = selectedObj;
      customFilterResult.allSchemes = allScheme.join('_');
      customFilterResult.filters = [];

      // Page Filter Dropdown
      const pageNavigationFilterObj = {
        id: 'custom_chart_filter_page',
        label: 'Select chart:',
        key: 'page_id',
        items: [],
        class: '',
        style: '',
        order: 0
      };

      if (chartSection.childrenList && chartSection.childrenList.length) {
        let selectedPageId;
        _.each(chartSection.childrenList, (child) => {
          const childObj = {
            label: child.label,
            value: child.value
          };
          if ((!child.isHiddenByMode) || (child.isHiddenByMode !== this.toolbarMode)) {
            pageNavigationFilterObj.items.push(childObj);
            if (child.selected) {
              selectedPageId = child.value;
            }
          }
        });

        if (!selectedPageId) {
          selectedPageId = pageNavigationFilterObj.items[0].value;
          this.clickGridItem(selectedPageId, undefined);
        }
        customFilterResult.selectedObject.page_id = selectedPageId;
        customFilterResult.filters.push(pageNavigationFilterObj);
      }

      // Special Coverage Case
      const isSpecialCoverage = ['coverage1', 'expenditure1', 'scCoverage1', 'scExpenditure1', 'coverage5_exclusion'].includes(sectionName);
      const setMapping = {
        coverage1: 'set1',
        expenditure1: 'set1',
        scCoverage1: 'set1',
        scExpenditure1: 'set2',
        coverage5_exclusion: 'set1'
      };
      const relationLabelItems = {
        set1: {
          default: 'Coverage:',
          70001: 'Coverage among children (0-17 years):',
          70002: 'Coverage among persons with severe disabilities:',
          70003: 'Coverage among older persons (65+ years):'
        },
        set2: {
          default: 'Consumption',
          70001: 'Consumption increase among children (0-17 years):',
          70002: 'Consumption increase among persons with severe disabilities:',
          70003: 'Consumption increase among older persons (65+ years):'
        }
      };
      const specialCovFilterObj = {
        id: 'custom_chart_filter_special_coverage',
        label: '',
        isRelationLabel: true,
        relationLabel: {
          field: 'scheme_id',
          items: relationLabelItems[setMapping[sectionName]]
        },
        isRelationVisibleIf: true,
        relationVisibleCondition: {
          field: 'scheme_id',
          items: ['70001', '70002', '70003']
        },
        key: 'special_cov',
        items: [
          {
            label: 'Yes',
            value: true
          },
          {
            label: 'No',
            value: false
          }
        ],
        class: '',
        style: '',
        order: 3
      };

      if (chartSection.isUseCustomFilter) {
        if (isSpecialCoverage) {
          customFilterResult.selectedObject.special_cov = this.isUseSpecialCoverage;
          customFilterResult.filters.push(specialCovFilterObj);
        }
        if (valueTypeFilterObj.items.length > 1) {
          customFilterResult.filters.push(valueTypeFilterObj);
        }
        customFilterResult.filters.push(schemeFilterObj);
      }

      // Maintain selection from previous page
      if (this.latestSelectedCustomFilter) {
        const keys = Object.keys(this.latestSelectedCustomFilter);
        _.each(keys, (k) => {
          if (customFilterResult.selectedObject[k] && k !== 'page_id') {
            const foundFilterObj = _.find(customFilterResult.filters, (filter) => {
              return filter.key === k;
            });
            const foundFilterItem = foundFilterObj && _.find(foundFilterObj.items, (item) => {
              return item.value === this.latestSelectedCustomFilter[k];
            });

            if (foundFilterItem) {
              customFilterResult.selectedObject[k] = this.latestSelectedCustomFilter[k];
            }
          }
        });
      }

      this.latestSelectedCustomFilter = undefined;

      return customFilterResult;
    },
    async formatChartData (sectionName, dataArray, rawDataArr, realSectionName, fetchTimestamp) {
      // Apply field_options
      if (this.filterPanelInputs[sectionName].field_options) {
        const gb = _.groupBy(dataArray, 'value_type_id');
        let keys = Object.keys(this.filterPanelInputs[sectionName].field_options);
        const mainArr = gb[this.filterPanelInputs[sectionName].field_options[keys[0]]];
        keys = _.without(keys, keys[0]);
        for (const key of keys) {
          const keyArr = gb[this.filterPanelInputs[sectionName].field_options[key]];
          mainArr.map(d => {
            d[key] = keyArr.find(d2 => d2.label_id === d.label_id && d2.scheme_id === d.scheme_id).value;
            d[`${key}_type`] = keyArr.find(d2 => d2.label_id === d.label_id && d2.scheme_id === d.scheme_id).value_type;
            d[`${key}_type_id`] = keyArr.find(d2 => d2.label_id === d.label_id && d2.scheme_id === d.scheme_id).value_type_id;
            return d;
          });
        }
        dataArray = mainArr;
      }

      // Remove label: Social Protection (20051)
      dataArray = dataArray.filter(d => d.label_id !== '20051');
      rawDataArr = rawDataArr.filter(d => d.label_id !== '20051');

      // Force quite when timeStamp not matched
      if (_.cloneDeep(this.getDashboardFetchTimestamp) !== fetchTimestamp) return;

      const indicatorList = _.cloneDeep(this.getIndicators);
      const detailChartList = _.cloneDeep(this.getDetailCharts);
      const selectedObject = this.filterPanelInputs[sectionName].selectedObject;
      const chartSection = this.chartSectionsData[sectionName];
      const isRegionalComparison = chartSection && chartSection.isRegionalComparison ? chartSection.isRegionalComparison : undefined;
      const isExclusionChartType = chartSection && chartSection.isExclusionChartType ? chartSection.isExclusionChartType : undefined;
      const foundIndicator = _.find(indicatorList, (d) => {
        return d.tid === selectedObject.indicator;
      });
      let sectionTitle = '';
      const sectionTag = chartSection ? chartSection.tag : '';
      const sectionIsSmall = realSectionName !== 'sectionDetail';
      const toolbarType = _.cloneDeep(this.getDashboardToolbarType);
      const setDecimalPointValue = 1;

      // Get chart title from taxo if undefined
      if (chartSection) {
        const ind = this.filterPanelInputs[sectionName].selectedObject.indicator;
        const indArr = indicatorList.filter(i => i.tid === ind);
        if (chartSection.title === undefined && indArr.length > 0) {
          sectionTitle = indArr[0].name;
        } else {
          sectionTitle = chartSection.title ? chartSection.title : 'Chart Title';
        }
      }

      // Get chart tab short name
      if (chartSection && chartSection.childrenList) {
        chartSection.childrenList.map(c => {
          const ignoreLabels = ['Overview', 'Comparison', 'Exclusion'];
          const ind = this.filterPanelInputs[c.value].selectedObject.indicator;
          const name = ignoreLabels.indexOf(c.label) > -1 ? c.label : indicatorList.filter(i => i.tid === ind)[0].field_short_name;
          c.label = name;
          return c;
        });
      }

      // Generate custom filter for phase3
      if (chartSection.childrenList) {
        const currentIndicatorId = selectedObject.indicator;
        const allSchemeString = _.chain(dataArray).map('scheme_id').uniq().value().join('_');
        if (!this.phase3CustomFilter[realSectionName] ||
          this.phase3CustomFilter[realSectionName].toolbarType !== toolbarType ||
          this.phase3CustomFilter[realSectionName].pageId !== sectionName ||
          this.phase3CustomFilter[realSectionName].indicator !== currentIndicatorId ||
          this.phase3CustomFilter[realSectionName].allSchemes !== allSchemeString) {
          // Create new filter
          const tempCustomFilter = this.getChartCustomFilter(
            dataArray,
            currentIndicatorId,
            realSectionName,
            sectionName,
            chartSection);
          // console.log('tempCustomFilter', tempCustomFilter);
          this.phase3CustomFilter[realSectionName] = tempCustomFilter;
        }
        // filter data
        const customSelectedObj = _.cloneDeep(this.phase3CustomFilter[realSectionName].selectedObject);
        const allFilterKeys = Object.keys(customSelectedObj);

        if (chartSection.isUseCustomFilter) {
          const customFilteredData = _.filter(_.cloneDeep(dataArray), (d) => {
            let bool = true;
            _.each(allFilterKeys, (dk) => {
              if (dk === 'special_cov') {
                if (toolbarType === 'normal' && d[dk] !== customSelectedObj[dk]) {
                  bool = false;
                }
                return;
              }
              const valArr = customSelectedObj[dk].split(':');
              if (dk !== 'page_id' && !(valArr.includes(d[dk]))) {
                bool = false;
              }
            });
            return bool;
          });
          dataArray = customFilteredData;

          // Filter raw data arraytoo
          const customFilteredRawData = _.filter(_.cloneDeep(rawDataArr), (d) => {
            let bool = true;
            _.each(allFilterKeys, (dk) => {
              if (dk === 'special_cov') {
                return;
              }
              const valArr = customSelectedObj[dk].split(':');
              if (dk !== 'page_id' && !(valArr.includes(d[dk]))) {
                bool = false;
              }
            });
            return bool;
          });
          rawDataArr = customFilteredRawData;
        }
      } else {
        this.phase3CustomFilter[realSectionName] = undefined;
      }
      // set custom domain
      const minValueObj = _.minBy(dataArray, 'value');
      const maxValueObj = _.maxBy(dataArray, 'value');
      const minValue = minValueObj ? minValueObj.value : NaN;
      const maxValue = maxValueObj ? maxValueObj.value : NaN;
      const appliedGroupLabelSection = [
        'section1', 'section2',
        'poverty0', 'inequality0'
      ];

      let possibleMax = 100;
      if (this.max50GroupSection.indexOf(sectionName) > -1) {
        possibleMax = 50;
      }

      const stringToColor = function (str) {
        let hash = 0;
        let i;
        for (i = 0; i < str.length; i++) {
          hash = str.charCodeAt(i) + ((hash << 5) - hash);
        }
        let colour = '#';
        for (i = 0; i < 3; i++) {
          const value = (hash >> (i * 8)) & 0xFF;
          colour += ('00' + value.toString(16)).substr(-2);
        }
        return colour;
      };

      const defaultChartSectionConfig = {
        title: 'Chart1',
        // active: true,
        chart: {},
        insight: '',
        legend: {
          name: 'chart-legend',
          params: {
            input: '{"data":[]}'
          }
        }
      };

      const chartMargin = { bottom: 100, left: 140 };
      // Dynamic adjust margin left based on label length
      const maxLabelLength = _.chain(dataArray)
        .map('label')
        .uniq('')
        .map((d) => { return d.length; })
        .max()
        .value();

      if (maxLabelLength >= 20) {
        chartMargin.left += (maxLabelLength - 20) * 10;
        if (chartMargin.left >= 260) {
          chartMargin.left = 260;
        }
      }

      // Calculate chart height
      let chartDetailHeight = 250;
      if (document.getElementsByClassName('isSectionDetail').length) {
        const detailContainerHeight = document.getElementsByClassName('isSectionDetail')[0].offsetHeight;
        const otherComponentHeight = this.mode === 'comparative' ? 300 : 440;
        if (detailContainerHeight) {
          chartDetailHeight = detailContainerHeight - otherComponentHeight;
          if (chartDetailHeight < 150) {
            chartDetailHeight = 150;
          }
        }
      }

      const defaultBarConfig = {
        name: 'bar-chart',
        params: {
          autoWidth: true,
          height: chartDetailHeight,
          marginBottom: chartMargin.bottom,
          marginLeft: chartMargin.left,
          // rotateX: 45,
          isHeightByData: true,
          isXAxisFixed: true,
          data: '{}',
          orderByField: 'percentage',
          barOrientation: 'horizontal',
          zeroLabel: '0',
          decimalPoint: setDecimalPointValue,
          showBarGroupedLabel: false,
          isWrapY: false,
          noDataLabel: ''
        }
      };
      // Negative value charts
      if (this.negativeValueCharts.includes(sectionName)) {
        // && (!minValue === 0 && !maxValue === 0)
        if (!isNaN(minValue) && !isNaN(maxValue)) {
          // Y Axis will be left hand side
          if (minValue < 0 && maxValue < 0) {
            defaultBarConfig.params.marginRight = defaultBarConfig.params.marginLeft;
            defaultBarConfig.params.marginLeft = 50;
          }
        }

        if (minValue === 0 && maxValue === 0) {
          defaultBarConfig.params.marginRight = chartMargin.right;
          defaultBarConfig.params.marginLeft = chartMargin.left;
        }
      }

      const defaultBarDataObject = {
        x_label: 'x axis label',
        y_label: 'y axis label',
        x_unit_label: '',
        tooltip_unit_label: '',
        tooltip: {
          value: undefined
        },
        data: [],
        sort_order: 'DESC'
      };

      const defaultLineConfig = {
        name: 'multi-line-chart',
        params: {
          data: {
            data: [],
            metadata: {
              x_datatype: 'datetime',
              y_datatype: 'number',
              name: 'Test Data',
              color: { 'Series 1': '#FF5733', 'Series 2': '3390FF' }
            }
          },
          chartOptions: {
            width: 960,
            height: chartDetailHeight + 40,
            margin: {
              bottom: chartMargin.bottom - 50,
              left: chartMargin.left - 30,
              right: 155
            },
            rotateX: null, // 45,
            xField: 'x',
            xLabel: 'X Label',
            yField: 'y',
            yLabel: 'Y label',
            isTrend: false,
            showLegend: false,
            timeFormat: '%Y', // d3.timeParse('%Y-%m-%dT%H:%M:%S%Z'),
            decimalPoint: setDecimalPointValue,
            yAxisMin: 0,
            strokeThickness: 4,
            timeLabelFormat: '%Y',
            xUnitLabel: '',
            isHideHorizontalGridLine: true,
            isYAxisHideDecimalValue: true,
            isYAxisHideDomain: true,
            isShowLineLabel: true,
            isShowLineNodeLabel: true
          }
        }
      };

      const defaultTableConfig = {
        name: 'data-table',
        params: {
          data: '{"data":[],"colums":[]}',
          chartOptions: {
            pageLength: 10
          }
        }
      };

      const defaultDataSourceConfig = {
        name: 'data-source',
        params: {
          data: {
            text: ''
          }
        }
      };

      const defaultParagraphConfig = {
        name: 'paragraph',
        params: {
          data: {
            html: ''
          }
        }
      };

      let sectionChartData = [];
      const selectedTabTypes = this.chartSectionsData[sectionName].tabTypes;
      const valueTypeFieldMapping = { color: 'field_color' };
      const valueTypeMapping = {};
      for (const valueType of this.getValueTypes) {
        valueTypeMapping[valueType.tid] = { ...valueType };
      }
      // Include Label list to mapping
      for (const label of this.getLabels) {
        valueTypeMapping[label.tid] = { ...label };
      }

      // new Case for scenario and scheme
      valueTypeMapping['Scenario A'] = { field_color: '#a0cdf8' };
      valueTypeMapping['Scenario B'] = { field_color: '#0d3562' };
      valueTypeMapping['Child Benefit'] = { field_color: '#39C7FA' };
      valueTypeMapping['Disability Benefit'] = { field_color: '#0060C2' };
      valueTypeMapping['Old Age Benefit'] = { field_color: '#66CC33' };
      valueTypeMapping['% eligible excluded'] = { field_color: '#FC7616' };
      valueTypeMapping['% ineligible included'] = { field_color: '#a0cdf8' };
      valueTypeMapping['% eligible included'] = { field_color: '#0d3562' };
      valueTypeMapping.Combined = { field_color: '#7F58A5' };

      if (appliedGroupLabelSection.indexOf(sectionName) > -1) {
        valueTypeMapping['Child Benefit'] = { field_color: '#B8BCC9' };
        valueTypeMapping['Disability Benefit'] = { field_color: '#B8BCC9' };
        valueTypeMapping['Old Age Benefit'] = { field_color: '#B8BCC9' };
        valueTypeMapping.Combined = { field_color: '#0060C2' };
      }

      let detailDataArr = [];

      // Loop over each tab type
      for (const tab of selectedTabTypes) {
        const tabType = tab.type;
        const groupByField = tab.groupByField ? tab.groupByField : 'value_type';
        const labelField = tab.labelField ? tab.labelField : 'label';
        const sectionObject = _.cloneDeep(defaultChartSectionConfig);
        let colorFieldName = 'value_type_id';

        if (['value_type', 'label'].indexOf(groupByField) > -1) {
          colorFieldName = groupByField + '_id';
          if (isExclusionChartType) {
            colorFieldName = 'value_type';
          }
          dataArray = _.map(_.cloneDeep(dataArray), (d) => {
            d.color_id = d[colorFieldName];
            return d;
          });
        } else if (['scheme', 'scenario'].indexOf(groupByField) > -1) {
          dataArray = _.map(_.cloneDeep(dataArray), (d) => {
            d.color_id = d[groupByField];
            return d;
          });
        }

        dataArray = _.map(_.cloneDeep(dataArray), (d) => {
          if (tab.labelField) {
            d.order = d[`${tab.labelField}_order`];
          } else {
            d.order = '999';
          }
          return d;
        });

        detailDataArr = _.cloneDeep(dataArray);

        sectionObject.title = tab.title;
        sectionObject.customTitle = tab.customTitle ? tab.customTitle : undefined;

        // ======= Data Insight zone ========
        sectionObject.insight = tab.insight ? tab.insight : sectionObject.insight;
        if (this.mode === 'comparative') {
          // Remove insight for compare mode
          sectionObject.insight = '';
        } else {
          if (['coverage1', 'coverage2', 'expenditure1', 'expenditure2', 'expenditure3', 'coverage4_comparison', 'expenditure4_comparison', 'coverage5_exclusion'].includes(sectionName)) {
            const selectedValueType = this.phase3CustomFilter.sectionDetail.selectedObject.value_type_id;
            if (selectedValueType !== '10001') {
              sectionObject.insight = tab.insight2 ? tab.insight2 : tab.insight;
            }
          }

          // PMT Insight
          if (tab.pmt_insight &&
            this.chartSectionsData[sectionName].isUseCustomFilter &&
            this.phase3CustomFilter.sectionDetail &&
            this.phase3CustomFilter.sectionDetail.selectedObject &&
            this.phase3CustomFilter.sectionDetail.selectedObject.scheme_id.indexOf('_') === -1) {
            if (this.getDashboardConfigs.scenario1.poverty_mean_tested === '80002' ||
              this.getDashboardConfigs.detailScenario1.scheme_details.map(d => d.pmt !== 100).reduce((res, cur) => res || cur, false)) {
              sectionObject.insight = `${sectionObject.insight} ${tab.pmt_insight}`;
            }
          }

          if (sectionObject.insight && sectionObject.insight.length) {
            sectionObject.insight = await this.getInsightData(sectionName, sectionObject.insight, _.cloneDeep(dataArray), chartSection.isUseCustomFilter, tab.insightOptions);
            sectionObject.insight = this.getPopoverGlossary(sectionObject.insight);
          }
        }
        // ======= End Data Insight zone ========

        if (isExclusionChartType) {
          // Remove total from exclusion chart
          dataArray = _.filter(dataArray, (d) => {
            return d.label_id !== '20011';
          });
        }

        // ======= Get data by chart ========
        if (tabType === 'bar') {
          const sectionDataObject = _.cloneDeep(defaultBarDataObject);
          sectionDataObject.data = _.map(dataArray, (d) => {
            return {
              label: d.label ? d.label.toString() : 'none',
              percentage: d.value ? d.value : 0,
              color: d.value_type ? valueTypeMapping[d.value_type] && valueTypeMapping[d.value_type][valueTypeFieldMapping.color] : 'black'
            };
          });

          const legendData = _.chain(dataArray)
            .map((d) => {
              return {
                label: d.value_type ? d.value_type.toString() : 'none',
                color: d.value_type ? valueTypeMapping[d.value_type] && valueTypeMapping[d.value_type][valueTypeFieldMapping.color] : 'black'
              };
            })
            .uniqBy('label')
            .value();

          sectionObject.chart = _.cloneDeep(defaultBarConfig);
          sectionObject.chart.params.data = JSON.stringify({ data: sectionDataObject });
          sectionObject.legend.params.input = JSON.stringify({ data: legendData });
        } else if (tabType === 'bar_grouped') {
          const sectionDataObject = _.cloneDeep(defaultBarDataObject);
          sectionDataObject.data = _.chain(dataArray)
            .groupBy('value_type')
            .map((v, k) => {
              const tempValues = {};
              _.each(v, (d) => {
                tempValues[d.label] = d.value;
              });
              return {
                label: k,
                values: tempValues
              };
            })
            .value();

          const allDataKeys = _.chain(dataArray)
            .groupBy('label')
            .map((v, k) => {
              return k;
            })
            .value();

          const legendData = _.map(allDataKeys, (d) => {
            return {
              label: d,
              color: stringToColor(d)
            };
          });

          sectionObject.chart = _.cloneDeep(defaultBarConfig);
          sectionObject.chart.params.data = JSON.stringify({ data: sectionDataObject });
          sectionObject.chart.params.barOrientation = 'grouped';
          sectionObject.legend.params.input = JSON.stringify({ data: legendData });
        } else if (['bar_horizontal_grouped', 'bar_horizontal_stacked'].includes(tabType) === true) {
          const sectionDataObject = JSON.parse(JSON.stringify(defaultBarDataObject));
          // axis labels
          const axisLabels = this.getAxisLabel(dataArray, foundIndicator, tab.textOptions, false);
          sectionDataObject.x_label = axisLabels.xLabel;
          sectionDataObject.y_label = axisLabels.yLabel;
          sectionDataObject.sort_order = tab.sortOrder ? tab.sortOrder : sectionDataObject.sort_order;
          sectionObject.chart = JSON.parse(JSON.stringify(defaultBarConfig));
          // Line on Bar
          if (tab.averageLines) {
            const gb = _.groupBy(dataArray, 'scenario');
            const scenarios = Object.keys(gb);
            let averageLines = [];
            for (const scenario of scenarios) {
              const avLines = _.cloneDeep(tab.averageLines).map(a => {
                let findXfields = [];
                const resAvgLines = [];
                if (a.xField) {
                  findXfields = dataArray.filter(d => d[a.xField.key] === a.xField.value && d.scenario === scenario);
                  findXfields = _.uniqBy(findXfields, groupByField);
                }

                if (isRegionalComparison) {
                  const sum = _.sumBy(dataArray, 'value');
                  const average = (sum / dataArray.length).toFixed(1);
                  const apefAvg = {
                    value: average
                  };
                  findXfields.push(apefAvg);
                }

                _.each(findXfields, (findXfield) => {
                  const tempA = _.cloneDeep(a);
                  const xVal = findXfield.value;
                  const scheme = findXfield.scheme;
                  const scenarioLetter = scenario === 'Scenario A' ? 'A' : 'B';
                  const scenarioText = this.mode === 'comparative' ? ` - ${scenarioLetter}` : '';
                  let color = 'black';
                  if (scenario === 'Scenario A') {
                    color = '#62a2de';
                  } else if (scenario === 'Scenario B') {
                    color = '#25537e';
                  }
                  tempA.xVal = xVal;
                  tempA.stroke = color;

                  if (a.xField) {
                    if (a.xField.key === 'label_id') {
                      let tempLabel = findXfield.value_type !== 'Total' ? findXfield.value_type : '';
                      tempA.label = `Average ${tempLabel}${scenarioText}`;
                      if (findXfield.value_type_id === '10001') {
                        if (['coverage1', 'coverage2', 'coverage5_exclusion'].indexOf(sectionName) > -1) {
                          tempLabel = 'Total Population';
                        } else if (['expenditure1'].indexOf(sectionName) > -1) {
                          tempLabel = 'Increase in consumption by total population';
                        } else if (['expenditure2', 'expenditure3'].indexOf(sectionName) > -1) {
                          tempLabel = 'Increase in consumption among recipient households';
                        }
                        tempA.label = `${tempLabel} ${scenarioText}`;
                      }
                      if (this.mode !== 'comparative') { // Total
                        color = '#0060c2';
                        if (findXfield.value_type_id === '10002') { // Urban
                          color = '#25537e';
                        } else if (findXfield.value_type_id === '10003') { // Rural
                          color = '#62a2de';
                        }
                      }
                      tempA.stroke = color;
                    } else {
                      tempA.label = `Cost of ${scheme}${scenarioText}`;
                    }
                  } else if (isRegionalComparison) {
                    tempA.label = 'Asia-Pacific Average';
                  }

                  resAvgLines.push(tempA);
                });

                if (a.xField) {
                  dataArray = _.reject(dataArray, d => { return d[a.xField.key] === a.xField.value && d.scenario === scenario; });
                }
                return resAvgLines;
              });
              averageLines = [...averageLines, ...avLines];
            }

            // flatten array of array
            averageLines = _.flatten(averageLines);
            sectionObject.additionalLegends = averageLines;
            sectionObject.chart.params.averageLines = averageLines;
          }

          const groupLevel1 = labelField;
          const groupLevel2 = groupByField;
          // console.log('dataArray', dataArray);
          sectionDataObject.data = _.chain(dataArray)
            .groupBy(groupLevel1)
            .map((v, k) => {
              const tempValues = {};
              let tempSum = 0;
              _.each(v, (d) => {
                tempValues[d[groupLevel2]] = d.value;
                if (d.value) {
                  tempSum = tempSum + d.value;
                }
              });
              let order = 9999;
              if (v.length) {
                order = v[0].order ? v[0].order : order;
              }
              return {
                label: k,
                order: order,
                sum_value: tempSum,
                values: tempValues,
                max_sum: _.maxBy(v, 'value') ? _.maxBy(v, 'value').value : 0
              };
            })
            .value();
          // console.log('sectionDataObject.data', sectionDataObject.data);
          sectionDataObject.colors = {};
          const allDataKeys = _.chain(dataArray)
            .groupBy(groupLevel2)
            .map((v, k) => {
              const tempObj = {
                key: k,
                color_id: v.length ? v[0].color_id : undefined
              };
              return tempObj;
            })
            .value();

          for (const d of allDataKeys) {
            sectionDataObject.colors[d.key] = valueTypeMapping[d.color_id] ? valueTypeMapping[d.color_id][valueTypeFieldMapping.color] : 'black';
          }
          const legendData = _.map(allDataKeys, (d) => {
            return { label: d.key, color: sectionDataObject.colors[d.key] };
          });
          sectionObject.chart.params.data = JSON.stringify({ data: sectionDataObject });
          sectionObject.chart.params.orderByField = tab.orderByField ? tab.orderByField : 'order';
          sectionObject.chart.params.hasYAxisGrid = true;
          sectionObject.chart.params.isYAxisGridFitXAxis = true;
          sectionObject.chart.params.tooltipAtMousePosition = true;

          if (tabType === 'bar_horizontal_stacked') {
            sectionObject.chart.params.barOrientation = 'horizontal-stacked';
            sectionObject.chart.params.barThickness = 15;
          } else {
            sectionObject.chart.params.barOrientation = 'horizontal-grouped';
            if (realSectionName === 'sectionDetail') {
              sectionObject.chart.params.barThickness = 15;
              if (appliedGroupLabelSection.indexOf(sectionName) > -1) {
                sectionObject.chart.params.showBarGroupedLabel = true;
                sectionObject.chart.params.marginLeft = 100;
              }
            }
            sectionObject.chart.params.showAverageLineValueLabel = true;
            let tempMax, tempMin;
            if (minValue >= 0 && maxValue > 0) {
              tempMin = 0;
              tempMax = Math.ceil(maxValue / 10) * 10;
              // tempMax = maxValue > possibleMax ? maxValue : possibleMax;
            } else if (minValue < 0 && maxValue <= 0) {
              tempMin = Math.floor(minValue / 10) * 10;
              tempMax = 0.0001;
              // tempMin = minValue < -possibleMax ? minValue : -possibleMax;
            } else if (minValue <= 0 && maxValue >= 0) {
              tempMin = Math.floor(minValue / 10) * 10;
              tempMax = Math.ceil(maxValue / 10) * 10;
              // tempMin = minValue < -possibleMax ? minValue : -possibleMax;
              // tempMax = maxValue > possibleMax ? maxValue : possibleMax;
            }
            if (tempMax || tempMin) {
              // console.log(tempMax, tempMin);
              if (tempMin < 0 && tempMax > 0.1 && Math.abs(tempMin) > Math.abs(tempMax)) {
                tempMax = -(tempMin);
              } else if (tempMin < 0 && tempMax > 0.1) {
                tempMin = -(tempMax);
              }
              // console.log(tempMax, tempMin);
              sectionObject.chart.params.xDomain = `[${tempMin},${tempMax}]`;
            }
          }
          sectionObject.legend.params.input = JSON.stringify({ data: legendData });
        } else if (['line', 'line_category'].includes(tabType)) {
          const foundMaxObj = _.maxBy(dataArray, (d) => { return d.value; });
          const lineMaxValue = foundMaxObj ? foundMaxObj.value : 0;
          let adjustMaxLine = 5;
          if (lineMaxValue > 5) {
            const decimalLeft = parseFloat('0.' + ((lineMaxValue / 5) + '').split('.')[1]);
            adjustMaxLine = lineMaxValue + ((1 - decimalLeft) * 5);
          }

          const lineData = _.chain(dataArray)
            .groupBy(groupByField)
            .map((v, k) => {
              return {
                label: k,
                data: _.map(v, (d) => {
                  return {
                    x: d[labelField],
                    y: Number(d.value)
                  };
                })
              };
            })
            .value();

          const allDataKeys = _.chain(dataArray)
            .groupBy(groupByField)
            .map((v, k) => {
              const tempObj = {
                key: k,
                color_id: v.length ? v[0].color_id : undefined
              };
              return tempObj;
            })
            .value();

          const colorKeys = {};
          _.each(allDataKeys, (dk) => {
            colorKeys[dk.key] = valueTypeMapping[dk.color_id] ? valueTypeMapping[dk.color_id][valueTypeFieldMapping.color] : 'black';
          });

          const legendData = _.map(allDataKeys, (d) => {
            return {
              label: d.key,
              color: valueTypeMapping[d.color_id] ? valueTypeMapping[d.color_id][valueTypeFieldMapping.color] : 'black'
            };
          });

          sectionObject.chart = _.cloneDeep(defaultLineConfig);
          sectionObject.chart.params.data.data = lineData;
          sectionObject.chart.params.data.metadata.color = colorKeys;

          // axis labels
          const axisLabels = this.getAxisLabel(dataArray, foundIndicator, tab.textOptions, false);
          sectionObject.chart.params.chartOptions.xLabel = axisLabels.xLabel;
          sectionObject.chart.params.chartOptions.yLabel = axisLabels.yLabel;

          // overrie maxY value
          sectionObject.chart.params.chartOptions.customMaxY = adjustMaxLine;

          if (tabType === 'line_category') {
            sectionObject.chart.params.chartOptions.xScaleType = 'scalePoint';
          }
          sectionObject.legend.params.input = JSON.stringify({ data: legendData });
        } else if (['table'].includes(tabType)) {
          let tableData = _.cloneDeep(rawDataArr);

          let firstColumnName = '';
          if (['poverty0', 'poverty1', 'poverty2', 'poverty3', 'poverty4'].indexOf(sectionName) > -1) {
            firstColumnName = 'Poverty Line';
          } else if (['inequality0', 'inequality1'].indexOf(sectionName) > -1) {
            firstColumnName = 'Inequality Metric';
          }

          const tableDataObject = {
            columns: [
              {
                name: firstColumnName,
                type: 'string'
              }
            ],
            data: [
            ],
            allowSearch: false
          };

          const groupByFieldKeys = _.chain(tableData)
            .groupBy(groupByField)
            .map((v, k) => { return k; })
            .value();

          // set columns
          _.each(groupByFieldKeys, (gk) => {
            tableDataObject.columns.push({
              name: gk,
              type: 'number'
            });
          });

          if (this.mode === 'comparative') {
            tableData = _.map(tableData, (d) => {
              d[labelField] = d.scenario + ' ' + d[labelField];
              return d;
            });
          }

          const dataGroupByLabel = _.groupBy(tableData, labelField);
          _.each(dataGroupByLabel, (dg, lbName) => {
            const dataArr = [lbName];
            _.each(dg, (d) => {
              let dvalue = d.value !== null ? d.value : 'NA';
              if (!isNaN(dvalue)) {
                dvalue = Number(dvalue.toFixed(2));
              }
              dataArr.push(dvalue);
            });
            tableDataObject.data.push(dataArr);
          });

          sectionObject.chart = _.cloneDeep(defaultTableConfig);
          sectionObject.legend = undefined;
          if (tableData.length) {
            sectionObject.chart.params.data = JSON.stringify(tableDataObject);
          }
        } else if (['paragraph'].includes(tabType)) {
          const gb = _.groupBy(dataArray, 'scenario');
          const scenarios = Object.keys(gb);
          sectionObject.chart = _.cloneDeep(defaultParagraphConfig);
          let result = '';
          for (const scenario of scenarios) {
            const filterDataArr = dataArray.filter(d => d.scenario === scenario);
            const scenarioCountryToken = scenario === 'Scenario A' ? 's1_country' : 's2_country';
            const scenarioCurrentYearValueToken = scenario === 'Scenario A' ? 's1_currentYearValue' : 's2_currentYearValue';
            let template = this.chartSectionData[sectionName].tabTypes[0].paragraph;
            if (!template) {
              template = '';
            }
            if (scenarios.length > 1) {
              template = template.replaceAll('[[country]]', `[[${scenarioCountryToken}]]`);
              template = template.replaceAll('[[currentYearValue]]', `[[${scenarioCurrentYearValueToken}]]`);
            }
            const output = template ? await this.getInsightData(sectionName, template, filterDataArr, false) : '';
            result += output;
          }

          sectionObject.chart.params.data.html = result;
          sectionObject.legend = undefined;
        }

        // ======= End Get data by chart ========

        sectionChartData.push(sectionObject);
      }

      if (sectionChartData.length) {
        sectionChartData[0].isVertical = true;
        if (realSectionName === 'sectionDetail') {
          // @Todo : test add data source
          const foundCountryObj = {
            s1: _.find(this.getCountries, (p) => { return p.tid === this.getDashboardConfigs.scenario1.country; }),
            s2: _.find(this.getCountries, (p) => { return p.tid === this.getDashboardConfigs.scenario2.country; })
          };

          const dataSourceObject = _.cloneDeep(defaultChartSectionConfig);
          const dataSourceChartObj = _.cloneDeep(defaultDataSourceConfig);

          let resultText = 'information';
          const foundDChart = _.find(detailChartList, (d) => { return d.name === sectionName; });
          if (foundDChart && foundDChart.field_information) {
            resultText = await this.getInsightData(sectionName, foundDChart.field_information, _.cloneDeep(detailDataArr), false);
            resultText = this.getPopoverGlossary(resultText);
          }

          dataSourceChartObj.params.data.text = resultText;
          dataSourceObject.title = 'Information';
          dataSourceObject.chart = dataSourceChartObj;
          dataSourceObject.insight = undefined;
          dataSourceObject.legend = undefined;
          sectionChartData.push(dataSourceObject);
        }
        if (realSectionName !== 'sectionDetail') {
          sectionChartData[0].insight = undefined;
          sectionChartData[0].legend = undefined;
        }

        // set active tab
        if (this.latestSelectedTab) {
          const selectedTab = _.cloneDeep(this.latestSelectedTab).replace('#', '');
          const foundChart = _.find(sectionChartData, (d) => {
            return d.title === selectedTab;
          });

          if (foundChart) {
            sectionChartData = _.map(sectionChartData, (d) => {
              if (d.title === selectedTab) {
                d.active = true;
              }
              return d;
            });
          } else {
            sectionChartData[0].active = true;
            this.latestSelectedTab = '';
          }
        } else {
          sectionChartData[0].active = true;
        }
      }

      // Generate chart section components
      const sectionComponentObj = {
        parent: chartSection && chartSection.parent ? chartSection.parent : '',
        child: chartSection && chartSection.child ? chartSection.child : '',
        childrenList: chartSection && chartSection.childrenList ? chartSection.childrenList : [],
        customChartFilter: this.phase3CustomFilter[realSectionName]
      };

      const csvDownloadData = getCsvDownloadData(rawDataArr);

      // @Todo : Force to set data into detail object
      this.pageData[realSectionName] = {
        type: 'chart-section',
        data: {
          tabs: _.cloneDeep(sectionChartData),
          title: sectionTitle,
          tag: sectionTag,
          isSmall: sectionIsSmall,
          showTabs: true,
          chartSectionComponents: sectionComponentObj,
          rawData: csvDownloadData
        },
        isLoading: false
      };
      this.pageData = { ...this.pageData };
      // console.log('sectionChartData', sectionName, this.chartSectionsData[sectionName]);
      // console.log('page data', this.pageData);
    },
    getPopoverGlossary: function (insight) {
      let result = insight;
      let tempResult = insight;
      for (const gs of this.glossaries) {
        if (!['100038'].includes(gs.tid)) {
          const re = new RegExp(`(${gs.name})(?!([^<]+)?>)`, 'gi');
          const matches = _.uniq(insight.match(re));
          for (const match of matches) {
            tempResult = tempResult.replaceAll(match, `[[${match}]]`);
          }
        }
      }
      result = tempResult;
      for (const gs of this.glossaries) {
        const re = new RegExp(`(\\[\\[${gs.name}\\]\\])(?!([^<]+)?>)`, 'gi');
        const matches = _.uniq(tempResult.match(re));
        if (matches) {
          for (const match of matches) {
            let matchText = match.replace('[[', '');
            matchText = matchText.replace(']]', '');
            result = result.replaceAll(match, `<span class="tooltip_text" data-bs-toggle="popover" data-bs-placement="bottom" data-bs-trigger="hover focus" title="${gs.name}" data-bs-content="${gs.field_definition}">${matchText}</span>`);
          }
        }
      }
      return result;
    },
    async getInsightData (sectionName, templateText, dataArray, isUseCustomFilter, insightOptions) {
      let options = {};
      if (insightOptions) {
        options = insightOptions;
      }
      const dashboardConfigs = _.cloneDeep(this.getDashboardConfigs);
      const countryList = _.cloneDeep(this.getCountries);
      const schemeList = _.cloneDeep(this.getSchemes);
      const isNegetiveChart = this.negativeValueCharts.indexOf(sectionName) > -1;
      const multiplier = isNegetiveChart ? -1 : 1;
      const isIneaulityChart = this.inequalityChart.indexOf(sectionName) > -1;
      let isInequalityChartHasPositive = false;
      let isInequality1AllZero = false;

      // console.log('dataArray', dataArray);
      let schemId = dashboardConfigs.pageLevel.scheme.sort().join('_');

      // handle filter scheme in sub-chart ddl
      if (this.phase3CustomFilter.sectionDetail &&
        this.phase3CustomFilter.sectionDetail.selectedObject &&
        this.phase3CustomFilter.sectionDetail.selectedObject.scheme_id) {
        schemId = this.phase3CustomFilter.sectionDetail.selectedObject.scheme_id;
      }

      if (schemId === '70001:70002:70003:70001_70002:70001_70003:70002_70003:70001_70002_70003') {
        schemId = '70001_70002_70003';
      }

      const foundCountryObj = {
        s1: _.find(countryList, (p) => { return p.tid === dashboardConfigs.scenario1.country; }),
        s2: _.find(countryList, (p) => { return p.tid === dashboardConfigs.scenario2.country; })
      };
      const baseValue = 10;
      const foundDataObj = {
        s1: _.find(dataArray, (d) => { return d.scenario === 'Scenario A' && d.scheme_id === schemId; }),
        s2: _.find(dataArray, (d) => { return d.scenario === 'Scenario B' && d.scheme_id === schemId; })
      };

      const obj = {
        maxValScheme: '',
        maxValLabel: '',
        maxVal: 0,
        minValScheme: '',
        minValLabel: '',
        minVal: 0,
        value: 0,
        s1_country: '',
        s2_country: '',
        s1_value: 0,
        s2_value: 0,
        s1_country_source: '',
        s2_country_source: '',
        compare_base_countries: '',
        baseValue,
        compareVal: 1.3,
        currentYearValue: 0,
        s1_currentYearValue: 0,
        s2_currentYearValue: 0,
        country: '',
        country_source: '',
        currency: '',
        currentYear: '',
        maxYearValue: 0,
        selected_schemes: 'Selected schemes',
        personText: '',
        ageText: '',
        pmtPercent: 0,
        exclusionCurrency: 0,
        exclusionPercent: 0
      };

      // selected_schemes
      if (dataArray.length) {
        let schemeArr = _.chain(dataArray).map('scheme').uniq().value();
        if (schemeArr.length > 1 && schemeArr.includes('Combined')) {
          schemeArr = _.without(schemeArr, 'Combined');
        }
        obj.selected_schemes = schemeArr.join(', ');
        if (schemeArr.length > 1) {
          const last = schemeArr.pop();
          obj.selected_schemes = schemeArr.join(', ') + ' and ' + last;
        }
      }

      // personText
      const personTextObj = {
        70001: 'children',
        70002: 'persons with severe disabilities',
        70003: 'older people'
      };
      obj.personText = personTextObj[schemId] ? personTextObj[schemId] : '';

      // ageText
      if (['70001', '70002', '70003'].indexOf(schemId) > -1) {
        const detailScenario1ConfigSelectedScheme = dashboardConfigs.detailScenario1.scheme_details.find(d => d.scheme === schemId);
        const startAge = detailScenario1ConfigSelectedScheme.age[0];
        const endAge = detailScenario1ConfigSelectedScheme.age[1];
        let ageTextTemplate = `${startAge} to ${endAge}`;
        if (endAge === 100) {
          ageTextTemplate = `${startAge}+`;
        }
        obj.ageText = ageTextTemplate;
      }

      const comparableArr = dataArray.filter((d) => {
        let bool = true;
        if (isNegetiveChart && d.value >= 0) {
          bool = false;
          if (isIneaulityChart) {
            isInequalityChartHasPositive = true;
          }
        }
        return d.value !== null && bool;
      });
      // minValScheme
      let minValScheme = '';
      let minVal = 0;
      let minValLabel = '';
      const minDataObj = _.minBy(comparableArr, d => Math.abs(d.value));
      // const minDataObj = _.minBy(comparableArr, d => { return multiplier * d.value; });
      if (minDataObj) {
        minValScheme = minDataObj ? minDataObj.scheme : '';
        minVal = minDataObj ? Math.abs(this.getRoundNumber(minDataObj.value, 1)) : 0;
        minValLabel = minDataObj ? minDataObj.label : '';
      }
      obj.minValScheme = minValScheme;
      obj.minVal = minVal;
      obj.minValLabel = minValLabel;

      // maxValScheme
      let maxValScheme = '';
      let maxVal = 0;
      let maxValLabel = '';
      const maxDataObj = _.maxBy(comparableArr, d => Math.abs(d.value));
      // const maxDataObj = _.maxBy(comparableArr, d => { return multiplier * d.value; });
      if (maxDataObj) {
        maxValScheme = maxDataObj ? maxDataObj.scheme : '';
        maxVal = maxDataObj ? Math.abs(this.getRoundNumber(maxDataObj.value, 1)) : 0;
        maxValLabel = maxDataObj ? maxDataObj.label : '';
      }
      obj.maxValScheme = maxValScheme;
      obj.maxVal = maxVal;
      obj.maxValLabel = maxValLabel;

      if (sectionName === 'inequality1' && minVal === 0 && maxVal === 0) {
        isInequality1AllZero = true;
      }

      // value
      const foundDataS1 = _.find(dataArray, (d) => {
        return d.scenario === 'Scenario A' && d.scheme_id === schemId;
      });
      const formattedValueS1 = foundDataS1 ? Math.abs(this.getRoundNumber(foundDataS1.value, 1)) : 0;
      obj.value = formattedValueS1;

      // country
      obj.country = foundCountryObj.s1.name;
      obj.country_source = foundCountryObj.s1.field_data_source;

      // pmtPercent
      const configScheme = this.getDashboardConfigs.detailScenario1.scheme_details.find(d => d.scheme === schemId);
      obj.pmtPercent = configScheme ? configScheme.pmt : '';

      if (configScheme && (templateText.includes('[[exclusionPercent]]') || templateText.includes('[[exclusionCurrency]]'))) {
        // exclusionCurrency
        const exclusionData = await this.getExclusion({
          countryName: foundCountryObj.s1.name,
          scheme: schemId,
          minAge: configScheme.age[0],
          maxAge: configScheme.age[1],
          pmt: configScheme.pmt
        });
        const fieldNames = {
          70001: 'child',
          70002: 'disab',
          70003: 'old'
        };
        obj.exclusionCurrency = exclusionData[`${fieldNames[schemId]}_consumption_expenditure`];

        // exclusionPercent
        obj.exclusionPercent = exclusionData[`${fieldNames[schemId]}_exclusion_error`];
      }

      // currency
      obj.currency = foundCountryObj.s1.field_currency_code;

      // currentYearValue
      const currentYear = String(new Date().getFullYear());
      const foundCurrentYearDataS1 = _.find(dataArray, (d) => {
        return d.scenario === 'Scenario A' && d.scheme_id === schemId && d.label === currentYear;
      });
      obj.currentYearValue = foundCurrentYearDataS1 ? Math.abs(this.getRoundNumber(foundCurrentYearDataS1.value, 1)) : 0;

      // s1_currentYearValue
      const foundCurrentYearDataS1Compare = _.find(dataArray, (d) => {
        return d.scenario === 'Scenario A' && d.label === currentYear;
      });
      obj.s1_currentYearValue = foundCurrentYearDataS1Compare ? Math.abs(this.getRoundNumber(foundCurrentYearDataS1Compare.value, 1)) : 0;

      // s2_currentYearValue
      const foundCurrentYearDataS2Compare = _.find(dataArray, (d) => {
        return d.scenario === 'Scenario B' && d.label === currentYear;
      });
      obj.s2_currentYearValue = foundCurrentYearDataS2Compare ? Math.abs(this.getRoundNumber(foundCurrentYearDataS2Compare.value, 1)) : 0;

      // currentYeaCurrencyValBillion
      obj.currentYeaCurrencyValBillion = foundCurrentYearDataS1 ? this.getRoundNumber(foundCurrentYearDataS1.value2 / 1000, 1) : 0;

      // _yearValue
      const years = ['2022', '2023', '2024', '2025', '2026', '2027', '2028', '2029', '2030', '2031'];
      for (const year of years) {
        const foundYearDataS1 = _.find(dataArray, (d) => {
          return d.scenario === 'Scenario A' && d.scheme_id === schemId && d.label === year;
        });
        obj[`${year}_yearValue`] = foundYearDataS1 ? Math.abs(this.getRoundNumber(foundYearDataS1.value, 1)) : 0;
      }

      // _labelIdValue
      const labeldIds = [
        '20001', // lowest
        '20010', // highest
        '20011', // total (deciles)
        '20012', // Couple household, with children
        '20013', // Couple household, with no children
        '20015', // One-person household, 60+ years
        '20022', // National
        '20020', // Whole population
        '20021', // Among children
        '20041', // Among persons with disabilities
        '20040', // Among older persons
        '20052', // Highest personal income tax bracket (per cent of net income and capital gains)
        '20053', // Corporate tax (per cent of net profits and capital gains)
        '20054' // Total cost of the programme(s) as percentage of tax revenue from income, profits and capital gains (per cent)
      ];
      const labelByScheme = {
        70001: '20021',
        70002: '20041',
        70003: '20040'
      };
      for (const labelId of labeldIds) {
        const foundLabelIdDataS1 = _.find(dataArray, (d) => {
          let targetLabelId = labelId;
          if (['20021', '20041', '20040'].includes(labelId)) {
            targetLabelId = labelByScheme[schemId] ? labelByScheme[schemId] : labelId;
          }
          let boolean;
          if (['20052', '20053', '20054'].includes(labelId)) {
            boolean = d.label_id === targetLabelId;
          } else {
            boolean = d.scenario === 'Scenario A' && d.scheme_id === schemId && d.label_id === targetLabelId;
          }
          return boolean;
        });
        const roundNum = foundLabelIdDataS1 ? this.getRoundNumber(foundLabelIdDataS1.value, 1) : 'N/A';
        const formatNum = typeof roundNum === 'number' ? Math.abs(roundNum) : roundNum;
        obj[`${labelId}_labelIdValue`] = formatNum;
      }

      // _labelIdValueTypeIdValue
      const valueTypeIds = [
        '10002', // Urban
        '10003', // Rural
        '10004', // With existing schemes
        '10005', // Post reform
        '10006' // Change (%)
      ];
      for (const labelId of labeldIds) {
        let targetLabelId = labelId;
        if (['20021', '20041', '20040'].includes(labelId)) {
          targetLabelId = labelByScheme[schemId] ? labelByScheme[schemId] : labelId;
        }
        for (const valueTypeId of valueTypeIds) {
          const foundLabelIdValueTypeIdDataS1 = _.find(dataArray, (d) => {
            return d.scenario === 'Scenario A' && d.scheme_id === schemId && d.label_id === targetLabelId && d.value_type_id === valueTypeId;
          });
          const roundNum = foundLabelIdValueTypeIdDataS1 ? this.getRoundNumber(foundLabelIdValueTypeIdDataS1.value, 1) : 'N/A';
          const formatNum = typeof roundNum === 'number' ? Math.abs(roundNum) : roundNum;
          obj[`${labelId}_${valueTypeId}_labelIdValueTypeIdValue`] = formatNum;
        }
      }

      for (const valueTypeId of valueTypeIds) {
        let minValOnlyValueType = 0;
        let minValOnlyValueTypeLabel = '';
        let maxValOnlyValueType = 0;
        let maxValOnlyValueTypeLabel = '';
        const onlyValueTypeObjs = comparableArr.filter(d => d.value_type_id === valueTypeId);
        // console.log('onlyValueTypeObjs ', onlyValueTypeObjs);
        // _minValOnlyValueType
        const minObjOnlyValueType = _.minBy(onlyValueTypeObjs, d => Math.abs(d.value));
        if (minObjOnlyValueType) {
          minValOnlyValueType = minObjOnlyValueType ? Math.abs(this.getRoundNumber(minObjOnlyValueType.value, 1)) : 0;
          minValOnlyValueTypeLabel = minObjOnlyValueType ? minObjOnlyValueType.label : '';
        }
        obj[`${valueTypeId}_minValOnlyValueType`] = minValOnlyValueType;
        obj[`${valueTypeId}_minValOnlyValueTypeLabel`] = minValOnlyValueTypeLabel;

        // _maxValOnlyValueType
        const maxObjOnlyValueType = _.maxBy(onlyValueTypeObjs, d => Math.abs(d.value));
        if (maxObjOnlyValueType) {
          maxValOnlyValueType = maxObjOnlyValueType ? Math.abs(this.getRoundNumber(maxObjOnlyValueType.value, 1)) : 0;
          maxValOnlyValueTypeLabel = maxObjOnlyValueType ? maxObjOnlyValueType.label : '';
        }
        obj[`${valueTypeId}_maxValOnlyValueType`] = maxValOnlyValueType;
        obj[`${valueTypeId}_maxValOnlyValueTypeLabel`] = maxValOnlyValueTypeLabel;
      }

      if (this.mode === 'comparative') {
        const foundDataS2 = _.find(dataArray, (d) => {
          return d.scenario === 'Scenario B' && d.scheme_id === schemId;
        });
        const formattedValueS2 = foundDataS2 ? Math.abs(this.getFormattedNumber(foundDataS2.value)) : 0;
        obj.s1_value = formattedValueS1;
        obj.s2_value = formattedValueS2;
        obj.s1_country = foundCountryObj.s1.name;
        obj.s2_country = foundCountryObj.s2.name;

        // compare_base_countries
        let cpbText = '';
        const conditionObj = {
          gt: [],
          less: [],
          eq: []
        };
        const scenarioList = ['s1', 's2'];
        _.each(scenarioList, (s) => {
          if (foundDataObj[s]) {
            if (foundDataObj[s].value > baseValue) {
              conditionObj.gt.push(foundCountryObj[s].name);
            } else if (foundDataObj[s].value < baseValue) {
              conditionObj.less.push(foundCountryObj[s].name);
            } else {
              conditionObj.eq.push(foundCountryObj[s].name);
            }
          }
        });
        _.each(conditionObj, (cd, key) => {
          if (cpbText && cd.length) {
            cpbText += ' and ';
          }
          if (cd.length) {
            if (cd.length === 2) {
              cpbText += 'both countries';
            } else if (cd.length === 1) {
              cpbText += cd[0];
            }

            if (key === 'gt') {
              cpbText += ' with greater than';
            } else if (key === 'less') {
              cpbText += ' with less than';
            } else if (key === 'eq') {
              cpbText += ' with equal to';
            }
          }
        });

        obj.compare_base_countries = cpbText;
      }

      if (isInequality1AllZero) {
        templateText = '<p>The figure shows the simulated change in inequality in response to selected scheme by different inequality indices.<p>';
      }

      if (isInequalityChartHasPositive) {
        templateText = templateText + '<p>Inequality may increase when there is a relatively higher proportion of recipients in higher welfare deciles.</p>';
      }

      const result = await getTextFromTemplate(templateText, obj);
      return result;
    },
    getAxisLabel (dataArray, foundIndicator, tabTextOptions, useDataFromDrupal) {
      let xLabel = '';
      let yLabel = '';

      if (dataArray.length && useDataFromDrupal) {
        const valTypes = _.uniq(_.map(dataArray, 'value_type_id'));
        xLabel = foundIndicator.field_x_label;
        if (valTypes.length > 1) { // indicator axis label
          yLabel = foundIndicator.field_y_label;
        } else { // 1 indicator has many axis label
          const valueTypeLabelRaw = this.getValueTypes.filter(d => d.tid === valTypes[0])[0].field_axis_label;
          let valueTypeLabel = valueTypeLabelRaw;
          if (valueTypeLabelRaw.includes('[[currency]]')) { // token
            const currencyCode = this.getCountries.filter(d => d.tid === this.selectedCountryId)[0].field_currency_code;
            valueTypeLabel = valueTypeLabelRaw.replace('[[currency]]', currencyCode);
          }
          yLabel = valueTypeLabel;
        }
      } else {
        // Use data from setting in chartSectionsData
        xLabel = tabTextOptions.xLabel;
        yLabel = tabTextOptions.yLabel;
      }

      return { xLabel, yLabel };
    },
    getBgInfoData (rawData, rawComData, sectionType) {
      const result = [];
      let bgInfoList = _.cloneDeep(this.getBackgroundInfos);
      bgInfoList = _.orderBy(bgInfoList, (d) => { return Number(d.weight); });
      if (sectionType === 'background-info-sub') {
        bgInfoList = bgInfoList.slice(0, 4);
      }
      if (rawData.length) {
        const rawDataObj = rawData[0];
        const combDataObj = rawComData.length ? rawComData[0] : undefined;
        _.each(bgInfoList, (bg) => {
          const dataObj = {
            name: bg.name,
            unit: bg.field_unit,
            value: rawDataObj[bg.field_field_name] ? this.getCommaSeparateNumber(rawDataObj[bg.field_field_name]) : '',
            value2: combDataObj && combDataObj[bg.field_field_name] ? this.getCommaSeparateNumber(combDataObj[bg.field_field_name]) : ''
          };
          result.push(dataObj);
        });
      }
      return result;
    },
    getCommaSeparateNumber (value) {
      let result = '';
      if (value) {
        result = this.getFormattedNumber(value).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
      }
      return result;
    },
    getFormattedNumber (value) {
      return (Math.round(Number(value) * 10) / 10);
    },
    setBgInfoObj (sectionName, data, mode) {
      this.pageData[sectionName] = { type: 'background-info', data: { data: data, mode: mode }, isLoading: false };
      this.pageData = { ...this.pageData };
    },
    formatDataWithNoScheme (dataArray) {
      const result = [];

      const gbCountry = _.groupBy(dataArray, 'country');
      _.each(gbCountry, (gbC) => {
        const gbScheme = _.groupBy(gbC, 'scheme');

        _.each(gbScheme, (gbArr) => {
          const gbLabels = _.groupBy(gbArr, 'label');

          _.each(gbLabels, (gblbArr) => {
            gblbArr = _.orderBy(gblbArr, 'benefit_level');
            const postRefObj = _.find(gblbArr, (d) => { return d.benefit_level !== '30004'; });

            if (postRefObj) {
              const valParam = postRefObj.parameter;
              const noSchemeArr = _.filter(gblbArr, (d) => { return d.benefit_level === '30004'; });
              let noSchemeObj = noSchemeArr[0];
              if (noSchemeArr.length > 1) {
                noSchemeObj = _.find(noSchemeArr, (d) => { return d.parameter === valParam; });
              }
              if (noSchemeObj) {
                if (noSchemeObj.value === 0) {
                  postRefObj.value = null;
                } else {
                  postRefObj.value = (postRefObj.value - noSchemeObj.value) / noSchemeObj.value * 100;
                }
              }
              // else {
              //   console.log('cannot find noSchemeObj', postRefObj);
              // }
              result.push(postRefObj);
            }
          });
        });
      });

      return result;
    },
    formatDataWithTaxonomy (dataArray, scenarioLabel) {
      let result = [];
      const lbLookup = {}; // Label Lookup
      const odLookup = {}; // order
      const vtLookup = {}; // value type
      const scLookup = {}; // scheme Lookup
      const bfLookup = {}; // benefit level
      const ctLookup = {}; // country
      const indLookup = {}; // indicator

      const labelList = _.cloneDeep(this.getLabels);
      const valueTypeList = _.cloneDeep(this.getValueTypes);
      const schemeList = _.cloneDeep(this.getSchemes);
      const benefitList = _.cloneDeep(this.getBenefitLevels);
      const countryList = _.cloneDeep(this.getCountries);
      const indicatorList = _.cloneDeep(this.getIndicators);

      _.each(labelList, (lb) => {
        lbLookup[lb.tid] = lb.field_display_name;
        odLookup[lb.tid] = Number(lb.weight);
      });

      _.each(valueTypeList, (vt) => {
        vtLookup[vt.tid] = vt.field_display_name ? vt.field_display_name : vt.name;
      });

      _.each(schemeList, (sc) => {
        scLookup[sc.tid] = sc.name;
        odLookup[sc.tid] = Number(sc.weight);
      });

      _.each(benefitList, (bf) => {
        bfLookup[bf.tid] = bf.name;
      });

      _.each(countryList, (ct) => {
        ctLookup[ct.tid] = ct.name;
      });

      _.each(indicatorList, (ind) => {
        indLookup[ind.tid] = ind.field_short_name;
      });

      const typeOfResultMapping = {
        60001: 'Coverage',
        60002: 'Household Consumption',
        60003: 'Poverty and Inequality',
        60004: 'Costs'
      };

      result = _.map(_.cloneDeep(dataArray), (d) => {
        d.value = Number(d.value);
        d.country_id = d.country;
        d.value_type_id = d.value_type;
        d.label_id = d.label;
        d.scheme_id = d.scheme;
        d.scheme_order = odLookup[d.scheme_id] ? odLookup[d.scheme_id] : 9999;
        d.label_order = odLookup[d.label_id] ? odLookup[d.label_id] : 9999;
        d.country = ctLookup[d.country] ? ctLookup[d.country] : d.country;
        d.label = lbLookup[d.label] ? lbLookup[d.label] : d.label;
        d.scenario = scenarioLabel;
        d.scheme = scLookup[d.scheme] ? scLookup[d.scheme] : 'Combined';
        d.value_type = vtLookup[d.value_type] ? vtLookup[d.value_type] : d.value_type;
        d.benefit_level_label = bfLookup[d.benefit_level] ? bfLookup[d.benefit_level] : d.benefit_level;
        d.poverty_mean_tested_label = d.poverty_mean_tested === '80002' ? '40%' : 'No';
        d.type_of_result_label = typeOfResultMapping[d.type_of_result];
        d.indicator_label = indLookup[d.indicator] ? indLookup[d.indicator] : d.indicator;

        // special value type cases
        if (d.value_type_id === '10001') {
          if (d.indicator === '40001') {
            d.value_type = 'Welfare Deciles (1 – 10)';
          } else if (d.indicator === '40002') {
            d.value_type = 'Household Types';
          } else if (['40004', '40005', '40006'].indexOf(d.indicator) > -1) {
            d.value_type = 'Increase in consumption by welfare decile';
          }
        }
        return d;
      });

      // console.log('formatDataWithTaxonomy', result);

      result = _.orderBy(result, 'order');
      return result;
    },
    getRoundNumber (num, precision) {
      let result = num;
      if (typeof num === 'number' && !isNaN(num)) {
        result = Number(Math.round(num + 'e+' + precision) + 'e-' + precision);
      }
      if (isNaN(num)) {
        result = 'N/A';
      }
      return result;
    },
    getCountryField (code, field) {
      let countryName = '';
      const countryList = _.cloneDeep(this.getCountries);
      const foundCountry = _.find(countryList, (p) => { return p.tid === code; });
      if (foundCountry) {
        countryName = foundCountry[field];
      }
      return countryName;
    },
    async getInfoGraphicData (sectionName, rawDataArray1, rawDataArray2, child, topic) {
      const toolbarType = _.cloneDeep(this.getDashboardToolbarType);
      const dashboardConfigs = _.cloneDeep(this.getDashboardConfigs);
      const scenario1Obj = _.cloneDeep(dashboardConfigs.scenario1);
      const infographicData = _.cloneDeep(this.infographicData);

      let infoVal1 = null;
      let infoVal2 = null;
      const infoTitleArr = [];
      let infoDescTop = '';
      let infoDescBottom = '';
      let infoThumbnail = '';
      const infoThumbnailChangable = infographicData[sectionName].thumbnail_changable;
      const infoTag = infographicData[sectionName].tag;

      const thumbnailSvg = await axios.get(infographicData[sectionName].thumbnail);
      infoThumbnail = thumbnailSvg && thumbnailSvg.data ? thumbnailSvg.data : infographicData[sectionName].thumbnail;
      const titleField = 'title';

      // Val
      let filterData1 = rawDataArray1 && rawDataArray1.length ? rawDataArray1 : [];
      let schmeIdTextsS1 = dashboardConfigs.pageLevel.scheme.sort().join('_');
      let schmeIdTextsS2 = dashboardConfigs.pageLevel.scheme.sort().join('_');
      const benefitLevel1 = dashboardConfigs.scenario1.benefit_level;
      const benefitLevel2 = dashboardConfigs.scenario2.benefit_level;
      const objKeys = Object.keys(infographicData[sectionName].filter);

      if (toolbarType === 'detail') {
        schmeIdTextsS1 = dashboardConfigs.detailScenario1.scheme_details.filter(d => d.is_selected).map(d => d.scheme).sort().join('_');
        schmeIdTextsS2 = dashboardConfigs.detailScenario2.scheme_details.filter(d => d.is_selected).map(d => d.scheme).sort().join('_');
      }

      for (const key of objKeys) {
        let tempKey = key;
        if (key === 'label') { tempKey = 'label_id'; }
        filterData1 = filterData1.filter(d => d[tempKey] === infographicData[sectionName].filter[key]);
      }
      filterData1 = filterData1.filter(d => d.scheme_id === schmeIdTextsS1);
      if (toolbarType === 'normal') {
        filterData1 = filterData1.filter(d => d.benefit_level === benefitLevel1);
      }
      if (filterData1[0]) {
        infoVal1 = this.getRoundNumber(filterData1[0].value, 1);
      }

      if (rawDataArray2 !== undefined) {
        let filterData2 = rawDataArray2 && rawDataArray2.length ? rawDataArray2 : [];
        const objKeys = Object.keys(infographicData[sectionName].filter);
        for (const key of objKeys) {
          let tempKey = key;
          if (key === 'label') { tempKey = 'label_id'; }
          filterData2 = filterData2.filter(d => d[tempKey] === infographicData[sectionName].filter[key]);
        }
        filterData2 = filterData2.filter(d => d.scheme_id === schmeIdTextsS2);
        if (toolbarType === 'normal') {
          filterData2 = filterData2.filter(d => d.benefit_level === benefitLevel2);
        }
        if (filterData2[0]) {
          infoVal2 = this.getRoundNumber(filterData2[0].value, 1);
        }
      }

      // Title, Desc
      if (infoVal1 !== null) {
        const dataObj1 = {
          value: infoVal1,
          unit: infographicData[sectionName].unit,
          country: this.getCountryField(scenario1Obj.country, 'name'),
          compareVal: 1.3
        };
        infoTitleArr.push(
          {
            name: 'Scenario A',
            value: await getTextFromTemplate(infographicData[sectionName][titleField], dataObj1)
          }
        );

        if (infoVal2 !== null) {
          const dataObj2 = {
            value: infoVal2,
            unit: infographicData[sectionName].unit,
            country: this.getCountryField(scenario1Obj.country, 'name'),
            compareVal: 1.3
          };
          infoTitleArr.push(
            {
              name: 'Scenario B',
              value: await getTextFromTemplate(infographicData[sectionName][titleField], dataObj2)
            }
          );
        }
        infoDescTop = await getTextFromTemplate(infographicData[sectionName].description_short_position_top, dataObj1);
        infoDescBottom = await getTextFromTemplate(infographicData[sectionName].description_short_position_bottom, dataObj1);
      }
      return {
        titles: infoTitleArr,
        description_short_position_top: infoDescTop,
        description_short_position_bottom: infoDescBottom,
        thumbnail: infoThumbnail,
        thumbnail_changable: infoThumbnailChangable,
        tag: infoTag,
        current_page: this.currentPage,
        current_topic: this.currentTopic,
        section_name: sectionName,
        topic,
        child
      };
    },
    setInfoGraphicObj (sectionName, data, fetchTimestamp) {
      // Force quite when timeStamp not matched
      if (_.cloneDeep(this.getDashboardFetchTimestamp) !== fetchTimestamp) return;

      this.pageData[sectionName] = { type: 'infographic', data: { data: data }, isLoading: false };

      // @Todo : fix object detect change, need to find a correct place to put this line later
      this.pageData = { ...this.pageData };
    },
    async getExclusionData (sectionName, filterObj, scenarioName) {
      const countryList = _.cloneDeep(this.getCountries);
      const fetchCountries = [];
      const fetchList = [];
      const fetchListType = [];
      let tempData = [];
      const schemeDetailList = filterObj.scheme_details;
      const selectedScheme = _.filter(filterObj.scheme_details, (d) => { return d.is_selected; });
      const childSchemeObj = schemeDetailList[0];
      const disSchemeObj = schemeDetailList[1];
      const oldSchemeObj = schemeDetailList[2];
      const oldPensionTest = oldSchemeObj.pt ? oldSchemeObj.pt : false;
      // const 'https://pshiny.thinkbluedata.com/exclusion_errors?country=Cambodia&childMaxAge=17&disabMaxAge=64&oldMinAge=65&oldMaxAge=100&childcovA=100&disabcovA=100&oldcovA=100';
      const staticfilterObj = {
        childMinAge: childSchemeObj.age[0],
        childMaxAge: childSchemeObj.age[1] - 1,
        childMeans: true,
        disabMinAge: disSchemeObj.age[0],
        disabMaxAge: disSchemeObj.age[1] === 100 ? disSchemeObj.age[1] : disSchemeObj.age[1] - 1,
        disabMeans: true,
        oldMinAge: oldSchemeObj.age[0],
        oldMaxAge: oldSchemeObj.age[1] === 100 ? oldSchemeObj.age[1] : oldSchemeObj.age[1] - 1,
        oldMeans: true,
        childcovA: childSchemeObj.pmt,
        disabcovA: disSchemeObj.pmt,
        oldcovA: oldSchemeObj.pmt
      };

      _.each(countryList, (c) => {
        const tempFilterObj = _.cloneDeep(staticfilterObj);
        tempFilterObj.country = c.name === 'Türkiye' ? 'Turkey' : c.name;
        const tempFilterObjString = this.getPShinyFilterString(tempFilterObj);
        let formattedData = [];
        if (this.downloadedData[tempFilterObjString]) {
          formattedData = _.cloneDeep(this.downloadedData[tempFilterObjString]);
          tempData = tempData.concat(formattedData);
        } else {
          this.pageData[sectionName] = { isLoading: true };
          const tempFetch$ = fetch('https://pshiny.thinkbluedata.com/exclusion_errors?' + tempFilterObjString).then((res) => res.json());
          fetchList.push(tempFetch$);
          fetchListType.push(tempFilterObjString);
          fetchCountries.push(c);
        }
      });

      // @Todo : Fetch all list at the same time
      const data = await Promise.all(fetchList);
      if (data.length) {
        _.each(data, (fetchData, index) => {
          // console.log('check', JSON.parse(fetchData[0]));

          const rawFetchData = JSON.parse(fetchData[0]);
          const rawExclusion = [
            {
              value: Number(rawFetchData.child_exclusion_error),
              country: fetchCountries[index].name,
              scheme: '70001',
              indicator: '40050',
              value_type: '10017',
              label: '20055'
            },
            {
              value: 100 - Number(rawFetchData.child_exclusion_error),
              country: fetchCountries[index].name,
              scheme: '70001',
              indicator: '40050',
              value_type: '10017',
              label: '20056'
            },
            {
              value: Number(rawFetchData.disab_exclusion_error),
              country: fetchCountries[index].name,
              scheme: '70002',
              indicator: '40050',
              value_type: '10017',
              label: '20055'
            },
            {
              value: 100 - Number(rawFetchData.disab_exclusion_error),
              country: fetchCountries[index].name,
              scheme: '70002',
              indicator: '40050',
              value_type: '10017',
              label: '20056'
            },
            {
              value: Number(rawFetchData.old_exclusion_error),
              country: fetchCountries[index].name,
              scheme: '70003',
              indicator: '40050',
              value_type: '10017',
              label: '20055'
            },
            {
              value: 100 - Number(rawFetchData.old_exclusion_error),
              country: fetchCountries[index].name,
              scheme: '70003',
              indicator: '40050',
              value_type: '10017',
              label: '20056'
            }
          ];

          const formattedData = fetchData && fetchData.length ? this.formatDataWithTaxonomy(rawExclusion, scenarioName) : [];
          // const formattedData = [];
          this.downloadedData[fetchListType[index]] = _.cloneDeep(formattedData);
          tempData = tempData.concat(formattedData);
        });
      }

      tempData = _.filter(tempData, (d) => {
        let bool = true;
        if (d.scheme_id === '70001' && !childSchemeObj.is_selected) {
          bool = false;
        }
        if (d.scheme_id === '70002' && !disSchemeObj.is_selected) {
          bool = false;
        }
        if (d.scheme_id === '70003' && !oldSchemeObj.is_selected) {
          bool = false;
        }
        return bool;
      });

      // console.log('tempData', tempData);

      return tempData;
    },
    async getPShinyDataByFilterObject (sectionName, filterObj, sectionFilterObj, indicatorId, scenarioName, fetchTimestamp) {
      // console.log('filterObj', filterObj, sectionFilterObj);

      const pShinyFilterString = 'param_id=999&ind_id=40012&country=Cambodia&childbenefit=true&childMaxAge=17&disabMaxAge=64&oldMinAge=64&oldMaxAge=100&childPercentage=5&childAdmin=5&disabAdmin=5&oldAdmin=5&scheme_id=70001&benefit_level=Other%20benefit';

      const countryId = filterObj.country;
      const countryList = _.cloneDeep(this.getCountries);
      const foundCountry = _.find(countryList, (p) => { return p.tid === countryId; });
      let isUseSpecialCoverage = false;

      if (['sectionDetail'].indexOf(sectionName) > -1) {
        isUseSpecialCoverage = _.cloneDeep(this.isUseSpecialCoverage);
      }

      const schemeDetailList = filterObj.scheme_details;
      const selectedScheme = _.filter(filterObj.scheme_details, (d) => { return d.is_selected; });
      const childSchemeObj = schemeDetailList[0];
      const disSchemeObj = schemeDetailList[1];
      const oldSchemeObj = schemeDetailList[2];
      const oldPensionTest = oldSchemeObj.pt ? oldSchemeObj.pt : false;

      // Mock fetch function
      const schemeListTest = ['40001', '40002', '40003', '40001_40002_40003'];
      let tempPShinyData = [];
      const pShinyIndicator = indicatorId;

      const fetchList = [];
      const fetchListType = [];

      if (childSchemeObj.is_selected &&
        _.cloneDeep(this.getDashboardFetchTimestamp) === fetchTimestamp) {
        const pShinyChild = _.cloneDeep(this.getDefaultPShinyObj);
        pShinyChild.param_id = 8;
        pShinyChild.ind_id = pShinyIndicator;
        pShinyChild.country = foundCountry.name === 'Türkiye' ? 'Turkey' : foundCountry.name;
        pShinyChild.childbenefit = true;
        pShinyChild.childPercentage = childSchemeObj.benefit_percent;
        pShinyChild.scheme_id = '70001';
        pShinyChild.childMinAge = childSchemeObj.age[0];
        pShinyChild.childMaxAge = childSchemeObj.age[1] - 1;
        pShinyChild.childAdmin = childSchemeObj.admin_cost;
        pShinyChild.oldPensionTest = oldPensionTest;
        pShinyChild.childcovA = childSchemeObj.pmt;
        pShinyChild.special_cov = isUseSpecialCoverage;
        const pShinyChildString = this.getPShinyFilterString(pShinyChild);
        let formattedPShinyDataChild = [];
        if (this.downloadedData[pShinyChildString]) {
          formattedPShinyDataChild = _.cloneDeep(this.downloadedData[pShinyChildString]);
          tempPShinyData = tempPShinyData.concat(formattedPShinyDataChild);
        } else {
          this.pageData[sectionName] = { isLoading: true };
          // const tempDatChild = await this.getPShinyDataByScheme(pShinyChildString);
          // formattedPShinyDataChild = tempDatChild && tempDatChild.length ? this.formatDataWithTaxonomy(JSON.parse(tempDatChild[0]), scenarioName) : [];
          // this.downloadedData[pShinyChildString] = _.cloneDeep(formattedPShinyDataChild);
          const childFetch$ = fetch('https://pshiny.thinkbluedata.com/process?' + pShinyChildString).then((res) => res.json());
          fetchList.push(childFetch$);
          fetchListType.push(pShinyChildString);
        }
      }

      if (disSchemeObj.is_selected &&
        _.cloneDeep(this.getDashboardFetchTimestamp) === fetchTimestamp) {
        const pShinyDis = _.cloneDeep(this.getDefaultPShinyObj);
        pShinyDis.param_id = 8;
        pShinyDis.ind_id = pShinyIndicator;
        pShinyDis.country = foundCountry.name === 'Türkiye' ? 'Turkey' : foundCountry.name;
        pShinyDis.disabilitybenefit = true;
        pShinyDis.disabilityPercentage = disSchemeObj.benefit_percent;
        pShinyDis.scheme_id = '70002';
        pShinyDis.disabMinAge = disSchemeObj.age[0];
        pShinyDis.disabMaxAge = disSchemeObj.age[1] === 100 ? disSchemeObj.age[1] : disSchemeObj.age[1] - 1;
        pShinyDis.disabAdmin = disSchemeObj.admin_cost;
        pShinyDis.oldPensionTest = oldPensionTest;
        pShinyDis.disabcovA = disSchemeObj.pmt;
        pShinyDis.special_cov = isUseSpecialCoverage;
        const pShinyDisString = this.getPShinyFilterString(pShinyDis);
        let formattedPShinyDataDis = [];
        if (this.downloadedData[pShinyDisString]) {
          formattedPShinyDataDis = _.cloneDeep(this.downloadedData[pShinyDisString]);
          tempPShinyData = tempPShinyData.concat(formattedPShinyDataDis);
        } else {
          this.pageData[sectionName] = { isLoading: true };
          // const tempDatDis = await this.getPShinyDataByScheme(pShinyDisString);
          // const formattedPShinyDataDis = tempDatDis && tempDatDis.length ? this.formatDataWithTaxonomy(JSON.parse(tempDatDis[0]), scenarioName) : [];
          // this.downloadedData[pShinyDisString] = _.cloneDeep(formattedPShinyDataDis);
          // tempPShinyData = tempPShinyData.concat(formattedPShinyDataDis);
          const disFetch$ = fetch('https://pshiny.thinkbluedata.com/process?' + pShinyDisString).then((res) => res.json());
          fetchList.push(disFetch$);
          fetchListType.push(pShinyDisString);
        }
      }

      if (oldSchemeObj.is_selected &&
        _.cloneDeep(this.getDashboardFetchTimestamp) === fetchTimestamp) {
        const pShinyOld = _.cloneDeep(this.getDefaultPShinyObj);
        pShinyOld.param_id = 8;
        pShinyOld.ind_id = pShinyIndicator;
        pShinyOld.country = foundCountry.name === 'Türkiye' ? 'Turkey' : foundCountry.name;
        pShinyOld.oldagebenefit = true;
        pShinyOld.oldagePercentage = oldSchemeObj.benefit_percent;
        pShinyOld.scheme_id = '70003';
        pShinyOld.oldMinAge = oldSchemeObj.age[0];
        pShinyOld.oldMaxAge = oldSchemeObj.age[1] === 100 ? oldSchemeObj.age[1] : oldSchemeObj.age[1] - 1;
        pShinyOld.oldAdmin = oldSchemeObj.admin_cost;
        pShinyOld.oldPensionTest = oldPensionTest;
        pShinyOld.oldcovA = oldSchemeObj.pmt;
        pShinyOld.special_cov = isUseSpecialCoverage;
        const pShinyOldString = this.getPShinyFilterString(pShinyOld);
        let formattedPShinyDataOld = [];
        if (this.downloadedData[pShinyOldString]) {
          formattedPShinyDataOld = _.cloneDeep(this.downloadedData[pShinyOldString]);
          tempPShinyData = tempPShinyData.concat(formattedPShinyDataOld);
        } else {
          this.pageData[sectionName] = { isLoading: true };
          // const tempDatOld = await this.getPShinyDataByScheme(pShinyOldString);
          // const formattedPShinyDataOld = tempDatOld && tempDatOld.length ? this.formatDataWithTaxonomy(JSON.parse(tempDatOld[0]), scenarioName) : [];
          // this.downloadedData[pShinyOldString] = _.cloneDeep(formattedPShinyDataOld);
          // tempPShinyData = tempPShinyData.concat(formattedPShinyDataOld);
          const oldFetch$ = fetch('https://pshiny.thinkbluedata.com/process?' + pShinyOldString).then((res) => res.json());
          fetchList.push(oldFetch$);
          fetchListType.push(pShinyOldString);
        }
      }

      // Combined cased
      let schemeCount = 0;
      schemeCount = childSchemeObj.is_selected ? schemeCount + 1 : schemeCount;
      schemeCount = disSchemeObj.is_selected ? schemeCount + 1 : schemeCount;
      schemeCount = oldSchemeObj.is_selected ? schemeCount + 1 : schemeCount;

      if (schemeCount > 1 &&
        _.cloneDeep(this.getDashboardFetchTimestamp) === fetchTimestamp) {
        const pShinyCombined = _.cloneDeep(this.getDefaultPShinyObj);
        pShinyCombined.param_id = 8;
        pShinyCombined.ind_id = pShinyIndicator;
        pShinyCombined.country = foundCountry.name === 'Türkiye' ? 'Turkey' : foundCountry.name;
        // pShinyCombined.scheme_id = '70001_70002_70003';
        pShinyCombined.scheme_id = _.map(selectedScheme, 'scheme').join('_');
        pShinyCombined.oldPensionTest = oldPensionTest;
        pShinyCombined.special_cov = isUseSpecialCoverage;
        if (childSchemeObj.is_selected) {
          pShinyCombined.childbenefit = true;
          pShinyCombined.childPercentage = childSchemeObj.benefit_percent;
          pShinyCombined.childMinAge = childSchemeObj.age[0];
          pShinyCombined.childMaxAge = childSchemeObj.age[1] - 1;
          pShinyCombined.childAdmin = childSchemeObj.admin_cost;
          pShinyCombined.childcovA = childSchemeObj.pmt;
        }
        if (disSchemeObj.is_selected) {
          pShinyCombined.disabilitybenefit = true;
          pShinyCombined.disabilityPercentage = disSchemeObj.benefit_percent;
          pShinyCombined.disabMinAge = disSchemeObj.age[0];
          pShinyCombined.disabMaxAge = disSchemeObj.age[1] === 100 ? disSchemeObj.age[1] : disSchemeObj.age[1] - 1;
          pShinyCombined.disabAdmin = disSchemeObj.admin_cost;
          pShinyCombined.disabcovA = disSchemeObj.pmt;
        }
        if (oldSchemeObj.is_selected) {
          pShinyCombined.oldagebenefit = true;
          pShinyCombined.oldagePercentage = oldSchemeObj.benefit_percent;
          pShinyCombined.oldMinAge = oldSchemeObj.age[0];
          pShinyCombined.oldMaxAge = oldSchemeObj.age[1] === 100 ? oldSchemeObj.age[1] : oldSchemeObj.age[1] - 1;
          pShinyCombined.oldAdmin = oldSchemeObj.admin_cost;
          pShinyCombined.oldcovA = oldSchemeObj.pmt;
        }
        const pShinyCombinedString = this.getPShinyFilterString(pShinyCombined);
        let formattedPShinyDataCombined = [];
        if (this.downloadedData[pShinyCombinedString]) {
          formattedPShinyDataCombined = _.cloneDeep(this.downloadedData[pShinyCombinedString]);
          tempPShinyData = tempPShinyData.concat(formattedPShinyDataCombined);
        } else {
          this.pageData[sectionName] = { isLoading: true };
          // const tempDatCombined = await this.getPShinyDataByScheme(pShinyCombinedString);
          // const formattedPShinyDataCombined = tempDatCombined && tempDatCombined.length ? this.formatDataWithTaxonomy(JSON.parse(tempDatCombined[0]), scenarioName) : [];
          // this.downloadedData[pShinyCombinedString] = _.cloneDeep(formattedPShinyDataCombined);
          // tempPShinyData = tempPShinyData.concat(formattedPShinyDataCombined);
          const comFetch$ = fetch('https://pshiny.thinkbluedata.com/process?' + pShinyCombinedString).then((res) => res.json());
          fetchList.push(comFetch$);
          fetchListType.push(pShinyCombinedString);
        }
      }

      // @Todo : Fetch all list at the same time
      const data = await Promise.all(fetchList);
      if (data.length) {
        _.each(data, (fetchData, index) => {
          const formattedPShinyData = fetchData && fetchData.length ? this.formatDataWithTaxonomy(JSON.parse(fetchData[0]), scenarioName) : [];
          this.downloadedData[fetchListType[index]] = _.cloneDeep(formattedPShinyData);
          tempPShinyData = tempPShinyData.concat(formattedPShinyData);
        });
      }

      const sectionFilterKeys = Object.keys(sectionFilterObj);
      tempPShinyData = _.filter(tempPShinyData, (d) => {
        let bool = true;
        _.each(sectionFilterKeys, (sk) => {
          let tempKey = sk;
          if (sk === 'value_type') { tempKey = 'value_type_id'; }
          if (sk === 'label') { tempKey = 'label_id'; }

          if (['special_cov', 'pension_tested'].indexOf(sk) > -1) {
            return;
          }

          if (sectionFilterObj[sk].indexOf('_')) {
            const tempCheckArr = sectionFilterObj[sk].split('_');
            if (tempCheckArr.indexOf(d[tempKey]) === -1) {
              bool = false;
            }
          } else {
            if (sectionFilterObj[sk] !== d[tempKey]) {
              bool = false;
            }
          }
        });
        return bool;
      });

      tempPShinyData = _.map(tempPShinyData, (d) => {
        d.scenario = scenarioName;
        return d;
      });

      // console.log('reultArr', tempPShinyData);
      return tempPShinyData;
    },
    getPShinyFilterString (filterObj) {
      const filterString = Object.keys(filterObj).map((k) => {
        return k + '=' + filterObj[k];
      }).join('&');

      return filterString;
    }
  },
  setup () {
    return {
    };
  }
};
</script>

<style scoped lang="scss">
.grid-num-text {
  z-index: 1000;
}
.close-button-container {
  position: absolute;
  right: 0;
  z-index: 1000;
}
.vue-grid-layout {
  background: #eee;
}
.vue-grid-item:not(.vue-grid-placeholder) {
  background: #ccc;
  border: 1px solid black;
}
.vue-grid-item .resizing {
  opacity: 0.9;
}
.vue-grid-item .static {
  background: #cce;
}
.vue-grid-item .text {
  font-size: 24px;
  text-align: center;
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  margin: auto;
  height: 100%;
  width: 100%;
}
.vue-grid-item .no-drag {
  height: 100%;
  width: 100%;
}
.vue-grid-item .minMax {
  font-size: 12px;
}
.vue-grid-item .add {
  cursor: pointer;
}
.vue-draggable-handle {
  position: absolute;
  width: 20px;
  height: 20px;
  top: 0;
  left: 0;
  background: url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='10' height='10'><circle cx='5' cy='5' r='5' fill='#999999'/></svg>") no-repeat;
  background-position: bottom right;
  padding: 0 8px 8px 0;
  background-repeat: no-repeat;
  background-origin: content-box;
  box-sizing: border-box;
  cursor: pointer;
}

.layoutJSON {
  background: #ddd;
  border: 1px solid black;
  margin-top: 10px;
  padding: 10px;
}
.columns {
  -moz-columns: 120px;
  -webkit-columns: 120px;
  columns: 160px;
}
.vue-grid-item {
  overflow: auto !important;
}
.spinner-box {
  margin: 0;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}
.height-100 {
  height: 100% !important;
}
.grid {
  width: 100%;
}
</style>
