<template>
  <div ref="mapWrapperContainerRef" class="map-wrapper-container">
    <div class="row">
      <div class="col-12 tab-content">
        <div class="row">
          <div class="col-12">
            <div
              ref="mapTitleContainer"
              class="map-wrapper-title-container">
              <h3>{{mapTitle}} <span v-if="mapUnit">( {{mapUnit}} )</span></h3>
            </div>
            <map-chart
              :choropleth-data="JSON.stringify(mapChoroplethData)"
              :chart-options="JSON.stringify(mapOptions)"
              :metadata="JSON.stringify(mapMetadata)">
            </map-chart>
          </div><!-- /.col -->
        </div><!-- /.row -->
        <div class="row">
          <div class="col-7 map-information">
            <div><b>Sources:</b> Based on ILO, 2017a; updated with information from ISSA, SSA, 2016, 2017a, 2017b, 2018; UNICEF, forthcoming (a); https://www.ssa.gov/policy/docs/progdesc/index.html (programme summaries), accessed November 2018; and MISSOC (2018): https://www.missoc.org/missoc-database/comparative-tables, accessed November 2018.
            </div>
          </div>
          <div class="col-5 map-legend">
            <chart-legend
              v-if="legendParams.input"
              v-bind="legendParams"
              class="py-1"></chart-legend>
          </div>
        </div>
      </div><!-- /.tab-content -->
    </div>
  </div>
</template>

<script>
import { ResizeObserver } from '@wc/chart-services';
import MapChart from '@wc/map-chart/map-chart.vue';
import ChartLegend from '@wc/spp-chart-legend/spp-chart-legend.vue';
import _ from 'lodash';
import 'vue-popperjs/dist/vue-popper.css';
import { choroplethMapData } from '../data/json';
import { RAPI_DOMAIN, RAPI_VERSION_URL } from '../environment.ts';

export default {
  props: {
    width: { type: Number, default: null },
    height: { type: Number, default: null }
  },
  components: {
    // BarChart,
    ChartLegend,
    MapChart
  },
  data: function () {
    return {
      loopBackApiPath: `${RAPI_DOMAIN}${RAPI_VERSION_URL}`,
      // drupalApiPath: `${DRUPAL_DOMAIN}${DRUPAL_API_VERSION_URL}`,
      drupalApiPath: 'https://thingproxy.freeboard.io/fetch/https://spp.thinkbluedata.com/api/v1',
      activeTabId: 'mapTab',
      mapTitle: 'Worldwide incidence of child benefit provision with a focus on UCGs and qUCGs',
      mapUnit: '',
      mapOptions: {
        url: 'https://geoservices.un.org/arcgis/rest/services/ClearMap_WebGray/MapServer/tile/{z}/{y}/{x}',
        tmsUrl: null,
        geoJsonUrl: null,
        geoJsonName: 'euCountriesGeoJson',
        height: this.height,
        width: this.width,
        zoom: 2.75,
        minZoom: 1,
        maxZoom: 10,
        showMarker: false,
        showBubble: true,
        // showLegend: true,
        tmsOptions: null,
        isShowControlPanel: false,
        isUnLockMouse: true,
        center: [13.173097, 113.314362],
        hideControlPanel: true,
        zoomStep: 0.01
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
      mapChoroplethData: {
        data: []
      },
      choroplethValueMapping: {
        1: {
          label: 'Contributory Schemes',
          color: '#FDDB9D',
          order: 4
        },
        2: {
          label: 'Universal Child Grant (UCG)',
          color: '#A42400',
          order: 1
        },
        3: {
          label: 'Quasi-UCG (short-term coverage)',
          color: '#EA5329',
          order: 2
        },
        4: {
          label: 'Quasi-UCG (means-tested)',
          color: '#EEA013',
          order: 3
        },
        5: {
          label: 'Quasi-UCG (means-tested)',
          color: '#EEA013',
          order: 3
        },
        6: {
          label: 'No child/family benefit scheme anchored in national legislation',
          color: '#E0E0DF',
          order: 5
        },
        7: {
          label: 'No data',
          color: '#ffffff',
          order: 6
        }
      },
      mapIndicators: [],
      mapCountries: [],
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
    adjustMapHeightByContainer () {
      const result = 650;
      this.mapOptions.height = result;
    },
    async fetchMapData () {
      this.mapOptions.height = 650;
      const resultData = _.map(_.cloneDeep(choroplethMapData), (d) => {
        d.color = this.choroplethValueMapping[d.value] ? this.choroplethValueMapping[d.value].color : 'white';
        return d;
      });

      // const mockData = [
      //   {
      //     iso: 'THA',
      //     color: 'red'
      //   }
      // ];

      this.mapChoroplethData = { data: resultData };

      let legendData = [];
      for (const [value, dat] of Object.entries(this.choroplethValueMapping)) {
        legendData.push({
          label: dat.label,
          color: dat.color,
          order: dat.order
        });
      }

      legendData = _.chain(legendData).uniqBy('label').orderBy('order').value();

      this.legendParams.input = JSON.stringify({ data: legendData });

      // setTimeout(() => {
      //   this.adjustMapHeightByContainer();
      // }, 250); // Wait for HTML rendering
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
  .map-information {
    font-weight: normal;
  }
  .map-legend {
    max-width: 415px;
  }
</style>
