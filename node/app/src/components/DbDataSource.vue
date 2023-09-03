<template>
  <div class="data-source-container" ref="container" style="height: -webkit-fill-available;">
    <div class="fw-light" v-html="data.text">
    </div>
  </div>
</template>

<script>

export default {
  components: {
  },
  props: {
    data: {
      type: Object
    }
  },
  data: function () {
    return {
    };
  },
  watch: {
    // data: function () {
    //   console.log('Data source input', this.data);
    // }
  },
  methods: {
  }
};
</script>

<style lang="scss">
  .data-source-container {
    padding: 0.5rem;
  }
</style>
