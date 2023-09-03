<template>
  <div class="dashboard-app">
    <db-sidebar
      :mode="mode"
      :input-params="params">
    </db-sidebar>
    <div class="row m-0">
      <div class="col-12 p-0">
        <dashboard></dashboard>
      </div>
    </div>
  </div>
</template>

<script>
import Dashboard from '@/views/Dashboard.vue';
import DbSidebar from '@/components/DbSidebar.vue';
import { mapActions } from 'vuex';

export default {
  props: {
    mode: { type: String, default: 'comparative' },
    toolbarMode: { type: String, default: 'normal' },
    params: { type: Object, default: undefined }
    // country: { type: String, default: 'Cambodia' },
    // scheme: {
    //   type: Array,
    //   default: function () {
    //     return [
    //       'Child  Benefit'
    //     ];
    //   }
    // }
  },
  components: {
    Dashboard,
    DbSidebar
  },
  // computed: {
  //   ...mapGetters('analysis', [
  //     'getConfigs'
  //   ])
  // },
  mounted: function () {
    this.updateDashboardToolbarType(this.toolbarMode);
  },
  methods: {
    ...mapActions('analysis', [
      'updateDashboardToolbarType'
    ])
  }
  // setup() {
  // },
};
</script>

<style lang="scss">
</style>
