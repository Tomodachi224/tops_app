<template>
  <div class="row">
    <div class="col-2">
      <div class="page-navigation-container">
        <div
          v-for="(item, index) in navigationMenuItems"
          class="navigation-box-item"
          :class="{active: selectedNavMenuItem === item.name}"
          :key="'navigation-item-' + index"
          @click="scrollToElement(item)"
         >
          <div class="row">
            <div class="mt-0 col-4">
              <div>
                <span class="svg-icon" v-html="item.iconData"></span>
              </div>
            </div>
            <div
              v-if="selectedNavMenuItem === item.name"
              class="navigation-text col-8">
              <span v-html="item.body"></span>
            </div>
          </div>
        </div><!-- /.navigation-box-item -->
      </div>
    </div><!-- /.col -->
    <div class="col-10">
      <div class="cross-country">
        <h1>Regional Comparison</h1>
        <div
          v-for="(item, index) in sectionList"
          class="mb-6"
          :key="'chart-section-' + index">
            <div
              class="scroll-checkpoint"
              :ref="'section_container_' + item"></div>
            <div
              v-if="pageData[item]"
              class="chart-section-box">
              <components
                class="component-container"
                :is="pageData[item].type"
                v-bind="pageData[item].data"
                @chartCustomFilterChanged="function (chartCustomFilter) {updateChartCustomFilter(chartCustomFilter)}"
                @onLegendItemClick="function (legendItem) {
                  onLegendItemClick(item, legendItem)}"
                @onLegendItemMouseOver="function (legendItem) {
                  onLegendItemMouseOver(item, legendItem)}"
                >
              </components>
            </div>
        </div>
      </div>
    </div><!-- /.col -->
  </div><!-- /.row -->
</template>

<script>
import ChartSection from '@/components/ChartSection.vue';
import FilterPanel from '@/components/FilterPanel.vue';
import { RAPI_DOMAIN, RAPI_VERSION_URL } from '@/environment';
import axios from '@axios';
import _ from 'lodash';
import { mapActions, mapGetters, mapState } from 'vuex';
import { regionalCompSectionData } from '../data';
import { getCsvDownloadData } from '../helper';

