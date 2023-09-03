<template>
  <div class="grid-page-app">
    <div class="row">
      <div class="col">
<!--         <div class="banner d-flex w-100 h-25 justify-content-center align-items-center bg-info bg-gradient">
          <h1>Gridpage App</h1>
        </div> -->
      </div>
    </div>
    <div class="container my-3">
      <div class="row">
        <div class="col">
          <grid-page></grid-page>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import GridPage from '@/views/GridPage.vue';
import { mapActions, mapGetters } from 'vuex';

export default {
  props: {
    mode: { type: String, default: 'comparative' },
    params: { type: Object, default: undefined }
  },
  components: {
    GridPage
  }
  // mounted: function () {
  //   const updateObj = {
  //     mode: this.mode,
  //     params: this.params
  //   };

  //   this.updateCompareConfigs({
  //     ...this.getCompareConfigs,
  //     ...updateObj
  //   });
  // }
  // setup() {
  // },
};
</script>

<style lang="scss"></style>
