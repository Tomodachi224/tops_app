<template>
  <div class="regional-comp-app">
    <div class="container my-3 mx-0 px-0">
      <div class="row">
        <div class="col">
          <regional-comp></regional-comp>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import RegionalComp from '@/views/RegionalComp.vue';
import { mapActions, mapGetters } from 'vuex';

export default {
  props: {
  },
  components: {
    RegionalComp
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
