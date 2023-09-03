<template>
  <div ref="mapWrapperContainerRef" class="map-wrapper-container">
    <div class="row">
      <div class="col-12 button-label-container">
        <label class="form-label">Select Social Protection category:</label>
      </div>
      <div class="col-12 d-flex flex-wrap gap-1">
        <div
          v-for="(button, buttonIndex) of buttonList"
          :key="`button_${buttonIndex}`"
        >
          <button
            slot="reference"
            @click="clickMapButton(button)"
            :class="filterPanelInputs.pageLevel.selectedObject.indicator === button.value ? 'active' : ''"
            class="btn-map-button btn btn-sm"
          >{{ button.label }}</button>
        </div>
      </div><!-- /.d-flex -->
      <div class="col-12 tab-content">
        <div
          ref="maptab"
          id="mapTab"
          class="tab-pane fade"
          :class="activeTabId === 'mapTab' ? 'active show' : ''"
          role="tabpanel"
          aria-labelledby="map-tab"
        >
          <div class="row">
            <div class="col-sm-12 col-md-7 col-lg-8">
              <div
                ref="mapTitleContainer"
                class="map-wrapper-title-container">
                <h3>{{mapTitle}} <span v-if="mapUnit">( {{mapUnit}} )</span></h3>
                <p>{{ indicatorDescription }}</p>
              </div>
              <map-chart
                :bubble-data="JSON.stringify(mapData)"
                :chart-options="JSON.stringify(mapOptions)"
                :metadata="JSON.stringify(mapMetadata)">
              </map-chart>
            </div><!-- /.col -->
            <div class="col-sm-12 col-md-5 col-lg-4 container-bar-chart mt-3 mt-sm-0">
              <div ref="barChartRef">
                <bar-chart
                  v-bind="barChartParams"
                  @chartReady="isBarChartReady($event)">
                </bar-chart>
              </div>
              <div ref="dataLegendRef" class="container-data-legend">
                <div class="d-flex flex-row align-items-center fw-bold">
                  <i class="uil uil-list-ul me-1"></i> Data legend
                </div>
                <div
                  v-if="selectedAverageData"
                  class="container-average-line-legend fs-12 fw-light">
                  <div class="d-flex gap-2 ">
                    <div
                      v-for="average in selectedAverageData"
                      :key="average.label"
                      class="d-flex align-items-center gap-1">
                      <span>{{ average.label }}</span>
                      <svg width="30" :height="average.strokeWidth">
                        <line
                          x1="0"
                          y1="0"
                          x2="30"
                          y2="0"
                          :stroke="average.stroke"
                          :stroke-dasharray="average.strokeDasharray"
                          :stroke-width="average.strokeWidth * 2"
                        />
                      </svg>
                    </div>
                  </div>
                </div>
                <chart-legend
                  v-if="legendParams.input"
                  v-bind="legendParams"
                  class="py-1"
                ></chart-legend>
              </div>
            </div><!-- /.col -->
          </div><!-- /.row -->
        </div><!-- /#mapTab -->
        <div
          id="sourceTab"
          class="tab-pane fade"
          :class="activeTabId === 'sourceTab' ? 'active show' : ''"
          role="tabpanel"
          aria-labelledby="source-tab">
          <div>
            International Labour Organization, World Social Protection Database. Available at <a class="text-link" href="https://www.social-protection.org/gimi/WSPDB.action?id=32" target="_blank">ILO | Social Protection Platform</a>
          </div>
        </div><!-- #sourceTab -->
        <ul ref="tabListRef" class="nav pb-2" role="tablist">
          <li class="nav-item" role="presentation">
            <button
              id="btnMapTab"
              class="nav-link border-0 tab-button"
              :class="activeTabId === 'mapTab' ? 'active' : ''"
              type="button"
              role="tab"
              aria-controls="map"
              data-bs-target="#mapTab"
            >Map & Bar</button>
          </li>
          <li class="nav-item" role="presentation">
            <button
              id="btnSourceTab"
              class="nav-link border-0 tab-button"
              :class="activeTabId === 'sourceTab' ? 'active' : ''"
              type="button"
              role="tab"
              aria-controls="source"
              data-bs-target="#sourceTab"
            >Information</button>
          </li>
        </ul>
      </div><!-- /.tab-content -->
    </div>
  </div>
