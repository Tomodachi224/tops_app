<template>
  <div class="param-slider-container d-flex flex-row" style="min-height: 160px;">
    <!-- Table -->
    <div class="first-column pt-9 px-3">
      <table class="" style="width: 170px;">
        <tr class="fw-light fs-12 text-end border-1 border-top-0 border-start-0 border-end-0 border border-light-blue-grey1">
          <td>Benefit (% of GDP per capita)</td>
        </tr>
        <tr class="fw-light fs-12 text-end border-1 border-top-0 border-start-0 border-end-0 border border-light-blue-grey1">
          <td>Age eligibility</td>
        </tr>
        <tr class="fw-light fs-12 text-end border-1 border-top-0 border-start-0 border-end-0 border border-light-blue-grey1">
          <td>Administrative cost</td>
        </tr>
        <tr
          v-if="this.mode === 'combined'"
          class="fw-light fs-12 text-end">
          <td>Means test</td>
        </tr>
        </table>
    </div>
    <div class="config-table-container d-flex flex-row">
      <div
        v-for="(datum, datumIndex) of data"
        :key="`box_${datumIndex}`"
        class="box border border-link-text rounded-1 me-3"
        style="width: 222px;">
        <div class="box-title d-flex flex-row justify-content-between bg-link-text text-white" style="height: 24px;">
          <div class="check-box-title d-flex align-items-center justify-content-center px-1">
            <input
              class="form-check-input action m-0"
              type="checkbox"
              :name="`box-${datum.scheme}`"
              :id="`box-${datum.scheme}`"
              :value="datum.scheme"
              v-model="datum.merge_is_selected"
              v-on:change="onSchemeCheckboxChange(datum)">
            <label
              class="form-check-label action fs-16 px-1"
              :for="`box-${datum.scheme}`">
              {{getSchemeText(datum.scheme)}}
            </label>
          </div>
          <span
            class="px-1 fw-light action"
            @click="clickEdit($event, datum.scheme)">
            Edit
          </span>
        </div>
        <div class="box-table">
          <table class="w-100">
            <thead>
              <tr class="bg-light-blue-grey1">
                <th class="ps-1 fw-light text-grey-additional fs-10">Scenario:</th>
                <th v-if="datum.is_selected_s1" class="px-4 text-link-blue fs-12 text-center">A</th>
                <th v-if="datum.is_selected_s2 && mode === 'comparative'" class="px-4 text-link-blue fs-12 text-center">B</th>
              </tr>
            </thead>
            <tbody>
              <tr class="fw-light fs-16 text-center border-1 border-top-0 border-start-0 border-end-0 border border-light-blue-grey1">
                <td class=""></td>
                <td v-if="datum.is_selected_s1">{{datum.benefit_percent_s1}}</td>
                <td v-if="datum.is_selected_s2 && mode === 'comparative'">{{datum.benefit_percent_s2}}</td>
              </tr>
              <tr class="fw-light fs-16 text-center border-1 border-top-0 border-start-0 border-end-0 border border-light-blue-grey1">
                <td class=""></td>
                <td v-if="datum.is_selected_s1">{{datum.age_s1}}</td>
                <td v-if="datum.is_selected_s2 && mode === 'comparative'">{{datum.age_s2}}</td>
              </tr>
              <tr class="fw-light fs-16 text-center border-1 border-top-0 border-start-0 border-end-0 border border-light-blue-grey1">
                <td class=""></td>
                <td v-if="datum.is_selected_s1">{{datum.admin_cost_s1}}</td>
                <td v-if="datum.is_selected_s2 && mode === 'comparative'">{{datum.admin_cost_s2}}</td>
              </tr>
              <tr
                v-if="mode === 'combined'"
                class="fw-light fs-16 text-center">
                <td class=""></td>
                <td v-if="datum.is_selected_s1">{{datum.pmt_s1}}</td>
                <td v-if="datum.is_selected_s2 && mode === 'comparative'">{{datum.pmt_s2}}</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
    <!-- /Table -->
    <!-- Modal -->
    <slider-modal
      ref="sliderModalRef"
      :selected-scheme="selectedScheme"
      :data="sliderData"
      :mode-status-a="modeStatusA"
      :mode-status-b="modeStatusB"
      :selected-object-a="selectedObjectA"
      :selected-object-b="selectedObjectB"
      :position="panelPosition"
      :mode="mode"
      @selectedChanged="handleSelectChanged()"></slider-modal>
    <!-- /Modal -->
  </div>
</template>

<script>
// import VueSlider from 'vue-slider-component';
// import 'vue-slider-component/theme/default.css';
import SliderModal from '@/components/SliderModal.vue';
import _ from 'lodash';
import { getSchemeText } from '../helper';
import { mapState, mapGetters, mapActions } from 'vuex';

