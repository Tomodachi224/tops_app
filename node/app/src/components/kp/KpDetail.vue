<template>
  <div
    ref="offcanvasRef"
    class="offcanvas offcanvas-end"
    tabindex="-1"
    aria-labelledby="offcanvasRightLabel"
  >
    <div class="offcanvas-header d-flex justify-content-end p-0 pt-3 pe-3">
      <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close" @click="clickCloseDetail()"></button>
    </div>
    <div class="offcanvas-body p-0 px-2">
      <div class="container p-0">
        <div class="row w-100 m-0">
          <div class="col-md-3 d-flex flex-column p-0">
            <img
              class="img-fluid rounded-0"
              :src="nodeObj.field_knowledge_product_cover"
              :alt="nodeObj.title"
            />
            <a class="btn btn-primary btn-sm rounded-0 m-0 my-2 p-1 fw-light" :href="nodeObj.field_download" target="_blank">Download</a>
          </div>
          <div class="col-md-9 ps-2">
            <div class="card-body d-flex flex-column p-0">
              <h3 class="card-title fw-normal">{{ nodeObj.title }}</h3>
              <p class="fw-light m-0">{{ nodeObj.field_publication_date }}</p>
              <div class="d-flex py-3">
                <span class="badge border rounded-0 fw-light bg-blue-tag-bg text-blue-tag-text border-blue-tag-border p-1">{{ nodeObj.field_tag }}</span>
              </div>
              <div v-if="showFullInfo === false" class="card-text">
                <div class="fw-light" v-html="nodeObj.field_additional_info_section_summary"></div>
                <button
                  type="button"
                  class="btn rounded-0 btn-primary btn-sm fw-light m-0 my-5 px-2 py-0 d-flex align-content-center justify-content-center"
                  @click="openFullInfo()"
                >
                  <i class="uil uil-angle-right"></i>
                  <span>Show More</span>
                </button>
              </div>
              <div v-if="showFullInfo === true" class="card-text fw-light">
                <div class="table-of-content">
                  <div class="card shadow-none">
                    <div class="card-body p-0 pb-5">
                      <div class="d-flex align-items-center">
                        <button
                          type="button"
                          class="btn btn-secondary collapsed px-1 py-0 me-2 rounded-1 bg-light-blue-grey1 border-light-blue-grey1 text-blue-tag-text"
                          data-bs-toggle="collapse"
                          data-bs-target="#collapseTableOfContent"
                          aria-expanded="false"
                          aria-controls="collapseTableOfContent"
                          title="Table of Content"
                        ><i class="uil uil-bars"></i></button>
                        <h5 class="card-title m-0 fw-light">Table of contents</h5>
                      </div>
                      <div id="collapseTableOfContent" class="collapse ps-9">
                        <div class="card-text fw-light" style="white-space: pre-line;" v-html="nodeObj.field_table_of_content"></div>
                      </div>
                    </div>
                  </div>
                </div>
                <div style="white-space: pre-line;" v-html="nodeObj.field_additional_info_section"></div>
                <button
                  type="button"
                  class="btn rounded-0 btn-primary btn-sm fw-light m-0 my-5 px-2 py-0 d-flex align-content-center justify-content-center"
                  @click="closeFullInfo()"
                ><i class="uil uil-angle-down"></i> Show Less</button>
              </div>
              <div class="attach-images d-flex flex-row gap-1" style="max-width: 100vw; overflow-x: auto;">
                <kp-attachment-carousel
                  v-if="attachments.length > 0"
                  :items="attachments"
                  @itemClick="handleAttachmentItemClick($event)"
                ></kp-attachment-carousel>
              </div>
              <kp-attachment-modal
                v-if="attachments.length > 0"
                ref="kpAttachmentModalRef"
                :items="attachments"
                :selected-index="selectedAttachmentIndex"
              ></kp-attachment-modal>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import KpAttachmentCarousel from './KpAttachmentCarousel.vue';
import KpAttachmentModal from './KpAttachmentModal.vue';

export default {
  props: {
    nodeObj: { type: Object }
  },
  components: {
    KpAttachmentCarousel,
    KpAttachmentModal
  },
  data: function () {
    return {
      showOffcanvas: false,
      attachments: [],
      selectedAttachmentIndex: 0,
      showFullInfo: false,
      offcanvas: null
    };
  },
  watch: {
    nodeObj: function () {
      const attachments = [];
      attachments.push(...this.getAttachments(this.nodeObj.field_youtube, 'youtube'));
      attachments.push(...this.getAttachments(this.nodeObj.field_attach_images, 'image'));
      this.attachments = [...attachments];
      this.closeFullInfo();
      if (this.showOffcanvas === false) this.offcanvas.show();
    }
  },
  mounted: function () {
    this.offcanvas = new window.bootstrap.Offcanvas(this.$refs.offcanvasRef, {
      backdrop: false, scroll: true
    });
  },
  methods: {
    closeFullInfo: function () {
      this.showFullInfo = false;
      this.updateUrl('/explore');
    },
    openFullInfo: function () {
      this.showFullInfo = true;
      this.updateUrl(`/node/${this.nodeObj.nid}`);
    },
    handleAttachmentItemClick: function (item) {
      const selectedIndex = this.attachments.findIndex(e => e.src === item.src);
      this.selectedAttachmentIndex = selectedIndex;
      this.$refs.kpAttachmentModalRef.bsModal.show();
    },
    clickCloseDetail: function () {
      const allDocs = document.querySelectorAll('.kp-doc-img');
      for (const el of allDocs) {
        el.style.border = '';
      }
    },
    updateUrl: function (path) {
      const newUrl = window.location.origin + path;
      history.pushState({}, null, newUrl);
    },
    getAttachments: function (fieldVal, type) {
      const attachments = [];
      const fmtAttachments = fieldVal.split(',').map(e => e.trim());
      fmtAttachments.forEach(attachment => {
        if (!attachment) return;
        attachments.push({ type: type, src: attachment });
      });
      return attachments;
    }
  }
};
</script>