</template>

<script>
import BarChart from '@wc/bar-chart/bar-chart.vue';
import { ResizeObserver } from '@wc/chart-services';
import MapChart from '@wc/map-chart/map-chart.vue';
import ChartLegend from '@wc/spp-chart-legend/spp-chart-legend.vue';
import axios from 'axios';
import _ from 'lodash';
import 'vue-popperjs/dist/vue-popper.css';
import { DRUPAL_API_VERSION_URL, DRUPAL_DOMAIN, RAPI_DOMAIN, RAPI_VERSION_URL } from '../environment.ts';

export default {
  props: {
    width: { type: Number, default: null },
    height: { type: Number, default: null }
  },
  components: {
    BarChart,
    ChartLegend,
    MapChart
  },
  data: function () {
    return {
      loopBackApiPath: `${RAPI_DOMAIN}${RAPI_VERSION_URL}`,
      drupalApiPath: `${DRUPAL_DOMAIN}${DRUPAL_API_VERSION_URL}`,
      // loopBackApiPath: `https://spp.thinkbluedata.com/rapi${RAPI_VERSION_URL}`,
      // drupalApiPath: 'https://thingproxy.freeboard.io/fetch/https://spp.thinkbluedata.com/api/v1',
      activeTabId: 'mapTab',
      mapTitle: '',
      mapUnit: '',
      buttonList: [
        // { value: '55001', label: 'Any' },
        // { value: '55002', label: 'Old Age' },
        // { value: '55003', label: 'Disabled' }
        // { value: '55004', label: 'Unemployed' },
        // { value: '55005', label: 'Injured' },
        // { value: '55006', label: 'Children' },
        // { value: '55007', label: 'Poor' },
        // { value: '55008', label: 'Vulnerable' },
        // { value: '55009', label: 'GDP' },
        // { value: '55010', label: 'Social' }
      ],
      filterPanelInputs: {
        pageLevel: {
          selectedObject: {
            indicator: '150001'
          },
          filters: [
            {
              label: 'Indicator',
              key: 'indicator',
              items: [
                // { value: '55001', label: 'Population covered by at least one social protection benefit' },
                // { value: '55002', label: 'Persons above retirement age receiving a pension' },
                // { value: '55003', label: 'Persons with severe disabilities collecting disability social protection benefits' },
                // { value: '55004', label: 'Unemployed receiving unemployment benefits' },
                // { value: '55005', label: 'Employed covered in the event of work injury' },
                // { value: '55006', label: 'Children/households receiving child/family cash benefits' },
                // // { value: '55007', label: 'Poor persons covered by social protection systems' },
                // { value: '55008', label: 'Vulnerable persons covered by social assistance' },
                // { value: '55009', label: 'Expenditure (% of GDP)' },
                // { value: '55010', label: 'Expenditure on Social Protection, % of GDP (excl healthcare)' }
              ]
            }
          ]
        }
      },
      mapOptions: {
        url: 'https://geoservices.un.org/arcgis/rest/services/ClearMap_WebGray/MapServer/tile/{z}/{y}/{x}',
        tmsUrl: null,
        geoJsonUrl: null,
        height: this.height,
        width: this.width,
        zoom: 4,
        minZoom: 2,
        maxZoom: 6,
        showMarker: false,
        showBubble: true,
        // showLegend: true,
        tmsOptions: null,
        isShowControlPanel: true,
        isUnLockMouse: false
      },
      mapMetadata: {
        colorField: 'value',
        radiusField: 'size',
        nameField: 'country',
        yearField: 'year',
        colorFieldLabel: 'Value',
        radiusFieldLabel: 'Size',
        yearFieldLabel: 'Year',
        colorFieldUnit: '',
        radiusFieldUnit: '%',
        colorConditions: undefined,
        tooltip: {
          value: '<b>\r\n [[name]] [[year]]\r\n</b>\r\n<br />\r\n[[colorFieldLabel]]: [[colorFieldValue]][[colorFieldUnit]]'
        }
      },
      mapData: {
        data: []
      },
      mapIndicators: [],
      mapCountries: [],
      colorCodes: {
        coverage: {
          '0-20': '#e2efd9',
          '21-40': '#c5e0b3',
          '41-60': '#a8d08d',
          '61-80': '#70ad47',
          '81-100': '#538135'
        },
        expenditure: {
          '0-4': '#deebf6',
          '5-8': '#bdd7ee',
          '9-12': '#9cc3e5',
          '13-16': '#2e75b5',
          '17-20': '#1f4e79'
        }
      },
      averageData: {
        expenditure: [
          { value: 4.9, label: 'Asia-Pacific average:', stroke: 'orange', strokeDasharray: '2,2', strokeWidth: 2 },
          { value: 12.9, label: 'Global:', stroke: 'orange', strokeDasharray: null, strokeWidth: 2 }
          // { value: 7, label: 'GDP-weighted', stroke: 'orange', strokeDasharray: null, strokeWidth: 2 }
        ],
        coverage: [
          { value: 44.1, label: 'Asia-Pacific average:', stroke: 'orange', strokeDasharray: '2,2', strokeWidth: 2 }
        ]
      },
      selectedAverageData: null,
      barChartParams: {
        autoWidth: true,
        height: 465,
        isHeightByData: true,
        isXAxisFixed: true,
        data: null,
        // orderByField: 'order',
        barOrientation: 'horizontal',
        zeroLabel: '0',
        decimalPoint: 1,
        barThickness: 15,
        averageLines: null,
        showAverageLineValueLabel: true,
        tooltipAtMousePosition: true
      },
      legendParams: { input: null },
      resizeObserver$: null
    };
  },
  computed: {
    indicatorDescription () {
      const indicator = this.mapIndicators.find(e => {
        return e.tid === this.filterPanelInputs.pageLevel.selectedObject.indicator;
      });

      if (!indicator) { return ''; }
      return indicator.field_description;
    }
  },
  mounted () {
    setTimeout(() => {
      this.activeBsTabs();
      // this.fetchListData();
      this.fetchMapData();
      const resizeObserverOptions = { skipFirst: false };
      this.resizeObserver$ = ResizeObserver.observe(this.$refs.mapWrapperContainerRef, () => {
        this.mapOptions.height = 0;
        this.adjustMapHeightByContainer();
      }, resizeObserverOptions);
    }, 250); // Wait for HTML rendering
  },
  destroyed: function () {
    if (this.resizeObserver$ !== null) ResizeObserver.unobserve(this.resizeObserver$);
  },
  methods: {
    activeBsTabs () {
      if (!this.$refs.tabListRef) { return; }
      const tabTriggerEls = this.$refs.tabListRef.querySelectorAll('.nav-link');
      tabTriggerEls.forEach(tabTriggerEl => {
        tabTriggerEl.addEventListener('click', this.showTab);
      });
    },
    adjustMapHeightByContainer () {
      const mapContainerHeight = this.$refs.maptab.offsetHeight;
      const mapTitleContainerHeight = this.$refs.mapTitleContainer.offsetHeight;
      const barContainerHeight = this.$refs.barChartRef.offsetHeight;
      const LegendContainerHeight = this.$refs.dataLegendRef.offsetHeight;

      let result = 500;

      // console.log('mapContainerHeight', mapContainerHeight);
      // console.log('mapTitleContainerHeight', mapTitleContainerHeight);
      if (this.height) {
        result = this.height;
      } else {
        result = (barContainerHeight + LegendContainerHeight) - (mapTitleContainerHeight + 20);
      }

      if (result < 100) {
        result = 500;
      }

      this.mapOptions.height = result;
    },
    showTab (event) {
      event.preventDefault();
      // const tabTrigger = new window.bootstrap.Tab(event.currentTarget);
      // this.activeTabId = tabTrigger._element.dataset.bsTarget;
      // tabTrigger.show();
      this.activeTabId = event.currentTarget.getAttribute('data-bs-target').substring(1);
    },
    async fetchMapData () {
      if (!this.mapCountries.length && !this.mapIndicators.length) {
        const mapCountries = await axios.get(this.drupalApiPath + '/map-country-taxonomies');
        if (mapCountries.data.length) {
          this.mapCountries = _.cloneDeep(mapCountries.data);
        }

        const mapIndicators = await axios.get(this.drupalApiPath + '/map-indicator-taxonomies');
        if (mapIndicators.data.length) {
          this.mapIndicators = _.cloneDeep(mapIndicators.data);
          this.buttonList = _.map(this.mapIndicators, (mind) => {
            const tempObj = {
              value: mind.tid,
              label: mind.field_display_name,
              source: mind.field_description
            };
            return tempObj;
          });
        }
      }
      this.mapOptions.height = 0;

      const filterObj = { where: {} };
      let dataArr = [];
      const tempObj = _.cloneDeep(this.filterPanelInputs.pageLevel.selectedObject);
      _.each(Object.keys(tempObj), (d) => {
        const filterValue = tempObj[d];
        if (filterValue) {
          filterObj.where[d] = { inq: filterValue.split('_') };
        }
      });

      const URL = `${this.loopBackApiPath}/spp-map-data?filter=${JSON.stringify(filterObj)}`;
      const tempData1 = await axios.get(URL);
      const selectedIndicator = this.filterPanelInputs.pageLevel.selectedObject.indicator;
      const foundIndicator = _.find(this.mapIndicators, (c) => {
        return c.tid === selectedIndicator;
      });
      const maxValue = foundIndicator.field_type === 'expenditure' ? 20 : 100;

      if (foundIndicator) {
        this.mapTitle = foundIndicator ? foundIndicator.name : '';
        this.mapUnit = foundIndicator ? foundIndicator.field_unit : '';
        this.mapMetadata.colorFieldUnit = foundIndicator ? foundIndicator.field_unit : '';
      }

      this.mapMetadata.colorConditions = _.cloneDeep(this.colorCodes[foundIndicator.field_type]);

      dataArr = tempData1.data ? tempData1.data : [];
      // console.log('dataArr', dataArr);
      dataArr = _.map(dataArr, (d) => {
        const foundCountry = _.find(this.mapCountries, (c) => {
          return c.name.replace('&#039;', "'") === d.country;
        });

        if (!foundCountry) {
          console.log('notfoundCountry test', d.country);
        }

        d.region = foundCountry ? foundCountry.field_region : null;
        d.lat = foundCountry ? foundCountry.field_lat : 0;
        d.long = foundCountry ? foundCountry.field_long : 0;
        d.color = this.getColorByScale('color', d.value, foundIndicator);
        // d.size = 25 + (25 * (d.value / maxValue));
        d.size = this.getColorByScale('size', d.value, foundIndicator);

        if (Number(d.long) > -180 && Number(d.long) < -155) {
          d.long = (Number(d.long) + 360).toString();
        }
        return d;
      });

      this.mapData = {
        data: dataArr
      };

      /* Bar Chart */
      const regionOrderMapping = {
        enea: 1,
        nca: 2,
        pacific: 3,
        sea: 4,
        sswa: 5
      };
      const sortedData = _.sortBy(dataArr, [
        e => { return -regionOrderMapping[e.region.toLowerCase()]; },
        'value'
      ]);
      const barChartData = [];
      for (let index = 0; index < sortedData.length; index++) {
        const region = index === sortedData.length - 1 || (sortedData[index].region !== sortedData[index + 1].region)
          ? sortedData[index].region
          : null;
        const fmtItem = {
          label: sortedData[index].country,
          percentage: sortedData[index].value,
          color: sortedData[index].color,
          region: region
        };
        barChartData.push(fmtItem);
      }
      this.selectedAverageData = ['Expenditure', 'Overall Coverage'].indexOf(foundIndicator.field_display_name) > -1
        ? this.averageData[foundIndicator.field_type]
        : null;
      this.barChartParams.averageLines = this.selectedAverageData
        ? this.selectedAverageData.map(e => {
          return {
            xVal: e.value,
            stroke: e.stroke,
            strokeDasharray: e.strokeDasharray,
            strokeWidth: e.strokeWidth,
            label: `${e.label} (${e.value}%)`
          };
        })
        : null;
      this.barChartParams.data = JSON.stringify({
        data: {
          tooltip: {
            value: '<strong>[[internal#label]]</strong><br>Value: [[internal#percentage]]'
          },
          // sort_order: 'DESC',
          data: barChartData
        }
      });
      const legendData = [];
      for (const [label, color] of Object.entries(this.mapMetadata.colorConditions)) {
        legendData.push({
          label: label,
          color: color
        });
      }
      this.legendParams.input = JSON.stringify({ data: legendData });
      /* /Bar Chart */

      setTimeout(() => {
        this.adjustMapHeightByContainer();
      }, 250); // Wait for HTML rendering
    },
    getColorByScale (type, value, foundIndicator) {
      const colorScale = _.cloneDeep(this.mapMetadata.colorConditions);
      let colour = 'black';
      let key = '0-20';
      let size = 20;

      if (foundIndicator.field_type === 'coverage') {
        if (value > 20 && value <= 40) {
          key = '21-40';
          size = 40;
        } else if (value > 40 && value <= 60) {
          key = '41-60';
          size = 60;
        } else if (value > 60 && value <= 80) {
          key = '61-80';
          size = 80;
        } else if (value > 80 && value <= 100) {
          key = '81-100';
          size = 100;
        }
      } else if (foundIndicator.field_type === 'expenditure') {
        key = '0-4';
        if (value > 4 && value <= 8) {
          key = '5-8';
          size = 40;
        } else if (value > 8 && value <= 12) {
          key = '9-12';
          size = 60;
        } else if (value > 12 && value <= 16) {
          key = '13-16';
          size = 80;
        } else if (value > 16 && value <= 20) {
          key = '17-20';
          size = 100;
        }
      }

      colour = colorScale[key];
      const result = type === 'color' ? colour : size;
      return result;
    },
    clickMapButton (buttonObj) {
      this.filterPanelInputs.pageLevel.selectedObject.indicator = buttonObj.value;
      this.fetchMapData();
    },
    isBarChartReady (self) {
      self.vis[0].selectAll('.y-axis .tick').each(function (d) {
        if (d.region === null) { return; }
        const $tspan = document.createElementNS('http://www.w3.org/2000/svg', 'tspan');
        $tspan.textContent = d.region;
        const $text = document.createElementNS('http://www.w3.org/2000/svg', 'text');
        $text.setAttribute('dy', this.querySelector('text').getAttribute('dy'));
        $text.setAttribute('x', -self.marginLeft);
        $text.setAttribute('text-anchor', 'start');
        $text.style.fill = '#1890FF';
        $text.prepend($tspan);
        this.prepend($text);
      });
    }
  },
  setup () {
    return {
    };
  }
};
</script>

