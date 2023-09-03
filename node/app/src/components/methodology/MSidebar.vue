<template>
  <div :id="scrollSpyId" class="list-group rounded-0 pt-2">
    <div
      v-for="(menu, mIndex ) of menuList"
      :key="`menu-item-container-${mIndex}`"
    >
      <a
        v-if="menu.depth==='1'"
        :href="`#${menu.field_anchor}`"
        class="menu-lv1 list-group-item border-0 py-1"
      ><h5 class="m-0">{{ menu.name }}</h5></a>
      <a
        v-if="menu.depth==='2'"
        :href="`#${menu.field_anchor}`"
        class="menu-lv2 list-group-item border-0 py-1"
      ><p class="m-0 fw-light sub-item">{{ menu.name }}</p></a>
      <a
        v-if="menu.depth==='3'"
        :href="`#${menu.field_anchor}`"
        class="menu-lv3 list-group-item border-0 py-1"
      ><p class="m-0 ms-3 fw-light sub-item">{{ menu.name }}</p></a>
  </div>
  </div>
</template>

<script>
export default {
  props: {
    menuList: { type: Array }
  },
  data: function () {
    return {
      scrollSpyId: 'methodologyMenu'
    };
  }
  // mounted: function () {
  //   const scrollSpy = new window.bootstrap.ScrollSpy(document.body, {
  //     target: `#${this.scrollSpyId}`,
  //     offset: 100,
  //     method: 'offset'
  //   });
  // }
};
</script>

<style lang="scss" scoped>
.list-group-item {
  padding-left: 0;
  &.active {
    background-color: inherit !important;
    color: #66CC33 !important;
    font-weight: bolder !important;
  }
  h5 {
    color: inherit;
  }
}

.menu-lv2, .menu-lv3 {
  padding-top: 0.25rem;
  padding-bottom: 0.25rem;
  color: #737A91;
  font-weight: lighter;
}
.sub-item {
  font-size: 14px;
}
</style>
