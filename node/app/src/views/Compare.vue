<template>
  <div class="compare-analysis">
    <div>
      <filter-panel
        :space="6"
        :selected-object="filterPanelInputs.pageLevel.selectedObject"
        :filters="filterPanelInputs.pageLevel.filters"
        @selectedChanged="fetchSectionList()">
      </filter-panel>
    </div>
    <div class="row">
      <div class="col-md-4">
        <h4>Scenario 1</h4>
        <filter-panel
          :space="12"
          :selected-object="filterPanelInputs.scenario1.selectedObject"
          :filters="filterPanelInputs.scenario1.filters"
          @selectedChanged="fetchSectionList()">
        </filter-panel>
      </div>

      <div v-if="mode === 'comparative'" class="col-md-4">
        <h4>Scenario 2</h4>
        <filter-panel
          :space="12"
          :selected-object="filterPanelInputs.scenario2.selectedObject"
          :filters="filterPanelInputs.scenario2.filters"
          @selectedChanged="fetchSectionList()">
        </filter-panel>
      </div>
    </div>

    <div v-if="mode === 'comparative'" class="comparative-chart-sections">
      <chart-section
        :title="chartSectionsData.section1.title"
        :tabs="chartSectionsData.section1.tabs"></chart-section>

      <chart-section
        :title="chartSectionsData.section2.title"
        :tabs="chartSectionsData.section2.tabs"></chart-section>

      <chart-section
        :title="chartSectionsData.section3.title"
        :tabs="chartSectionsData.section3.tabs"></chart-section>

      <chart-section
        :title="chartSectionsData.section4.title"
        :tabs="chartSectionsData.section4.tabs"></chart-section>

      <chart-section
        :title="chartSectionsData.section5.title"
        :tabs="chartSectionsData.section5.tabs"></chart-section>
    </div>

    <div v-if="mode === 'combined'" class="combined-chart-sections">
      <chart-section
        :title="chartSectionsData.sectionc1.title"
        :tabs="chartSectionsData.sectionc1.tabs"></chart-section>
      <infographic
        :data="infographicOutput.sectionc1.data"></infographic>

      <chart-section
        :title="chartSectionsData.sectionc2.title"
        :tabs="chartSectionsData.sectionc2.tabs"></chart-section>
      <infographic
        :data="infographicOutput.sectionc2.data"></infographic>

      <chart-section
        :title="chartSectionsData.sectionc3.title"
        :tabs="chartSectionsData.sectionc3.tabs"></chart-section>
      <infographic
        :data="infographicOutput.sectionc3.data"></infographic>

      <chart-section
        :title="chartSectionsData.sectionc4.title"
        :tabs="chartSectionsData.sectionc4.tabs"></chart-section>
      <infographic
        :data="infographicOutput.sectionc4.data"></infographic>

      <chart-section
        :title="chartSectionsData.sectionc5.title"
        :tabs="chartSectionsData.sectionc5.tabs"></chart-section>
      <infographic
        :data="infographicOutput.sectionc5.data"></infographic>
    </div>
  </div>
</template>

<script>
import ChartSection from '@/components/ChartSection.vue';
import FilterPanel from '@/components/FilterPanel.vue';
import Infographic from '@/components/Infographic.vue';
import { RAPI_DOMAIN, RAPI_VERSION_URL } from '@/environment';
import axios from '@axios';
import _ from 'lodash';
import { mapActions, mapGetters, mapState } from 'vuex';

