<template>
  <div
    ref="modalRef"
    class="modal fade"
    id="modalSlider"
    tabindex="-1"
    aria-labelledby="modalSliderLabel"
    aria-hidden="true"
    :style="`top: ${position.top}px; left: ${position.left}px;`">
    <div class="modal-dialog m-0">
      <div v-if="dataObj" class="modal-content border-1 border border-link-text rounded-1" style="width: 319px;">
        <div class="m-title d-flex align-items-center justify-content-between ps-2 pe-1 fs-16 bg-link-text text-white" style="height: 24px;">
          <span id="modalSliderLabel">{{ getSchemeText(dataObj.scheme) }}</span>
          <button type="button" class="btn-close text-white action" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="m-content">
          <div v-if="mode==='comparative'" class="d-flex flex-row py-2 px-2 justify-content-between">
            <!-- Scenario -->
            <span
              :class="`border-1 rounded-pill text-center fs-14 ${getScenarioButtonClass(dataObj.scheme, 's1')}`"
              style="width: 140px;"
              @click="updateSelectedScenario($event, dataObj.scheme, 's1')">
              <input
                v-if="selectedObject.s1 && selectedObject.s1.scheme_details"
                class="form-check-input action"
                type="checkbox"
                :name="`box-${dataObj.scheme}-s1`"
                :id="`box-${dataObj.scheme}-s1`"
                :value="dataObj.scheme"
                v-model="selectedObject.s1.scheme_details.filter(d => d.scheme === dataObj.scheme)[0].is_selected"
                @click.capture.stop
                v-on:change="onScenarioCheckboxChange($event, dataObj.scheme, 's1', selectedObject.s1.scheme_details.filter(d => d.scheme === dataObj.scheme)[0].is_selected)">
              <label
                class="form-check-label action px-1">
                Scenario A
              </label>
            </span>
            <span
              :class="`border-1 rounded-pill text-center fs-14 ${getScenarioButtonClass(dataObj.scheme, 's2')}`"
              style="width: 140px;"
              @click="updateSelectedScenario($event, dataObj.scheme, 's2')">
              <input
                v-if="selectedObject.s2 && selectedObject.s2.scheme_details"
                class="form-check-input action"
                type="checkbox"
                :name="`box-${dataObj.scheme}-s2`"
                :id="`box-${dataObj.scheme}-s2`"
                :value="dataObj.scheme"
                v-model="selectedObject.s2.scheme_details.filter(d => d.scheme === dataObj.scheme)[0].is_selected"
                @click.capture.stop
                v-on:change="onScenarioCheckboxChange($event, dataObj.scheme, 's2', selectedObject.s2.scheme_details.filter(d => d.scheme === dataObj.scheme)[0].is_selected)">
              <label
                class="form-check-label action px-1">
                Scenario B
              </label>
            </span>
            <!--/ Scenario -->
          </div>
          <div
            v-for="(section, sectionIndex) of orderObj(dataObj[`tip_section_${scenarioMode[dataObj.scheme]}`], 'order')"
            :key="`section_${dataObj.scheme}_${sectionIndex}`">
            <div
              v-if="(modeStatus[scenarioMode[dataObj.scheme]][dataObj.scheme].collapseMode[section.name] === false) && ((!section.is_hide_in_comparative) || (section.is_hide_in_comparative && mode === 'combined'))">
              <!-- Title -->
              <div class="bg-light-blue-grey1 d-flex flex-row">
                <!-- Default -->
                <p v-if="!section.edit_type" class="text-main-body-text text-start fw-bold p-1 ps-2 pb-0 mb-1 flex-grow-1">{{section.title}}</p>
                <div v-if="section.editable && !section.edit_type" class="d-flex align-items-center">
                  <span
                    v-if="modeStatus[scenarioMode[dataObj.scheme]][dataObj.scheme].editMode[section.name] === false"
                    class="edit-btn p-1 pe-2 text-link-text"
                    @click="onClickEdit(dataObj.scheme, section, true, scenarioMode[dataObj.scheme])">Edit</span>
                  <span
                    v-if="modeStatus[scenarioMode[dataObj.scheme]][dataObj.scheme].editMode[section.name] === true"
                    class="edit-btn p-1 pe-2 text-link-text"
                    @click="onClickEdit(dataObj.scheme, section, false, scenarioMode[dataObj.scheme])">Slider</span>
                </div>
                <!-- /Default -->
                <!-- Currency -->
                <p
                  v-if="modeStatus[scenarioMode[dataObj.scheme]][dataObj.scheme].editMode[section.name] === false && section.edit_type === 'benefit_currency'"
                  class="text-main-body-text text-start fw-bold p-1 ps-2 pb-0 mb-1 flex-grow-1">
                  {{section.title}}
                </p>
                <p
                  v-if="modeStatus[scenarioMode[dataObj.scheme]][dataObj.scheme].editMode[section.name] === true && section.edit_type === 'benefit_currency' && selectedObject[scenarioMode[dataObj.scheme]]"
                  class="text-main-body-text text-start fw-bold p-1 ps-2 pb-0 mb-1 flex-grow-1">
                  {{getCurrencyText(section.title_back, selectedObject[scenarioMode[dataObj.scheme]].country_obj)}}
                </p>
                <div v-if="section.editable && section.edit_type === 'benefit_currency'" class="d-flex align-items-center">
                  <span
                    v-if="modeStatus[scenarioMode[dataObj.scheme]][dataObj.scheme].editMode[section.name] === false && selectedObject[scenarioMode[dataObj.scheme]]"
                    class="edit-btn p-1 pe-2 text-link-text"
                    @click="onClickEdit(dataObj.scheme, section, true, scenarioMode[dataObj.scheme])">
                    {{getCurrencyText(section.edit_title, selectedObject[scenarioMode[dataObj.scheme]].country_obj)}}
                  </span>
                  <span
                    v-if="modeStatus[scenarioMode[dataObj.scheme]][dataObj.scheme].editMode[section.name] === true && selectedObject[scenarioMode[dataObj.scheme]].scheme_details.filter(s => s.scheme === dataObj.scheme)[0].benefit_currency < getCurrencyRange(selectedObject[scenarioMode[dataObj.scheme]].country_obj.name, dataObj.scheme).max"
                    class="edit-btn p-1 pe-2 text-link-text"
                    @click="onClickEdit(dataObj.scheme, section, false, scenarioMode[dataObj.scheme])">
                    {{section.edit_title_back}}
                  </span>
                </div>
                 <!-- /Currency -->
                <button
                  v-if="modeStatus[scenarioMode[dataObj.scheme]][dataObj.scheme].collapseMode[section.name] === false"
                  type="button"
                  class="close-btn border-0"
                  @click="onClickCollapse($event, dataObj.scheme, section, true, scenarioMode[dataObj.scheme])">
                  <i class="uil uil-multiply text-primary" style="font-size: 18px;"></i>
                </button>
              </div>
              <!-- /Title -->
              <!-- Toggle -->
              <div v-if="section.toggleable === true">
                <div class="form-check form-check-inline mx-2 mt-1">
                  <input
                    class="form-check-input"
                    type="checkbox"
                    :name="`toggle_${dataObj.scheme}_${section.name}`"
                    :id="`toggle_${dataObj.scheme}_${section.name}`"
                    @change="handleToggleChanged(section.name,
                      modeStatus[scenarioMode[dataObj.scheme]][dataObj.scheme].toggleMode[section.name],
                      scenarioMode[dataObj.scheme],
                      dataObj.scheme,
                      selectedObject[scenarioMode[dataObj.scheme]].scheme_details.filter(s => s.scheme === dataObj.scheme)[0][section.name])"
                    v-model="modeStatus[scenarioMode[dataObj.scheme]][dataObj.scheme].toggleMode[section.name]"
                    :checked="getToggleStatus(scenarioMode[dataObj.scheme], dataObj.scheme, section.name)">
                  <label
                    class="form-check-label"
                    :for="`toggle_${dataObj.scheme}_${section.name}`">{{section.toggle_text}}</label>
                </div>
              </div>
              <div v-if="(!section.toggleable) || (section.toggleable === true && modeStatus[scenarioMode[dataObj.scheme]][dataObj.scheme].toggleMode[section.name] === true)">
                <!-- Inner Title -->
                <div v-if="section.inner_title">
                  <p class="text-main-body-text text-start fw-bold p-1 ps-2 pb-0 mb-1">{{section.inner_title}}</p>
                </div>
                <!-- /Inner Title -->
                <!-- Slider -->
                <div
                  v-if="modeStatus[scenarioMode[dataObj.scheme]][dataObj.scheme].editMode[section.name] === false
                    && selectedObject[scenarioMode[dataObj.scheme]]
                    && selectedObject[scenarioMode[dataObj.scheme]].scheme_details
                    && section.slider_settings"
                  class="px-3 py-6 pt-8">
                  <vue-slider
                  :min="section.slider_settings.min"
                  :max="section.slider_settings.max"
                  :interval="section.slider_settings.interval"
                  :tooltip="'always'"
                  :lazy="true"
                  :enable-cross="false"
                  :adsorb="false"
                  :dot-style="{ background: '#DFE2EB', border: '2px solid #66CC33' }"
                  :process-style="{ background: '#66CC33'}"
                  :tooltip-style="{ background: '#66CC33', borderColor: '#66CC33'}"
                  :step-style="{ display: 'none'}"
                  :rail-style="{ background: '#DFE2EB'}"
                  :marks="section.slider_settings.marks"
                  v-model="selectedObject[scenarioMode[dataObj.scheme]].scheme_details.filter(s => s.scheme === dataObj.scheme)[0][section.name]"
                  @change="handleSelectChanged()"></vue-slider>
                </div>
                <!-- /Slider -->
                <!-- Shortcut -->
                <div
                  v-if="modeStatus[scenarioMode[dataObj.scheme]][dataObj.scheme].editMode[section.name] === false && section.shortcut_marks"
                  class="d-flex flex-row p-2">
                  <div
                    v-for="(shortcut, shortcutIndex) of section.shortcut_marks"
                    :key="`section_${dataObj.scheme}_${sectionIndex}_${shortcutIndex}`"
                    class="shortcut-btn pe-2"
                    @click="onClickShortcut(dataObj.scheme, section, shortcut, scenarioMode[dataObj.scheme])">
                    <img :src="shortcut.thumbnail" class="pe-1" /><span class="text-grey-additional">{{shortcut.name}}</span>
                  </div>
                </div>
                <!-- /Shortcut -->
                <!-- Edit -->
                <div
                  v-if="modeStatus[scenarioMode[dataObj.scheme]][dataObj.scheme].editMode[section.name] === true && !section.edit_type">
                  <div
                    v-if="Array.isArray(selectedObject[scenarioMode[dataObj.scheme]].scheme_details.filter(s => s.scheme === dataObj.scheme)[0][section.name])"
                    class="d-flex flex-row align-items-center">
                    <div class="d-flex flex-column m-2 flex-grow-1">
                      <label
                      :for="`section_${dataObj.scheme}_${sectionIndex}_${shortcutIndex}_edit`"
                      class="form-label text-start text-grey-additional">From</label>
                      <input
                        type="number"
                        class="form-control"
                        :name="`section_${dataObj.scheme}_${sectionIndex}_${shortcutIndex}_edit`"
                        :min="section.slider_settings.min"
                        :max="section.slider_settings.max"
                        v-on:change="inputNumberValidation($event, dataObj.scheme, section, section.slider_settings.min, 0, scenarioMode[dataObj.scheme])"
                        v-model.number="selectedObject[scenarioMode[dataObj.scheme]].scheme_details.filter(s => s.scheme === dataObj.scheme)[0][section.name][0]">
                    </div>
                    <span class="text-grey-additional">-</span>
                    <div class="d-flex flex-column m-2 flex-grow-1">
                      <label
                        :for="`section_${dataObj.scheme}_${sectionIndex}_${shortcutIndex}_edit`"
                        class="form-label text-start text-grey-additional">To</label>
                      <input
                        type="number"
                        class="form-control"
                        :name="`section_${dataObj.scheme}_${sectionIndex}_${shortcutIndex}_edit`"
                        :min="section.slider_settings.min"
                        :max="section.slider_settings.max"
                        v-on:change="inputNumberValidation($event, dataObj.scheme, section, section.slider_settings.max, 1, scenarioMode[dataObj.scheme])"
                        v-model.number="selectedObject[scenarioMode[dataObj.scheme]].scheme_details.filter(s => s.scheme === dataObj.scheme)[0][section.name][1]">
                    </div>
                  </div>
                  <div
                    v-if="Array.isArray(selectedObject[scenarioMode[dataObj.scheme]].scheme_details.filter(s => s.scheme === dataObj.scheme)[0][section.name]) === false"
                    class="d-flex flex-column m-2">
                    <label
                      :for="`section_${dataObj.scheme}_${sectionIndex}_${shortcutIndex}_edit`"
                      class="form-label text-start text-grey-additional">Enter exact amount</label>
                    <input
                      type="number"
                      class="form-control"
                      :name="`section_${dataObj.scheme}_${sectionIndex}_${shortcutIndex}_edit`"
                      :min="section.slider_settings.min"
                      :max="section.slider_settings.max"
                      v-on:change="inputNumberValidation($event, dataObj.scheme, section, section.slider_settings.min, undefined, scenarioMode[dataObj.scheme])"
                      v-model.number="selectedObject[scenarioMode[dataObj.scheme]].scheme_details.filter(s => s.scheme === dataObj.scheme)[0][section.name]">
                  </div>
                </div>
                <!-- /Edit -->
                <!-- Edit Currency -->
                <div
                  v-if="modeStatus[scenarioMode[dataObj.scheme]][dataObj.scheme].editMode[section.name] === true && section.edit_type === 'benefit_currency'">
                  <div
                    v-if="selectedObject[scenarioMode[dataObj.scheme]] && Array.isArray(selectedObject[scenarioMode[dataObj.scheme]].scheme_details.filter(s => s.scheme === dataObj.scheme)[0][section.name]) === false"
                    class="d-flex flex-column m-2">
                    <label
                      :for="`section_${dataObj.scheme}_${sectionIndex}_${shortcutIndex}_edit`"
                      class="form-label text-start text-grey-additional">
                      Enter amount in Local Currency
                      <!-- Enter amount in Local Currency ({{`${getCurrencyRange(selectedObject[scenarioMode[dataObj.scheme]].country_obj.name, dataObj.scheme).min} - ${getCurrencyRange(selectedObject[scenarioMode[dataObj.scheme]].country_obj.name, dataObj.scheme).max.toLocaleString()}`}}) -->
                    </label>
                    <input
                      type="number"
                      class="form-control"
                      :name="`section_${dataObj.scheme}_${sectionIndex}_${shortcutIndex}_edit`"
                      :min="getCurrencyRange(selectedObject[scenarioMode[dataObj.scheme]].country_obj.name, dataObj.scheme).min"
                      v-on:change="onCurrencyChange($event, dataObj.scheme, section, scenarioMode[dataObj.scheme])"
                      v-model.number="selectedObject[scenarioMode[dataObj.scheme]].scheme_details.filter(s => s.scheme === dataObj.scheme)[0].benefit_currency">
                  </div>
                </div>
                <!-- /Edit Currency -->
                <!-- Information -->
                <p
                  v-if="section.benefit_info || section.benefit_info_back || section.info"
                  class="fw-light m-0 px-2 pb-2">
                  <span
                    v-if="section.benefit_info &&
                      modeStatus[scenarioMode[dataObj.scheme]][dataObj.scheme].editMode[section.name] === false &&
                      section.edit_type === 'benefit_currency' &&
                      selectedObject[scenarioMode[dataObj.scheme]]"
                    v-html="getBenefitText(section.benefit_info, {
                      ppp: selectedObject[scenarioMode[dataObj.scheme]].scheme_details.filter(s => s.scheme === dataObj.scheme)[0].benefit_ppp,
                      currency: selectedObject[scenarioMode[dataObj.scheme]].country_obj.field_currency_code,
                      benefit_currency: selectedObject[scenarioMode[dataObj.scheme]].scheme_details.filter(s => s.scheme === dataObj.scheme)[0].benefit_currency
                    })">
                    {{getBenefitText(section.benefit_info, {
                      ppp: selectedObject[scenarioMode[dataObj.scheme]].scheme_details.filter(s => s.scheme === dataObj.scheme)[0].benefit_ppp,
                      currency: selectedObject[scenarioMode[dataObj.scheme]].country_obj.field_currency_code,
                      benefit_currency: selectedObject[scenarioMode[dataObj.scheme]].scheme_details.filter(s => s.scheme === dataObj.scheme)[0].benefit_currency
                    })}}
                  </span>
                  <span
                    v-if="section.benefit_info_back &&
                      modeStatus[scenarioMode[dataObj.scheme]][dataObj.scheme].editMode[section.name] === true &&
                      section.edit_type === 'benefit_currency' &&
                      selectedObject[scenarioMode[dataObj.scheme]]"
                    v-html="getBenefitText(section.benefit_info_back, {
                      ppp: selectedObject[scenarioMode[dataObj.scheme]].scheme_details.filter(s => s.scheme === dataObj.scheme)[0].benefit_ppp,
                      benefit_percent: selectedObject[scenarioMode[dataObj.scheme]].scheme_details.filter(s => s.scheme === dataObj.scheme)[0].benefit_percent
                    })">
                    {{getBenefitText(section.benefit_info_back, {
                      ppp: selectedObject[scenarioMode[dataObj.scheme]].scheme_details.filter(s => s.scheme === dataObj.scheme)[0].benefit_ppp,
                      benefit_percent: selectedObject[scenarioMode[dataObj.scheme]].scheme_details.filter(s => s.scheme === dataObj.scheme)[0].benefit_percent
                    })}}
                  </span>
                  <span
                    v-if="section.info">
                    {{section.info}}
                  </span>
                </p>
                <p
                  v-if="section.name==='benefit_percent'"
                  class="fw-light m-0 px-2 pb-2">
                  {{dataObj.existingScheme[scenarioMode[dataObj.scheme]]}}
                </p>
                <!-- /Information -->
              </div>
              <!-- /Toggle -->
            </div>
            <!-- Collapse view -->
            <div
              v-if="modeStatus[scenarioMode[dataObj.scheme]][dataObj.scheme].collapseMode[section.name] === true"
              class="d-flex flex-row m-2 bg-light-blue-grey1">
              <button
                type="button"
                class="plus-btn border-0"
                @click="onClickCollapse($event, dataObj.scheme, section, false, scenarioMode[dataObj.scheme])">
                <i class="uil uil-plus-circle text-primary" style="font-size: 18px;"></i>
              </button>
              <p class="text-main-body-text text-start fw-bold p-1 ps-2 pb-0 mb-1">{{section.title}}</p>
            </div>
            <!-- /Collapse view -->
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import _ from 'lodash';
import VueSlider from 'vue-slider-component';
import 'vue-slider-component/theme/default.css';
import { mapActions } from 'vuex';
import { getSchemeText } from '../helper';

