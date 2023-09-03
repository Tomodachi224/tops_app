<template>
  <div>
    <div v-if="showPageContent" class="d-block d-lg-none container box-shadow">
      <div style="position: absolute; right: 0;">
        <button
          v-if="showPageContent === true"
          type="button"
          class="close-btn border-0 float-end"
          @click="onClickPageContent($event, false)">
          <i class="uil uil-multiply text-primary" style="font-size: 18px;"></i>
        </button>
      </div>
        <m-sidebar :menu-list="methodologyList"></m-sidebar>
    </div>
    <div class="container">
      <div class="row container-filter d-none d-lg-block">
        <m-sidebar :menu-list="methodologyList"></m-sidebar>
      </div>
      <div class="d-flex justify-content-end">
        <button
          v-if="showPageContent === false"
          class="d-block d-lg-none btn d-flex flex-row align-items-center p-0 m-0 border-0 rounded-1"
          @click="onClickPageContent($event, true)">
          <div class="bg-light-blue-grey3 p-1 py-0 rounded-1"><i class="fw-normal uil uil-list-ul fs-20 text-white"></i></div>
          <span class="fw-light px-2 text-blue-grey4">Page content</span>
        </button>
      </div>
      <div class="row">
        <div v-for="(methodology, mIndex) of methodologyList" :key="`m-${mIndex}`">
          <m-content
            :id="methodology.field_anchor"
            :depth="methodology.depth"
            :name="methodology.name"
            :description="methodology.description"
          ></m-content>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapActions, mapState } from 'vuex';
import _ from 'lodash';
import MContent from '@/components/methodology/MContent.vue';
import MSidebar from '@/components/methodology/MSidebar.vue';

export default {
  components: {
    MContent,
    MSidebar
  },
  data: function () {
    return {
      methodologyList: [],
      showPageContent: false
    };
  },
  computed: {
    ...mapState('methodology', ['methodologies'])
  },
  watch: {
    methodologies: function () {
      this.methodologyList = _.sortBy(_.map(this.methodologies, d => {
        if (d.parent_target_id) {
          const parent = this.methodologies.filter(m => m.tid === d.parent_target_id)[0];
          d.weight = (Number(d.weight) + 1) + Number(parent.weight);
        } else {
          d.weight = (Number(d.weight) + 1) * 100;
        }
        return d;
      }), 'weight');
    }
  },
  mounted: function () {
    this.fetchMethodologies();
  },
  methods: {
    ...mapActions('methodology', ['fetchMethodologies']),
    onClickPageContent: function (e, status) {
      this.showPageContent = status;
    }
  }
};
</script>

<style lang="scss" scoped>
.container-filter {
  position: sticky;
  float: left;
  top: 137px;
  width: 230px;
}
.box-shadow {
  box-shadow: 6px 6px 22px 1px rgb(0 0 0 / 10%);
}
</style>
