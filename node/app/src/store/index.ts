import Vue from 'vue';
import Vuex from 'vuex';
import analysis from './analysis';
import kp from './kp';
import methodology from './methodology';
import user from './user';

Vue.use(Vuex);

export default new Vuex.Store({
  // state: {},
  // mutations: {},
  // actions: {},
  modules: {
    analysis,
    kp,
    methodology,
    user
  }
});
