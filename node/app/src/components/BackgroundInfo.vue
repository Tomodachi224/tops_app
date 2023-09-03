<template>
  <div
    class="bg-info-container bg-light-blue-grey1"
    style="height: -webkit-fill-available;"
    :data-section-name="`${data.section_name}`"
    @mouseover="onMouseOver($event)"
    @mouseleave="onMouseLeave($event)"
    @click="onClick($event)">
    <div :class="`d-flex flex-row ${classes.bgColor}`">
      <div class="m-1 ms-2 d-flex flex-column align-items-center justify-content-center">
        <img
          v-for="(image, tabIndex) of data.codes"
          :key="`img_${tabIndex}`"
          class="flag-img mb-1 border border-white border-1"
          :src="`/themes/custom/tbdtheme/assets/dist/img/flags/${image}.png`">
      </div>
      <div class="d-flex flex-column m-1" style="line-height: normal;">
        <p class="text-white fw-light m-0" style="font-size: 0.7rem;">At a Glance</p>
        <div class="d-flex align-items-center h-100">
          <h4 class="text-white fw-light m-0">{{data.country}}</h4>
        </div>
      </div>
    </div>
    <div
      v-if="data.data"
      class="px-2 text-main-body-text bg-light-blue-grey1">
      <table class="bg-info-table w-100">
        <tbody>
          <tr
            v-for="(item, tabIndex) of data.data"
            :key="`row_${tabIndex}`">
            <td>{{item.name}} <span v-if="item.unit">({{item.unit.replace('(','').replace(')','')}})</span></td>
            <td class="text-end fw-light">{{item.value}}</td>
            <td v-if="item.value2" class="text-end fw-light">{{item.value2}}</td>
          </tr>
        </tbody>
      </table>
      <p
       v-if="data.source && data.source !== ''"
       class="source-text fw-light m-0">
       <strong>Source:</strong> {{data.source}}
      </p>
    </div>
  </div>
</template>

<script>
// import _ from 'lodash';
export default {
  props: {
    data: {
      type: Object
    },
    mode: {
      type: String,
      default: 'full'
    }
  },
  components: {
    // FilterPanel
  },
  computed: {
  },
  data: function () {
    return {
      renderData: {},
      classes: {
        bgColor: 'bg-nav-bg'
      }
    };
  },
  mounted: function () {
    this.initialize();
    if (this.data.section_type === 'background-info') {
      this._applySelectedClasses();
    }
  },
  watch: {
    data: function () {
      if (this.data.current_page === this.data.section_name) {
        this._applySelectedClasses();
      } else {
        this._applyDefaultClasses();
      }
    }
  },
  methods: {
    initialize: function () {
      console.log('initialize');
    },
    onClick: function (e) {
      if (e.currentTarget.getAttribute('data-section-name') !== this.data.current_page && this.data.section_type !== 'background-info') {
        this._applySelectedClasses();
      }
    },
    onMouseOver: function (e) {
      if (e.currentTarget.getAttribute('data-section-name') !== this.data.current_page && this.data.section_type !== 'background-info') {
        this._applySelectedClasses();
      }
    },
    onMouseLeave: function (e) {
      if (e.currentTarget.getAttribute('data-section-name') !== this.data.current_page && this.data.section_type !== 'background-info') {
        this._applyDefaultClasses();
      }
    },
    _applySelectedClasses: function () {
      this.classes.bgColor = 'bg-simulator-tool-text';
    },
    _applyDefaultClasses: function () {
      this.classes.bgColor = 'bg-nav-bg';
    }
  },
  setup () {
    return {
    };
  }
};
</script>

<style lang="scss">
.flag-img {
  border-radius: 50% !important;
  width: 1.3rem;
  height: 1.3rem;
  object-fit: cover;
}
.bg-info-table {
  td {
    padding: 0 0.5rem 0 0;
  }
}
.source-text {
  font-size: 80%;
  position: absolute;
  bottom: 0;
}

@supports (-moz-appearance:none) {
  .bg-info-container {
    height: 100% !important;
  }
}
</style>
