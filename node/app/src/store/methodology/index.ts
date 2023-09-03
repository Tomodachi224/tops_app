import { DRUPAL_API_VERSION_URL, DRUPAL_DOMAIN, RAPI_DOMAIN, RAPI_VERSION_URL } from '@/environment';
import axios from 'axios';
import { MutationTree } from 'vuex';

const loopBackApiPath = `${RAPI_DOMAIN}${RAPI_VERSION_URL}`;
const drupalApiPath = `${DRUPAL_DOMAIN}${DRUPAL_API_VERSION_URL}`;

// States
type Methodology = { [key: string]: any };
export interface MethodologyState {
  methodologies: Array<Methodology>;
}
export const state: MethodologyState = {
  methodologies: []
};
export type State = typeof state;
// /State

// Getters
export const getters = {
  getMethodologies: (state: State) => state.methodologies
};
// /Getters

// Mutations
export const mutations: MutationTree<State> = {
  setMethodologies (state: State, val: Array<Methodology>): void {
    state.methodologies = val;
  }
};
// /Mutations

// Actions
export const actions: any = {
  async fetchMethodologies ({ commit }: any): Promise<void> {
    const response = await axios.get(drupalApiPath + '/methodology-taxonomies');
    const methodologies = response.data.length > 0 ? response.data : null;
    commit('setMethodologies', methodologies);
  }
};
// /Actions

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
};
