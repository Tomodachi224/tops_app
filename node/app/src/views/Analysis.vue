<template>
  <div class="analysis">
    <h1>{{ selectedCountry }}</h1>
    <div>
      <filter-panel
        :space="4"
        :selected-object="filterPanelInputs.pageLevel.selectedObject"
        :filters="filterPanelInputs.pageLevel.filters"
        @selectedChanged="setPageLevelFilter()">
      </filter-panel>
    </div>
    <h4>Coverage</h4>
    <filter-panel
      :selected-object="filterPanelInputs.section1.selectedObject"
      :filters="filterPanelInputs.section1.filters"
      @selectedChanged="fetchChartData('section1')">
    </filter-panel>
    <chart-section
      :title="chartSectionsData.section1.title"
      :tabs="chartSectionsData.section1.tabs"></chart-section>
    <filter-panel
      :selected-object="filterPanelInputs.section1_2.selectedObject"
      :filters="filterPanelInputs.section1_2.filters"
      @selectedChanged="fetchChartData('section1_2')">
    </filter-panel>
    <chart-section
      :title="chartSectionsData.section1_2.title"
      :tabs="chartSectionsData.section1_2.tabs"></chart-section>

    <h4>Household Consumption</h4>
    <filter-panel
      :selected-object="filterPanelInputs.section2.selectedObject"
      :filters="filterPanelInputs.section2.filters"
      @selectedChanged="fetchChartData('section2')">
    </filter-panel>
    <chart-section
      :title="chartSectionsData.section2.title"
      :tabs="chartSectionsData.section2.tabs"></chart-section>

    <h4>Poverty and Inequality</h4>
    <filter-panel
      :selected-object="filterPanelInputs.section3.selectedObject"
      :filters="filterPanelInputs.section3.filters"
      @selectedChanged="fetchChartData('section3')">
    </filter-panel>
    <chart-section
      :title="chartSectionsData.section3.title"
      :tabs="chartSectionsData.section3.tabs"></chart-section>

    <h4>Costs</h4>
    <filter-panel
      :selected-object="filterPanelInputs.section4.selectedObject"
      :filters="filterPanelInputs.section4.filters"
      @selectedChanged="fetchChartData('section4')">
    </filter-panel>
    <chart-section
      :title="chartSectionsData.section4.title"
      :tabs="chartSectionsData.section4.tabs"></chart-section>
    <filter-panel
      :selected-object="filterPanelInputs.section4_2.selectedObject"
      :filters="filterPanelInputs.section4_2.filters"
      @selectedChanged="fetchChartData('section4_2')">
    </filter-panel>
    <chart-section
      :title="chartSectionsData.section4_2.title"
      :tabs="chartSectionsData.section4_2.tabs"></chart-section>
  </div>
</template>

<script>
import ChartSection from '@/components/ChartSection.vue';
import FilterPanel from '@/components/FilterPanel.vue';
import { RAPI_DOMAIN, RAPI_VERSION_URL } from '@/environment';
import axios from '@axios';
import _ from 'lodash';
import { mapActions, mapGetters, mapState } from 'vuex';