export default {
  components: {
    ChartSection,
    FilterPanel
  },
  created () {
    window.addEventListener('scroll', this.handleScroll);
    // setTimeout(() => {
    //   const iconEls = window.document.querySelectorAll('.regional-title-container h4');
    //   // console.log(iconEls);
    //   this.sectionsTopY = [];
    //   iconEls.forEach(iconEl => {
    //     this.sectionsTopY.push(iconEl.offsetTop);
    //   });
    //   // console.log(this.sectionsTopY);
    // }, 4000);
  },
  // updated () {
  //   const iconEls = window.document.querySelectorAll('.regional-title-container h4');
  //   // console.log(iconEls);
  //   this.sectionsTopY = [];
  //   iconEls.forEach(iconEl => {
  //     this.sectionsTopY.push(iconEl.offsetTop);
  //   });
  //   console.log(this.sectionsTopY);
  // },
  unmounted () {
    window.removeEventListener('scroll', this.handleScroll);
  },
  computed: {
    ...mapGetters('analysis', [
      'getConfigs',
      'getIndicators',
      'getCountries',
      'getValueTypes',
      'getLabels',
      'getSchemes',
      'getBenefitLevels'
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
      sectionList: [
        'section1', 'section2', 'section5', 'section4', 'section3'
      ],
      pageData: [],
      regionalCompSectionData: [],
      chartCustomFilter: {},
      negativeValueCharts: [
        'section2'
      ],
      customMaxValue: {
        section7: 25
      },
      downloadedData: {},
      max50GroupSection: [],
      sectionsTopY: [],
      processedSections: [],
      selectedNavMenuItem: 'section1',
      navigationMenuItems: [
        {
          name: 'section1',
          icon: '/themes/custom/tbdtheme/assets/dist/img/icons/poverty-reduction.svg',
          body: '<b>Poverty</b>'
        },
        {
          name: 'section2',
          icon: '/themes/custom/tbdtheme/assets/dist/img/icons/equality.svg',
          body: 'Reduction in <b>Inequality</b>'
        },
        {
          name: 'section5',
          icon: '/themes/custom/tbdtheme/assets/dist/img/icons/basket.svg',
          body: 'Increase in <b>Consumption</b>'
        },
        {
          name: 'section4',
          icon: '/themes/custom/tbdtheme/assets/dist/img/icons/umbrella.svg',
          body: '<b>Coverage</b>'
        },
        {
          name: 'section3',
          icon: '/themes/custom/tbdtheme/assets/dist/img/icons/money-bag.svg',
          body: '<b>Cost</b>'
        }
      ],
      legendSelectStatus: {},
      legendHoverStatus: {}
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
      'fetchBenefitLevels',
      'fetchPovertyMeanTesteds'
    ]),
    initialize: function () {
      console.log('initialize');
      this.regionalCompSectionData = _.cloneDeep(regionalCompSectionData);
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
      this.fetchNavigationData();
      this.setSectionData();
    },
    handleScroll () {
      // Any code to be executed when the window is scrolled
      // console.log(window.scrollY);
      for (let i = 0; i < this.sectionsTopY.length; i++) {
        if (window.scrollY > this.sectionsTopY[i] - 130) {
          this.selectedNavMenuItem = this.sectionList[i];
        }
      }
      // const fromTop = jQuery(window).scrollTop(); // 264
      // const actualTop = parseInt(fromTop);
      // // console.log('check active section');
      // console.log(fromTop, actualTop);
    },
    setSectionData: function () {
      _.each(this.regionalCompSectionData, (section) => {
        this.fetchChartData(section);
      });
    },
    async fetchNavigationData () {
      for (const n of this.navigationMenuItems) {
        const thumbnailSvg = await axios.get(n.icon);
        n.iconData = thumbnailSvg && thumbnailSvg.data ? thumbnailSvg.data : '';
      }
    },
    async fetchChartData (sectionObj) {
      // Create custom filter
      if (!this.chartCustomFilter[sectionObj.name]) {
        const tempSelectedObject = {
          scheme_id: '70001_70002_70003'
        };
        const schemeFilterObj = {
          id: 'custom_chart_filter_scheme',
          label: 'Select benefit:',
          key: 'scheme_id',
          type: 'blocklist',
          items: [
            { value: '70001_70002_70003', label: 'Combined' },
            { value: '70001', label: 'Child' },
            { value: '70002', label: 'Disability' },
            { value: '70003', label: 'Old Age' }
          ],
          class: '',
          style: '',
          order: 1
        };
        const filterArr = [schemeFilterObj];

        if (['section2'].indexOf(sectionObj.name) > -1) {
          tempSelectedObject.label_id = '20026';
          const indicatorFilterObj = {
            id: 'custom_chart_filter_label',
            label: 'Select indicator:',
            key: 'label_id',
            type: 'blocklist',
            items: [
              { value: '20026', label: 'Gini' },
              { value: '20027', label: 'Palma' },
              { value: '20028', label: 'Quintile' }
            ],
            class: '',
            style: '',
            order: 2
          };
          filterArr.push(indicatorFilterObj);
        }

        // if (['section4'].indexOf(sectionObj.name) > -1) {
        //   tempSelectedObject.benefit_level = '30002';
        //   const benefitFilterObj = {
        //     id: 'custom_chart_filter_benefit',
        //     label: 'Select benefit level:',
        //     key: 'benefit_level',
        //     items: [
        //       { value: '30002', label: 'Global Average' },
        //       { value: '30003', label: 'OECD Average' }
        //     ],
        //     class: '',
        //     style: '',
        //     order: 3
        //   };
        //   filterArr.push(benefitFilterObj);
        // }

        this.chartCustomFilter[sectionObj.name] = {
          selectedObject: tempSelectedObject,
          filters: filterArr,
          section: sectionObj.name
        };
      }

      let benefits = ['30002', '30003'];
      if (['section1', 'section2'].indexOf(sectionObj.name) > -1) {
        benefits = ['30004', '30005', '30002', '30003'];
      } else if (['section4'].indexOf(sectionObj.name) > -1) {
        benefits = ['30005', '30002'];
      }

      // @Todo : test mock data
      let resultData = [];
      let rawDataArr = [];
      for (const benefit_id of benefits) {
        const filterObj = sectionObj.filterObject;
        filterObj.where.benefit_level = { inq: [benefit_id] };
        if (sectionObj.isformatNoSchemeIndicator) {
          filterObj.where.benefit_level.inq.push('30004');
        }
        const fetchUrl = `${this.loopBackApiPath}/spp-data?filter=${JSON.stringify(filterObj)}`;
        const checkKey = JSON.stringify(filterObj);
        let tempData;
        if (this.downloadedData[checkKey]) {
          tempData = _.cloneDeep(this.downloadedData[checkKey]);
        } else {
          tempData = await axios.get(fetchUrl);
          this.downloadedData[checkKey] = _.cloneDeep(tempData);
        }
        const formattedData = tempData.data ? this.formatDataWithTaxonomy(sectionObj.name, tempData.data) : [];
        rawDataArr = rawDataArr.concat(_.cloneDeep(formattedData));
        // if (sectionObj.isformatNoSchemeIndicator) {
        //   formattedData = this.formatDataWithNoScheme(formattedData);
        // }
        resultData = resultData.concat(_.cloneDeep(formattedData));
      }

      // Test sort legend
      // if (['section5'].indexOf(sectionObj.name) > -1) {
      //   const labelList = ['20001', '20011', '20010'];
      //   resultData = _.orderBy(resultData, (d) => {
      //     return labelList.indexOf(d.label_id);
      //   });
      // }

      this.formatChartData(sectionObj, resultData, rawDataArr);
      // console.log(sectionObj.name);
      this.processedSections.push(sectionObj.name);
      if (this.processedSections.length === this.sectionList.length) {
        setTimeout(() => {
          const iconEls = window.document.querySelectorAll('.regional-title-container h4');
          // console.log(iconEls);
          this.sectionsTopY = [];
          iconEls.forEach(iconEl => {
            this.sectionsTopY.push(iconEl.offsetTop);
          });
          // console.log(this.sectionsTopY);
        }, 1500);
      }
    },
    async formatChartData (sectionInputObj, dataArray, rawDataArr) {
      const sectionName = sectionInputObj.name;
      const defaultChartSectionConfig = {
        title: 'Chart',
        name: sectionName,
        // active: true,
        chart: {},
        insight: '',
        legend: {
          name: 'chart-legend',
          hoveringItem: undefined,
          params: {
            input: '{"data":[]}',
            isSelectable: true,
            isHoverable: false
          }
        }
      };
      const sectionObject = _.cloneDeep(defaultChartSectionConfig);
      // Remove label: Social Protection (20051)
      dataArray = dataArray.filter(d => d.label_id !== '20051');
      // const isRegionalComparison = true;
      const tab = sectionInputObj.chartOptions;
      const groupByField = tab.groupByField ? tab.groupByField : 'value_type';
      const labelField = tab.labelField ? tab.labelField : 'label';
      const indicatorList = _.cloneDeep(this.getIndicators);
      const foundIndicator = _.find(indicatorList, (d) => {
        return d.tid === sectionInputObj.filterObject.where.indicator.inq[0];
      });
      const setDecimalPointValue = 1;
      // const sectionTitle = sectionInputObj.title;

      // Filterdata by custom filter
      const customSelectedObj = _.cloneDeep(this.chartCustomFilter[sectionInputObj.name].selectedObject);
      const allFilterKeys = Object.keys(customSelectedObj);
      const customFilteredData = _.filter(_.cloneDeep(dataArray), (d) => {
        let bool = true;
        _.each(allFilterKeys, (dk) => {
          if (dk === 'special_cov') {
            if (d[dk] !== customSelectedObj[dk]) {
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

      // @Todo : specific case for section cost - child
      if (['section1', 'section2', 'section3', 'section5'].indexOf(sectionName) > -1 && customSelectedObj.scheme_id === '70001') {
        dataArray = _.filter(dataArray, (d) => { return d.benefit_level !== '30003'; });
      }

      // insight
      sectionObject.regionalInsight = this.getRegionalInsight(sectionInputObj, dataArray);

      // FilterData By Legend Status
      const dataArrayBeforeFilter = _.cloneDeep(dataArray);
      let checkSelectedLegendArray = [];
      if (this.legendSelectStatus[sectionName]) {
        checkSelectedLegendArray = _.chain(this.legendSelectStatus[sectionName])
          .filter((d) => { return d.selected === true; })
          .map('label')
          .value();
      }

      // set custom domain
      const minValueObj = _.minBy(dataArray, 'value');
      const maxValueObj = _.maxBy(dataArray, 'value');
      const minValue = minValueObj ? minValueObj.value : NaN;
      const maxValue = maxValueObj ? maxValueObj.value : NaN;

      // let possibleMax = 100;
      // if (this.max50GroupSection.indexOf(sectionName) > -1) {
      //   possibleMax = 50;
      // }

      const chartMargin = { bottom: 100, left: 75 };
      const maxLabelLength = _.chain(dataArray)
        .map('label')
        .uniq('')
        .map(d => d.length)
        .max()
        .value();
      if (maxLabelLength >= 20) {
        chartMargin.bottom += (maxLabelLength - 20) * 10;
        if (chartMargin.bottom >= 260) {
          chartMargin.bottom = 260;
        }
      }

      const legendHoveringLabel = this.legendHoverStatus[sectionName] && this.legendHoverStatus[sectionName].item ? this.legendHoverStatus[sectionName].item.label : undefined;

      const defaultChartConfig = {
        name: 'lollipop-chart',
        params: {
          width: 'auto',
          height: 170,
          margin: chartMargin,
          xAxis: { label: '' },
          yAxis: { label: '' },
          xScale: { field: 'label' },
          yScale: { fieldDataPoint: [] },
          dataPoint: {},
          selectedLegend: checkSelectedLegendArray.length ? checkSelectedLegendArray[0] : undefined,
          hoveringLegend: legendHoveringLabel,
          data: '{}'
        }
      };
      // Negative value charts
      // if (this.negativeValueCharts.includes(sectionName)) {
      //   // // && (!minValue === 0 && !maxValue === 0)
      //   // if (!isNaN(minValue) && !isNaN(maxValue)) {
      //   //   defaultChartConfig.params.marginRight = defaultChartConfig.params.marginLeft; // Y Axis will be left hand side
      //   //   defaultChartConfig.params.marginLeft = 50;
      //   // }
      //   // if (minValue === 0 && maxValue === 0) {
      //   //   defaultChartConfig.params.marginRight = chartMargin.right;
      //   //   defaultChartConfig.params.marginLeft = chartMargin.left;
      //   // }
      // }

      const sectionChartData = [];
      const valueTypeFieldMapping = { color: 'field_color' };
      const valueTypeMapping = {};
      for (const valueType of this.getValueTypes) {
        valueTypeMapping[valueType.tid] = { ...valueType };
      }
      // Include Label list to mapping
      for (const label of this.getLabels) {
        valueTypeMapping[label.tid] = { ...label };
        valueTypeMapping[label.field_display_name] = {
          ...label,
          dataPoint: {
            el: 'circle',
            fill: label[valueTypeFieldMapping.color]
          }
        };
      }
      // new Case for scenario and scheme
      valueTypeMapping['Scenario A'] = { field_color: '#a0cdf8' };
      valueTypeMapping['Scenario B'] = { field_color: '#0d3562' };
      valueTypeMapping['Child Benefit'] = { field_color: '#39C7FA' };
      valueTypeMapping['Disability Benefit'] = { field_color: '#0060C2' };
      valueTypeMapping['Old Age Benefit'] = { field_color: '#66CC33' };
      valueTypeMapping.Combined = { field_color: '#7F58A5' };
      /* Benefit level */
      // @TODO: Store color data in Drupal taxonomy
      valueTypeMapping['Other benefit'] = { field_color: '#B8BCC9' };
      valueTypeMapping['Global Average'] = {
        field_color: '#39C7FA',
        border_color: '#39C7FA',
        dataPoint: { label: 'Global Average', el: 'circle', fill: '#39C7FA', stroke: '#39C7FA' }
      };
      valueTypeMapping['OECD Average'] = {
        field_color: '#7F58A5',
        border_color: '#7F58A5',
        dataPoint: { label: 'OECD Average', el: 'circle', fill: '#7F58A5', stroke: '#7F58A5' }
      };
      valueTypeMapping['With universal schemes'] = {
        field_color: '#0060C2',
        border_color: '#0060C2',
        dataPoint: { label: 'With universal schemes', el: 'circle', fill: '#0060C2', stroke: '#0060C2' }
      };
      valueTypeMapping['With no schemes'] = {
        field_color: '#000000',
        dataPoint: { label: 'With no schemes', el: 'circle', fill: '#000', stroke: '#000' }
      };
      valueTypeMapping['With existing schemes'] = {
        field_color: '#fff',
        border_color: '#000',
        dataPoint: { label: 'With existing schemes', el: 'circle', fill: '#fff', stroke: '#000' }
      };
      /* /Benefit level */

      // Check data
      const defaultChartDataObject = { data: [] };
      const sectionDataObject = JSON.parse(JSON.stringify(defaultChartDataObject));
      const axisLabels = this.getAxisLabel(dataArray, foundIndicator, tab.textOptions, false);
      defaultChartConfig.params.xAxis.label = axisLabels.xLabel;
      defaultChartConfig.params.yAxis.label = axisLabels.yLabel;
      const allDataKeys = Object.keys(_.groupBy(dataArray, groupByField));
      defaultChartConfig.params.yScale.dataPointFields = allDataKeys;

      if (checkSelectedLegendArray.length) {
        defaultChartConfig.params.yScale.dataPointFields = _.orderBy(allDataKeys, (d) => {
          return checkSelectedLegendArray.indexOf(d);
        });
      }

      defaultChartConfig.params.yScale.dataPointFields.forEach(dataPointField => {
        defaultChartConfig.params.dataPoint[dataPointField] = { ...valueTypeMapping[dataPointField].dataPoint };
      });

      sectionObject.chart = JSON.parse(JSON.stringify(defaultChartConfig));

      const orderMapping = {};
      const groupAxisData = [];
      if (sectionInputObj.chartOptions.groupAxisOptions) {
        const groupAxisByField = sectionInputObj.chartOptions.groupAxisOptions.groupField;
        const groupByAxis = _.groupBy(_.cloneDeep(dataArray), groupAxisByField);
        let orderCount = 0;
        let groupKeys = Object.keys(groupByAxis).sort();
        if (groupAxisByField === 'region') {
          // Specific order
          groupKeys = [
            'East and North-East Asia',
            'North and Central Asia',
            'Pacific',
            'South-East Asia',
            'South and South-West Asia'];
        }
        _.each(groupKeys, (kk, i) => {
          const k = kk;
          const d = groupByAxis[k];
          const obj = {
            name: k,
            order: i
          };
          const gbCountry = _.chain(d)
            .groupBy('country')
            .map((d2, k2) => {
              const c = {
                name: k2,
                sum: _.maxBy(d2, 'value').value
              };
              return c;
            })
            .orderBy(['sum'], ['desc'])
            .map((d2) => {
              orderCount++;
              d2.order = orderCount;
              orderMapping[d2.name] = d2.order;
              return d2;
            })
            .value();

          if (gbCountry.length) {
            const max = _.maxBy(gbCountry, 'sum');
            const min = _.minBy(gbCountry, 'sum');
            obj.start = max.name;
            obj.end = min.name;
            obj.data = gbCountry;
            groupAxisData.push(obj);
          }
        });
        sectionDataObject.groupAxisData = groupAxisData;
      }

      const groupLevel1 = labelField;
      // const groupLevel2 = groupByField;
      sectionDataObject.data = _.chain(dataArray)
        .groupBy(groupLevel1)
        .map((v, k) => {
          // const tempValues = {};
          // let tempSum = 0;
          // _.each(v, (d) => {
          //   tempValues[d[groupLevel2]] = d.value;
          //   if (d.value) {
          //     tempSum = tempSum + d.value;
          //   }
          // });
          let order = 9999;
          if (v.length) {
            order = orderMapping[k] ? orderMapping[k] : order;
          }
          const colorId = v[0].color_id;
          const result = {
            id: k,
            label: k,
            order: order,
            // sum_value: tempSum,
            // values: tempValues,
            // max_sum: _.maxBy(v, 'value') ? _.maxBy(v, 'value').value : 0,
            color: valueTypeMapping[colorId] ? valueTypeMapping[colorId][valueTypeFieldMapping.color] : 'black'
          };
          defaultChartConfig.params.yScale.dataPointFields.forEach(dataPointField => {
            const dataPointItem = v.find(d => d[groupByField] === dataPointField);
            if (dataPointItem) {
              result[dataPointField] = dataPointItem.value;
            }
          });
          return result;
        })
        .sortBy((d) => {
          if (Object.keys(orderMapping).length) {
            return d.order;
          } else {
            return d[defaultChartConfig.params.xScale.field];
          }
        })
        .value();

      const fullLegendKeys = Object.keys(_.groupBy(dataArrayBeforeFilter, groupByField));
      let legendData = _.map(fullLegendKeys, dataPointField => {
        return {
          label: dataPointField,
          color: valueTypeMapping[dataPointField][valueTypeFieldMapping.color],
          border: valueTypeMapping[dataPointField].border_color ? valueTypeMapping[dataPointField].border_color : undefined,
          selected: 'none'
        };
      });

      if (sectionName !== 'section4') {
        if (!this.legendSelectStatus[sectionName]) {
          this.legendSelectStatus[sectionName] = _.cloneDeep(legendData);
        } else {
          legendData = _.map(legendData, (lgd) => {
            const foundExisting = _.find(this.legendSelectStatus[sectionName], (elg) => {
              return elg.label === lgd.label;
            });

            if (foundExisting) {
              lgd.selected = foundExisting.selected;
            }
            return lgd;
          });
          // this.legendSelectStatus[sectionName] = _.cloneDeep(legendData);
        }
      }

      sectionObject.chart.params.data = JSON.stringify({ data: sectionDataObject });
      // sectionObject.chart.params.orderByField = tab.orderByField ? tab.orderByField : 'order';
      // sectionObject.chart.params.hasYAxisGrid = true;
      // sectionObject.chart.params.isYAxisGridFitXAxis = true;
      // sectionObject.chart.params.tooltipAtMousePosition = true;
      // sectionObject.chart.params.barOrientation = 'horizontal-grouped';
      // sectionObject.chart.params.barThickness = 15;
      // if (appliedGroupLabelSection.indexOf(sectionName) > -1) {
      //   sectionObject.chart.params.showBarGroupedLabel = true;
      //   sectionObject.chart.params.marginLeft = 100;
      // }
      // sectionObject.chart.params.showAverageLineValueLabel = true;
      let tempMax, tempMin;
      if (minValue >= 0 && maxValue > 0) {
        tempMin = 0;
        tempMax = Math.ceil(maxValue / 10) * 10;
        // tempMax = maxValue > possibleMax ? maxValue : possibleMax;
      } else if (minValue < 0 && maxValue <= 0) {
        tempMin = Math.floor(minValue / 10) * 10;
        tempMax = 0.0001;
      } else if (minValue <= 0 && maxValue >= 0) {
        tempMin = Math.floor(minValue / 10) * 10;
        tempMax = Math.ceil(maxValue / 10) * 10;
        // tempMin = minValue < -possibleMax ? minValue : -possibleMax;
        // tempMax = maxValue > possibleMax ? maxValue : possibleMax;
      }
      // console.log(sectionName);
      // console.log(sectionObject.chart);
      if (tempMax || tempMin) {
        // sectionObject.chart.params.yScale.domain = [tempMin, tempMax];
        // sectionObject.chart.params.yScale.domain = [tempMin, tempMax];
        // [tempMin, (tempMax - tempMin) / 2, tempMax];
      }
      // console.log(JSON.stringify(this.chartCustomFilter.section3.selectedObject));
      if (sectionName === 'section4') {
        sectionObject.chart.params.yDomain = '[0, 20, 40, 60, 80, 100]';
      } else if (sectionName === 'section2') {
        // console.log(this.chartCustomFilter.section2.selectedObject.label_id);
        if (this.chartCustomFilter.section2.selectedObject.label_id === '20027') {
          sectionObject.chart.params.yScale.domain = [0, 1, 2, 3];
        } else if (this.chartCustomFilter.section2.selectedObject.label_id === '20028') {
          sectionObject.chart.params.yScale.domain = [0, 5, 10, 15];
        } else {
          sectionObject.chart.params.yScale.domain = [0, 0.1, 0.2, 0.3, 0.4, 0.5];
        }
      } else if (sectionName === 'section1') {
        sectionObject.chart.params.yScale.domain = [0, 20, 40, 60];
      } else if (sectionName === 'section5') {
        sectionObject.chart.params.yScale.domain = [0, 20, 40, 60, 80, 100];
      } else if (sectionName === 'section3') {
        sectionObject.chart.params.yScale.domain = [0, 2, 4, 6, 7];
      } else {
        sectionObject.chart.params.yScale.domain = [tempMin, tempMax];
      }
      sectionObject.legend.params.input = JSON.stringify({ data: legendData });

      if (sectionName === 'section4') {
        sectionObject.chart.name = 'bar-chart';
        sectionObject.chart.params.height = 140;
        sectionObject.chart.params.autoWidth = true;
        sectionObject.chart.params.isWrapY = false;
        sectionObject.chart.params.isWrapX = false;
        sectionObject.chart.params.rotateX = 45;
        sectionObject.chart.params.barOrientation = 'vertical';
        sectionObject.chart.params.valueField = 'value';
        sectionObject.chart.params.marginLeft = 70;
        sectionObject.chart.params.marginBottom = 170;
        sectionObject.chart.params.showTextOnBar = false;
        sectionObject.chart.params.groupAxisData = groupAxisData;
        sectionObject.chart.params.xAxisPadding = 0.2;
        sectionObject.chart.params.decimalPoint = setDecimalPointValue;
        // sectionObject.chart.params.hasYAxisGrid = true;

        const regionMappingColor = {
          'East and North-East Asia': '#f7901e',
          'North and Central Asia': '#1fa860',
          Pacific: '#45c7ed',
          'South-East Asia': '#ef4638',
          'South and South-West Asia': '#9e1f4f'
        };

        const regionMappingGreyoutColor = {
          'East and North-East Asia': 'rgb(247, 144, 30, 0.1)',
          'North and Central Asia': 'rgba(31, 168, 96, 0.1)',
          Pacific: 'rgb(69, 199, 237, 0.1)',
          'South-East Asia': 'rgb(239, 70, 56, 0.1)',
          'South and South-West Asia': 'rgb(158, 31, 79, 0.1)'
        };

        const AllRegionKeys = Object.keys(regionMappingColor);

        if (checkSelectedLegendArray.length) {
          _.each(AllRegionKeys, (rk) => {
            if (checkSelectedLegendArray.indexOf(rk) === -1) {
              regionMappingColor[rk] = regionMappingGreyoutColor[rk];
            }
          });
        }

        const simpleBarData = _.chain(dataArray)
          .groupBy(groupLevel1)
          .map((v, k) => {
            let order = 9999;
            if (v.length) {
              order = orderMapping[k] ? orderMapping[k] : order;
            }
            const colorId = v[0].color_id;
            const result = {
              id: k,
              label: k,
              order: order,
              color: valueTypeMapping[colorId] ? valueTypeMapping[colorId][valueTypeFieldMapping.color] : 'black'
            };
            defaultChartConfig.params.yScale.dataPointFields.forEach(dataPointField => {
              const dataPointItem = v.find(d => d[groupByField] === dataPointField);
              if (dataPointItem) {
                result.value = dataPointItem.value;
                result.region = dataPointItem.region;
                result.color = regionMappingColor[result.region];
              }
            });
            return result;
          })
          .sortBy((d) => {
            if (Object.keys(orderMapping).length) {
              return d.order;
            } else {
              return d[defaultChartConfig.params.xScale.field];
            }
          })
          .value();

        const tempDataObj = {
          x_label: '',
          y_label: axisLabels.yLabel,
          x_unit_label: '',
          tooltip_unit_label: '',
          tooltip: {
            value: '<strong>[[internal#label]]</strong></br>[[internal#value]]'
          },
          data: simpleBarData
        };
        sectionObject.chart.params.data = JSON.stringify({ data: tempDataObj });
        let regionLegend = _.map(regionMappingColor, (v, k) => {
          return {
            label: k,
            color: v,
            border: v,
            selected: 'none'
          };
        });
        if (!this.legendSelectStatus[sectionName]) {
          this.legendSelectStatus[sectionName] = _.cloneDeep(regionLegend);
        } else {
          regionLegend = _.map(regionLegend, (lgd) => {
            const foundExisting = _.find(this.legendSelectStatus[sectionName], (elg) => {
              return elg.label === lgd.label;
            });

            if (foundExisting) {
              lgd.selected = foundExisting.selected;
            }
            return lgd;
          });
          this.legendSelectStatus[sectionName] = _.cloneDeep(regionLegend);
        }

        sectionObject.legend.params.input = JSON.stringify({ data: regionLegend });
        // ===== End special case for section 4 (coverage) =====
      }
      // console.log(sectionObject);
      sectionChartData.push(sectionObject);

      if (sectionChartData.length) {
        sectionChartData[0].active = true;
        sectionChartData[0].isVertical = true;
      }

      // Generate chart section components
      const sectionComponentObj = {
        childrenList: [],
        customChartFilter: this.chartCustomFilter[sectionInputObj.name]
      };

      const regionalTitle = {
        title: sectionInputObj.title,
        subTitle: sectionInputObj.subTitle
      };

      const csvDownloadData = getCsvDownloadData(rawDataArr);

      this.pageData[sectionInputObj.name] = {
        type: 'chart-section',
        data: {
          tabs: _.cloneDeep(sectionChartData),
          regionalTitle: regionalTitle,
          title: sectionInputObj.title,
          // tag: sectionInputObj.tag,
          forceChartBoxHeight: sectionInputObj.chartBoxHeight,
          isSmall: false,
          showTabs: false,
          forceRenderChart: true,
          chartSectionComponents: sectionComponentObj,
          rawData: csvDownloadData
          // sectionDetail: sectionInputObj.sectionDetail
        },
        isLoading: false
      };
      this.pageData = { ...this.pageData };
    },
    formatDataWithTaxonomy (sectionName, dataArray) {
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
        if (bf.tid === '30002') {
          if (sectionName === 'section4') {
            bf.name = 'With universal schemes';
          } else {
            bf.name = 'Global Average';
          }
        } else if (bf.tid === '30003') {
          bf.name = 'OECD Average';
        }
        bfLookup[bf.tid] = bf.name;
      });

      _.each(countryList, (ct) => {
        ctLookup[ct.tid] = ct;
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

      const regionMapping = {
        NCA: 'North and Central Asia',
        PAC: 'Pacific',
        SSWA: 'South and South-West Asia',
        SEA: 'South-East Asia',
        ENEA: 'East and North-East Asia'
      };

      // special case : pick data by poverty type
      if (['section1'].indexOf(sectionName) > -1) {
        const pTypeMapping = {
          '$3.20': '20024',
          '$5.50': '20025'
        };
        const gbCountry = _.chain(dataArray)
          .groupBy('country')
          .map((v, k) => {
            const foundCountry = _.find(countryList, (c) => { return c.tid === k; });
            const temp = _.filter(_.cloneDeep(v), (d) => {
              return d.label === pTypeMapping[foundCountry.field_poverty_type];
            });
            // console.log('temp', foundCountry.field_poverty_type, temp);
            return temp;
          })
          .flattenDeep()
          .value();
        dataArray = gbCountry;
      }

      result = _.map(_.cloneDeep(dataArray), (d) => {
        d.value = Number(d.value);
        d.country_id = d.country;
        d.value_type_id = d.value_type;
        d.label_id = d.label;
        d.scheme_id = d.scheme;
        d.scheme_order = odLookup[d.scheme_id] ? odLookup[d.scheme_id] : 9999;
        d.label_order = odLookup[d.label_id] ? odLookup[d.label_id] : 9999;
        d.country = ctLookup[d.country_id] ? ctLookup[d.country_id].name : d.country;
        d.region = ctLookup[d.country_id] ? regionMapping[ctLookup[d.country_id].field_region] : '';
        // d.region = ctLookup[d.country_id] ? ctLookup[d.country_id].field_region : '';
        d.poverty_type = ctLookup[d.country_id] ? ctLookup[d.country_id].field_poverty_type : '';
        d.label = lbLookup[d.label] ? lbLookup[d.label] : d.label;
        d.scenario = '';
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

      // filter simulation country out
      result = _.filter(result, (d) => {
        return d.country_id !== '50020';
      });
      return result;
    },
    formatDataWithNoScheme (dataArray) {
      const result = [];
      const gbCountry = _.groupBy(dataArray, 'country');
      _.each(gbCountry, (gbC) => {
        const gbScheme = _.groupBy(gbC, 'scheme');

        _.each(gbScheme, (gbArr) => {
          const gbLabels = _.groupBy(gbArr, 'label');

          _.each(gbLabels, (gblbArr) => {
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
              result.push(postRefObj);
            }
          });
        });
      });

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
    updateChartCustomFilter (chartCustomFilter) {
      // console.log(chartCustomFilter);
      // console.log(this.chartCustomFilter);
      if (this.chartCustomFilter[chartCustomFilter.section]) {
        this.chartCustomFilter[chartCustomFilter.section].selectedObject = _.cloneDeep(chartCustomFilter.selectedObject);
      }
      this.setSectionData();
    },
    onLegendItemClick (sectionName, legendItem) {
      const foundCurrentSelected = _.find(this.legendSelectStatus[sectionName], (d) => {
        return d.label === legendItem.item.label;
      });
      const isDeselect = foundCurrentSelected.selected === true;
      this.legendSelectStatus[sectionName] = _.each(this.legendSelectStatus[sectionName], (d) => {
        if (isDeselect) {
          d.selected = 'none';
        } else {
          if (legendItem.item.label === d.label) {
            d.selected = true;
          } else {
            d.selected = false;
          }
        }
        return d;
      });
      this.setSectionData();
    },
    onLegendItemMouseOver (sectionName, legendItem) {
      this.legendHoverStatus[sectionName] = _.cloneDeep(legendItem);
      this.setSectionData();
    },
    scrollToElement (item) {
      // console.log('scrollToElement');
      window.removeEventListener('scroll', this.handleScroll);
      this.selectedNavMenuItem = item.name;
      const refName = 'section_container_' + item.name;
      // const targetEle = this.$refs[refName][0];
      this.$refs[refName][0].scrollIntoView({ behavior: 'smooth', block: 'start' });
      setTimeout(() => {
        window.addEventListener('scroll', this.handleScroll);
      }, 1000);
    },
    getRegionalInsight (sectionInputObj, dataArray) {
      const sectionName = sectionInputObj.name;
      let result = '';
      const lookup = {
        countryCount: undefined,
        sum: 0
      };

      const tempCalculation = {};

      // General
      const countryList = _.cloneDeep(this.getCountries);
      const filteredCountry = _.filter(countryList, (d) => {
        return d.tid !== '50020';
      });
      lookup.countryCount = filteredCountry.length;

      // Calculation
      // console.log('dataArray', dataArray);
      const groupByCountry = _.groupBy(dataArray, 'country_id');
      // console.log('groupByCountry', groupByCountry);
      _.each(groupByCountry, (v, k) => {
        if (['section1', 'section2'].indexOf(sectionName) > -1) {
          const tempData = _.chain(v)
            .filter((d) => { return d.benefit_level === '30002'; })
            .orderBy('value')
            .value();
          const noSchemeObj = _.find(v, (d) => { return d.benefit_level === '30004'; });
          const postRefObj = tempData[0];
          const decreaseInPercent = (postRefObj.value - noSchemeObj.value) / noSchemeObj.value * 100;
          if (sectionName === 'section2') {
            // Only include negative value
            if (decreaseInPercent < 0) {
              tempCalculation[k] = decreaseInPercent * -1;
            }
          } else {
            tempCalculation[k] = decreaseInPercent * -1;
          }
        } else if (['section3', 'section4', 'section5'].indexOf(sectionName) > -1) {
          const foundData = _.find(v, (dv) => { return dv.benefit_level === '30002'; });
          if (foundData) {
            tempCalculation[k] = foundData.value;
          }
        } else {
          tempCalculation[k] = 0;
        }
        if (tempCalculation[k] !== undefined) {
          lookup.sum = lookup.sum + tempCalculation[k];
          if ((lookup.max < tempCalculation[k]) || (!lookup.max)) {
            lookup.max = tempCalculation[k];
            lookup.maxValue = lookup.max.toFixed(1);
            lookup.maxValue_1 = lookup.max.toFixed(1);
            lookup.maxCountry = v[0].country;
            lookup.maxPoverty = v[0].poverty_type;
            lookup.maxRegion = v[0].region;
          }
          if ((lookup.min > tempCalculation[k]) || (!lookup.min)) {
            lookup.min = tempCalculation[k];
            lookup.minValue = lookup.min.toFixed(1);
            lookup.minValue_1 = lookup.min.toFixed(1);
            lookup.minCountry = v[0].country;
            lookup.minPoverty = v[0].poverty_type;
            lookup.minRegion = v[0].region;
          }
        }
      });
      // console.log(sectionName, tempCalculation);

      lookup.avg = lookup.sum / lookup.countryCount;
      lookup.avgValue = lookup.avg.toFixed(1);
      lookup.avgValue_1 = lookup.avg.toFixed(1);
      lookup.scheme = dataArray.length ? dataArray[0].scheme : 'scheme(s)';

      if (lookup.scheme === 'Combined') {
        lookup.scheme = 'Combined Benefit';
      }

      // console.log('lookup', lookup);

      if (sectionName === 'section1') {
        result = `Current and simulated poverty rates, at international poverty lines that are commensurate to their level of income, in different scenarios are presented for <span class="focus-text">${lookup.countryCount}</span> countries.</br></br>
          At a maximum, <span class="focus-text">${lookup.maxValue}%</span> poverty reduction is observed in <span class="focus-text">${lookup.maxCountry}</span> at <span class="focus-text">${lookup.maxPoverty}</span> international poverty line.
          At a minimum, <span class="focus-text">${lookup.minValue}%</span> poverty reduction is observed in <span class="focus-text">${lookup.minCountry}</span> at <span class="focus-text">${lookup.minPoverty}</span> international poverty line.
          On average, <span class="focus-text">${lookup.avgValue}%</span> decrease in poverty rates is expected for <span class="focus-text">${lookup.countryCount}</span> countries.`;
      } else if (sectionName === 'section2') {
        const selectedIndex = dataArray.length ? dataArray[0].label : 'Selected index';

        result = `Current and simulated <span class="focus-text">${selectedIndex}</span> in different scenarios are presented for <span class="focus-text">${lookup.countryCount}</span> countries.</br></br>
        At a maximum, inequality is simulated to decrease by <span class="focus-text">${lookup.maxValue}%</span> in <span class="focus-text">${lookup.maxCountry}</span>.
        At a minimum, inequality is simulated to decrease by <span class="focus-text">${lookup.minValue}%</span> in <span class="focus-text">${lookup.minCountry}</span>.
        On average, <span class="focus-text">${lookup.avgValue}%</span> decrease in inequality is expected for <span class="focus-text">${lookup.countryCount}</span> countries. Inequality may increase when there is a relatively higher proportion of recipients in higher welfare deciles.`;
      } else if (sectionName === 'section3') {
        const costScheme = lookup.scheme === 'Combined Benefit' ? 'Combined' : lookup.scheme;
        const preSchemeText = costScheme === 'Combined' ? 'universal' : 'universal social protection';

        result = `The cost of introducing ${preSchemeText} <span class="focus-text">${costScheme} schemes</span> is presented for <span class="focus-text">${lookup.countryCount}</span> countries.</br></br>
        At a maximum, it would cost <span class="focus-text">${lookup.maxValue_1}</span>% of GDP in <span class="focus-text">${lookup.maxCountry}</span>.
        At a minimum, it would cost <span class="focus-text">${lookup.minValue_1}</span>% of GDP in <span class="focus-text">${lookup.minCountry}</span>.
        On average, it would cost <span class="focus-text">${lookup.avgValue_1}</span>% in <span class="focus-text">${lookup.countryCount}</span> countries in the region.`;
      } else if (sectionName === 'section4') {
        result = `Simulated coverage by universal <span class="focus-text">${lookup.scheme} schemes</span> are presented for <span class="focus-text">${lookup.countryCount}</span> countries.</br></br>
        At a maximum, <span class="focus-text">${lookup.maxValue}</span>% of the total population is expected to be covered in <span class="focus-text">${lookup.maxCountry}</span>.
        At a minimum, <span class="focus-text">${lookup.minValue}</span>% of the total population is expected to be covered in <span class="focus-text">${lookup.minCountry}</span>.
        On average, <span class="focus-text">${lookup.avgValue}</span>% is expected to be covered in <span class="focus-text">${lookup.countryCount}</span> countries.`;
      } else if (sectionName === 'section5') {
        result = `Simulated change in consumption for the poorest 10% in <span class="focus-text">${lookup.scheme} schemes</span> is presented for <span class="focus-text">${lookup.countryCount}</span> countries.</br></br>
        At a maximum, consumption is expected to increase by <span class="focus-text">${lookup.maxValue}</span>% in <span class="focus-text">${lookup.maxCountry}</span>.
        At a minimum, consumption is expected to increase by <span class="focus-text">${lookup.minValue}</span>% in <span class="focus-text">${lookup.minCountry}</span>.
        On average, <span class="focus-text">${lookup.avgValue}</span>% increase in consumption is expected for <span class="focus-text">${lookup.countryCount}</span> countries.`;
      }

      return result;
    }
  },
  setup () {
    return {
    };
  }
};
</script>

<style lang="scss">
.cross-country {
  font-size: 12px;
  .chart-section-wrapper {
    .vs__selected-options {
      height: 20px !important;
    }
  }
  .export-dropdown {
    // display: none;
  }
  .filter-panel-container {
    .filter-box {
      div {
        display: block !important;
      }
      padding-right: 0 !important;
    }
  }
  .chart-section-filter-panel {
    margin-left: 0 !important;
    .filter-label {
      margin-bottom: 0;
    }
  }
}
.page-navigation-container {
  position: sticky;
  top: 115px;
}
.navigation-box-item {
  &.active {
    background-color: #449945;
    width: 140px;
    color: white;
    .svg-icon svg path {
      fill: white;
    }
  }
  border: 1px solid black;
  border: 1px solid #F8F9FA;
  // border-radius: 5px;
  margin-bottom: 1px;
  margin-right: 5px;
  cursor: pointer;
  font-size: 12px;
  height: 50px;
  width: 50px;
  margin-right: 0 !important;
  // margin-left: auto;
  text-align: center;
  background: #F8F9FA;
  .navigation-text {
    line-height: 1;
    font-size: 13px;
    margin-top: auto;
    margin-bottom: auto;
    text-align: left;
  }
}
.svg-icon svg {
  width: 45px;
  height: 45px;
  margin-left: auto;
  margin-right: auto;
}
.svg-icon svg path {
  fill: #6C757D;
}
.scroll-checkpoint {
  scroll-margin-top: 110px; // 120px is 100px(nav height) + 10px(spacing)
}
.filter-box {
  padding-left: 5px !important;
}
.chart-regional-insight {
  .focus-text {
    color: #449945 !important;
    font-weight: bold;
  }
}
.chart-legend-container {
  max-height: 100px !important;
}
.chart-section-box {
  // height: 650px;
}
@media (max-width: 991px) {
  .navigation-box-item {
    &.active {
      width: 50px;
      .navigation-text {
        display: none;
      }
    }
    &.active:hover {
      width: 140px;
      .navigation-text {
        display: block;
      }
    }
  }
}
</style>