export default {
  components: {
    ChartSection,
    FilterPanel,
    Infographic
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
      'getCompareConfigs'
    ]),
    ...mapState('analysis', [
      'compareConfigs',
      'indicators',
      'parameters'
    ])
  },
  data: function () {
    return {
      loopBackApiPath: `${RAPI_DOMAIN}${RAPI_VERSION_URL}`,
      mode: 'comparative',
      scenarioList: ['scenario1', 'scenario2'],
      sectionList: ['section1', 'section2', 'section3', 'section4', 'section5'],
      combinedScenarioList: ['scenario1'],
      combinedSectionList: ['sectionc1', 'sectionc2', 'sectionc3', 'sectionc4', 'sectionc5'],
      filterPanelInputs: {
        pageLevel: {
          selectedObject: {
            scheme: ['70001', '70002', '70003']
          },
          filters: [
            {
              label: 'Scheme',
              type: 'multiple',
              key: 'scheme',
              items: [
                { value: '70001', label: 'Child Benefit' },
                { value: '70002', label: 'Disability Benefit' },
                { value: '70003', label: 'Old Age Benefit' }
              ]
            }
          ]
        },
        scenario1: {
          selectedObject: {
            country: '50004',
            benefit_level: '30002',
            poverty_mean_tested: '80001'
          },
          filters: [
            {
              label: 'Country',
              key: 'country',
              items: [
                { value: '50004', label: 'Cambodia' },
                { value: '50017', label: 'Thailand' }
              ]
            },
            {
              label: 'Benefit',
              key: 'benefit_level',
              items: [
                { value: '30002', label: 'Basic' },
                { value: '30003', label: 'Enhanced' }
              ]
            },
            {
              label: 'Poverty',
              key: 'poverty_mean_tested',
              items: [
                { value: '80001', label: 'No' },
                { value: '80002', label: '40%' }
              ]
            }
          ]
        },
        scenario2: {
          selectedObject: {
            country: '50004',
            benefit_level: '30003',
            poverty_mean_tested: '80001'
          },
          filters: [
            {
              label: 'Country',
              key: 'country',
              items: [
                { value: '50004', label: 'Cambodia' },
                { value: '50017', label: 'Thailand' }
              ]
            },
            {
              label: 'Benefit',
              key: 'benefit_level',
              items: [
                { value: '30002', label: 'Basic' },
                { value: '30003', label: 'Enhanced' }
              ]
            },
            {
              label: 'Poverty',
              key: 'poverty_mean_tested',
              items: [
                { value: '80001', label: 'No' },
                { value: '80002', label: '40%' }
              ]
            }
          ]
        },
        section1: {
          selectedObject: {
            indicator: '40007',
            label: '20022'
          }
        },
        section2: {
          selectedObject: {
            indicator: '40011',
            label: '20026'
          }
        },
        section3: {
          selectedObject: {
            indicator: '40012',
            label: '20038'
          }
        },
        section4: {
          selectedObject: {
            indicator: '40001',
            label: '20011'
          }
        },
        section5: {
          selectedObject: {
            indicator: '40004',
            label: '20011'
          }
        },
        sectionc1: {
          selectedObject: {
            indicator: '40007'
          }
        },
        sectionc2: {
          selectedObject: {
            indicator: '40011'
          }
        },
        sectionc3: {
          selectedObject: {
            indicator: '40012',
            value_type: '10010'
          }
        },
        sectionc4: {
          selectedObject: {
            indicator: '40001',
            label: '20001_20010_20011',
            value_type: '10001'
          }
        },
        sectionc5: {
          selectedObject: {
            indicator: '40004',
            label: '20001_20010_20011',
            value_type: '10001'
          }
        }
      },
      chartSectionsData: {
        section1: {
          title: 'Poverty Reduction by Benefit Scheme (% change)',
          tabTypes: [
            {
              title: 'Bar',
              type: 'bar_horizontal_grouped',
              groupByField: 'scenario',
              labelField: 'scheme',
              insight: 'Combined schemes can reduce poverty in Cambodia by 40% and in Thailand by 66%.',
              textOptions: {
                xLabel: 'Poverty Reduction (% change)',
                yLabel: 'Scheme'
              }
            }
          ],
          tabs: []
        },
        section2: {
          title: 'Inequality Reduction by All Schemes (% change)',
          tabTypes: [
            {
              title: 'Bar',
              type: 'bar_horizontal_grouped',
              groupByField: 'scenario',
              labelField: 'scheme',
              insight: 'The reduction in inequality is much less pronounced in both countries with less than 10% reduction in Gini index.',
              textOptions: {
                xLabel: 'Gini index (% change)',
                yLabel: 'Schemes'
              }
            }
          ],
          tabs: []
        },
        section3: {
          title: 'Cost as % of GDP, by scheme (% ), 2022',
          tabTypes: [
            {
              title: 'Bar',
              type: 'bar_horizontal_grouped',
              groupByField: 'scenario',
              labelField: 'scheme',
              insight: 'The cost of selected schemes reach 3.6% of GDP in Thailand and 2.9% in Cambodia.',
              textOptions: {
                xLabel: 'Cost as % of GDP',
                yLabel: 'Schemes'
              }
            }
          ],
          tabs: []
        },
        section4: {
          title: 'Coverage (Total Deciles) of Schemes (share of whole population)',
          tabTypes: [
            {
              title: 'Bar',
              type: 'bar_horizontal_grouped',
              groupByField: 'scenario',
              labelField: 'scheme',
              insight: 'Universal schemes ensure that all eligible people are covered. This leads to majority of households benefiting.',
              textOptions: {
                xLabel: 'Coverage (Total Deciles)',
                yLabel: 'Schemes'
              }
            }
          ],
          tabs: []
        },
        section5: {
          title: 'Change in Household Expenditure (per capita, %) (Lowest Deciles)',
          tabTypes: [
            {
              title: 'Bar',
              type: 'bar_horizontal_grouped',
              groupByField: 'scenario',
              labelField: 'scheme',
              insight: 'Among recipient households, expenditure per capita can increase by 50% in Thailand for poorest households. The increase is much less pronounced in Cambodia.',
              textOptions: {
                xLabel: 'Increase in per capita consumption expenditure (Lowest Deciles)',
                yLabel: 'Schemes'
              }
            }
          ],
          tabs: []
        },
        sectionc1: {
          title: 'Poverty reduction impact by scheme and international poverty line (IPL) ',
          tabTypes: [
            {
              title: 'Bar',
              type: 'bar_horizontal_grouped',
              groupByField: 'scheme',
              labelField: 'label',
              insight: 'Child Benefits leads to the largest poverty reduction impact among the selected schemes particularly for extreme poverty.',
              textOptions: {
                xLabel: 'Poverty Reduction (% change)',
                yLabel: 'Poverty Line'
              }
            }
          ],
          tabs: []
        },
        sectionc2: {
          title: 'Simulated impact on inequality is modest and similar across different measures. Child benefits contributes to reduction in inequalitt the most.',
          tabTypes: [
            {
              title: 'Bar',
              type: 'bar_horizontal_grouped',
              groupByField: 'scheme',
              labelField: 'label',
              insight: 'The reduction in inequality is much less pronounced in both countries with less than 10% reduction in Gini index.',
              textOptions: {
                xLabel: 'Inequality reduction impact (% change)',
                yLabel: 'Inequality Metric'
              }
            }
          ],
          tabs: []
        },
        sectionc3: {
          title: ' Cost as % GDP, by scheme',
          tabTypes: [
            {
              title: 'Line',
              type: 'line',
              groupByField: 'scheme',
              labelField: 'label',
              insight: 'The total cost is set to decrease over time with old-age benefits becoming increasingly more important relative to child benefits.',
              textOptions: {
                xLabel: 'Year',
                yLabel: 'Cost as % of GDP'
              }
            }
          ],
          tabs: []
        },
        sectionc4: {
          title: 'Coverage of Schemes (share of whole population)',
          tabTypes: [
            {
              title: 'Bar',
              type: 'bar_horizontal_grouped',
              groupByField: 'label',
              labelField: 'scheme',
              insight: 'All children (0-17) eldely (65+) and people with disabilities are covered. Child benefits penetrate 85% of households in Cambodia.',
              textOptions: {
                xLabel: 'Coverage (%)',
                yLabel: 'Schemes'
              }
            }
          ],
          tabs: []
        },
        sectionc5: {
          title: 'Impact on Expenditure per capita (% change)',
          tabTypes: [
            {
              title: 'Bar',
              type: 'bar_horizontal_grouped',
              groupByField: 'label',
              labelField: 'scheme',
              insight: 'Expenditures: Per capita expenditures can increase by as much as 5%  in response to child beneifts scheme.',
              textOptions: {
                xLabel: 'Increase in per capita consumption expenditure (%)',
                yLabel: 'Schemes'
              }
            }
          ],
          tabs: []
        }
      },
      infographicData: {
        sectionc1: {
          value: 0,
          unit: '%',
          title: '[[isNeg]][[value]][[unit]]',
          title_s: '[[isNeg]]Cut poverty by [[value]][[unit]]',
          description: '<b>Poverty rate</b> measured at <u>national poverty line</u> would decrease by [[value]][[unit]] following the selected schemes.',
          description_s: 'Poverty rate measured according to the national poverty line.',
          thumbnail: '/themes/custom/tbdtheme/assets/dist/img/template/placeholder.png',
          filter: {
            label: '20022'
          }
        },
        sectionc2: {
          value: 0,
          unit: '%',
          title: '[[isNeg]][[value]][[unit]]',
          title_s: '[[isNeg]]Reduce inequality by [[value]][[unit]]',
          description: '<b>Inequality</b> as measured by Gini coefficient would decrease by [[value]][[unit]].',
          description_s: 'Inequality measured by the Gini coefficient.',
          thumbnail: '/themes/custom/tbdtheme/assets/dist/img/template/placeholder.png',
          filter: {
            label: '20026'
          }
        },
        sectionc3: {
          value: 0,
          unit: '%',
          title: '[[isNeg]][[value]][[unit]] of GDP',
          title_s: '[[isNeg]]Cost [[value]][[unit]] of GDP',
          description: 'The <b>cost</b> of the scheme(s) would be [[value]][[unit]], [[compare_text]] than Asia-Pacific average of 1.3% in tax financed non-contributory social protection schemes.',
          description_s: 'Cost of selected scheme is measured as a share of [[currentYear]] GDP.',
          thumbnail: '/themes/custom/tbdtheme/assets/dist/img/template/placeholder.png',
          filter: {
            label: '20038'
          }
        },
        sectionc4: {
          value: 0,
          unit: '%',
          title: '[[isNeg]][[value]][[unit]]',
          title_s: 'Cover 100% of selected scheme <br>Benefit [[value]][[unit]] of population',
          description: 'The scheme(s) would provide <b>coverage</b> by [[value]][[unit]] of the whole population in [[country]].',
          description_s: 'This scheme would benefit [[value]][[unit]] of the population in [[country]].',
          thumbnail: '/themes/custom/tbdtheme/assets/dist/img/template/placeholder.png',
          filter: {
            label: '20011'
          }
        },
        sectionc5: {
          value: 0,
          unit: '%',
          title: '[[isNeg]][[value]][[unit]]',
          title_s: '[[isNeg]]Boost expenditure per capita by [[value]][[unit]] in poorest households',
          description: 'The scheme(s) would boost household <b>expenditure</b> per capita by [[value]][[unit]] among the bottom 10%.',
          description_s: 'This scheme would boost household expenditure per capita by [[value]][[unit]] among the poorest 10% of households.',
          thumbnail: '/themes/custom/tbdtheme/assets/dist/img/template/placeholder.png',
          filter: {
            label: '20001'
          }
        }
      },
      infographicOutput: {
        sectionc1: {
          data: {} // title, description, thumbnail
        },
        sectionc2: {
          data: {}
        },
        sectionc3: {
          data: {}
        },
        sectionc4: {
          data: {}
        },
        sectionc5: {
          data: {}
        }
      }
    };
  },
  // mounted: function () {
  //   this.initialize();
  // },
  watch: {
    compareConfigs: function () {
      console.log('check', this.getCompareConfigs);
      this.mode = this.getCompareConfigs.mode;
      this.initialize();
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
      'fetchPovertyMeanTesteds'
    ]),
    initialize: function () {
      console.log('initialize');
      this.fetchListData();
    },
    async fetchListData () {
      await this.fetchIndicators();
      await this.fetchCountries();
      await this.fetchValueTypes();
      await this.fetchLabels();
      await this.fetchSchemes();
      await this.fetchBenefitLevels();
      await this.fetchPovertyMeanTesteds();

      // Comparative Section 3, Current year data
      const currentYear = String(new Date().getFullYear());
      const labelList = _.cloneDeep(this.getLabels);
      const labelId = labelList.filter(d => d.name === currentYear)[0].tid;
      this.filterPanelInputs.section3.selectedObject.label = labelId;
      this.infographicData.sectionc3.filter.label = labelId;

      this.setConfigFromUrl();
      this.fetchSectionList();
    },
    setConfigFromUrl () {
      const configObj = _.cloneDeep(this.getCompareConfigs.params);
      if (this.mode === 'comparative') {
        this.filterPanelInputs.pageLevel.selectedObject = configObj.pageLevel ? configObj.pageLevel : this.filterPanelInputs.pageLevel.selectedObject;
        this.filterPanelInputs.scenario1.selectedObject = configObj.scenario1 ? configObj.scenario1 : this.filterPanelInputs.scenario1.selectedObject;
        this.filterPanelInputs.scenario2.selectedObject = configObj.scenario2 ? configObj.scenario2 : this.filterPanelInputs.scenario2.selectedObject;
      } else if (this.mode === 'combined') {
        this.filterPanelInputs.pageLevel.selectedObject = configObj.pageLevel ? configObj.pageLevel : this.filterPanelInputs.pageLevel.selectedObject;
        this.filterPanelInputs.scenario1.selectedObject = configObj.scenario1 ? configObj.scenario1 : this.filterPanelInputs.scenario1.selectedObject;

        // @Todo : Old version
        // const countryList = _.cloneDeep(this.getCountries);
        // const schemeList = _.cloneDeep(this.getSchemes);
        // const benefitLevelList = _.cloneDeep(this.getBenefitLevels);
        // const povertyList = _.cloneDeep(this.getPovertyMeanTesteds);
        // const foundSchemes = [];

        // if (configObj.scheme.length) {
        //   _.each(configObj.scheme, (scString) => {
        //     const foundSc = _.find(schemeList, (p) => { return p.name === scString; });
        //     if (foundSc) {
        //       foundSchemes.push(foundSc);
        //     }
        //   });
        // }

        // // Set Scheme
        // if (foundSchemes.length) {
        //   const schemeIdList = _.map(foundSchemes, 'tid').sort();
        //   this.filterPanelInputs.pageLevel.selectedObject.scheme = schemeIdList;
        // }

        // const foundCountry = _.find(countryList, (p) => { return p.name === configObj.country; });
        // const foundBenefit = _.find(benefitLevelList, (bl) => { return bl.tid === configObj.benefit_level; });
        // const foundPoverty = _.find(povertyList, (pv) => { return pv.tid === configObj.poverty_mean_tested; });

        // this.filterPanelInputs.scenario1.selectedObject.country = foundCountry ? foundCountry.tid : this.filterPanelInputs.scenario1.selectedObject.country;
        // this.filterPanelInputs.scenario1.selectedObject.benefit_level = foundBenefit ? foundBenefit.tid : this.filterPanelInputs.scenario1.selectedObject.benefit_level;
        // this.filterPanelInputs.scenario1.selectedObject.poverty_mean_tested = foundPoverty ? foundPoverty.tid : this.filterPanelInputs.scenario1.selectedObject.poverty_mean_tested;
      }
    },
    async fetchSectionList () {
      const sectionList = this.mode === 'combined' ? this.combinedSectionList : this.sectionList;
      _.each(sectionList, (s) => {
        this.fetchChartData(s);
      });
      this.updateURLFromSelection();
    },
    updateURLFromSelection () {
      const mode = this.mode;
      const pageFilterObj = _.cloneDeep(this.filterPanelInputs.pageLevel.selectedObject);
      const schemeList = _.cloneDeep(this.getSchemes);
      const countryList = _.cloneDeep(this.getCountries);
      const benefitLevelList = _.cloneDeep(this.getBenefitLevels);
      const povertyList = _.cloneDeep(this.getPovertyMeanTesteds);
      const foundSchemes = [];

      if (pageFilterObj.scheme.length) {
        _.each(pageFilterObj.scheme.sort(), (scCode) => {
          const foundSc = _.find(schemeList, (p) => { return p.tid === scCode; });
          if (foundSc) {
            foundSchemes.push(foundSc);
          }
        });
      }
      const schmeListTexts = _.map(foundSchemes, 'name').join('_');

      if (this.mode === 'combined') {
        const scenario1Obj = _.cloneDeep(this.filterPanelInputs.scenario1.selectedObject);
        // const foundCountry = _.find(countryList, (c) => { return c.tid === scenario1Obj.country; });
        // const foundBenefit = _.find(benefitLevelList, (bl) => { return bl.tid === scenario1Obj.benefit_level; });
        // const foundPoverty = _.find(povertyList, (pv) => { return pv.tid === scenario1Obj.poverty_mean_tested; });

        // const countryName = foundCountry ? foundCountry.name : scenario1Obj.country;
        // const benefitName = foundBenefit ? foundBenefit.name : scenario1Obj.benefit_level;
        // const povertyName = foundPoverty ? foundPoverty.name : scenario1Obj.poverty_mean_tested;

        // const newUrlIS = window.location.origin + `/compare-app/combined/${countryName}/${benefitName}/${povertyName}/${schmeListTexts}`;
        const urlFilterObj = {
          pageLevel: pageFilterObj,
          scenario1: scenario1Obj
        };
        const newUrlIS = window.location.origin + `/compare-app/combined/params?filter=${JSON.stringify(urlFilterObj)}`;
        history.pushState({}, null, newUrlIS);
      } else if (this.mode === 'comparative') {
        const scenario1Obj = _.cloneDeep(this.filterPanelInputs.scenario1.selectedObject);
        const scenario2Obj = _.cloneDeep(this.filterPanelInputs.scenario2.selectedObject);
        const urlFilterObj = {
          pageLevel: pageFilterObj,
          scenario1: scenario1Obj,
          scenario2: scenario2Obj
        };

        const newUrlIS = window.location.origin + `/compare-app/comparative/params?filter=${JSON.stringify(urlFilterObj)}`;
        history.pushState({}, null, newUrlIS);
      }
    },
    async fetchChartData (sectionName) {
      const scenarioList = this.mode === 'combined' ? this.combinedScenarioList : this.scenarioList;
      const filterObj = {
        scenario1: { where: {} },
        scenario2: { where: {} }
      };

      const dataArr = {
        scenario1: [],
        scenario2: []
      };

      _.each(scenarioList, (scenario) => {
        const tempObj = _.chain(_.cloneDeep(this.filterPanelInputs[sectionName].selectedObject))
          .merge(this.filterPanelInputs.pageLevel.selectedObject)
          .merge(this.filterPanelInputs[scenario].selectedObject)
          .value();

        _.each(Object.keys(tempObj), (d) => {
          const filterValue = tempObj[d];
          if (filterValue) {
            if (d === 'scheme') {
              let schemeArr = [];
              if (filterValue.length > 2) {
                schemeArr = _.concat(filterValue, [filterValue.sort().join('_')]);
              } else {
                schemeArr = filterValue;
              }
              filterObj[scenario].where[d] = { inq: schemeArr };
            } else {
              filterObj[scenario].where[d] = { inq: filterValue.split('_') };
            }
          }
        });

        // Special case for some section that need to fetch both post reform and with no benefit
        if (['40007', '40011'].indexOf(filterObj[scenario].where.indicator.inq[0]) > -1) {
          filterObj[scenario].where.benefit_level.inq.push('30004');
        }
      });

      const URL1 = `${this.loopBackApiPath}/spp-data?filter=${JSON.stringify(filterObj.scenario1)}`;
      const tempData1 = await axios.get(URL1);
      dataArr.scenario1 = tempData1.data ? this.formatDataWithTaxonomy(tempData1.data, 'Scenario 1') : [];

      if (this.mode === 'comparative') {
        const URL2 = `${this.loopBackApiPath}/spp-data?filter=${JSON.stringify(filterObj.scenario2)}`;
        const tempData2 = await axios.get(URL2);
        dataArr.scenario2 = tempData2.data ? this.formatDataWithTaxonomy(tempData2.data, 'Scenario 2') : [];
      }

      if (['40007', '40011'].indexOf(filterObj.scenario1.where.indicator.inq[0]) > -1) {
        dataArr.scenario1 = this.formatDataWithNoScheme(dataArr.scenario1);
        if (this.mode === 'comparative') {
          dataArr.scenario2 = this.formatDataWithNoScheme(dataArr.scenario2);
        }
      }

      const tempMergeData = _.concat(dataArr.scenario1, dataArr.scenario2);
      this.formatChartData(sectionName, tempMergeData);
      if (this.mode === 'combined') {
        const infoGraphicData = this.getInfoGraphicData(sectionName, this.formatDataWithNoScheme(tempData1.data));
        this.setInfoGraphicObj(sectionName, infoGraphicData);
      }
    },
    formatDataWithNoScheme (dataArray) {
      const result = [];
      const gbScheme = _.groupBy(dataArray, 'scheme');

      _.each(gbScheme, (gbArr) => {
        const gbLabels = _.groupBy(gbArr, 'label');

        _.each(gbLabels, (gblbArr) => {
          const postRefObj = _.find(gblbArr, (d) => { return d.benefit_level !== '30004'; });

          if (postRefObj) {
            const valParam = postRefObj.parameter;
            const noSchemeArr = _.filter(gblbArr, (d) => { return d.benefit_level === '30004'; });
            let noSchemeObj = noSchemeArr[0];
            if (noSchemeArr.length > 1) {
              console.log('With no schemes has more than 1 set of data.');
              noSchemeObj = _.find(noSchemeArr, (d) => { return d.parameter === valParam; });
            }
            if (noSchemeObj) {
              postRefObj.value = (postRefObj.value - noSchemeObj.value) / noSchemeObj.value * 100;
            }

            result.push(postRefObj);
          }
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

      const labelList = _.cloneDeep(this.getLabels);
      const valueTypeList = _.cloneDeep(this.getValueTypes);
      const schemeList = _.cloneDeep(this.getSchemes);

      _.each(labelList, (lb) => {
        lbLookup[lb.tid] = lb.field_display_name;
        odLookup[lb.tid] = Number(lb.weight);
      });

      _.each(valueTypeList, (vt) => {
        vtLookup[vt.tid] = vt.name;
      });

      _.each(schemeList, (sc) => {
        scLookup[sc.tid] = sc.name;
        odLookup[sc.tid] = Number(sc.weight);
      });
      result = _.map(_.cloneDeep(dataArray), (d) => {
        d.value_type_id = d.value_type;
        d.order = odLookup[d.scheme] ? odLookup[d.scheme] : 9999;
        d.label = lbLookup[d.label] ? lbLookup[d.label] : d.label;
        d.value_type = vtLookup[d.value_type] ? vtLookup[d.value_type] : d.value_type;
        d.scenario = scenarioLabel;
        d.scheme = scLookup[d.scheme] ? scLookup[d.scheme] : 'Combined';
        return d;
      });

      result = _.orderBy(result, 'order');
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
    formatChartData (sectionName, dataArray) {
      const indicatorList = _.cloneDeep(this.getIndicators);
      const selectedObject = this.filterPanelInputs[sectionName].selectedObject;
      const chartSection = this.chartSectionsData[sectionName];
      const foundIndicator = _.find(indicatorList, (d) => {
        return d.tid === selectedObject.indicator;
      });
      const sectionTitle = chartSection ? chartSection.title : 'Chart title';

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
        insight: 'This figure depicts the simulated coverage by consumption expenditure deciles after the proposed reforms. Simulations indicate that 87 per cent of the population are likely to benefit directly or indirectly from the programme(s). Across welfare deciles, coverage will range from 95 per cent in the lowest decile and 74 per cent in the highest decile.',
        legend: {
          name: 'chart-legend',
          params: {
            input: '{"data":[]}'
          }
        }
      };

      const chartMargin = { bottom: 100, left: 180 };
      // Dynamic adjust margin left based on label length
      const maxLabelLength = _.chain(dataArray)
        .map('label')
        .uniq('')
        .map((d) => { return d.length; })
        .max()
        .value();

      if (maxLabelLength > 24) {
        chartMargin.left += (maxLabelLength - 24) * 5;
      }

      const defaultBarConfig = {
        name: 'bar-chart',
        params: {
          autoWidth: true,
          height: 485,
          marginBottom: chartMargin.bottom,
          marginLeft: chartMargin.left,
          // rotateX: 45,
          isHeightByData: true,
          data: '{}',
          orderByField: 'percentage',
          barOrientation: 'horizontal'
        }
      };
      // Negative value charts
      if (['section1', 'section2', 'sectionc1', 'sectionc2'].includes(sectionName)) {
        defaultBarConfig.params.marginRight = defaultBarConfig.params.marginLeft; // Y Axis will be left hand side
        defaultBarConfig.params.marginLeft = 50;
      }

      const defaultBarDataObject = {
        x_label: 'x axis label',
        y_label: 'y axis label',
        x_unit_label: '',
        tooltip_unit_label: '',
        tooltip: {
          value: '<strong>[[internal#label]]</strong><br>Value: [[internal#percentage]]'
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
            height: 400,
            margin: { ...chartMargin },
            rotateX: null, // 45,
            xField: 'x',
            xLabel: 'X Label',
            yField: 'y',
            yLabel: 'Y label',
            isTrend: false,
            showLegend: false,
            timeFormat: '%Y', // d3.timeParse('%Y-%m-%dT%H:%M:%S%Z'),
            decimalPoint: 2,
            yAxisMin: 0,
            timeLabelFormat: '%Y',
            xUnitLabel: ''
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

      const sectionChartData = [];
      const selectedTabTypes = this.chartSectionsData[sectionName].tabTypes;
      const valueTypeFieldMapping = { color: 'field_color' };
      const valueTypeMapping = {};
      for (const valueType of this.getValueTypes) {
        valueTypeMapping[valueType.name] = { ...valueType };
      }
      // Include Label list to mapping
      for (const label of this.getLabels) {
        valueTypeMapping[label.name] = { ...label };
      }

      // new Case for scenario and scheme
      valueTypeMapping['Scenario 1'] = { field_color: '#0d3562' };
      valueTypeMapping['Scenario 2'] = { field_color: '#a0cdf8' };
      valueTypeMapping['Child Benefit'] = { field_color: 'blue' };
      valueTypeMapping['Disability Benefit'] = { field_color: 'orange' };
      valueTypeMapping['Old Age Benefit'] = { field_color: 'grey' };
      valueTypeMapping.Combined = { field_color: 'yellow' };

      // Loop over each tab type
      _.each(selectedTabTypes, (tab) => {
        const tabType = tab.type;
        const groupByField = tab.groupByField ? tab.groupByField : 'value_type';
        const labelField = tab.labelField ? tab.labelField : 'label';
        const sectionObject = _.cloneDeep(defaultChartSectionConfig);
        sectionObject.title = tab.title;

        // getDataByChartType
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
        } else if (tabType === 'bar_horizontal_grouped') {
          const sectionDataObject = JSON.parse(JSON.stringify(defaultBarDataObject));
          // axis labels
          const axisLabels = this.getAxisLabel(dataArray, foundIndicator, tab.textOptions, false);
          sectionDataObject.x_label = axisLabels.xLabel;
          sectionDataObject.y_label = axisLabels.yLabel;

          const groupLevel1 = labelField;
          const groupLevel2 = groupByField;
          sectionDataObject.data = _.chain(dataArray)
            .groupBy(groupLevel1)
            .map((v, k) => {
              const tempValues = {};
              _.each(v, (d) => {
                tempValues[d[groupLevel2]] = d.value;
              });
              let order = 9999;
              if (v.length) {
                order = v[0].order ? v[0].order : order;
              }
              return {
                label: k,
                order: order,
                values: tempValues,
                max_sum: _.maxBy(v, 'value').value
              };
            })
            .value();
          sectionDataObject.colors = {};
          const allDataKeys = _.chain(dataArray)
            .groupBy(groupLevel2)
            .map((v, k) => {
              return k;
            })
            .value();

          for (const d of allDataKeys) {
            sectionDataObject.colors[d] = valueTypeMapping[d] ? valueTypeMapping[d][valueTypeFieldMapping.color] : 'black';
          }
          const legendData = _.map(allDataKeys, (d) => {
            return { label: d, color: sectionDataObject.colors[d] };
          });

          sectionObject.chart = JSON.parse(JSON.stringify(defaultBarConfig));
          sectionObject.chart.params.data = JSON.stringify({ data: sectionDataObject });
          sectionObject.chart.params.barOrientation = 'horizontal-grouped';
          sectionObject.chart.params.orderByField = 'order';
          sectionObject.legend.params.input = JSON.stringify({ data: legendData });
        } else if (['line', 'line_category'].includes(tabType)) {
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
              return k;
            })
            .value();

          const colorKeys = {};
          _.each(allDataKeys, (dk) => {
            colorKeys[dk] = valueTypeMapping[dk] ? valueTypeMapping[dk][valueTypeFieldMapping.color] : 'black';
          });

          const legendData = _.map(allDataKeys, (d) => {
            return {
              label: d,
              color: valueTypeMapping[d] ? valueTypeMapping[d][valueTypeFieldMapping.color] : 'black'
            };
          });

          sectionObject.chart = _.cloneDeep(defaultLineConfig);
          sectionObject.chart.params.data.data = lineData;
          sectionObject.chart.params.data.metadata.color = colorKeys;

          // axis labels
          const axisLabels = this.getAxisLabel(dataArray, foundIndicator, tab.textOptions, false);
          sectionObject.chart.params.chartOptions.xLabel = axisLabels.xLabel;
          sectionObject.chart.params.chartOptions.yLabel = axisLabels.yLabel;

          if (tabType === 'line_category') {
            sectionObject.chart.params.chartOptions.xScaleType = 'scalePoint';
          }
          sectionObject.legend.params.input = JSON.stringify({ data: legendData });
        } else if (['table'].includes(tabType)) {
          const tableDataObject = {
            columns: [
              {
                name: '',
                type: 'string'
              }
            ],
            data: [
            ]
          };

          const groupByFieldKeys = _.chain(dataArray)
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

          const dataGroupByLabel = _.groupBy(dataArray, labelField);
          _.each(dataGroupByLabel, (dg, lbName) => {
            const dataArr = [lbName];
            _.each(dg, (d) => {
              const dvalue = d.value !== null ? d.value : 'NA';
              dataArr.push(dvalue);
            });
            tableDataObject.data.push(dataArr);
          });

          sectionObject.chart = _.cloneDeep(defaultTableConfig);
          if (dataArray.length) {
            sectionObject.chart.params.data = JSON.stringify(tableDataObject);
          }
        }
        sectionChartData.push(sectionObject);
      });
      this.chartSectionsData[sectionName].title = sectionTitle;
      this.chartSectionsData[sectionName].tabs = _.cloneDeep(sectionChartData);
      this.chartSectionsData[sectionName].tabs[0].active = true;

      console.log('sectionChartData', sectionName, this.chartSectionsData[sectionName]);
    },
    getRoundNumber (num, precision) {
      return Number(Math.round(num + 'e+' + precision) + 'e-' + precision);
    },
    getCountryName (code) {
      let countryName = '';
      const countryList = _.cloneDeep(this.getCountries);
      const foundCountry = _.find(countryList, (p) => { return p.tid === code; });
      if (foundCountry) {
        countryName = foundCountry.name;
      }
      return countryName;
    },
    getInfoGraphicDesc (templateText, dataObj) {
      const re = /(\[\[).+?(?=\]\])/g;
      let result = templateText;
      const matches = templateText.match(re);
      let compareText = '';
      if (matches) {
        for (const match_ of matches) {
          const match = match_.split('[[')[1];
          if (match === 'compare_text') {
            if (dataObj.value > dataObj.compareVal) {
              compareText = 'higher';
            } else if (dataObj.value < dataObj.compareVal) {
              compareText = 'lower';
            }
            result = result.replace(`[[${match}]]`, compareText);
          } else if (match === 'value') {
            const absoluteVal = Math.abs(dataObj[match]);
            result = result.replace(`[[${match}]]`, absoluteVal);
          } else if (match === 'isNeg') {
            if (dataObj.value < 0) {
              const negHtml = `<img
              v-if="isNegVal === true"
              src="/themes/custom/tbdtheme/assets/dist/img/icons/arrow-down.svg"
              class="neg-icon" />`;
              result = result.replace(`[[${match}]]`, negHtml);
            } else {
              result = result.replace(`[[${match}]]`, '');
            }
          } else if (match === 'currentYear') {
            result = result.replace(`[[${match}]]`, String(new Date().getFullYear()));
          } else if (match === 'country') {
            result = result.replace(`[[${match}]]`, dataObj.country);
          } else {
            result = result.replace(`[[${match}]]`, dataObj[match]);
          }
        }
      }
      return result;
    },
    getInfoGraphicData (sectionName, rawDataArray) {
      const scenario1Obj = _.cloneDeep(this.filterPanelInputs.scenario1.selectedObject);
      const infographicData = _.cloneDeep(this.infographicData);
      const filterPanelInputs = _.cloneDeep(this.filterPanelInputs);

      let infoVal = null;
      let infoTitle = '';
      let infoDesc = '';
      const infoThumbnail = infographicData[sectionName].thumbnail;
      if (this.mode === 'combined') {
        let titleField = 'title';
        let descField = 'description';
        if (filterPanelInputs.pageLevel.selectedObject.scheme.length === 1) {
          titleField = 'title_s';
          descField = 'description_s';
        }

        // Val
        let filterData = rawDataArray;
        const schmeIdTexts = filterPanelInputs.pageLevel.selectedObject.scheme.join('_');
        const benefitLevel = filterPanelInputs.scenario1.selectedObject.benefit_level;
        const objKeys = Object.keys(infographicData[sectionName].filter);
        for (const key of objKeys) {
          filterData = filterData.filter(d => d[key] === infographicData[sectionName].filter[key]);
        }
        filterData = filterData.filter(d => d.scheme === schmeIdTexts && d.benefit_level === benefitLevel);
        if (filterData[0]) {
          infoVal = this.getRoundNumber(filterData[0].value, 1);
        }

        // Title, Desc
        if (infoVal !== null) {
          const dataObj = {
            value: infoVal,
            unit: infographicData[sectionName].unit,
            country: this.getCountryName(scenario1Obj.country),
            compareVal: 1.3
          };
          infoTitle = this.getInfoGraphicDesc(infographicData[sectionName][titleField], dataObj);
          infoDesc = this.getInfoGraphicDesc(infographicData[sectionName][descField], dataObj);
        }
      }
      return {
        title: infoTitle,
        description: infoDesc,
        thumbnail: infoThumbnail
      };
    },
    setInfoGraphicObj (sectionName, data) {
      this.infographicOutput[sectionName].data = data;
    }
  },
  setup () {
    return {
    };
  }
};
</script>

<style lang="scss"></style>
