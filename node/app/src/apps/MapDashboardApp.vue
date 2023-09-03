<template>
  <div class="map-dashboard-app">
    <div class="row m-0">
      <div class="col-12 p-0">
        <map-dashboard></map-dashboard>
      </div>
    </div>
  </div>
</template>

<script>
import MapDashboard from '@/views/MapDashboard.vue';
// import DbSidebar from '@/components/DbSidebar.vue';
// import { mapActions, mapGetters } from 'vuex';

export default {
  props: {
    mode: { type: String, default: 'comparative' }
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
    MapDashboard
  }
  // computed: {
  //   ...mapGetters('analysis', [
  //     'getConfigs'
  //   ])
  // },
  // mounted: function () {
  //   const updateObj = {
  //     country: this.country,
  //     scheme: this.scheme
  //   };

  //   this.updateConfigs({
  //     ...this.getUrlConfigs,
  //     ...updateObj
  //   });
  // },
  // methods: {
  //   ...mapActions('analysis', [
  //     'updateCountry',
  //     'updateConfigs'
  //   ])
  // }
  // setup() {
  // },
};
</script>

<style lang="scss">
</style>
