<template>
  <div class="chart-section-wrapper" id="chart-section-wrapper-id" ref="container" style="height: -webkit-fill-available;">
    <div class="tab-content mt-0">
      <div ref="tag">
        <div
          v-if="tag"
          class="bg-simulator-tool-text text-white px-2 fw-bold">
          {{ tag }} Details
        </div>
        <div
          class="regional-title-container"
          v-if="regionalTitle">
          <div><h4>{{regionalTitle.title}}</h4></div>
          <div class="sub-title">{{regionalTitle.subTitle}}</div>
        </div>
        <div
          v-if="chartSectionComponents && chartSectionComponents.childrenList.length && false"
          class="button-navigation-container d-flex flex-row">
          <div
            v-for="(scButton, scIndex) of chartSectionComponents.childrenList"
            :key="`botton_navigation_${scButton.label}_${scIndex}`"
            @click="clickNavigate(scButton.value, $event)"
            v-bind:class="{ active: scButton.selected}"
            class="button-navigation-item text-dark border border-default-border fw-light me-1 px-2 rounded-1 fs-14">{{scButton.label}}</div>
        </div>
        <div
          class="chart-section-detail-panel py-1 ps-2"
          v-if="sectionDetail">
          {{sectionDetail}}
        </div>
        <div class="d-flex flex-row justify-content-between align-items-center">
          <div
            class="chart-section-filter-panel ms-2"
            v-if="chartSectionComponents &&
            chartSectionComponents.customChartFilter &&
            chartSectionComponents.customChartFilter.selectedObject">
            <filter-panel
              :space="4"
              :selected-object="chartSectionComponents.customChartFilter.selectedObject"
              :filters="chartSectionComponents.customChartFilter.filters"
              @selectedChanged="customChartFilterChanged()">
            </filter-panel>
          </div>
          <div
            v-if="(tabs[0] && tabs[0].chart.name.includes('-chart') &&
            (activeTabId === '#' + getTabId(tabs[0].title) ||
              (activeTabId === null && defaultActiveTab && defaultActiveTab.includes('-chart'))
              )) || (tabs[1] && tabs[1].chart.name.includes('-table') &&
            (activeTabId === '#' + getTabId(tabs[1].title)))">
            <div class="dropdown export-dropdown">
              <button
                type="button"
                class="btn text-dark border px-2 py-0 "
                data-bs-toggle="dropdown"
                aria-expanded="false"
              ><i class="uil uil-download-alt fs-18"></i></button>
              <ul class="dropdown-menu border p-1">
                <li>
                  <button type="button" class="dropdown-item fs-12 fw-normal" @click="downloadData('csv')">Save as .csv</button>
                </li>
                <li>
                  <button type="button" class="dropdown-item fs-12 fw-normal" @click="downloadData('png')">Save as .png</button>
                </li>
              </ul>
            </div>
          </div><!-- /.dropdown -->
        </div><!-- /.d-flex -->
      </div>
      <!-- <div v-if="isSmall === false" class="text-main-body-text px-2 chart-title" ref="title">{{ title }}</div> -->
      <div
        v-for="(tab, tabIndex) of tabs"
        :key="`tabpanel_${tabIndex}`"
        :id="getTabId(tab.title)"
        class="tab-pane fade"
        v-bind:class="{
          'hide-content': isShowContent === 0,
          'show active': tab.active
        }"
        role="tabpanel"
        :aria-labelledby="tab.title + '-tab'">
        <div class="row w-100 m-0 border-bottom border-light-blue-grey2">
          <div
            v-if="isSmall === false"
            class="text-main-body-text px-2 chart-title"
            ref="title">
            <span v-if="!tab.customTitle">{{ title }}</span>
            <span v-if="tab.customTitle">{{ tab.customTitle }}</span>
          </div>
          <div :style="`height: ${chartBoxHeight}px; overflow: overlay;`">
            <components
              v-if="(isContainerSizeReady && activeTabId === '#' + getTabId(tab.title)) || forceRenderChart"
              ref="chart"
              :is="tab.chart.name"
              v-bind="tab.chart.params"
            ></components>
          </div>
          <div v-if="tab.insight" class="insight-container text-main-body-text bg-light-blue-grey1" ref="insight">
            <div class="d-flex flex-row align-items-center fw-bold p-2 py-1">
              <i class="uil uil-lightbulb-alt me-1"></i>
              Data insights
            </div>
            <div
              v-html="tab.insight"
              class="fw-light p-2 py-1"
              :style="`max-height: ${setInsightBoxHeight}px;`"
              style="line-height: 1rem; overflow-y: auto;">
            </div>
          </div>
          <div v-if="tab.legend" class="text-main-body-text chart-legend" ref="legend">
            <div class="d-flex flex-row align-items-center fw-bold p-2 py-1">
              <i class="uil uil-list-ul me-1"></i>
              Data&nbsp;legend
            </div>
            <div class="d-flex flex-row p-2 py-1 chart-legend-container" style="max-height: 46px; overflow-y: auto;">
              <components
                :is="tab.legend.name"
                v-bind="tab.legend.params"
                @onLegendItemMouseOver="function (legendItem) {
                  onLegendItemMouseOver(tab, legendItem)}"
                @onLegendItemClick="function (legendItem) {
                  onLegendItemClick(tab, legendItem)}"
                class="py-1"
              ></components>
              <div
                v-if="tab.additionalLegends"
                class="d-flex flex-row align-items-center">
                <div
                  v-for="(additionalLegend, aLegendIndex) of tab.additionalLegends"
                  :key="`additional_legend_${aLegendIndex}`"
                  class="me-5">
                  <svg width="30" :height="additionalLegend.strokeWidth">
                    <line
                      x1="0"
                      y1="0"
                      x2="30"
                      y2="0"
                      :stroke="additionalLegend.stroke"
                      :stroke-dasharray="additionalLegend.strokeDasharray"
                      :stroke-width="additionalLegend.strokeWidth * 2"
                    />
                  </svg>
                  <span class="ms-1 fw-light fs-14">{{ additionalLegend.label }}</span>
                </div>
              </div>
            </div>
          </div>
          <div
            v-if="tab.regionalInsight"
            class="chart-regional-insight"
            ref="regionalInsight">
            <div class="d-flex flex-row align-items-center fw-bold p-2 py-1 text-main-body-text">
              <i class="uil uil-lightbulb-alt me-1"></i>
              Data insights
            </div>
            <div
              class="regional-insight-content"
              v-html="tab.regionalInsight">
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="chart-section-footer px-1 d-flex flex-row justify-content-between align-items-center">
      <ul v-if="showTabs && isSmall === false" ref="tabs" class="nav pb-2" role="tablist" style="height: 56px;">
        <li
          v-for="(tab, tabIndex) of tabs"
          :key="`tab_${tabIndex}`"
          class="nav-item"
          role="presentation">
          <button
            :id="`tab-${tab.title}`"
            class="nav-link border-0 tab-button"
            :class="tab.active === true ? 'active' : ''"
            type="button"
            role="tab"
            :aria-controls="tab.title"
            aria-selected="true"
            :data-bs-target="`#${getTabId(tab.title)}`"
          >{{ tab.title }}</button>
        </li>
      </ul>
      <div
        v-if="chartSectionComponents && chartSectionComponents.child && false"
        class="btn btn-sm text-white bg-link-text d-flex align-items-center justify-content-end w-auto p-0 px-2 m-0 rounded-1"
        @click="clickNavigate(chartSectionComponents.child, $event)">
        <span class="fs-16">Advanced settings</span>
        <i class="text-white fw-normal uil uil-arrow-right display-6"></i>
      </div>
      <div
        v-if="chartSectionComponents && chartSectionComponents.parent && false"
        class="btn btn-sm text-white bg-link-text d-flex align-items-center justify-content-end w-auto p-0 px-2 m-0 rounded-1"
        @click="clickNavigate(chartSectionComponents.parent, $event)">
        <i class="text-white fw-normal uil uil-arrow-left display-6"></i>
        <span class="fs-16">Back</span>
      </div>
    </div>
  </div>
