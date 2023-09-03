<template>
  <div class="map-dashboard">
    <div class="map-choropleth-wrapper-container">
      <map-choropleth-wrapper></map-choropleth-wrapper>
    </div>

    <div>
      <h4>Asia and the Pacific region</h4>
      <div class="row">
        <div class="col-6">
          <filter-panel
            :selected-object="filterPanelInputs.section1.selectedObject"
            :filters="filterPanelInputs.section1.filters"
            @selectedChanged="fetchChartData('section1')">
          </filter-panel>
        </div>
        <div class="col-6">
          <div
            class="form-check form-check-inline m-0 me-3">
            <input
              class="form-check-input"
              type="checkbox"
              :checked="customColor.enable"
              v-model="customColor.enable"
              v-on:change="fetchChartData('section1')">
            <label
              class="form-check-label fw-light text-main-body-text"
              style="font-size: 15px;">Custom color</label>
          </div>
          <div v-if="customColor.enable">
            <div
              v-for="(color, colorIndex) of customColor.colorScale"
              :key="`colorBox_${colorIndex}`"
              class="color-picker-box">
              <input
                type="color"
                v-model="customColor.colorScale[colorIndex]"
                v-on:change="fetchChartData('section1')">
              <div>{{color}}</div>
            </div>
          </div>
        </div>
      </div>
      <div class="px-3">
        <chart-section
          :chartHeight="chartSectionsData.section1.chartHeight"
          :title="chartSectionsData.section1.title"
          :tabs="chartSectionsData.section1.tabs"></chart-section>
      </div>
    </div>
  </div>
</template>

<script>
import ChartSection from '@/components/ChartSection.vue';
import FilterPanel from '@/components/FilterPanel.vue';
import MapChoroplethWrapper from '@/components/MapChoroplethWrapper.vue';
import { RAPI_DOMAIN, RAPI_VERSION_URL, DRUPAL_DOMAIN, DRUPAL_API_VERSION_URL } from '@/environment';
import axios from '@axios';
import _ from 'lodash';
import { mapActions, mapGetters, mapState } from 'vuex';

