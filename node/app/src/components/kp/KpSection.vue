<template>
  <div v-bind="$attrs" :id="id" class="card rounded-0 shadow-none kp-section py-3" style="position: relative;">
    <div class="card-body p-0">
      <div class="d-flex align-items-center">
        <h5 class="card-title m-0 py-2">
          {{ title }}
        </h5>
        <span
          v-if="tag"
          class="badge border rounded-0 fw-light bg-blue-tag-bg text-blue-tag-text border-blue-tag-border p-1 mx-2"
        >{{ tag.name }}
        </span>
      </div>
      <div v-if="desc" class="card-text fw-light pb-2">{{ desc }}</div>
      <div v-if="sectionItems.length === 0" class="card-text">No Data</div>
      <div v-else>
        <div
          ref="sliderRef"
          class="owl-carousel owl-theme basic-slider w-100 my-3"
          data-dots="false"
          data-margin="5"
          data-auto-width="true"
          data-auto-height="true"
          data-nav="false"
          data-stageclass="owl-stage d-flex align-items-end"
        >
          <div
            v-for="sectionItem in sectionItems"
            :key="sectionItem.nid"
            class="item"
            @click="handleSectionItemClick(sectionItem)"
          >
            <img class="kp-doc-img" :data-nid="sectionItem.nid" :src="sectionItem.field_knowledge_product_cover" />
            <div class="d-flex gap-1 mt-1">
              <span
                class="badge border rounded-0 fw-light bg-blue-tag-bg text-blue-tag-text border-blue-tag-border p-1"
              >{{sectionItem.field_tag}}</span>
              <span
                class="badge border rounded-0 fw-light bg-blue-tag-bg text-blue-tag-text border-blue-tag-border p-1"
              >{{sectionItem.field_publication_year}}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapActions } from 'vuex';
import { initCarousel } from '../../libs/carousel';
import { fetchKps } from './fetchData';

export default {
  props: {
    id: { type: String },
    title: { type: String },
    desc: { type: String },
    tag: { type: Object },
    queryParams: { type: Object, required: true }
  },
  data: function () {
    return {
      sectionItems: []
    };
  },
  watch: {
    queryParams: function () {
      this.sectionItems = []; // Clear old list
      this.setSectionItems(this.queryParams);
    }
  },
  mounted: function () {
    if (this.queryParams === null) { return; }
    this.setSectionItems(this.queryParams);
  },
  methods: {
    ...mapActions('kp', ['updateSelectedNode']),
    setSectionItems: async function (queryParams) {
      if (queryParams.tag_ids && queryParams.tag_ids.length === 0) { return; }
      const _sectionItems = await fetchKps(queryParams);
      this.sectionItems = [..._sectionItems];
      if (this.sectionItems.length === 0) { return; }

      setTimeout(() => {
        initCarousel(this.$refs.sliderRef);
      }, 1000); // Waiting for rendering
    },
    handleSectionItemClick: function (sectionItem) {
      const allDocs = document.querySelectorAll('.kp-doc-img');
      for (const el of allDocs) {
        el.style.border = '';
      }
      const selectedDocs = document.querySelectorAll(`.kp-doc-img[data-nid="${sectionItem.nid}"]`);
      for (const el of selectedDocs) {
        el.style.border = '4px solid #96102C';
      }
      this.updateSelectedNode(parseInt(sectionItem.nid));
    }
  }
};
</script>

<style lang="scss" scoped>
.item {
  &:not(:first) {
    margin-left: 1rem;
  }
}
</style>