</template>

<script>
import '@wc/chart-services/css/tooltip.css';

import FilterPanel from '@/components/FilterPanel.vue';
import BarChart from '@wc/bar-chart/bar-chart.vue';
import DataTable from '@wc/data-table/data-table.vue';
import LollipopChart from '@wc/lollipop-chart/LollipopChart.vue';
import MultiLineChart from '@wc/line-chart/spp-multi-line-chart.vue';
import MapChart from '@wc/map-chart/map-chart.vue';
import ChartLegend from '@wc/spp-chart-legend/spp-chart-legend.vue';
import { exportImage } from '@wc/utility/export-chart.js';
import csvDownload from 'json-to-csv-export';
import _ from 'lodash';
import { initPopover } from '../libs/popover';
import DataSource from './DbDataSource.vue';
import Paragraph from './DbParagraph.vue';

export default {
  components: {
    BarChart,
    ChartLegend,
    LollipopChart,
    MultiLineChart,
    MapChart,
    DataTable,
    DataSource,
    Paragraph,
    FilterPanel
  },
  props: {
    title: {
      type: String,
      default: ''
    },
    subtitle: {
      type: String
    },
    regionalTitle: {
      type: Object
    },
    tag: {
      type: String
    },
    chart: {
      type: String
    },
    isSmall: {
      type: Boolean,
      default: false
    },
    showTabs: {
      type: Boolean,
      default: true
    },
    tabs: {
      type: Array
    },
    forceRenderChart: {
      type: Boolean,
      default: false
    },
    forceChartBoxHeight: {
      type: Number
    },
    chartSectionComponents: {
      type: Object,
      default: function () {
        return {
          parent: '', // section1
          child: '', // poverty1
          childrenList: [], // [{label: 'Detail Chart', value: 'poverty1', selected: 'true'}]
          customChartFilter: undefined
        };
      }
    },
    sectionDetail: {
      type: String
    },
    rawData: { type: Array, default: () => [] }
  },
  data: function () {
    return {
      uniqNum: (Math.random() + 1).toString(16).substring(2, 10),
      chartBoxHeight: 100,
      setInsightBoxHeight: 47,
      insightBoxHeight: 0,
      legendBoxHeight: 0,
      activeTabId: null,
      isShowContent: undefined,
      tempInsightBoxHeight: undefined,
      tempLegendBoxHeight: undefined,
      defaultActiveTab: null,
      isContainerSizeReady: false
    };
  },
  watch: {
    tabs: function () {
      setTimeout(() => {
        this.activeBsTabs();
        this.setContainerSize();
        initPopover();
      }, 50); // Wait for HTML rendering
    }
    // chartHeight: function () {
    //   if (this.chartHeight) {
    //     this.chartBoxHeight = this.chartHeight;
    //   }
    // }
  },
  mounted () {
    this.initialize();
  },
  methods: {
    initialize: function () {
      if (this.activeTabId == null) {
        const temp = _.find(this.tabs, (d) => d.active);
        this.defaultActiveTab = temp ? temp.chart.name : null;
      }
      this.setContainerSize();
      this.activeBsTabs();
      initPopover();
    },
    setContainerSize: function () {
      this.isShowContent = 0;
      this.setInsightBoxHeight = 47;
      const containerHeight = this.$refs.container ? this.$refs.container.offsetHeight : 0;
      const tagHeight = this.$refs.tag ? this.$refs.tag.offsetHeight : 0;
      let insightBoxHeight = 0;
      let legendBoxHeight = 0;
      let titleHeight = 0;
      if (this.isSmall === false) {
        if (this.$refs.insight) {
          if (Array.isArray(this.$refs.insight) && this.$refs.insight.length) {
            insightBoxHeight = this.$refs.insight[0].offsetHeight;
          } else {
            insightBoxHeight = this.$refs.insight.offsetHeight ? this.$refs.insight.offsetHeight : insightBoxHeight;
          }
        }

        if (this.$refs.title) {
          if (Array.isArray(this.$refs.title) && this.$refs.title.length) {
            titleHeight = this.$refs.title[0].offsetHeight;
          } else {
            titleHeight = this.$refs.title.offsetHeight ? this.$refs.title.offsetHeight : insightBoxHeight;
          }
        }

        if (this.$refs.legend) {
          if (Array.isArray(this.$refs.legend) && this.$refs.legend.length) {
            legendBoxHeight = this.$refs.legend[0].offsetHeight;
          } else {
            legendBoxHeight = this.$refs.legend.offsetHeight ? this.$refs.legend.offsetHeight : legendBoxHeight;
          }
        }

        if (!this.tempInsightBoxHeight) {
          this.tempInsightBoxHeight = insightBoxHeight;
        }

        if (!this.tempLegendBoxHeight) {
          this.tempLegendBoxHeight = legendBoxHeight;
        }

        // const insightBoxHeight = this.$refs.insight && Array.isArray(this.$refs.insight) && this.$refs.insight.length ? this.$refs.insight[0].offsetHeight : this.$refs.insight.offsetHeight;
        // const legendBoxHeight = this.$refs.legend && Array.isArray(this.$refs.legend) && this.$refs.legend.length ? this.$refs.legend[0].offsetHeight : this.$refs.legend.offsetHeight;
        const tabHeight = this.$refs.tabs ? this.$refs.tabs.offsetHeight : 0;
        // const titleHeight = this.$refs.title.offsetHeight;
        this.chartBoxHeight = this.forceChartBoxHeight ? this.forceChartBoxHeight : containerHeight - (this.tempInsightBoxHeight + this.tempLegendBoxHeight + tagHeight + tabHeight + titleHeight + 2);
      } else {
        this.chartBoxHeight = this.forceChartBoxHeight ? this.forceChartBoxHeight : containerHeight - tagHeight;
      }

      // Adjust chart size
      this.isShowContent = new Date().getTime();
      let container = document;
      if (this.regionalTitle) {
        container = this.$refs.container;
      }

      const findAvailableChart = container.getElementsByClassName('container-tbd-chart');
      if (findAvailableChart.length) {
        let tempSize = 150;
        _.each(findAvailableChart, (fa) => {
          if (fa.offsetHeight > tempSize) {
            tempSize = fa.offsetHeight;
          }
        });
        const realChartSize = tempSize;
        const tabHeight = this.$refs.tabs ? this.$refs.tabs.offsetHeight : 0;
        // const titleHeight = this.$refs.title.offsetHeight;

        if (!this.forceChartBoxHeight) {
          if (this.chartBoxHeight > realChartSize) {
            this.chartBoxHeight = realChartSize;
          } else if (realChartSize > this.chartBoxHeight) {
            this.chartBoxHeight = realChartSize;
          }
        }

        const sizeUsed = (this.chartBoxHeight + this.tempInsightBoxHeight + this.tempLegendBoxHeight + tagHeight + tabHeight + titleHeight + 2);
        const remainingForInsight = containerHeight - sizeUsed;
        if (remainingForInsight > 0) {
          this.setInsightBoxHeight = this.setInsightBoxHeight + remainingForInsight - 30;
        }

        // // Adjust back to chart
        setTimeout(() => {
          const findTabContentSize = container.getElementsByClassName('tab-content')[0].offsetHeight;
          const findFooterSize = container.getElementsByClassName('chart-section-footer')[0].offsetHeight;
          const remainingForChart = containerHeight - (findTabContentSize + findFooterSize);

          if (this.forceChartBoxHeight) {
            this.chartBoxHeight = this.forceChartBoxHeight;
          } else if (remainingForChart > 0) {
            this.chartBoxHeight = this.chartBoxHeight + remainingForChart;
          }
          this.isContainerSizeReady = true;
        }, 50); // Wait for HTML rendering
      }
    },
    getTabId: function (title) {
      return `${title}_${this.uniqNum}`;
    },
    activeBsTabs: function () {
      if (this.$refs.tabs === undefined) { return; }
      const tabTriggerEls = this.$refs.tabs.querySelectorAll('.nav-link');
      tabTriggerEls.forEach(tabTriggerEl => {
        tabTriggerEl.addEventListener('click', this.showTab);
        if (tabTriggerEl.classList.contains('active') === true) {
          this.activeTabId = tabTriggerEl.dataset.bsTarget;
        }
      });
    },
    showTab: function (event) {
      const tabTrigger = new window.bootstrap.Tab(event.currentTarget);
      this.activeTabId = tabTrigger._element.dataset.bsTarget;
      // console.log(this.activeTabId);
      // console.log(this.$refs.tabs);
      event.preventDefault();
      tabTrigger.show();
      setTimeout(() => {
        this.setContainerSize();
        this.$emit('chartSelectedTabChanged', _.cloneDeep(this.activeTabId).split('_')[0]);
        initPopover();
      }, 270); // Wait for HTML rendering
    },
    clickNavigate: function (pageName, event) {
      this.$emit('clickNavigate', { pageName, event });
    },
    customChartFilterChanged: function () {
      this.$emit('chartCustomFilterChanged', {
        selectedObject: this.chartSectionComponents.customChartFilter.selectedObject,
        section: this.chartSectionComponents.customChartFilter.section
      });
    },
    onLegendItemClick: function (tab, legendItem) {
      // console.log('onLegendItemClick ===', tab, legendItem);
      this.$emit('onLegendItemClick', { name: tab.name, item: legendItem });
    },
    onLegendItemMouseOver: function (tab, legendItem) {
      // console.log('onLegendItemMouseOver', tab, legendItem);
      this.$emit('onLegendItemMouseOver', { name: tab.name, item: legendItem });
    },
    downloadData (type) {
      if (type === 'csv') {
        this.downloadCSV();
        return;
      }
      if (type === 'png') {
        this.downloadPNG();
      }
    },
    downloadCSV () {
      csvDownload({
        data: this.rawData,
        filename: this.title ?? 'chart-data',
        delimiter: ','
      });
    },
    downloadPNG () {
      // identify dropdown selections
      const selectedObj = this.chartSectionComponents.customChartFilter.selectedObject;
      const filters = this.chartSectionComponents.customChartFilter.filters;
      const subTitleArr = [];
      for (const property in selectedObj) {
        const tempObj = _.find(filters, (d) => d.key === property);
        const temp = tempObj ? _.find(tempObj.items, (d) => d.value === selectedObj[property]) : null;
        if (temp) subTitleArr[tempObj.order] = temp.label;
      }
      setTimeout(() => {
        // const $container = document.getElementById('chart-section-wrapper-id');\
        const $container = this.$refs.container.cloneNode(true);
        const $title = $container.querySelector('.chart-title');
        const $regionalTitle = $container.querySelector('.regional-title-container');
        const $titleFull = document.createElement('div');
        let fileName = $title.innerText;
        if ($regionalTitle) {
          $titleFull.appendChild($regionalTitle.cloneNode(true));
        } else {
          $titleFull.appendChild($title.cloneNode(true));
          if (subTitleArr.length > 0) { // use current selections as subtitle
            const $subTitle = document.createElement('div');
            $subTitle.innerText = subTitleArr.join(', ');
            $subTitle.style.fontWeight = '500';
            $subTitle.style.fontSize = '12px';
            $subTitle.style.marginLeft = '10px';
            $titleFull.appendChild($subTitle);
            fileName += ' - ' + subTitleArr.join(', ');
          }
        }
        const $chart = $container.querySelector('.container-chart svg');
        const $chartAxis = $container.querySelector('.container-x-axis');
        const $completeChart = document.createElement('div');
        const $source = document.createElement('div');
        $source.innerText = 'Source: ESCAP Social Protection Tool. Available at https://spot.unescap.org';
        $source.style.fontWeight = '400';
        $source.style.fontSize = '14px';
        $source.style.marginLeft = '10px';
        $source.style.marginTop = '20px';
        let $legend = null;
        const $elStyles = [];
        if ($chart) {
          $completeChart.appendChild($chart);
          if ($chartAxis) {
            $completeChart.appendChild($chartAxis);
          }
          $legend = $container.querySelector('.chart-legend');
        } else {
          const $tableEl = document.createElement('table');
          $tableEl.id = 'exportTable';
          $tableEl.style.cssText = 'margin-left:10px; font-weight: 400; font-size: 11px; border-collapse: collapse;';
          const $tableHeader = $container.querySelector('.dataTables_scrollHead table thead');
          $tableEl.appendChild($tableHeader);
          const $tableBody = $container.querySelector('.dataTables_scrollBody table tbody');
          $tableEl.appendChild($tableBody);
          $completeChart.appendChild($tableEl);
          const $elStyle = document.createElement('style');
          $elStyle.appendChild(document.createTextNode('#exportTable th, #exportTable td {border: 1px solid #DDD; padding: 5px;}'));
          $elStyles.push($elStyle);
        }
        $completeChart.appendChild($source);

        const imageWidth = Number($chart.getAttribute('width'));
        exportImage({
          $styles: $elStyles,
          $title: $titleFull,
          $chart: $completeChart,
          $legend: $legend
          // $logo: '/themes/custom/tbdtheme/assets/dist/img/UNESCAP75.png'
        }, {
          width: imageWidth,
          fileName: fileName,
          exportDelay: 2500
        }).then(() => {
          console.log('DOWNLOAD complete');
        });
      }, 1000); // Waiting for legend panel open
    }
  }
};
</script>