export default {
  components: {
    ChartSection,
    FilterPanel
  },
  computed: {
    ...mapGetters('analysis', [
      'getConfigs',
      'getIndicators',
      'getCountries',
      'getValueTypes',
      'getLabels',
      'getSchemes'
    ]),
    ...mapState('analysis', [
      'configs',
      'indicators',
      'parameters'
    ])
  },
  data: function () {
    return {
      loopBackApiPath: `${RAPI_DOMAIN}${RAPI_VERSION_URL}`,
      selectedCountry: 'Cambodia',
      selectedCountryId: '50004',
      sectionList: ['section1', 'section1_2', 'section2', 'section3', 'section4', 'section4_2'],
      filterPanelInputs: {
        pageLevel: {
          selectedObject: {
            country: '50004',
            scheme: [],
            poverty_mean_tested: '80001'
          },
          filters: [
            {
              label: 'Country',
              key: 'country',
              items: [
                { value: '50002', label: 'Bangladesh' },
                { value: '50004', label: 'Cambodia' },
                { value: '50017', label: 'Thailand' }
              ]
            },
            {
              label: 'Scheme',
              type: 'multiple',
              key: 'scheme',
              items: [
                { value: '70001', label: 'Child Benefit' },
                { value: '70002', label: 'Disability Benefit' },
                { value: '70003', label: 'Old Age Benefit' }
                // { value: '70001_70002_70003', label: 'Combined' }
              ]
            },
            {
              label: 'Poverty Mean Tested',
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
            country: '50004',
            indicator: '40001',
            value_type: '10002_10003',
            scheme: '70001',
            benefit_level: '30002',
            poverty_mean_tested: '80001'
          },
          filters: [
            {
              label: 'Select type of indicator',
              key: 'indicator',
              items: [
                { value: '40001', label: 'Consumption expenditure deciles' },
                { value: '40002', label: 'Different types of households' }
              ]
            },
            {
              label: 'Type of analysis',
              key: 'value_type',
              items: [
                { value: '10001', label: 'Total' },
                { value: '10002', label: 'Urban' },
                { value: '10003', label: 'Rural' },
                { value: '10002_10003', label: 'Urban-Rural' }
              ]
            },
            {
              label: 'Benefit',
              key: 'benefit_level',
              items: [
                // { value: '30001', label: 'Other benefit' },
                { value: '30002', label: 'Basic' },
                { value: '30003', label: 'Enhanced' }
              ]
            }
          ]
        },
        section1_2: {
          selectedObject: {
            country: '50004',
            indicator: '40003',
            value_type: '10004_10005_10006',
            scheme: '70001',
            benefit_level: '30002',
            poverty_mean_tested: '80001'
          },
          filters: [
            {
              label: 'Benefit',
              key: 'benefit_level',
              items: [
                // { value: '30001', label: 'Other benefit' },
                { value: '30002', label: 'Basic' },
                { value: '30003', label: 'Enhanced' }
              ]
            }
          ]
        },
        section2: {
          selectedObject: {
            country: '50004',
            indicator: '40004',
            value_type: '10002_10003',
            scheme: '70001',
            benefit_level: '30002',
            poverty_mean_tested: '80001'
          },
          filters: [
            {
              label: 'Select type of indicator',
              key: 'indicator',
              items: [
                { value: '40004', label: 'Whole population' },
                { value: '40005', label: 'By consumption expenditure deciles' },
                { value: '40006', label: 'By diﬀerent household types' }
              ]
            },
            {
              label: 'Type of analysis',
              key: 'value_type',
              items: [
                { value: '10001', label: 'Total' },
                { value: '10002', label: 'Urban' },
                { value: '10003', label: 'Rural' },
                { value: '10002_10003', label: 'Urban-Rural' }
              ]
            },
            {
              label: 'Benefit',
              key: 'benefit_level',
              items: [
                // { value: '30001', label: 'Other benefit' },
                { value: '30002', label: 'Basic' },
                { value: '30003', label: 'Enhanced' }
              ]
            }
          ]
        },
        section3: {
          selectedObject: {
            country: '50004',
            indicator: '40007',
            scheme: '70001',
            benefit_level: '30002_30004',
            poverty_mean_tested: '80001'
          },
          filters: [
            {
              label: 'Simulated impact on',
              key: 'indicator',
              items: [
                { value: '40007', label: 'Poverty rates, whole population' },
                { value: '40008', label: 'Poverty rates, recipient households' },
                { value: '40009', label: 'Poverty gap index, whole population' },
                { value: '40010', label: 'Poverty gap index, recipient households' },
                { value: '40011', label: 'Inequality' }
              ]
            },
            {
              label: 'Benefit',
              key: 'benefit_level',
              items: [
                // { value: '30001_30004', label: 'Other benefit' },
                { value: '30002_30004', label: 'Basic' },
                { value: '30003_30004', label: 'Enhanced' },
                { value: '30002_30003_30004', label: 'Basic-Enhanced' }
              ]
            }
          ]
        },
        section4: {
          selectedObject: {
            country: '50004',
            indicator: '40012',
            value_type: '10008',
            scheme: '70001',
            benefit_level: '30002',
            poverty_mean_tested: '80001'
          },
          filters: [
            {
              label: 'Select type of analysis',
              key: 'value_type',
              items: [
                { value: '10008', label: 'Recipients (thousands)' },
                { value: '10009', label: 'Spending (billions KHR)' },
                { value: '10010', label: 'Spending (percent of GDP)' }
              ]
            },
            {
              label: 'Benefit',
              key: 'benefit_level',
              items: [
                // { value: '30001', label: 'Other benefit' },
                { value: '30002', label: 'Basic' },
                { value: '30003', label: 'Enhanced' }
              ]
            }
          ]
        },
        section4_2: {
          selectedObject: {
            country: '50004',
            indicator: '40013',
            value_type: '10011',
            scheme: '70001',
            benefit_level: '30002',
            poverty_mean_tested: '80001'
          },
          filters: [
            {
              label: 'Benefit',
              key: 'benefit_level',
              items: [
                // { value: '30001', label: 'Other benefit' },
                { value: '30002', label: 'Basic' },
                { value: '30003', label: 'Enhanced' }
              ]
            }
          ]
        }
      },
      chartSectionsData: {
        section1: {
          title: '',
          tabTypes: [
            { title: 'Bar', type: 'bar_horizontal_grouped' }
          ],
          tabs: []
        },
        section1_2: {
          title: '',
          tabTypes: [
            { title: 'Table', type: 'table' }
          ],
          tabs: []
        },
        section2: {
          title: '',
          tabTypes: [
            { title: 'Bar', type: 'bar_horizontal_grouped' }
          ],
          tabs: []
        },
        section3: {
          title: '',
          tabTypes: [
            { title: 'Bar', type: 'bar_horizontal_grouped' },
            { title: 'Line', type: 'line_category', groupByField: 'label', labelField: 'value_type' }
          ], // 'bar'],
          tabs: []
        },
        section4: {
          title: '',
          tabTypes: [
            { title: 'Line', type: 'line' }
          ],
          tabs: []
        },
        section4_2: {
          title: '',
          tabTypes: [
            { title: 'Line', type: 'line' }
          ],
          tabs: []
        }
      }
    };
  },
  watch: {
    configs: function () {
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
      await this.fetchPovertyMeanTesteds();

      this.setDropdownItemFromTaxonomies();
      this.setConfigFromUrl();
      this.fetchSectionList();
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

      this.filterPanelInputs.pageLevel.filters[0].items = mappedCountry;
    },
    setConfigFromUrl: function () {
      const sectionList = this.sectionList;
      const configObj = this.getConfigs;
      const schemeList = _.cloneDeep(this.getSchemes);
      const foundSchemes = [];
      const countryList = _.cloneDeep(this.getCountries);
      const foundCountry = _.find(countryList, (p) => { return p.name === configObj.country; });

      if (configObj.scheme.length) {
        _.each(configObj.scheme, (scString) => {
          const foundSc = _.find(schemeList, (p) => { return p.name === scString; });
          if (foundSc) {
            foundSchemes.push(foundSc);
          }
        });
      }

      // set country
      if (foundCountry) {
        this.selectedCountry = foundCountry.name;
        this.selectedCountryId = foundCountry.tid;
        _.each(sectionList, (s) => {
          this.filterPanelInputs[s].selectedObject.country = foundCountry.tid;
        });
      }

      if (foundSchemes.length) {
        const schemeIdList = _.map(foundSchemes, 'tid').sort();

        this.filterPanelInputs.pageLevel.selectedObject.scheme = schemeIdList;
        _.each(sectionList, (s) => {
          this.filterPanelInputs[s].selectedObject.scheme = schemeIdList;
        });
      }
    },
    setPageLevelFilter: function () {
      const sectionList = this.sectionList;
      const pageFilterObj = _.cloneDeep(this.filterPanelInputs.pageLevel.selectedObject);
      const schemeList = _.cloneDeep(this.getSchemes);
      const povertyMeanTestedseList = _.cloneDeep(this.getPovertyMeanTesteds);
      const countryList = _.cloneDeep(this.getCountries);
      const foundSchemes = [];
      const foundPMTs = [];
      if (pageFilterObj.scheme.length) {
        _.each(pageFilterObj.scheme.sort(), (scCode) => {
          const foundSc = _.find(schemeList, (p) => { return p.tid === scCode; });
          if (foundSc) {
            foundSchemes.push(foundSc);
          }
        });
      }

      if (pageFilterObj.poverty_mean_tested.length) {
        _.each(pageFilterObj.scheme.sort(), (pmtCode) => {
          const foundPMT = _.find(povertyMeanTestedseList, (p) => { return p.tid === pmtCode; });
          if (foundPMT) {
            foundPMTs.push(foundPMT);
          }
        });
      }

      // update config from page level
      _.each(Object.keys(pageFilterObj), (key) => {
        _.each(sectionList, (s) => {
          if (key === 'scheme') {
            const val = pageFilterObj[key].sort();
            this.filterPanelInputs[s].selectedObject[key] = val;
          } else {
            this.filterPanelInputs[s].selectedObject[key] = pageFilterObj[key];
          }
        });
      });

      const foundCountry = _.find(countryList, (p) => { return p.tid === pageFilterObj.country; });
      // set country
      if (foundCountry) {
        this.selectedCountry = foundCountry.name;
        this.selectedCountryId = foundCountry.tid;
      }

      // update url without reload'
      if (foundSchemes.length) {
        const schmeListTexts = _.map(foundSchemes, 'name').join('_');
        const newUrlIS = window.location.origin + `/analysis-app/${this.selectedCountry}/${schmeListTexts}`;
        history.pushState({}, null, newUrlIS);
      }
      this.fetchSectionList();
    },
    async fetchSectionList () {
      const sectionList = this.sectionList;

      _.each(sectionList, (s) => {
        this.fetchChartData(s);
      });
    },
    async fetchChartData (sectionName) {
      const filterObj = { where: {} };
      _.each(Object.keys(this.filterPanelInputs[sectionName].selectedObject), (d) => {
        const filterValue = this.filterPanelInputs[sectionName].selectedObject[d];
        if (filterValue) {
          if (d === 'scheme') {
            filterObj.where[d] = { inq: [filterValue.join('_')] };
          } else {
            filterObj.where[d] = { inq: filterValue.split('_') };
          }
        }
      });

      const URL = `${this.loopBackApiPath}/spp-data?filter=${JSON.stringify(filterObj)}`;
      const tempData = await axios.get(URL);
      // console.log('tempData', tempData);
      const dataArray = tempData.data ? tempData.data : [];
      const formattedDataArray = this.formatDataWithTaxonomy(dataArray);
      this.formatChartData(sectionName, formattedDataArray);
    },
    formatDataWithTaxonomy (dataArray) {
      let result = [];
      const lbLookup = {};
      const odLookup = {};
      const vtLookup = {};

      const labelList = _.cloneDeep(this.getLabels);
      const valueTypeList = _.cloneDeep(this.getValueTypes);

      _.each(labelList, (lb) => {
        lbLookup[lb.tid] = lb.field_display_name;
        odLookup[lb.tid] = Number(lb.weight);
      });

      _.each(valueTypeList, (vt) => {
        vtLookup[vt.tid] = vt.name;
      });

      // dataArray = _.filter(dataArray, (d) => { return d.value; });

      result = _.map(dataArray, (d) => {
        d.value_type_id = d.value_type;
        d.order = odLookup[d.label] ? odLookup[d.label] : 9999;
        d.label = lbLookup[d.label] ? lbLookup[d.label] : d.label;
        d.value_type = vtLookup[d.value_type] ? vtLookup[d.value_type] : d.value_type;
        return d;
      });

      result = _.orderBy(result, 'order');
      return result;
    },
    getAxisLabel (dataArray, foundIndicator) {
      let xLabel = '';
      let yLabel = '';

      if (dataArray.length) {
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
      }

      return { xLabel, yLabel };
    },
    formatChartData (sectionName, dataArray) {
      const indicatorList = _.cloneDeep(this.getIndicators);
      const selectedObject = this.filterPanelInputs[sectionName].selectedObject;
      const foundIndicator = _.find(indicatorList, (d) => {
        return d.tid === selectedObject.indicator;
      });
      const sectionTitle = foundIndicator ? foundIndicator.name : 'Chart title';

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
          const axisLabels = this.getAxisLabel(dataArray, foundIndicator);
          const valTypes = _.uniq(_.map(dataArray, 'value_type_id'));
          sectionDataObject.x_label = axisLabels.xLabel;
          sectionDataObject.y_label = axisLabels.yLabel;

          // axis labels special case
          if (['40007', '40008', '40009', '40010', '40011'].includes(foundIndicator.tid)) {
            sectionDataObject.y_label = foundIndicator.field_x_label;
            if (valTypes.length > 1) {
              sectionDataObject.x_label = foundIndicator.field_y_label;
            } else {
              if (dataArray.length) {
                sectionDataObject.x_label = this.getValueTypes.filter(d => d.tid === valTypes[0])[0].field_axis_label;
              }
            }
          }

          const groupLevel1 = labelField;
          const groupLevel2 = groupByField;
          // console.log('check', sectionName, _.map(dataArray, 'value'));
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
                max_sum: _.maxBy(v, 'value')
              };
            })
            .value();
          // console.log(sectionName, sectionDataObject.data);
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
          const axisLabels = this.getAxisLabel(dataArray, foundIndicator);
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

      // console.log('sectionChartData', sectionName, this.chartSectionsData[sectionName]);
    }
  },
  setup () {
    return {
    };
  }
};
</script>

<style lang="scss"></style>