export default {
  components: {
    ChartSection,
    FilterPanel,
    MapChoroplethWrapper
  },
  computed: {
    ...mapGetters('analysis', [
      'getConfigs',
      'getIndicators',
      'getMapIndicators',
      'getMapCountries'
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
      drupalApiPath: `${DRUPAL_DOMAIN}${DRUPAL_API_VERSION_URL}`,
      sectionList: ['section1'],
      filterPanelInputs: {
        section1: {
          selectedObject: {
            indicator: '150001'
          },
          filters: [
            {
              label: 'Select indicator',
              key: 'indicator',
              items: [
              ]
            }
          ]
        }
      },
      chartSectionsData: {
        section1: {
          title: '',
          tabTypes: [
            { title: 'map', type: 'map' }
          ],
          tabs: [],
          chartHeight: 500
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
        showLegend: true,
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
      customColor: {
        enable: true,
        colorScale: ['#7f58a5', '#b8a2cb', '#f1f1f1', '#97c3b3', '#33967a']
      }
    };
  },
  watch: {
  },
  mounted () {
    this.initialize();
  },
  methods: {
    ...mapActions('analysis', [
      'fetchMapCountries',
      'fetchMapIndicators'
    ]),
    initialize: function () {
      console.log('initialize');
      this.fetchListData();
    },
    async fetchListData () {
      await this.fetchMapIndicators();
      await this.fetchMapCountries();

      this.setDropdownItemFromTaxonomies();
      this.fetchSectionList();
    },
    setDropdownItemFromTaxonomies () {
      // Set country
      const indicatorList = _.cloneDeep(this.getMapIndicators);
      const mappedIndicator = _.map(indicatorList, (d) => {
        return {
          label: d.name,
          value: d.tid
        };
      });

      this.filterPanelInputs.section1.filters[0].items = mappedIndicator;
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

      const URL = `${this.loopBackApiPath}/spp-map-data?filter=${JSON.stringify(filterObj)}`;
      const tempData = await axios.get(URL);
      // console.log('tempData', tempData);
      const dataArray = tempData.data ? tempData.data : [];
      // const formattedDataArray = this.formatDataWithTaxonomy(dataArray);
      this.formatChartData(sectionName, dataArray);
    },
    formatChartData (sectionName, dataArray) {
      const indicatorList = _.cloneDeep(this.getIndicators);
      const selectedObject = this.filterPanelInputs[sectionName].selectedObject;
      const foundIndicator = _.find(indicatorList, (d) => {
        return d.tid === selectedObject.indicator;
      });
      let sectionTitle = foundIndicator ? foundIndicator.name : 'Chart title';

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

      const defaultMapConfig = {
        name: 'map-chart',
        params: {}
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
      // for (const valueType of this.getValueTypes) {
      //   valueTypeMapping[valueType.name] = { ...valueType };
      // }
      // // Include Label list to mapping
      // for (const label of this.getLabels) {
      //   valueTypeMapping[label.name] = { ...label };
      // }

      // Loop over each tab type
      _.each(selectedTabTypes, (tab) => {
        const tabType = tab.type;
        const groupByField = tab.groupByField ? tab.groupByField : 'value_type';
        const labelField = tab.labelField ? tab.labelField : 'label';
        const sectionObject = _.cloneDeep(defaultChartSectionConfig);
        sectionObject.title = tab.title;

        // getDataByChartType
        if (tabType === 'map') {
          const sectionDataObject = { data: [] };
          const tempMapMetadata = _.cloneDeep(this.mapMetadata);
          const tempMapOptions = _.cloneDeep(this.mapOptions);
          const selectedMapIndicator = this.filterPanelInputs[sectionName].selectedObject.indicator;
          const foundMapIndicator = _.find(_.cloneDeep(this.getMapIndicators), (c) => {
            return c.tid === selectedMapIndicator;
          });

          if (foundMapIndicator) {
            const mapTitle = foundMapIndicator ? foundMapIndicator.name : '';
            const mapUnit = foundMapIndicator ? foundMapIndicator.field_unit : '';
            sectionTitle = foundMapIndicator ? `${mapTitle} (${mapUnit})` : sectionTitle;
            tempMapMetadata.colorFieldUnit = foundMapIndicator ? foundMapIndicator.field_unit : '';
          }

          tempMapMetadata.colorConditions = _.cloneDeep(this.colorCodes[foundMapIndicator.field_type]);

          if (this.customColor.enable) {
            const tempKeys = Object.keys(tempMapMetadata.colorConditions);
            _.each(tempKeys, (v, i) => {
              tempMapMetadata.colorConditions[v] = this.customColor.colorScale[i];
            });
          }

          const mapData = _.map(dataArray, (d) => {
            const foundCountry = _.find(_.cloneDeep(this.getMapCountries), (c) => {
              return c.name.replace('&#039;', "'") === d.country;
            });

            if (!foundCountry) {
              console.log('notfoundCountry test', d.country);
            }

            d.lat = foundCountry ? foundCountry.field_lat : 0;
            d.long = foundCountry ? foundCountry.field_long : 0;
            d.color = this.getColorByScale('color', d.value, foundMapIndicator, tempMapMetadata.colorConditions);
            d.size = this.getColorByScale('size', d.value, foundMapIndicator, tempMapMetadata.colorConditions);

            if (Number(d.long) > -180 && Number(d.long) < -155) {
              d.long = (Number(d.long) + 360).toString();
            }
            return d;
          });

          sectionDataObject.data = mapData;

          sectionObject.chart = _.cloneDeep(defaultMapConfig);
          sectionObject.chart.params.metadata = JSON.stringify(tempMapMetadata);
          sectionObject.chart.params.chartOptions = JSON.stringify(tempMapOptions);
          sectionObject.chart.params.bubbleData = JSON.stringify(sectionDataObject);
          // sectionObject.chart.params.data = JSON.stringify({ data: sectionDataObject });
          // sectionObject.legend.params.input = JSON.stringify({ data: legendData });
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
    getColorByScale (type, value, foundIndicator, colorScale) {
      // const colorScale = _.cloneDeep(this.mapMetadata.colorConditions);
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
    }
  },
  setup () {
    return {
    };
  }
};
</script>

<style lang="scss">
.map-dashboard {
  .map-choropleth-wrapper-container {
    margin-bottom: 2rem;
    border-bottom: 1px solid lightgray;
  }
  .filter-panel-wrapper {
    justify-content: left !important;
    min-height: inherit !important;
  }
  .filter-box {
    border: none !important;
  }
  .vs__dropdown-toggle {
    height: auto;
    .vs__selected {
      font-size: inherit;
      font-weight: normal;
    }
    .vs__dropdown-menu {
      top: 48px;
    }
  }
  .color-picker-box {
    display: inline-block;
    padding-left: 5px;
  }
}
</style>
