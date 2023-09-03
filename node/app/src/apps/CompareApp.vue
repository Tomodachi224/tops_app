<template>
  <div class="compare-app">
    <div class="row">
      <div class="col">
        <div class="banner d-flex w-100 h-25 justify-content-center align-items-center bg-info bg-gradient">
          <h1>Compare App</h1>
        </div>
      </div>
    </div>
    <div class="container my-3">
      <div class="row">
        <div class="col">
          <compare></compare>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Compare from '@/views/Compare.vue';
import { mapActions, mapGetters } from 'vuex';

export default {
  props: {
    mode: { type: String, default: 'comparative' },
    params: { type: Object, default: undefined }
  },
  components: {
    Compare
  },
  computed: {
    ...mapGetters('analysis', [
      'getCompareConfigs'
    ])
  },
  mounted: function () {
    const updateObj = {
      mode: this.mode,
      params: this.params
    };

    this.updateCompareConfigs({
      ...this.getCompareConfigs,
      ...updateObj
    });
  },
  methods: {
    ...mapActions('analysis', [
      'updateCompareConfigs'
    ])
  }
  // setup() {
  // },
};
</script>

<style lang="scss"></style>
