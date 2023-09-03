<template>
  <div class="filter-panel-wrapper d-flex flex-column flex-sm-column flex-md-column flex-lg-row h-100" style="min-height: 80px;">
    <div
      v-for="(filter, filterIndex) of orderObj(filters, 'order')"
      :key="`filter_${filterIndex}`"
      :class="`filter-box d-flex flex-column ${filter.class} px-3 ${getBorderClass(filter)}`"
      :style="`${filter.style}`">
      <label
        v-if="(filter.visible !== false) &&
          (filter.label)"
        class="form-label fw-light text-grey-additional filter-label"
        style="font-size: 14px;">{{ filter.label }}</label>
      <label
        v-if="(filter.isRelationLabel) &&
          (filter.visible !== false) &&
          (!filter.isRelationVisibleIf || (filter.isRelationVisibleIf && filter.relationVisibleCondition.items.indexOf(selectedObject[filter.relationVisibleCondition.field]) > -1))"
        class="form-label fw-light text-grey-additional filter-label"
        style="font-size: 14px;">
          {{ filter.relationLabel.items[selectedObject[filter.relationLabel.field]] ?
        filter.relationLabel.items[selectedObject[filter.relationLabel.field]] :
        filter.relationLabel.items.default }}
      </label>
      <v-select
        v-if="(!filter.type) &&
          (filter.visible !== false) &&
          (!filter.isRelationVisibleIf || (filter.isRelationVisibleIf && filter.relationVisibleCondition.items.indexOf(selectedObject[filter.relationVisibleCondition.field]) > -1))"
        label="label"
        :options="filter.items"
        v-model="selectedObject[filter.key]"
        :clearable="false"
        :searchable="false"
        :reduce="item => item.value"
        @input="handleSelectChanged()"
      ></v-select>
      <v-select
        v-if="(filter.type === 'multiple') && (filter.visible !== false)"
        label="label"
        multiple
        :options="filter.items"
        v-model="selectedObject[filter.key]"
        :selectable="(option) => !selectedObject[filter.key].includes(option.value)"
        :searchable="false"
        :reduce="item => item.value"
        @input="handleSelectChanged()"
      ></v-select>
      <div v-if="(filter.type === 'radio') && (filter.visible !== false)" class="d-flex align-items-center">
        <div
          v-for="(item, itemIndex) of filter.items"
          :key="`${filter.id}_filter_${filterIndex}_item_${itemIndex}`"
          class="form-check form-check-inline">
          <input
            class="form-check-input"
            type="radio"
            :name="`${filter.id}_filter_${filterIndex}_item_${itemIndex}`"
            :id="`${filter.id}_filter_${filterIndex}_item_${itemIndex}`"
            :value="item.value"
            v-model="selectedObject[filter.key]"
            v-on:change="handleSelectChanged()">
          <label
            @click="onLabelClick()"
            class="form-check-label fw-light text-main-body-text"
            v-bind:class="{ tooltip_text: getTooltipTextStatus(item)}"
            style="font-size: 15px;"
            :for="`${filter.id}_filter_${filterIndex}_item_${itemIndex}`"
            data-bs-toggle="popover"
            data-bs-placement="bottom"
            data-bs-trigger="hover focus"
            :title="`${item.label}`"
            :data-bs-content="`${item.tooltip_text}`">{{item.label}}</label>
        </div>
      </div>
      <div v-if="(filter.type === 'checkbox') && (filter.visible !== false)" class="d-flex align-items-center">
        <div
          v-for="(item, itemIndex) of filter.items"
          :key="`${filter.id}_filter_${filterIndex}_item_${itemIndex}`"
          class="form-check form-check-inline m-0 me-3">
          <input
            class="form-check-input"
            type="checkbox"
            :name="`${filter.id}_filter_${filterIndex}_item_${itemIndex}`"
            :id="`${filter.id}_filter_${filterIndex}_item_${itemIndex}`"
            :value="item.value"
            v-model="selectedObject[filter.key]"
            v-on:change="handleSelectChanged()">
          <label
            class="form-check-label fw-light text-main-body-text"
            style="font-size: 15px;"
            :for="`${filter.id}_filter_${filterIndex}_item_${itemIndex}`">{{item.label}}</label>
        </div>
      </div>
      <div v-if="(filter.type === 'blocklist') && (filter.visible !== false)" class="d-flex align-items-center block-list-selection">
        <div
          v-for="(item, itemIndex) of filter.items"
          :key="`${filter.id}_filter_${filterIndex}_item_${itemIndex}`"
          class="block-selection">
          <div
            @click="onBlockClick(item, filter.key)"
            class="block-item"
            v-bind:class="{
              'selected': selectedObject[filter.key] === item.value
            }"
            :name="`${filter.id}_filter_${filterIndex}_item_${itemIndex}`"
            :id="`${filter.id}_filter_${filterIndex}_item_${itemIndex}`">
            {{item.label}}
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import _ from 'lodash';
import vSelect from 'vue-select';
import 'vue-slider-component/theme/default.css';
import { initPopover } from '../libs/popover';