<style>
@import url('/themes/custom/tbdtheme/assets/dist/css/style.css?r9n785');
</style>

<style scoped lang="scss">
  .text-link {
    color: blue;
  }
  .tab-button {
    text-transform: uppercase;
    background-color: white !important;
    color: #2E2E2E !important;
    font-size: 14px;
    border-radius: 0;
    &.active {
      border-bottom: 2px solid #66CC33 !important;
    }
  }
  .button-label-container {
    text-align: left;
  }
  .button-list-container {
    display: flex;
    justify-content: center;
  }
  // .button-block {
  //   display: inline-block;
  // }
  .btn-map-button {
    border-radius: 2px;
    font-weight: 400;
    border: 1px solid #D9D9D9;
    margin-right: 0.5rem;
    margin-bottom: 0.2rem;
    cursor: pointer;
    display: inline-block;
    padding: 0.4rem 1rem;
    font-size: .7rem;
    line-height: 1.7;
    letter-spacing: -.01rem;
    color: #000000;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    background-color: transparent;
    box-sizing: border-box;
    transform: translateY(0);
    transition: all .2s ease-in-out;
    &:hover {
      color: #000000;
      transform: scale(1.05);
      box-shadow: 0 10px 20px rgba(0,0,0,.12), 0 4px 8px rgba(0,0,0,.06);
    }
    &.active {
      color: #096DD9;
      // background-color: #9499a3;
      border-color: #096DD9;
      transform: translateY(0);
    }
  }
  .filter-container {
    text-align: left;
    width: 25%;
  }
  .v-select ul {
    padding: 0 !important;
    width: auto;
    min-width: 100%;
  }
  .v-select {
    font-size: 10px;
  }
  .v-select input {
    position: absolute;
  }
  .vs__dropdown-toggle {
    cursor: pointer !important;
    white-space: nowrap !important;
    overflow: hidden !important;
  }
  .popper-container {
    max-width: 300px;
    text-align: left;
    z-index: 1000;
    background: white;
    border: 1px solid grey;
    padding: 5px;
    font-size: 12px;
  }
  .map-wrapper-title-container {
    text-align: start;
  }
  .container-data-legend {
    text-align: start;
  }
  .d3-tip {
    z-index: 1000 !important;
  }
</style>
