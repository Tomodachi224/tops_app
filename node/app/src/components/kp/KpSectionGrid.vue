<template>
  <div v-bind="$attrs" :id="id" class="card rounded-0 shadow-none kp-section-grid py-3" style="position: relative;">
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
      <div v-if="title" class="card-text fw-light pb-2">{{ title }}</div>
      <div class="card-text">
        <div class="row mb-4">
          <div v-for="item in items" :key="item.src" class="col-12 col-sm-6 col-md-4 mt-4 p-0 ps-4 text-center">
            <div class="vid-containter" v-if="item.type === 'youtube'">
              <div
                class="vid-overlay d-flex align-items-center"
                v-if="item.show_overlay"
                @click="setShowOverlay(item.id, false)">
                <span class="text-white lead fw-light p-3">{{ item.description }}</span>
              </div>
              <iframe
                :src="item.src"
                class="grid-item youtube"
              >Your browser does not support the video tag.</iframe>
            </div>
            <img
              v-if="item.type === 'image'"
              :src="item.src"
              class="grid-item image"
            />
            <p class="m-0 pb-2 text-start text-dark">{{ item.title }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    id: { type: String },
    title: { type: String },
    tag: { type: Object },
    desc: { type: String },
    items: { type: Array }
  },
  methods: {
    setShowOverlay: function (videoId, status) {
      const targetVideo = this.items.filter(i => i.id === videoId);
      if (targetVideo.length > 0) {
        targetVideo[0].show_overlay = status;
      }
    }
  }
};
</script>

<style lang="scss" scoped>
.grid-item {
  width: 100%;
  height: 250px;
}
.vid-containter {
  position: relative;
}
.vid-overlay {
  position: absolute;
  width: 100%;
  height: 100%;
  background: black;
  opacity: 0.5;
  cursor: pointer;
}
</style>
