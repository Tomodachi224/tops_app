<template>
  <div>
    <div v-if="showPageContent" class="d-block d-lg-none container box-shadow">
      <div style="position: absolute; right: 0;">
        <button
          v-if="showPageContent === true"
          type="button"
          class="close-btn border-0 float-end"
          @click="onClickPageContent($event, false)">
          <i class="uil uil-multiply text-primary" style="font-size: 18px;"></i>
        </button>
      </div>
      <div class="col ps-0 pt-5">
        <kp-filter :tagItems="getTags" :sections="sections" />
      </div>
    </div>
    <div class="container">
      <div class="row container-filter d-none d-lg-block">
        <div class="col ps-0">
          <kp-filter :tagItems="getTags" :sections="sections" />
        </div>
      </div>
      <div class="d-flex justify-content-end">
        <button
          v-if="showPageContent === false"
          class="d-block d-lg-none btn d-flex flex-row align-items-center p-0 m-0 border-0 rounded-1"
          @click="onClickPageContent($event, true)">
          <div class="bg-light-blue-grey3 p-1 py-0 rounded-1"><i class="fw-normal uil uil-list-ul fs-20 text-white"></i></div>
          <span class="fw-light px-2 text-blue-grey4">Page content</span>
        </button>
      </div>
      <div class="row">
        <div class="col col-content">
          <div class="row">
            <div class="col">
              <kp-detail :node-obj="getSelectedNode" :show="true" />
            </div>
          </div>
          <div class="row">
            <div class="col mb-10">
              <kp-section-title
                :id="sections[0].href.substring(1)"
                :title="sections[0].title"
                :tag="sections[0].tag"
              />
              <kp-section
                v-if="actionPlanQueryParams"
                :id="sections[0].children[0].href.substring(1)"
                :title="sections[0].children[0].title"
                :desc="sections[0].children[0].desc"
                :query-params="actionPlanQueryParams"
              />
              <kp-section
                v-if="countryReportQueryParams"
                :id="sections[0].children[1].href.substring(1)"
                :title="sections[0].children[1].title"
                :desc="sections[0].children[1].desc"
                :query-params="countryReportQueryParams"
              />
            </div>
          </div>
          <div class="row">
            <div class="col mb-10">
              <kp-section-title
                :id="sections[1].href.substring(1)"
                :title="sections[1].title"
                :tag="sections[1].tag" />
              <kp-section
                v-if="socialOutlookQueryParams"
                :id="sections[1].children[0].href.substring(1)"
                :title="sections[1].children[0].title"
                :desc="sections[1].children[0].desc"
                :query-params="socialOutlookQueryParams"
              />
              <kp-section
                v-if="policyPaperQueryParams"
                :id="sections[1].children[1].href.substring(1)"
                :title="sections[1].children[1].title"
                :desc="sections[1].children[1].desc"
                :query-params="policyPaperQueryParams"
              />
            </div>
          </div>
          <div class="row">
            <div class="col mb-10">
              <kp-section-title
                :id="sections[2].href.substring(1)"
                :title="sections[2].title"
                :tag="sections[2].tag"
              />
              <kp-section
                v-if="primerQueryParams"
                :id="sections[2].children[0].href.substring(1)"
                :title="sections[2].children[0].title"
                :desc="sections[2].children[0].desc"
                :query-params="primerQueryParams"
              />
              <kp-section-grid
                :id="sections[2].children[1].href.substring(1)"
                :title="sections[2].children[1].title"
                :desc="sections[2].children[1].desc"
                :items="videoPrimerItems"
              />
              <kp-section
                v-if="inequalityQueryParams"
                :id="sections[2].children[2].href.substring(1)"
                :title="sections[2].children[2].title"
                :desc="sections[2].children[2].desc"
                :query-params="inequalityQueryParams"
              />
            </div>
          </div>
        </div>
        <div class="row my-10">
          <div class="col mb-10 text-center">
            <h5 class="fw-light">Have any questions?</h5>
            <a href="/contact">
              <button type="button" class="btn border border-dark rounded-0 text-dark fw-light">Contact us</button>
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex';

import { fetchVideos } from '@/components/kp/fetchData';
import KpDetail from '@/components/kp/KpDetail.vue';
import KpFilter from '@/components/kp/KpFilter.vue';
import KpSection from '@/components/kp/KpSection.vue';
import KpSectionGrid from '@/components/kp/KpSectionGrid.vue';
import KpSectionTitle from '@/components/kp/KpSectionTitle.vue';

