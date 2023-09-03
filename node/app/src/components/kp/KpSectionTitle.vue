<template>
  <div v-bind="$attrs" :id="id" class="d-flex align-items-center kp-section-title" style="position: relative;">
    <h3 class="card-title fw-normal m-0 border-bottom border-primary border-2 py-1">
      {{ title }}
    </h3>
    <!-- <span
      class="badge border rounded-0 fw-light bg-blue-tag-bg text-blue-tag-text border-blue-tag-border p-1 mx-2"
    >{{ tag.name }}</span> -->
  </div>
</template>

<script>
export default {
  props: {
    title: { type: String },
    id: { type: String },
    tag: { type: Object }
  }
};
</script>
