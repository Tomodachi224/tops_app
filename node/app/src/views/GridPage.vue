<template>
  <div class="grid-page-container">
    <div>
      <div class="layoutJSON">
        Displayed as <code>[x, y, w, h]</code>:
        <div class="columns">
          <div
            v-for="(item, index) in layout"
            :key="'col-item-'+ index">
            <b>{{item.i}}</b>: [{{item.x}}, {{item.y}}, {{item.w}}, {{item.h}}]
          </div>
        </div>
      </div>
      <div>
        <span
          v-for="(item, index) in breadCrumb"
          @click="clickGridItem(item)"
          :key="'bc-'+ index">
          <span v-if="index > 0"> / </span>
          {{item}}
        </span>
      </div>
      <div style="width:100%;margin-top: 10px;height:100%;">
          <grid-layout
            :layout.sync="layout"
            :col-num="16"
            :cols="{ lg: 16, md: 16, sm: 16, xs: 16, xxs: 16 }"
            :row-height="24"
            :margin="[5, 5]"
            :is-draggable="draggable"
            :is-resizable="resizable"
            :responsive="responsive"
            :vertical-compact="false"
            :use-css-transforms="true">
              <grid-item
                v-for="(item, index) in layout"
                :key="'grid-item-'+ index"
                :static="item.static"
                :x="item.x"
                :y="item.y"
                :w="item.w"
                :h="item.h"
                :i="item.i">
                  <div @click="clickGridItem(item.i)">
                    <span class="text grid-num-text">{{item.i}}</span>
                    <div v-if="pageData[item.i] && pageData[item.i].type === 'chart-section'">
                      <chart-section
                        :title="pageData[item.i].data.title"
                        :tabs="pageData[item.i].data.tabs">
                      </chart-section>
                    </div>
                    <div v-if="pageData[item.i] && pageData[item.i].type === 'info-graphic'">
                      <infographic
                        :data="pageData[item.i].data">
                      </infographic>
                    </div>
                  </div>
              </grid-item>
          </grid-layout>
      </div>
    </div>
  </div>
</template>

<script>
import axios from '@axios';
import _ from 'lodash';
import { RAPI_DOMAIN, RAPI_VERSION_URL } from '@/environment';
import { mapState, mapGetters, mapActions } from 'vuex';

import { mockGridData } from '../data/grid-data.ts';

import { GridLayout, GridItem } from 'vue-grid-layout';
import ChartSection from '@/components/ChartSection.vue';
import Infographic from '@/components/Infographic.vue';

export default {
  components: {
    GridLayout,
    GridItem,
    ChartSection,
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
      draggable: false,
      resizable: false,
      responsive: true,
      index: 0,
      // layout: [
      //   { x: 0, y: 0, w: 8, h: 24, i: '1000' },
      //   { x: 8, y: 0, w: 4, h: 8, i: '1001' },
      //   { x: 12, y: 0, w: 4, h: 8, i: '1002' },
      //   { x: 8, y: 8, w: 4, h: 8, i: '1003' },
      //   { x: 12, y: 8, w: 4, h: 8, i: '1004' },
      //   { x: 8, y: 16, w: 4, h: 8, i: '1005' },
      //   { x: 12, y: 16, w: 4, h: 4, i: '1006' },
      //   { x: 12, y: 20, w: 2, h: 4, i: '1007' },
      //   { x: 14, y: 20, w: 2, h: 4, i: '1008' }
      // ],
      layout: [
        { x: 0, y: 0, w: 16, h: 24 },
        { x: 0, y: 0, w: 16, h: 24 },
        { x: 0, y: 0, w: 16, h: 24 },
        { x: 0, y: 0, w: 16, h: 24 },
        { x: 0, y: 0, w: 16, h: 24 },
        { x: 0, y: 0, w: 16, h: 24 },
        { x: 0, y: 0, w: 16, h: 24 },
        { x: 0, y: 0, w: 16, h: 24 },
        { x: 0, y: 0, w: 16, h: 24 }
      ],
      pageData: {},
      currentPage: 'home',
      breadCrumb: ['home']
    };
  },
  mounted: function () {
    this.initialize();
    console.log('mockGridData', mockGridData);
  },
  // watch: {
  //   compareConfigs: function () {
  //     console.log('check', this.getCompareConfigs);
  //     this.mode = this.getCompareConfigs.mode;
  //     this.initialize();
  //   }
  // },
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
      this.getPageData();
    },
    getPageData () {
      const filteredData = _.filter(mockGridData, (mgd) => {
        return mgd.parent === this.currentPage;
      });

      // set default
      this.pageData = _.cloneDeep({});
      this.layout = _.chain(filteredData)
        .orderBy('id')
        .map('layout')
        .value();

      const currentLayout = _.cloneDeep(this.layout);
      _.each(currentLayout, (layout) => {
        const foundItem = _.find(mockGridData, (d) => {
          return d.id === layout.i;
        });
        if (foundItem) {
          this.pageData[foundItem.id] = foundItem;
        }
      });
    },
    clickGridItem (itemId) {
      const foundIndex = this.breadCrumb.indexOf(itemId);
      if (foundIndex > -1) {
        this.breadCrumb = this.breadCrumb.slice(0, foundIndex + 1);
      } else {
        this.breadCrumb.push(itemId);
      }

      this.currentPage = itemId;
      this.initialize();
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
// .vue-grid-layout {
//   height: auto !important;
// }
.vue-grid-item {
  overflow: auto !important;
}
//    position: relative !important;
//     width: 100% !important;
//     top: inherit !important;
//     transform: inherit !important;
// }
</style>