export default {
  components: {
    KpFilter,
    KpDetail,
    KpSection,
    KpSectionGrid,
    KpSectionTitle
  },
  data: function () {
    return {
      sections: [
        {
          title: 'Regional and national actions',
          href: '#regional-and-national-actions',
          // tag: { name: 'flagships' },
          children: [
            {
              title: 'Action Plan and Supporting Documents',
              href: '#action-plan',
              desc: null
            },
            {
              title: 'Country reports',
              href: '#country-reports',
              desc: null
            }
            // ,
            // {
            //   title: 'Webinars',
            //   href: '#webinars',
            //   desc: null
            // }
          ]
        },
        {
          title: 'Research',
          href: '#research',
          // tag: { name: 'flagships' },
          children: [
            {
              title: 'Flagship reports',
              href: '#flagship-reports',
              desc: 'The Social Outlook for Asia and the Pacific Series is a biennial flagship publication that highlights social protection and other key social developments trends in the Asia-Pacific region. It analyses how these trends need to be addressed and proposes policy recommendations to realize the 2030 Agenda for Sustainable Development.'
            },
            {
              title: 'Policy papers',
              href: '#policy-papers',
              desc: 'The ESCAP Policy Papers on Social Protection explore various thematic areas.'
            }
          ]
        },
        {
          title: 'Advocacy',
          href: '#advocacy',
          // tag: { name: 'flagships' },
          children: [
            {
              title: 'Primers series on social protection',
              href: '#primers-series-on-social-protection',
              desc: 'The social protection primer series is a comprehensive set of easy-to-digest policy guides developed to support policymakers and practitioners in Asia and the Pacific in their efforts to strengthen social protection.'
            },
            {
              title: 'Video primer series on social protection',
              href: '#video-primer-series-on-social-protection',
              desc: "These videos are part of ESCAP's primer series to build capacity and awareness on social protection."
            },
            {
              title: 'Inequality of Opportunity papers',
              href: '#inequality',
              desc: 'The ESCAP Inequality of Opportunity Papers presents latest evidence from ESCAP Leave No One Behind (LNOB) platform on gaps in access to a variety of opportunities including financial inclusion, clean energy, education and children’s health.'
            }
            // ,
            // {
            //   title: 'Podcasts / Webinars',
            //   href: '#podcasts-webinars',
            //   desc: null
            // }
          ]
        }
      ],
      socialOutlookTags: ['1001', '1002'],
      policyPaperTags: ['1006'],
      inequalityTags: ['1007'],
      primerTags: ['1003'],
      actionPlanTags: ['1004'],
      countryReportTags: ['1005'],
      placeholderTags: ['1001'],
      showInequalitySection: true,
      showPolicyGuideSection: true,
      relatedArticleQueryParams: {},
      socialOutlookQueryParams: { tag_ids: [] },
      policyPaperQueryParams: { tag_ids: [] },
      inequalityQueryParams: { tag_ids: [] },
      primerQueryParams: { tag_ids: [] },
      actionPlanQueryParams: { tag_ids: [] },
      countryReportQueryParams: { tag_ids: [] },
      placeholderQueryParams: { tag_ids: [] },
      videoPrimerItems: [],
      showPageContent: false
    };
  },
  computed: {
    ...mapGetters('kp', [
      'getSearchKeyword',
      'getSelectedYear',
      'getSelectedNode',
      'getSelectedTags',
      'getTags'
    ])
  },
  watch: {
    getSearchKeyword: function () {
      this.socialOutlookQueryParams.keyword = this.getSearchKeyword;
      this.socialOutlookQueryParams = { ...this.socialOutlookQueryParams };
      this.policyPaperQueryParams.keyword = this.getSearchKeyword;
      this.policyPaperQueryParams = { ...this.policyPaperQueryParams };
      this.primerQueryParams.keyword = this.getSearchKeyword;
      this.primerQueryParams = { ...this.primerQueryParams };
      this.actionPlanQueryParams.keyword = this.getSearchKeyword;
      this.actionPlanQueryParams = { ...this.actionPlanQueryParams };
      this.countryReportQueryParams.keyword = this.getSearchKeyword;
      this.countryReportQueryParams = { ...this.countryReportQueryParams };
      this.placeholderQueryParams.keyword = this.getSearchKeyword;
      this.placeholderQueryParams = { ...this.placeholderQueryParams };
    },
    getSelectedYear: function () {
      const yearQueryParams = {
        field_publication_date_value_start: this.getSelectedYear ? `${this.getSelectedYear}-01-01` : null,
        field_publication_date_value_end: this.getSelectedYear ? `${this.getSelectedYear}-12-31` : null
      };
      this.socialOutlookQueryParams = { ...this.socialOutlookQueryParams, ...yearQueryParams };
      this.policyPaperQueryParams = { ...this.policyPaperQueryParams, ...yearQueryParams };
      this.primerQueryParams = { ...this.primerQueryParams, ...yearQueryParams };
      this.actionPlanQueryParams = { ...this.actionPlanQueryParams, ...yearQueryParams };
      this.countryReportQueryParams = { ...this.countryReportQueryParams, ...yearQueryParams };
      this.placeholderQueryParams = { ...this.placeholderQueryParams, ...yearQueryParams };
    },
    getSelectedTags: function () {
      const updateSocialOutlookTags = this.getSelectedTags.map(e => e.tid).filter(value => this.socialOutlookTags.includes(value));
      this.socialOutlookQueryParams.tag_ids = updateSocialOutlookTags;
      this.socialOutlookQueryParams = { ...this.socialOutlookQueryParams };

      const updatePolicyPaperTags = this.getSelectedTags.map(e => e.tid).filter(value => this.policyPaperTags.includes(value));
      this.policyPaperQueryParams.tag_ids = updatePolicyPaperTags;
      this.policyPaperQueryParams = { ...this.policyPaperQueryParams };

      const updateInequalityTags = this.getSelectedTags.map(e => e.tid).filter(value => this.inequalityTags.includes(value));
      this.inequalityQueryParams.tag_ids = updateInequalityTags;
      this.inequalityQueryParams = { ...this.inequalityQueryParams };

      const updatePrimerTags = this.getSelectedTags.map(e => e.tid).filter(value => this.primerTags.includes(value));
      this.primerQueryParams.tag_ids = updatePrimerTags;
      this.primerQueryParams = { ...this.primerQueryParams };

      const updateActionPlanTags = this.getSelectedTags.map(e => e.tid).filter(value => this.actionPlanTags.includes(value));
      this.actionPlanQueryParams.tag_ids = updateActionPlanTags;
      this.actionPlanQueryParams = { ...this.actionPlanQueryParams };

      const updateCountryReportTags = this.getSelectedTags.map(e => e.tid).filter(value => this.countryReportTags.includes(value));
      this.countryReportQueryParams.tag_ids = updateCountryReportTags;
      this.countryReportQueryParams = { ...this.countryReportQueryParams };

      const updatePlaceholderTags = this.getSelectedTags.map(e => e.tid).filter(value => this.placeholderTags.includes(value));
      this.placeholderQueryParams.tag_ids = updatePlaceholderTags;
      this.placeholderQueryParams = { ...this.placeholderQueryParams };
    }
  },
  mounted: function () {
    this.socialOutlookQueryParams.tag_ids = this.socialOutlookTags;
    this.policyPaperQueryParams.tag_ids = this.policyPaperTags;
    this.inequalityQueryParams.tag_ids = this.inequalityTags;
    this.primerQueryParams.tag_ids = this.primerTags;
    this.actionPlanQueryParams.tag_ids = this.actionPlanTags;
    this.countryReportQueryParams.tag_ids = this.countryReportTags;
    this.placeholderQueryParams.tag_ids = this.placeholderTags;
    this.fetchTags();
    this.setVideoPrimerItems();
  },
  methods: {
    ...mapActions('kp', ['fetchTags', 'updateSelectedNode']),
    onClickPageContent: function (e, status) {
      this.showPageContent = status;
    },
    setVideoPrimerItems: async function () {
      const videos = await fetchVideos();
      const videoPrimerItems = [];
      for (const item of videos) {
        videoPrimerItems.push({ id: item.tid, type: 'youtube', src: item.field_link, title: item.name, description: item.description, show_overlay: true });
      }
      this.videoPrimerItems = [...videoPrimerItems];
    }
  }
};
</script>

<style lang="scss" scoped>
.container-filter {
  position: sticky;
  float: left;
  top: 137px;
  width: 230px;
}

.kp-section-title,
.kp-section,
.kp-section-grid {
  scroll-margin-top: calc(100px - 15px); /* 100px is header height, 15px is section padding */
}
.box-shadow {
  box-shadow: 6px 6px 22px 1px rgb(0 0 0 / 10%);
}
</style>
