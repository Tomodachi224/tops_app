<template>
  <div v-if="isReady === true">
    <div v-if="items.length === 0" class="card-text">No Data</div>
    <div v-else>
      <div
        ref="carouselRef"
        class="owl-carousel owl-theme basic-slider w-100 m-0 p-0"
        data-dots="false"
        data-auto-width="false"
        data-auto-height="true"
      >
        <div
          v-for="(item, index) in items"
          :key="index"
          class="item"
          @click="handleItemClick(item)"
        >
          <img :src="getSrc(item)" />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { initCarousel } from '../../libs/carousel';

export default {
  props: {
    items: { type: Array }
  },
  emits: ['itemClick'],
  data: function () {
    return {
      isReady: false
    };
  },
  watch: {
    items: function () {
      this.isReady = false;
      setTimeout(() => {
        this.isReady = true;
        this.initCarousel();
      }, 200);
    }
  },
  mounted: function () {
    this.isReady = true;
    this.initCarousel();
  },
  methods: {
    getSrc: function (item) {
      if (item.type === 'image') return item.src;
      if (item.type === 'youtube') {
        const splitSrc = item.src.split('/');
        const videoId = splitSrc[splitSrc.length - 1];
        return `https://img.youtube.com/vi/${videoId}/0.jpg`;
      }
      return null;
    },
    handleItemClick: function (item) {
      this.$emit('itemClick', item);
    },
    initCarousel: function () {
      if (this.items.length === 0) return;
      setTimeout(() => {
        initCarousel(this.$refs.carouselRef);
      }, 200); // Waiting for rendering
    }
  }
};
</script>