export default {
  components: {
    'v-select': vSelect
  },
  props: {
    selectedObject: {
      type: Object,
      default: function () {
        return {
          indicator: 'item1',
          country: 'item1'
        };
      }
    },
    filters: {
      type: Array,
      default: function () {
        return [
          {
            label: 'Indicator',
            key: 'indicator',
            items: [
              { value: 'item1', label: 'Item 1' },
              { value: 'item2', label: 'Item 2' }
            ]
          },
          {
            label: 'Country',
            key: 'country',
            items: [
              { value: 'item1', label: 'Item 1' },
              { value: 'item2', label: 'Item 2' }
            ]
          }
        ];
      }
    },
    modeStatus: {
      type: Object
    },
    space: {
      type: Number,
      default: 4
    }
  },
  mounted: function () {
    this.initialize();
    initPopover();
  },
  methods: {
    initialize: function () {
      // console.log('initial');
    },
    handleSelectChanged: function () {
      // console.log('handleSelectChanged', this.selectedObject);
      this.$emit('selectedChanged', _.cloneDeep({ ...this.selectedObject }));
    },
    getTooltipTextStatus (item) {
      let status = false;
      if (item.tooltip_text && item.tooltip_text !== '') {
        status = true;
      }
      return status;
    },
    orderObj: function (obj, orderField) {
      return _.orderBy(obj, orderField);
    },
    getBorderClass (filter) {
      let borderClass = 'border border-light-blue-grey1 border-1 border-top-0 border-start-0 border-bottom-0';
      if (filter.no_border && filter.no_border === true) {
        borderClass = '';
      } else {
        borderClass = 'border border-light-blue-grey1 border-1 border-top-0 border-start-0 border-bottom-0';
      }
      return borderClass;
    },
    onLabelClick () {
      const popOverItems = document.querySelectorAll('.popover');

      popOverItems.forEach(popOverItem => {
        popOverItem.remove();
      });
    },
    onBlockClick (item, key) {
      this.selectedObject[key] = item.value;
      this.handleSelectChanged();
    }
  }
};

</script>

<style lang="scss">
@import 'vue-select/src/scss/vue-select.scss';

.vs__dropdown-toggle {
  height: 45px;
  width: 200px;
  .vs__selected {
    font-size: 24px;
    font-weight: bold;
  }
  .vs__dropdown-menu {
    top: 48px;
  }
}

@media (max-width: 575px) {
  .filter-panel-wrapper {
    min-height: 75px !important;
  }
  .form-check-label {
    font-size: 12px !important;
  }
  .form-check-inline {
    margin-right: 0.25rem !important;
  }
  .filter-box {
    padding-right: 0.25rem !important;
    padding-left: 0.25rem !important;
  }
  .vs__dropdown-toggle {
    width: 130px;
    .vs__selected {
      font-size: 17px;
      font-weight: bold;
    }
    .vs__dropdown-menu {
      top: 48px;
    }
  }
}

.close-btn, .plus-btn {
  &:hover {
    i {
      color: #000000 !important;
    }
  }
}
.block-list-selection {
  // margin-top: -10px;
}
.block-selection {
  margin-right: 2px;
  cursor: pointer;
  font-size: 13px;
  .block-item {
    padding: 2px 6px;
    background: #F8F9FA;
    border: 1px solid #CED4DA;
    border-radius: 5px;
    &.selected {
      color: #FFFFFF;
      background: #449945;
    }
  }
}
</style>
