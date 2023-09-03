import HelloWorld from '@/components/HelloWorld.vue';
import Vue, { Component, CreateElement } from 'vue';

function _initVAC (selector: string, component: Component): void {
  const $elements = document.querySelectorAll<HTMLElement>(selector);
  if ($elements.length === 0) { return; }
  $elements.forEach($element => {
    const props = $element.dataset.props === undefined ? {} : JSON.parse($element.dataset.props);
    const vm = new Vue({
      el: $element,
      render: (h: CreateElement) => h(component, { props: props })
    });
  });
}

_initVAC('.hello-world-vac', HelloWorld);
