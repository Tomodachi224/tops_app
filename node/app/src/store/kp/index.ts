import { DRUPAL_API_VERSION_URL, DRUPAL_DOMAIN, RAPI_DOMAIN, RAPI_VERSION_URL } from '@/environment';
import axios from 'axios';
import { ActionContext, ActionTree, MutationTree } from 'vuex';

const loopBackApiPath = `${RAPI_DOMAIN}${RAPI_VERSION_URL}`;
const drupalApiPath = `${DRUPAL_DOMAIN}${DRUPAL_API_VERSION_URL}`;

// States
type SelectedNode = { [key: string]: any };
type Tag = { [key: string]: any };
export interface KPState {
  searchKeyword: string;
  selectedYear: string;
  selectedNode: SelectedNode;
  selectedTags: Array<Tag>;
  tags: Array<Tag>;
}
export const state: KPState = {
  searchKeyword: '',
  selectedYear: '',
  selectedNode: {},
  selectedTags: [],
  tags: []
};
export type State = typeof state;
// /State

// Getters
export const getters = {
  getSearchKeyword: (state: State) => state.searchKeyword,
  getSelectedYear: (state: State) => state.selectedYear,
  getSelectedNode: (state: State) => state.selectedNode,
  getSelectedTags: (state: State) => state.selectedTags,
  getTags: (state: State) => state.tags
};
// /Getters

// Mutations
export const mutations: MutationTree<State> = {
  setSearchKeyword (state: State, val: string): void {
    state.searchKeyword = val;
  },
  setSelectedYear (state: State, val: string): void {
    state.selectedYear = val;
  },
  setSelectedNode (state: State, val: SelectedNode): void {
    state.selectedNode = val;
  },
  setSelectedTags (state: State, val: Array<Tag>): void {
    state.selectedTags = val;
  },
  setTags (state: State, val: Array<Tag>): void {
    state.tags = val;
  }
};
// /Mutations

// Actions
export const actions: ActionTree<State, State> = {
  async fetchTags ({ commit }: ActionContext<State, State>): Promise<void> {
    const response = await axios.get(drupalApiPath + '/kp-tag-taxonomies');
    const tags = response.data.length > 0 ? response.data : null;
    commit('setTags', tags);
    commit('setSelectedTags', tags);
  },
  updateSearchKeyword ({ commit }: ActionContext<State, State>, val: string): void {
    commit('setSearchKeyword', val);
  },
  updateSelectedYear ({ commit }: ActionContext<State, State>, val: string): void {
    commit('setSelectedYear', val);
  },
  async updateSelectedNode ({ commit }: ActionContext<State, State>, nid: number): Promise<void> {
    const kpResponse = await axios.get(drupalApiPath + '/kp', { params: { nid: nid } });
    const selectedNode = kpResponse.data.length > 0 ? kpResponse.data[0] : null;
    commit('setSelectedNode', selectedNode);
  },
  updateSelectedTags ({ commit }: ActionContext<State, State>, val: Array<Tag>): void {
    commit('setSelectedTags', val);
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
