<template>
  <div class="cross-country-app">
    <div class="container my-3">
      <div class="row">
        <div class="col">
          <cross-country></cross-country>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import CrossCountry from '@/views/CrossCountry.vue';
import { mapActions, mapGetters } from 'vuex';

export default {
  props: {
  },
  components: {
    CrossCountry
  },
  computed: {
    ...mapGetters('analysis', [
      'getConfigs'
    ])
  },
  mounted: function () {
    // const updateObj = {
    //   country: this.country,
    //   scheme: this.scheme
    // };

    // this.updateConfigs({
    //   ...this.getUrlConfigs,
    //   ...updateObj
    // });
  },
  methods: {
    ...mapActions('analysis', [
      'updateCountry',
      'updateConfigs'
    ])
  }
  // setup() {
  // },
};
</script>

<style lang="scss"></style>