export default {
  components: {
    SliderModal
  },
  computed: {
    ...mapGetters('analysis', [
      'getCountries'
    ])
  },
  data: function () {
    return {
      data: [],
      sliderData: [],
      bsModal: null,
      selectedScheme: '',
      getSchemeText,
      panelPosition: {
        top: 0,
        left: 0
      },
      downloadedExistingSchemeData: {}
    };
  },
  props: {
    selectedObjectA: {
      type: Object
    },
    filtersA: {
      type: Array
    },
    modeStatusA: {
      type: Object
    },
    selectedObjectB: {
      type: Object
    },
    filtersB: {
      type: Array
    },
    modeStatusB: {
      type: Object
    },
    mode: {
      type: String
    }
  },
  watch: {
    selectedObjectA: {
      handler: function () {
        this.updateTableValue();
      },
      deep: true
    },
    selectedObjectB: {
      handler: function () {
        this.updateTableValue();
      },
      deep: true
    },
    mode: function () {
      // console.log('check', this.mode);
      // console.log('selectedObjectA', this.selectedObjectA);
    }
  },
  mounted: function () {
    this.initialize();
  },
  methods: {
    ...mapActions('analysis', [
      'getPShinyExistingSchemeByCountry',
      'getBenefitCurrencyData',
      'getBenefitPercentageData'
    ]),
    initialize: function () {
      this.formatData();
      this.formatSliderData();
      this.handlePanelCollapseStatus();
    },
    onSchemeCheckboxChange: function (datum) {
      this.selectedObjectA.scheme_details.map(d => {
        if (d.scheme === datum.scheme) {
          d.is_selected = datum.merge_is_selected;
        }
        return d;
      });
      this.selectedObjectB.scheme_details.map(d => {
        if (d.scheme === datum.scheme) {
          d.is_selected = datum.merge_is_selected;
        }
        return d;
      });
      this.handleSelectChanged();
    },
    handleSelectChanged: function () {
      this.updateTableValue();
      this.$emit('selectedChanged', {});
    },
    updateTableValue: function () {
      for (const scheme_detail of this.selectedObjectA.scheme_details) {
        const targetObj = this.data.filter(d => d.scheme === scheme_detail.scheme);
        if (targetObj.length > 0) {
          targetObj[0].benefit_percent_s1 = `${scheme_detail.benefit_percent}%`;
          targetObj[0].admin_cost_s1 = scheme_detail.ad;
          let ageText = scheme_detail.age.join('-');
          if (scheme_detail.age[1] === 100) {
            ageText = `${scheme_detail.age[0]}+`;
          }
          targetObj[0].age_s1 = ageText;
          targetObj[0].pmt_s1 = scheme_detail.pmt;
          targetObj[0].admin_cost_s1 = scheme_detail.admin_cost;
          targetObj[0].is_selected_s1 = scheme_detail.is_selected;
        }
      }

      for (const scheme_detail of this.selectedObjectB.scheme_details) {
        const targetObj = this.data.filter(d => d.scheme === scheme_detail.scheme);
        if (targetObj.length > 0) {
          targetObj[0].benefit_percent_s2 = `${scheme_detail.benefit_percent}%`;
          targetObj[0].admin_cost_s2 = scheme_detail.ad;
          let ageText = scheme_detail.age.join('-');
          if (scheme_detail.age[1] === 100) {
            ageText = `${scheme_detail.age[0]}+`;
          }
          targetObj[0].age_s2 = ageText;
          targetObj[0].pmt_s2 = scheme_detail.pmt;
          targetObj[0].admin_cost_s2 = scheme_detail.admin_cost;
          targetObj[0].is_selected_s2 = scheme_detail.is_selected;
          targetObj[0].merge_is_selected = targetObj[0].is_selected_s1 || targetObj[0].is_selected_s2;
        }
      }
      this.updateExistingSchemeData();
    },
    getBenefitCurrencyObj: async function (countryName, percentage) {
      const benefitCurrencyTemp = await this.getBenefitCurrencyData({ countryName, percentage });
      const benefitCurrency = JSON.parse(benefitCurrencyTemp[0]);
      return benefitCurrency;
    },
    formatData: function () {
      // Table data
      const obj = {
        scheme: '',
        benefit_percent_s1: '',
        age_s1: '',
        pmt_s1: '',
        admin_cost_s1: '',
        is_selected_s1: true,
        benefit_percent_s2: '',
        age_s2: '',
        pmt_s2: '',
        admin_cost_s2: '',
        is_selected_s2: true,
        merge_is_selected: true
      };

      const schemes = ['70001', '70002', '70003'];
      for (const scheme of schemes) {
        const result = _.cloneDeep(obj);
        result.scheme = scheme;
        this.data.push(result);
      }

      this.updateTableValue();
    },
    formatSliderData: function () {
      const obj = {
        scheme: '',
        tip_section_s1: [],
        tip_section_s2: [],
        existingScheme: {
          s1: 's1',
          s2: 's2'
        }
      };

      const schemes = ['70001', '70002', '70003'];
      for (const scheme of schemes) {
        const result = _.cloneDeep(obj);
        result.scheme = scheme;
        this.sliderData.push(result);
      }

      const checkboxDetailA = this.filtersA.filter(d => d.type === 'checkbox_detail');
      if (checkboxDetailA.length > 0) {
        this.sliderData.map(d => {
          const targetItem = checkboxDetailA[0].items.filter(c => c.value === d.scheme);
          if (targetItem.length > 0) {
            d.tip_section_s1 = targetItem[0].tip_sections;
          }
          return d;
        });
      }

      const checkboxDetailB = this.filtersB.filter(d => d.type === 'checkbox_detail');
      if (checkboxDetailB.length > 0) {
        this.sliderData.map(d => {
          const targetItem = checkboxDetailB[0].items.filter(c => c.value === d.scheme);
          if (targetItem.length > 0) {
            d.tip_section_s2 = targetItem[0].tip_sections;
          }
          return d;
        });
      }
    },
    async updateExistingSchemeData () {
      const countryList = _.cloneDeep(this.getCountries);
      const foundCountryS1 = _.find(countryList, (c) => { return c.tid === this.selectedObjectA.country; });
      const foundCountryS2 = _.find(countryList, (c) => { return c.tid === this.selectedObjectB.country; });

      const sList = ['s1', 's2'];
      const foundCountry = {
        s1: _.find(countryList, (c) => { return c.tid === this.selectedObjectA.country; }),
        s2: _.find(countryList, (c) => { return c.tid === this.selectedObjectB.country; })
      };

      const schemeMapping = {
        70001: 'existing_child',
        70002: 'existing_disab',
        70003: 'existing_old',
        70004: 'existing_household:'
      };

      for (const s of sList) {
        let existingSchemeData;
        if (!this.downloadedExistingSchemeData[foundCountry[s].tid]) {
          const tempFetch = await this.getPShinyExistingSchemeByCountry(foundCountry[s].name);
          if (tempFetch && tempFetch.length) {
            const formattedFetch = JSON.parse(tempFetch[0]);
            this.downloadedExistingSchemeData[foundCountry[s].tid] = formattedFetch;
            existingSchemeData = formattedFetch;
          }
        } else {
          existingSchemeData = _.cloneDeep(this.downloadedExistingSchemeData[foundCountry[s].tid]);
        }

        if (existingSchemeData) {
          _.each(this.sliderData, (sd, i) => {
            this.sliderData[i].existingScheme[s] = existingSchemeData[schemeMapping[sd.scheme]][0];
          });
        }
      }
    },
    getPanelPosition: function (event) {
      // panel width = 319px;

      const panelWidth = 319;
      const boxEl = event.currentTarget.parentElement;
      const screenWidth = window.innerWidth;
      let topPosition = boxEl.offsetTop;
      let leftPosition = boxEl.offsetLeft;

      if (screenWidth < 1227) {
        topPosition = 50;
        leftPosition = (screenWidth - panelWidth) / 2;
      } else if (screenWidth <= 319) {
        leftPosition = 0;
      }

      this.panelPosition = {
        top: topPosition,
        left: leftPosition
      };
    },
    handlePanelCollapseStatus: function () {
      // const panelHeight = 725;
      const modeVarList = ['modeStatusA', 'modeStatusB'];
      if (window.innerHeight < 976) {
        _.each(modeVarList, (modeVar) => {
          if (this[modeVar]) {
            _.each(this[modeVar], (v, k, i) => {
              _.each(v.collapseMode, (v2, mode) => {
                if (mode !== 'benefit_percent') {
                  this[modeVar][k].collapseMode[mode] = true;
                }
              });
            });
          }
        });
      }
    },
    clickEdit: function (event, schemeId) {
      this.getPanelPosition(event);
      this.selectedScheme = schemeId;
      this.$refs.sliderModalRef.bsModal.show();
    },
    orderObj: function (obj, orderField) {
      return _.orderBy(obj, orderField);
    }
  }
};

</script>

<style lang="scss">
.first-column {
  table {
    tr {
      height: 1.4rem;
    }
  }
}

.box-table {
  width: 220px;
}

.config-table-container {
  width: 100%;
  overflow: auto;
}

/* Hide scrollbar for Chrome, Safari and Opera */
.config-table-container::-webkit-scrollbar {
  display: none;
}

/* Hide scrollbar for IE, Edge and Firefox */
.config-table-container {
  -ms-overflow-style: none;  /* IE and Edge */
  scrollbar-width: none;  /* Firefox */
}

.action {
  &:hover {
    cursor: pointer;
    font-weight: 900 !important;
  }
}
</style>
