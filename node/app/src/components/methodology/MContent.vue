<template>
  <div>
    <h3
      v-if="depth==='1'"
      :id="id"
      class="anchor-section fw-normal m-0 border-bottom border-primary border-2 py-1"
      style="width: fit-content;">
      {{name}}
    </h3>
    <h5
      v-if="depth==='2'"
      :id="id"
      class="anchor-section m-0 py-2">
      {{name}}
    </h5>
    <h6
      v-if="depth==='3'"
      :id="id"
      class="anchor-section m-0 py-2">
      {{name}}
    </h6>
    <div
      v-if="description"
      v-html="description"
      class="fw-light py-4">{{description}}</div>
  </div>
</template>

<script>
// import TableWrapper from '@/components/TableWrapper.vue';

export default {
  props: {
    id: { type: String },
    name: { type: String },
    description: { type: String },
    depth: { type: String }
  },
  components: {
    // TableWrapper
  },
  watch: {
    id: function () {
      this.replaceTableToken();
    }
  },
  mounted: function () {
    this.initMathJax();
    this.replaceTableToken();
  },
  methods: {
    initMathJax: function () {
      if (document.getElementById('MathJax-script')) { return; }
      const ScriptES = document.createElement('script');
      ScriptES.setAttribute('src', 'https://polyfill.io/v3/polyfill.min.js?features=es6');
      const ScriptMathML = document.createElement('script');
      ScriptMathML.setAttribute('id', 'MathJax-script');
      ScriptMathML.setAttribute('src', 'https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js');
      ScriptMathML.setAttribute('async', true);
      document.head.appendChild(ScriptES);
      document.head.appendChild(ScriptMathML);
    },
    replaceTableToken: function () {
      if (!this.description) { return; }
      const re = /(\[\[).+?(?=\]\])/g;
      let result = this.description;
      const matches = this.description.match(re);
      if (matches) {
        for (const match_ of matches) {
          const match = match_.split('[[')[1];
          const tableDataId = match.split(':')[1];
          const htmlResult = `<table-wrapper table-data-id="${tableDataId}"></table-wrapper>`;
          result = result.replace(`[[${match}]]`, htmlResult);
        }
      }
      this.description = result;
    }
  }
};
</script>

<style lang="scss" scoped>

.anchor-section {
  scroll-margin-top: calc(100px - 10px);
}
</style>
