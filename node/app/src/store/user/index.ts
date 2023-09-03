import { DRUPAL_API_VERSION_URL, DRUPAL_DOMAIN, RAPI_DOMAIN, RAPI_VERSION_URL } from '@/environment';
import axios from '@axios';

const loopBackApiPath = `${RAPI_DOMAIN}${RAPI_VERSION_URL}`;
const drupalApiPath = `${DRUPAL_DOMAIN}${DRUPAL_API_VERSION_URL}`;
const pShinyApiPath = 'https://pshiny.thinkbluedata.com';
const drupalDomain = `${DRUPAL_DOMAIN}`;

const state: any = {
  userData: undefined
};
const getters = {
  getuserData: (state: any) => state.userData
};
const actions = {
  async fetchUserData (context: any) {
    const tempData = await axios
      .get(drupalApiPath + '/get-current-user?_format=hal_json')
      .catch((error: any) => {
        console.log('error', error);
      });

    let userObj;
    if (tempData) {
      const currentUser = tempData.data;
      userObj = {
        uid: currentUser.user.uid[0].value,
        uuid: currentUser.user.uuid[0].value,
        name: currentUser.user.name[0].value,
        roles: currentUser.user.roles ? currentUser.user.roles.map((r: any) => r.target_id) : []
      };
    }

    // console.log('userObj', userObj);
    context.commit('setuserData', userObj);
  }
};
const mutations = {
  setuserData: (state: any, res: any) => (state.userData = res)
};

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
};
