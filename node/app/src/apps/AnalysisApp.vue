<template>
  <div class="analysis-app">
    <div class="container my-3">
      <div class="row">
        <div class="col">
          <analysis></analysis>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Analysis from '@/views/Analysis.vue';
import { mapActions, mapGetters } from 'vuex';

export default {
  props: {
    country: { type: String, default: 'Cambodia' },
    scheme: {
      type: Array,
      default: function () {
        return [
          'Child  Benefit'
        ];
      }
    }
  },
  components: {
    Analysis
  },
  computed: {
    ...mapGetters('analysis', [
      'getConfigs'
    ])
  },
  mounted: function () {
    const updateObj = {
      country: this.country,
      scheme: this.scheme
    };

    this.updateConfigs({
      ...this.getUrlConfigs,
      ...updateObj
    });
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
