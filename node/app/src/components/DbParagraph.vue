<template>
  <div>
    <div class="p-2 fw-light fs-15" v-html="data.html">
      {{ data.html }}
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
    data: function () {
      // console.log('data', this.data);
    }
  },
  methods: {
  }
};
</script>

<style lang="scss">
</style>
