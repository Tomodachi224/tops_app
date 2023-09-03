<template>
  <div ref="modalRef" class="modal fade" id="kpAttachmenteModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header border-0 p-2 pb-4">
          <button type="button" class="btn-close p-0 px-1" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body pt-0">
          <div class="row" :style="`height: ${screenHeight - 70 - 30 - 115 - 20 - 15}px; overflow: auto;`">
            <div class="col text-center">
              <iframe
                v-if="selectedItem.type === 'youtube'"
                :src="selectedItem.src"
                class="attachment video"
              >Your browser does not support the video tag. </iframe>
              <img
                v-if="selectedItem.type === 'image'"
                :src="selectedItem.src"
                class="attachment"
              />
            </div>
          </div>
          <div class="row mt-3" style="height: 115px; overflow: auto;">
            <div class="col">
              <kp-attachment-carousel :items="items" @itemClick="handleItemClick($event)"></kp-attachment-carousel>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import KpAttachmentCarousel from './KpAttachmentCarousel.vue';

export default {
  props: {
    items: { type: Array },
    selectedIndex: { type: Number, default: 0 }
  },
  components: {
    KpAttachmentCarousel
  },
  data: function () {
    return {
      bsModal: null,
      selectedItem: {},
      screenHeight: 500
    };
  },
  watch: {
    items: function () {
      this.setSelectedItem(this.selectedIndex);
    },
    selectedIndex: function () {
      this.setSelectedItem(this.selectedIndex);
    }
  },
  mounted: function () {
    this.selectedItem = this.items[this.selectedIndex];
    this.bsModal = new window.bootstrap.Modal(this.$refs.modalRef, { backdrop: false });
    this.screenHeight = window.innerHeight;
  },
  methods: {
    handleItemClick: function (item) {
      this.selectedItem = { ...item };
    },
    setSelectedItem: function (index) {
      this.selectedItem = this.items[this.selectedIndex] ? this.items[this.selectedIndex] : this.items[0];
    }
  }
};
</script>

<style lang="scss" scoped>
.attachment {
  width: 100%;
  height: auto;
  &.video {
    height: 500px;
  }
}
</style>