<style lang="scss">
  .chart-section-wrapper {
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
    .row>* {
      padding: 0;
    }
    .button-navigation-item {
      cursor: pointer;
      &:hover {
        transform: scale(1.05);
        box-shadow: 0 10px 20px rgba(0,0,0,.12), 0 4px 8px rgba(0,0,0,.06);
      }
      &.active {
        color: #096DD9 !important;
        border-color: #096DD9 !important;
        transform: translateY(0);
      }
    }
    .hide-content {
      visibility: hidden;
    }
  }
  .chart-section-filter-panel {
    font-size: 10px;
    .filter-panel-wrapper {
      min-height: 50px !important;
      margin-left: -5px;
      margin-bottom: 5px;
    }
    .filter-box {
      border: none !important;
    }
    .vs__dropdown-toggle {
      white-space: nowrap!important;
      overflow: hidden!important;
      height: auto;
      width: 100px !important;
      .vs__selected {
        font-size: inherit;
        font-weight: normal;
      }
      .vs__dropdown-menu {
        top: 48px;
      }
    }
  }

  @supports (-moz-appearance:none) {
    .chart-section-wrapper {
      height: 100% !important;
    }
  }

  .regional-title-container {
    margin-top: 5px;
    margin-bottom: 10px;
    h4 {
      color: #449945;
      margin-bottom: 0;
    }
    .sub-title {
      color: #C7C7C7;
      font-size: 15px;
      font-weight: normal;
      line-height: 1;
    }
  }
  .chart-regional-insight {
    margin-bottom: 25px;
    .regional-insight-content {
      font-weight: normal;
      margin-left: 10px;
    }
  }
</style>
