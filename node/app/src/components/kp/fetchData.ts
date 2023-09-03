'use strict';

import { DRUPAL_API_VERSION_URL, DRUPAL_DOMAIN } from '@/environment';
import axios from '@axios';
import _ from 'lodash';

const drupalApiPath = `${DRUPAL_DOMAIN}${DRUPAL_API_VERSION_URL}`;

export async function getKpDetail (nid: number): Promise<any> {
  const kpResponse = await axios.get(drupalApiPath + '/kp', { params: { nid: nid } });
  return kpResponse.data.length > 0 ? kpResponse.data[0] : null;
}

export async function fetchKps (params: { [key: string]: any }): Promise<any> {
  const kpResponse = await axios.get(drupalApiPath + '/kp', { params: params });
  return kpResponse.data.length > 0 ? kpResponse.data : [];
}

export async function fetchKpPublicationYears (): Promise<any> {
  const kpResponse = await axios.get(drupalApiPath + '/kp/publication-years');
  return kpResponse.data.length > 0
    ? _.chain(kpResponse.data).unionBy('field_publication_year').map(e => e.field_publication_year).sort().reverse().value()
    : [];
}

export async function fetchVideos (): Promise<any> {
  const vdoResponse = await axios.get(drupalApiPath + '/video-taxonomies', {});
  return vdoResponse.data.length > 0 ? vdoResponse.data : [];
}
