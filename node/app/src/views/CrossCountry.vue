<template>
  <div class="cross-country">
    <h1>Cross Country Page</h1>
    <div
      v-for="(item, index) in pageData"
      :key="'chart-section-' + index">
        <div v-if="pageData[index]" class="h-100">
          <components
            class="component-container"
            :is="pageData[index].type"
            v-bind="pageData[index].data"
            @chartCustomFilterChanged="function (chartCustomFilter) {updateChartCustomFilter(chartCustomFilter)}"
            >
          </components>
        </div>
    </div>
  </div>
</template>

<script>
import ChartSection from '@/components/ChartSection.vue';
// import FilterPanel from '@/components/FilterPanel.vue';
// import { RAPI_DOMAIN, RAPI_VERSION_URL } from '@/environment';
// import axios from '@axios';
import _ from 'lodash';
import { mapActions, mapGetters, mapState } from 'vuex';
import { crossCountryData, crossCountryMapping, crossCountrySectionData } from '../data';

export default {
  components: {
    ChartSection
    // FilterPanel
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
      pageData: [],
      chartCustomFilter: {},
      crossCountryData: [],
      crossCountryMapping: [],
      crossCountrySectionData: [],
      negativeValueCharts: [
        'section1', 'section3'
      ],
      customMaxValue: {
        section7: 25
      }
    };
  },
  watch: {
    // configs: function () {
    //   this.initialize();
    // }
  },
  mounted: function () {
    this.initialize();
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
      this.crossCountryData = _.cloneDeep(crossCountryData);
      this.crossCountryMapping = _.cloneDeep(crossCountryMapping);
      this.crossCountrySectionData = _.cloneDeep(crossCountrySectionData);
      console.log('this.crossCountryData', this.crossCountryData);
      this.setSectionData();
    },
    setSectionData: function () {
      _.each(this.crossCountrySectionData, (section) => {
        this.setChartData(section);
      });
    },
    setChartData: function (sectionConfigObj) {
      console.log('setChartData', _.cloneDeep(sectionConfigObj));
      // Create custom filter
      if (sectionConfigObj.dropdownFields && sectionConfigObj.dropdownFields.length) {
        if (!this.chartCustomFilter[sectionConfigObj.name]) {
          const tempSelectedObject = {
            field: sectionConfigObj.dropdownFields[0]
          };
          const tempFilterItems = _.map(sectionConfigObj.dropdownFields, (f) => {
            const foundMappingObj = _.find(this.crossCountryMapping, (d) => {
              return d.field_name === f;
            });
            const tempObj = {
              label: foundMappingObj ? foundMappingObj.display_name : f,
              value: f
            };
            return tempObj;
          });
          const fieldFilterObj = {
            id: 'custom_chart_filter_field',
            label: 'Select type:',
            key: 'field',
            items: tempFilterItems,
            class: '',
            style: '',
            order: 0
          };
          this.chartCustomFilter[sectionConfigObj.name] = {
            selectedObject: tempSelectedObject,
            filters: [fieldFilterObj],
            section: sectionConfigObj.name
          };
        }
      }

      const fullDataArray = this.getSectionDataArray(sectionConfigObj);
      const selectedFields = sectionConfigObj.dataFields && sectionConfigObj.dataFields.length ? sectionConfigObj.dataFields : [];
      if (this.chartCustomFilter[sectionConfigObj.name]) {
        selectedFields.push(this.chartCustomFilter[sectionConfigObj.name].selectedObject.field);
      }

      const excludeGeo = ['Min', 'Max', 'AP Average'];
      const dataArray = _.filter(_.cloneDeep(fullDataArray), (d) => {
        return d.value && selectedFields.indexOf(d.field) > -1 && excludeGeo.indexOf(d.country) === -1;
      });
      console.log('dataArray', dataArray);
      const setDecimalPointValue = 1;
      // set custom domain
      const minValueObj = _.minBy(dataArray, 'value');
      const maxValueObj = _.maxBy(dataArray, 'value');
      const minValue = minValueObj ? minValueObj.value : 0;
      const maxValue = maxValueObj ? maxValueObj.value : 0;
      let possibleMax = 100;
      if (this.customMaxValue[sectionConfigObj.name]) {
        possibleMax = this.customMaxValue[sectionConfigObj.name];
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

      const chartMargin = { bottom: 100, left: 140 };
      // Dynamic adjust margin left based on label length
      const maxLabelLength = _.chain(dataArray)
        .map('label')
        .uniq('')
        .map((d) => { return d.length; })
        .max()
        .value();

      // if (maxLabelLength >= 20) {
      //   chartMargin.left += (maxLabelLength - 20) * 10;
      //   if (chartMargin.left >= 260) {
      //     chartMargin.left = 260;
      //   }
      // }

      // Calculate chart height
      let chartDetailHeight = 350;
      if (document.getElementsByClassName('isSectionDetail').length) {
        const detailContainerHeight = document.getElementsByClassName('isSectionDetail')[0].offsetHeight;
        if (detailContainerHeight) {
          chartDetailHeight = detailContainerHeight - 440;
          if (chartDetailHeight < 150) {
            chartDetailHeight = 150;
          }
        }
      }

      const defaultChartSectionConfig = {
        title: 'Bar',
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
          isWrapY: false
        }
      };
      // Negative value charts
      if (this.negativeValueCharts.includes(sectionConfigObj.name)) {
        defaultBarConfig.params.marginRight = defaultBarConfig.params.marginLeft; // Y Axis will be left hand side
        defaultBarConfig.params.marginLeft = 50;
      }

      const defaultBarDataObject = {
        x_label: 'Value',
        y_label: 'Country',
        x_unit_label: '',
        tooltip_unit_label: '',
        tooltip: {
          value: '<strong>[[internal#label]]</strong><br>Value: [[internal#percentage]]'
        },
        data: [],
        sort_order: 'DESC'
      };

      const sectionChartData = [];
      const valueTypeFieldMapping = { color: 'field_color' };
      const valueTypeMapping = {};

      // Create chart data
      const sectionObject = _.cloneDeep(defaultChartSectionConfig);
      const sectionDataObject = JSON.parse(JSON.stringify(defaultBarDataObject));
      // axis labels
      // const axisLabels = this.getAxisLabel(dataArray, foundIndicator, tab.textOptions, false);
      sectionDataObject.x_label = 'Value';
      sectionDataObject.y_label = 'Country';
      sectionObject.chart = JSON.parse(JSON.stringify(defaultBarConfig));
      // Line on Bar
      if (sectionConfigObj.averageLineFields && sectionConfigObj.averageLineFields.length) {
        // const gb = _.groupBy(dataArray, 'scenario');
        // const scenarios = Object.keys(gb);
        const averageLines = [];
        _.each(sectionConfigObj.averageLineFields, (avgLine) => {
          const filteredLineData = _.filter(fullDataArray, (d) => {
            return d.field === avgLine;
          });
          const dataValue = filteredLineData.length ? filteredLineData[0].value : 0;
          const foundMappingObj = _.find(this.crossCountryMapping, (d) => {
            return d.field_name === avgLine;
          });
          const tempAvgLineObj = {
            stroke: stringToColor(avgLine),
            strokeDasharray: 2.2,
            strokeWidth: 3,
            xVal: dataValue,
            label: foundMappingObj ? foundMappingObj.display_name : avgLine
          };
          averageLines.push(tempAvgLineObj);
        });
        sectionObject.additionalLegends = averageLines;
        sectionObject.chart.params.averageLines = averageLines;
      }

      const groupLevel1 = 'country';
      const groupLevel2 = 'label';
      // console.log('dataArray', dataArray);
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
        sectionDataObject.colors[d.key] = valueTypeMapping[d.color_id] ? valueTypeMapping[d.color_id][valueTypeFieldMapping.color] : stringToColor(d.key);
      }
      console.log('sectionDataObject', sectionDataObject);
      const legendData = _.map(allDataKeys, (d) => {
        return { label: d.key, color: sectionDataObject.colors[d.key] };
      });
      sectionObject.chart.params.data = JSON.stringify({ data: sectionDataObject });
      sectionObject.chart.params.barOrientation = 'horizontal-grouped';
      sectionObject.chart.params.orderByField = 'order';
      sectionObject.chart.params.barThickness = 5;

      // if (realSectionName === 'sectionDetail' && appliedGroupLabelSection.indexOf(sectionName) > -1) {
      //   sectionObject.chart.params.showBarGroupedLabel = true;
      // }

      sectionObject.chart.params.barThickness = 15;

      let tempMax, tempMin;
      if (minValue >= 0 && maxValue > 0) {
        tempMin = 0;
        tempMax = maxValue > possibleMax ? maxValue : possibleMax;
      } else if (minValue < 0 && maxValue <= 0) {
        tempMin = minValue < -possibleMax ? minValue : -possibleMax;
        tempMax = 0.0001;
      } else if (minValue <= 0 && maxValue >= 0) {
        tempMin = minValue < -possibleMax ? minValue : -possibleMax;
        tempMax = maxValue > possibleMax ? maxValue : possibleMax;
      }
      if (tempMax || tempMin) {
        sectionObject.chart.params.xDomain = `[${tempMin},${tempMax}]`;
      }
      sectionObject.legend.params.input = JSON.stringify({ data: legendData });
      sectionChartData.push(sectionObject);

      if (sectionChartData.length) {
        sectionChartData[0].active = true;
        sectionChartData[0].isVertical = true;
      }

      // Generate chart section components
      const sectionComponentObj = {
        childrenList: [],
        customChartFilter: this.chartCustomFilter[sectionConfigObj.name]
      };

      this.pageData[sectionConfigObj.name] = {
        type: 'chart-section',
        data: {
          tabs: _.cloneDeep(sectionChartData),
          title: sectionConfigObj.title,
          tag: '',
          isSmall: false,
          showTabs: true,
          chartSectionComponents: sectionComponentObj
        },
        isLoading: false
      };
      this.pageData = { ...this.pageData };
      console.log('check', _.cloneDeep(this.pageData));
    },
    getSectionDataArray (sectionObject) {
      const excludeMultiply = ['poverty_rate_no', 'poverty_rate_basic', 'poverty_rate_enhanced',
        'cost_child', 'cost_disability', 'cost_old', 'cost_ap', 'cost_global', 'cost_oecd'];
      let result = [];
      let selectedFields = sectionObject.dataFields && sectionObject.dataFields.length ? sectionObject.dataFields : [];

      if (sectionObject.averageLineFields && sectionObject.averageLineFields.length) {
        selectedFields = selectedFields.concat(_.cloneDeep(sectionObject.averageLineFields));
      }

      if (this.chartCustomFilter[sectionObject.name]) {
        selectedFields.push(this.chartCustomFilter[sectionObject.name].selectedObject.field);
      }

      _.each(selectedFields, (field) => {
        const isMultiply = excludeMultiply.indexOf(field) === -1;
        const foundMappingObj = _.find(this.crossCountryMapping, (d) => {
          return d.field_name === field;
        });
        const temp = _.map(_.cloneDeep(this.crossCountryData), (d) => {
          const dat = {
            country: d.Country,
            field: field,
            label: foundMappingObj ? foundMappingObj.display_name : field,
            value: isMultiply ? d[field] * 100 : d[field]
          };
          return dat;
        });

        result = result.concat(temp);
      });

      // console.log('result', result);

      return result;
    },
    updateChartCustomFilter (chartCustomFilter) {
      if (this.chartCustomFilter[chartCustomFilter.section]) {
        this.chartCustomFilter[chartCustomFilter.section].selectedObject = _.cloneDeep(chartCustomFilter.selectedObject);
      }
      this.setSectionData();
    }
  },
  setup () {
    return {
    };
  }
};
</script>

<style lang="scss"></style>
