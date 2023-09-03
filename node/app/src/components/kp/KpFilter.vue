<template>
  <div class="card border border-0 rounded-0 shadow-none">
    <div class="card-body p-0">
      <div>
        <input
          type="type"
          class="form-control border rounded-1"
          placeholder="Search by keywords"
          @keyup="handleSearchChangeDelay($event)"
        >
      </div>
      <div class="mt-1">
        <select class="form-select border rounded-1" @change="handleYearFilterChange($event)">
          <option value="">All Years</option>
          <option v-for="year in publicationYears" :key="year" :value="year">{{ year }}</option>
        </select>
      </div>
      <div :id="scrollSpyId" class="list-group rounded-0 pt-2">
        <div
          v-for="item in sections"
          :key="item.title"
        >
          <a
            :href="item.href"
            class="list-group-item border-0 py-1"
          ><h5 class="m-0">{{ item.title }}</h5></a>
          <div class="list-group sub-list-group rounded-0">
            <a
              v-for="subItem in item.children"
              :key="subItem.title"
              :href="subItem.href"
              class="list-group-item border-0 pb-1"
            ><p class="m-0 fw-light sub-item">{{ subItem.title }}</p></a>
          </div>
        </div>
      </div>
      <div class="my-4">
        <h5>Tags</h5>
        <div class="d-flex flex-wrap gap-1">
          <button
            v-for="tagItem in tagItems"
            :key="tagItem.tid"
            class="badge border rounded-0 fw-light p-1"
            :class="getTagClassObj(tagItem)"
            @click="handleTagClick(tagItem)"
          >{{ tagItem.name }}</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex';
import _ from 'lodash';
import { fetchKpPublicationYears } from './fetchData';

export default {
  props: {
    sections: { type: Array },
    tagItems: { type: Array }
  },
  data: function () {
    return {
      scrollSpyId: 'sectionList',
      publicationYears: []
    };
  },
  computed: {
    ...mapGetters('kp', ['getSelectedTags'])
  },
  mounted: async function () {
    // const scrollSpy = new window.bootstrap.ScrollSpy(document.body, {
    //   target: `#${this.scrollSpyId}`,
    //   offset: 100,
    //   method: 'offset'
    // });
    this.publicationYears = await fetchKpPublicationYears();
  },
  methods: {
    ...mapActions('kp', [
      'updateSearchKeyword',
      'updateSelectedTags',
      'updateSelectedYear'
    ]),
    handleSearchChangeDelay: _.debounce(function (event) {
      const searchKeyword = event.srcElement.value;
      this.updateSearchKeyword(searchKeyword);
    }, 800),
    handleYearFilterChange: function (event) {
      const selectedYear = event.currentTarget.value;
      this.updateSelectedYear(selectedYear);
    },
    getTagClassObj: function (tag) {
      const classObj = {
        'bg-blue-tag-bg': false,
        'text-blue-tag-text': false,
        'border-blue-tag-border': false,
        'bg-light': true,
        'text-dark': true,
        'border-light': true
      };
      const foundTag = this.getSelectedTags.find(e => e.tid === tag.tid);
      if (foundTag === undefined) return classObj;
      classObj['bg-blue-tag-bg'] = true;
      classObj['text-blue-tag-text'] = true;
      classObj['border-blue-tag-border'] = true;
      classObj['bg-light'] = false;
      classObj['text-dark'] = false;
      classObj['border-light'] = false;
      return classObj;
    },
    handleTagClick: function (tag) {
      let selectedTags = [...this.getSelectedTags];
      const foundTag = selectedTags.find(e => e.tid === tag.tid);
      if (foundTag === undefined) selectedTags.push(tag);
      else selectedTags = selectedTags.filter(e => e.tid !== tag.tid);
      this.updateSelectedTags(selectedTags);
    }
  }
};
</script>

<style lang="scss" scoped>
.list-group-item {
  padding-left: 0;
  &.active {
    background-color: inherit !important;
    color: #96102C !important;
    font-weight: bolder !important;
  }
}
.sub-list-group {
  .list-group-item {
    padding-top: 0.25rem;
    padding-bottom: 0.25rem;
    color: #737A91;
    font-weight: lighter;
  }
}
.sub-item {
  font-size: 14px;
}
</style>