export default {
  components: {
    // eslint-disable-next-line vue/no-unused-components
    VueSlider
  },
  props: {
    selectedScheme: {
      type: String
    },
    data: {
      type: Array
    },
    modeStatusA: {
      type: Object
    },
    modeStatusB: {
      type: Object
    },
    selectedObjectA: {
      type: Object
    },
    selectedObjectB: {
      type: Object
    },
    position: {
      type: Object
    },
    mode: {
      type: String
    }
  },
  data: function () {
    return {
      bsModal: null,
      dataObj: undefined,
      getSchemeText,
      modeStatus: {},
      selectedObject: {},
      scenarioMode: {
        70001: 's1',
        70002: 's1',
        70003: 's1'
      },
      benefitMode: 'currency', // percent || currency
      benefitMetadata: [],
      benefitPercentageRanges: {
        70001: {
          min: 0,
          max: 16
        },
        70002: {
          min: 0,
          max: 40
        },
        70003: {
          min: 0,
          max: 40
        }
      }
    };
  },
  watch: {
    selectedScheme: async function () {
      this.formatData();
      this.formatModeStatusData();
      await this.formatSelectedObjectData();
    },
    selectedObjectA: {
      handler: async function () {
        this.formatData();
        this.formatModeStatusData();
        await this.formatSelectedObjectData();
      },
      deep: true
    },
    selectedObjectB: {
      handler: async function () {
        this.formatData();
        this.formatModeStatusData();
        await this.formatSelectedObjectData();
      },
      deep: true
    },
    mode: function () {
      this.updateMode();
    }
  },
  mounted: function () {
    this.initialize();
  },
  methods: {
    ...mapActions('analysis', [
      'getCountryById',
      'getBenefitCurrencyData',
      'getBenefitPercentageData',
      'getBenefitMetadata'
    ]),
    initialize: function () {
      this.initModal();
      this.fetchData();
    },
    initModal: function () {
      const modalRef = this.$refs.modalRef;
      this.bsModal = new window.bootstrap.Modal(modalRef, { backdrop: true });
    },
    fetchData: async function () {
      this.benefitMetadata = await this.getBenefitMetadata({
        childMinPercentage: this.benefitPercentageRanges['70001'].min,
        childMaxPercentage: this.benefitPercentageRanges['70001'].max,
        disabilityMinPercentage: this.benefitPercentageRanges['70002'].min,
        disabilityMaxPercentage: this.benefitPercentageRanges['70002'].max,
        oldAgeMinPercentage: this.benefitPercentageRanges['70003'].min,
        oldAgeMaxPercentage: this.benefitPercentageRanges['70003'].max
      });
    },
    onScenarioCheckboxChange: function (event, schemeId, selectedScenario, status) {
      event.stopPropagation();
      if (selectedScenario === 's1') {
        this.selectedObjectA.scheme_details.map(d => {
          if (d.scheme === schemeId) {
            d.is_selected = status;
          }
          return d;
        });
      }

      if (selectedScenario === 's2') {
        this.selectedObjectB.scheme_details.map(d => {
          if (d.scheme === schemeId) {
            d.is_selected = status;
          }
          return d;
        });
      }

      this.handleSelectChanged();
    },
    handleSelectChanged: function () {
      this.$emit('selectedChanged', {});
    },
    handleToggleChanged: function (sectionName, toggleValue, scenario, scheme, value) {
      if (sectionName === 'pmt') {
        if (toggleValue === false && value !== 100) {
          this.selectedObject[scenario].scheme_details.find(d => d.scheme === scheme)[sectionName] = 100;
          this.handleSelectChanged();
        }
      } else if (sectionName === 'pt') {
        this.selectedObject[scenario].scheme_details.find(d => d.scheme === scheme)[sectionName] = toggleValue;
        this.handleSelectChanged();
      }
    },
    getToggleStatus: function (scenario, scheme, sectionName) {
      let result = false;
      if (this.selectedObject[scenario]) {
        if (sectionName === 'pt') {
          const bool = this.selectedObject[scenario].scheme_details.find(d => d.scheme === scheme)[sectionName];
          if (bool !== undefined) {
            result = bool;
            this.modeStatus[scenario][scheme].toggleMode[sectionName] = bool;
          }
        } else {
          if (this.selectedObject[scenario].scheme_details.find(d => d.scheme === scheme)[sectionName] !== 100) {
            this.modeStatus[scenario][scheme].toggleMode[sectionName] = true;
            result = true;
          }
        }
      }
      return result;
    },
    formatData: function () {
      const targetScheme = this.data.filter(d => d.scheme === this.selectedScheme);
      if (targetScheme.length > 0) {
        this.dataObj = targetScheme[0];
      }
    },
    formatModeStatusData: function () {
      this.modeStatus = {
        s1: this.modeStatusA,
        s2: this.modeStatusB
      };
    },
    formatSelectedObjectData: async function () {
      // Add country obj
      this.selectedObjectA.country_obj = await this.getCountryById(this.selectedObjectA.country);
      this.selectedObjectB.country_obj = await this.getCountryById(this.selectedObjectB.country);

      // Add benefit infoGraphicData
      this.onBenefitChange();
      this.selectedObject = {
        s1: this.selectedObjectA,
        s2: this.selectedObjectB
      };
      this.handleSelectChanged();
    },
    getBenefitText: function (template, benefitObj) {
      let result = template;
      const keys = Object.keys(benefitObj);
      for (const key of keys) {
        let replaceText = benefitObj[key];
        if (key === 'benefit_currency') {
          replaceText = benefitObj[key].toLocaleString();
        }
        result = result.replace(`[[${key}]]`, replaceText);
      }
      return result;
    },
    getBenefitCurrencyObj: async function (countryName, percentage) {
      const benefitCurrencyTemp = await this.getBenefitCurrencyData({ countryName, percentage });
      const benefitCurrency = JSON.parse(benefitCurrencyTemp[0]);
      return benefitCurrency;
    },
    getBenefitPercentageObj: async function (countryName, currencyAmount) {
      const benefitPercentageTemp = await this.getBenefitPercentageData({ countryName, currencyAmount });
      const benefitPercentage = JSON.parse(benefitPercentageTemp[0]);
      return benefitPercentage;
    },
    onClickShortcut: function (schemeId, tipSection, shortcut, selectedScenario) {
      this.selectedObject[selectedScenario].scheme_details.filter(s => s.scheme === schemeId)[0][tipSection.name] = shortcut.value;
      this.handleSelectChanged();
    },
    onClickEdit: function (schemeId, tipSection, selectedValue, selectedScenario) {
      this.modeStatus[selectedScenario][schemeId].editMode[tipSection.name] = selectedValue;
    },
    onClickCollapse: function (event, schemeId, tipSection, selectedValue, selectedScenario) {
      event.stopPropagation();

      // Collapse other section when small screen
      if (window.innerHeight < 976) {
        _.each(this.modeStatus[selectedScenario][schemeId].collapseMode, (v, k) => {
          if (k !== tipSection.name) {
            this.modeStatus[selectedScenario][schemeId].collapseMode[k] = true;
          }
        });
      }
      this.modeStatus[selectedScenario][schemeId].collapseMode[tipSection.name] = selectedValue;
    },
    onCurrencyChange: async function (event, schemeId, tipSection, selectedScenario) {
      if (!event.target.value || event.target.value === '') {
        return;
      }
      console.log('debounce');
      this.benefitMode = 'currency';
      const val = Number(event.target.value);
      const min = Number(event.target.getAttribute('min'));
      // const max = Number(event.target.getAttribute('max'));
      if (val < min) {
        if (val < min) {
          this.selectedObject[selectedScenario].scheme_details.filter(s => s.scheme === schemeId)[0].benefit_currency = min;
          this.selectedObject[selectedScenario].scheme_details.filter(s => s.scheme === schemeId)[0].benefit_percent = min;
        }
        //  else if (val > max) {
        //   const maxPercentage = this.benefitPercentageRanges[schemeId].max;
        //   this.selectedObject[selectedScenario].scheme_details.filter(s => s.scheme === schemeId)[0].benefit_currency = max;
        //   this.selectedObject[selectedScenario].scheme_details.filter(s => s.scheme === schemeId)[0].benefit_percent = maxPercentage;
        // }
      } else {
        this.selectedObject[selectedScenario].scheme_details.filter(s => s.scheme === schemeId)[0].benefit_currency = val;
        const benefitPercentageObj = await this.getBenefitPercentageObj(this.selectedObject[selectedScenario].country_obj.name, val);
        this.selectedObject[selectedScenario].scheme_details.filter(s => s.scheme === schemeId)[0].benefit_percent = this.getRoundNumber(benefitPercentageObj.percent, 2);
        this.selectedObject[selectedScenario].scheme_details.filter(s => s.scheme === schemeId)[0].benefit_ppp = benefitPercentageObj.ppp_equivalent;
      }
      this.handleSelectChanged();
    },
    onBenefitChange: function () {
      const schemes = [70001, 70002, 70003];
      const scenarios = ['s1', 's2'];
      for (const scenario of scenarios) {
        for (const scheme of schemes) {
          const isChangePercentage = !this.modeStatus[scenario][scheme].editMode.benefit_percent;
          this.updateBenefit(isChangePercentage, scenario, scheme);
        }
      }
    },
    updateBenefit: async function (isChangePercentage, scenario, scheme) {
      let selectedObj;
      if (scenario === 's1') {
        selectedObj = this.selectedObjectA;
      } else {
        selectedObj = this.selectedObjectB;
      }
      const target = selectedObj.scheme_details.find(d => d.scheme === String(scheme));
      if (target) {
        if (isChangePercentage) {
          const percentageRange = this.benefitPercentageRanges[scheme];
          if (target.benefit_percent < percentageRange.min) {
            target.benefit_percent = percentageRange.min;
          } else if (target.benefit_percent > percentageRange.max) {
            target.benefit_percent = percentageRange.max;
          }
          const benefitCurrencyObj = await this.getBenefitCurrencyObj(selectedObj.country_obj.name, target.benefit_percent);
          target.benefit_currency = this.getRoundNumber(benefitCurrencyObj.local_currency, 2);
          target.benefit_ppp = benefitCurrencyObj.ppp_equivalent;
        } else {
          _.debounce(async function () {
            const currencyRange = this.getCurrencyRange(selectedObj.country_obj.name, scheme);
            if (!target.benefit_currency) {
              return;
            }
            if (target.benefit_currency < currencyRange.min) {
              target.benefit_currency = currencyRange.min;
            } else if (target.benefit_currency > currencyRange.max) {
              target.benefit_currency = currencyRange.max;
            }
            const benefitPercentageObj = await this.getBenefitPercentageObj(selectedObj.country_obj.name, target.benefit_currency);
            target.benefit_percent = this.getRoundNumber(benefitPercentageObj.percent, 2);
            target.benefit_ppp = benefitPercentageObj.ppp_equivalent;
          }, 800);
        }
      }
    },
    inputNumberValidation: function (event, schemeId, tipSection, defaultVal, index, selectedScenario) {
      const val = Number(event.target.value);
      const min = Number(event.target.getAttribute('min'));
      const max = Number(event.target.getAttribute('max'));
      if (val > max || val < min) {
        if (index !== undefined) {
          this.selectedObject[selectedScenario].scheme_details.filter(s => s.scheme === schemeId)[0][tipSection.name][index] = defaultVal;
        } else {
          this.selectedObject[selectedScenario].scheme_details.filter(s => s.scheme === schemeId)[0][tipSection.name] = defaultVal;
        }
      }
      this.handleSelectChanged();
    },
    orderObj: function (obj, orderField) {
      return _.orderBy(obj, orderField);
    },
    updateSelectedScenario: function (event, schemeId, scenario) {
      event.stopPropagation();
      this.scenarioMode[schemeId] = scenario;
    },
    getScenarioButtonClass: function (schemeId, selectedScenario) {
      const status = this.scenarioMode[schemeId] === selectedScenario;
      let classText = '';
      const selectedClass = 'border border-simulator-tool-text bg-simulation-tool text-white';
      const defaultClass = 'border border-light-blue-grey3 bg-light-blue-grey1 text-grey-additional';
      if (status) {
        classText = selectedClass;
      } else {
        classText = defaultClass;
      }

      return classText;
    },
    getCurrencyText: function (template, country) {
      const currency = country.field_currency_code;
      const result = template.replace('[[currency]]', currency);
      return result;
    },
    updateMode: async function () {
      if (this.mode === 'combined') {
        this.selectedObjectA.scheme_details.map(d => {
          d.is_selected = true;
          return d;
        });

        this.selectedObjectB.scheme_details.map(d => {
          d.is_selected = false;
          return d;
        });
        await this.formatSelectedObjectData();

        this.scenarioMode = {
          70001: 's1',
          70002: 's1',
          70003: 's1'
        };
      } else if (this.mode === 'comparative') {
        this.selectedObjectA.scheme_details.map(d => {
          d.is_selected = true;
          return d;
        });

        this.selectedObjectB.scheme_details.map(d => {
          d.is_selected = true;
          return d;
        });
        await this.formatSelectedObjectData();
      }
    },
    getCurrencyRange: function (countryName, schemeId) {
      countryName = countryName === 'Türkiye' ? 'Turkey' : countryName;
      const benefitMetadata = this.benefitMetadata.find(d => d.country === countryName);
      let min = 0;
      let max = 0;
      if (String(schemeId) === '70001') {
        min = benefitMetadata.child_min_currency;
        max = benefitMetadata.child_max_currency;
      } else if (String(schemeId) === '70002') {
        min = benefitMetadata.disability_min_currency;
        max = benefitMetadata.disability_max_currency;
      } else if (String(schemeId) === '70003') {
        min = benefitMetadata.oldage_min_currency;
        max = benefitMetadata.oldage_max_currency;
      }
      return { min, max };
    },
    getRoundNumber (num, precision) {
      return Number(Math.round(num + 'e+' + precision) + 'e-' + precision);
    }
  }
};

</script>

<style lang="scss">
#modalSlider .btn-close {
  position: static;
}
.action {
  &:hover {
    cursor: pointer;
    font-weight: 900 !important;
  }
}
.tooltip_text {
  cursor: pointer;
  text-decoration-line: underline;
  text-decoration-style: dotted;
}

.shortcut-btn {
  &:hover {
    font-weight: 900;
    cursor: pointer;
  }
}
.edit-btn {
  text-decoration: underline;
  &:hover {
    font-weight: 900;
    cursor: pointer;
  }
}
</style>
