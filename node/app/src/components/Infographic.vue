<template>
  <div
    ref="root"
    :class="`p-0 ${classes.bgColor} container-tbd-chart`"
    style="height: inherit;"
    :data-topic-name="`${data.topic}`"
    @mouseover="onMouseOver($event)"
    @mouseleave="onMouseLeave($event)"
    @click="onClick($event)">
    <div v-if="data.titles.length > 0" class="height-100">
      <div
        :class="`d-flex flex-column browser-selector ${classes.svgThumbnailColor}`"
        style="height: -webkit-fill-available;">
        <div class="info-tag">
          <span
            class="badge border rounded-pill fw-bold bg-simulation-tool text-white border-simulation-tool p-1 m-2"
          >{{data.tag}}</span>
        </div>
        <span
          v-html="data.thumbnail"
          :class="`info-thumbnail ${classes.svgThumbnailColor}`"></span>
        <div class="flex-grow-1 d-flex flex-column justify-content-center align-items-center">
          <h4
            v-if="data.description_short_position_top !== ''"
            :class="`fw-light m-0 desc-text ${classes.textColor} text-center`"
            v-html="data.description_short_position_top">{{ data.description_short_position_top }}</h4>
          <div class="d-flex flex-row gap-1">
            <div
              v-for="(title, titleIndex) of data.titles"
              :key="`title_${titleIndex}`"
              :class="`scenario-box d-flex flex-column justify-content-center align-items-center my-1 ${classes.showBorder}`">
              <h4
                v-if="data.titles.length > 1"
                class="desc-text text-simulation-tool mb-0">{{ title.name }}</h4>
              <h2
                :class="`info-title ${classes.textColor} ${classes.svgColor} fw-light mb-0`"
                v-html="title.value">{{ title.value }}</h2>
            </div>
          </div>
          <h4
            v-if="data.description_short_position_bottom !== ''"
            :class="`fw-light m-0 px-2 desc-text ${classes.textColor} text-center`"
            v-html="data.description_short_position_bottom">{{ data.description_short_position_bottom }}</h4>
        </div>
        <div
          @click="clickReadMore(data.child, $event)"
          v-if="data.child"
          :class="`readmore-container d-flex align-items-center justify-content-end fw-light ${classes.readMoreColor} m-2`">
          Read More
          <i :class="`${classes.readMoreColor} fw-normal uil uil-angle-right-b`"></i>
        </div>
      </div>
    </div>
    <div
      v-if="data.titles.length === 0"
      class="d-flex align-items-center justify-content-center height-100">
      <p :class="`m-0 p-0 ${classes.textColor}`" style="text-align: center">NO DATA</p>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    data: { type: Object }
  },
  emits: ['readMoreClicked'],
  data: function () {
    return {
      classes: {
        bgColor: 'bg-simulator-tool-text',
        textColor: 'text-white',
        svgThumbnailColor: '',
        svgColor: '',
        readMoreColor: 'text-white',
        showBorder: ''
      }
    };
  },
  watch: {
    data: function () {
      if (this.data.current_topic === this.data.topic) {
        this.applySelectedClasses();
      } else {
        this.applyDefaultClasses();
      }
      if (this.data.titles.length > 1) {
        this.applyComparativeClasses();
      } else {
        this.applyCombinedClasses();
      }
    }
  },
  mounted: function () {
    // const resizeObserverOptions = { skipFirst: false };
    // resizeObserver$.value = ResizeObserver.observe(root.value, () => {
    //   elWidth.value = root.value.offsetWidth;
    // }, resizeObserverOptions);

    if (this.data.current_topic === this.data.topic) {
      this.applySelectedClasses();
    } else {
      this.applyDefaultClasses();
    }

    if (this.data.titles.length > 1) {
      this.applyComparativeClasses();
    } else {
      this.applyCombinedClasses();
    }
  },
  // unmounted: function () {
  // if (resizeObserver$.value !== null) {
  //   ResizeObserver.unobserve(resizeObserver$.value);
  // }
  // }
  methods: {
    clickReadMore: function (child, event) {
      this.$emit('readMoreClicked', { child, event });
    },
    onClick: function (e) {
      if (e.currentTarget.getAttribute('data-topic-name') !== this.data.current_topic) {
        this.applySelectedClasses();
      }
    },
    onMouseOver: function (e) {
      if (e.currentTarget.getAttribute('data-topic-name') !== this.data.current_topic) {
        this.applyHoveringClasses();
      }
    },
    onMouseLeave: function (e) {
      if (e.currentTarget.getAttribute('data-topic-name') !== this.data.current_topic) {
        this.applyDefaultClasses();
      }
    },
    applyDefaultClasses: function () {
      this.classes.bgColor = 'bg-simulator-tool-text';
      this.classes.textColor = 'text-white';
      this.classes.svgThumbnailColor = '';
      this.classes.svgColor = '';
      this.classes.readMoreColor = 'text-white';
      if (this.data.titles.length > 1) {
        this.classes.borderColor = 'border-white';
      }
    },
    applySelectedClasses: function () {
      this.classes.bgColor = 'bg-white';
      this.classes.textColor = 'text-simulator-tool-text';
      this.classes.svgColor = 'hovering';
      this.classes.svgThumbnailColor = '';
      this.classes.readMoreColor = 'text-nav-bg';
      if (this.data.thumbnail_changable) {
        this.classes.svgThumbnailColor = 'hovering';
      }
    },
    applyHoveringClasses: function () {
      this.classes.bgColor = 'bg-light-blue-grey1';
      this.classes.textColor = 'text-simulator-tool-text';
      this.classes.svgColor = 'hovering';
      this.classes.svgThumbnailColor = '';
      this.classes.readMoreColor = 'text-nav-bg';
      if (this.data.thumbnail_changable) {
        this.classes.svgThumbnailColor = 'hovering';
      }
    },
    applyCombinedClasses: function () {
      this.classes.showBorder = '';
    },
    applyComparativeClasses: function () {
      this.classes.showBorder = 'border border-simulation-tool border-1 rounded-1';
    }
  }
};
</script>
<style>
.info-tag {
  position: absolute;
  top: 0;
  left: 0;
}
.info-thumbnail svg {
  width: 10%;
  height: auto;
  position: absolute;
  right: 0;
  top: 0;
}
/* .thumbnail-bg {
  background-repeat: no-repeat;
  background-position: top right;
  background-size: 17%;
} */
.hovering svg path {
  fill: #449945;
}

.info-title {
  font-size: 250%;
}

.info-title svg {
  width: 1.3rem;
  height: 1.3rem;
}
.desc-text {
  font-size: 0.8rem;
}

.readmore-container {
  cursor: pointer;
  position: absolute;
  right: 0;
  bottom: 0;
}

.readmore-container:hover {
  font-weight: 900 !important;
}

.readmore-container:hover i {
  font-weight: 900 !important;
}

.scenario-box {
  min-width: 135px;
}

.height-100 {
  height: 100% !important;
}

@supports (-moz-appearance:none) {
  .browser-selector {
    height: 100% !important;
  }
}
</style>
