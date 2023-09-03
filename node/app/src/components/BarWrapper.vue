<template>
  <div v-if="formattedData">
    <bar-chart :data="formattedData" :chart-options="chartOptions"></bar-chart>
  </div>
</template>

<script>
import _ from 'lodash';
import BarChart from '@wc/idd-bar-chart/idd-bar-chart.vue';
export default {
  name: 'BarComponent',
  props: {
    data: {
      type: Object,
      default: function () {
        return {
          rawData: [
            {
              id: '60b488f8c05adbfb4ff06078',
              indic_id: 529,
              unit_id: 306,
              area_id: 'CHN',
              x_time: '',
              data_value: 196069.2,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff06079',
              indic_id: 529,
              unit_id: 306,
              area_id: 'IND',
              x_time: '',
              data_value: 71994.6,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff0607a',
              indic_id: 529,
              unit_id: 306,
              area_id: 'IDN',
              x_time: '',
              data_value: 23308.48,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff0607b',
              indic_id: 529,
              unit_id: 306,
              area_id: 'PAK',
              x_time: '',
              data_value: 13748.4,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff0607c',
              indic_id: 529,
              unit_id: 306,
              area_id: 'TUR',
              x_time: '',
              data_value: 12335.24,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff0607d',
              indic_id: 529,
              unit_id: 306,
              area_id: 'RUS',
              x_time: '',
              data_value: 12315.8,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff0607e',
              indic_id: 529,
              unit_id: 306,
              area_id: 'JPN',
              x_time: '',
              data_value: 9665.52,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff0607f',
              indic_id: 529,
              unit_id: 306,
              area_id: 'THA',
              x_time: '',
              data_value: 8295,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff06080',
              indic_id: 529,
              unit_id: 306,
              area_id: 'IRN',
              x_time: '',
              data_value: 7936.45,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff06081',
              indic_id: 529,
              unit_id: 306,
              area_id: 'VNM',
              x_time: '',
              data_value: 6592.12,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff06082',
              indic_id: 529,
              unit_id: 306,
              area_id: 'AUS',
              x_time: '',
              data_value: 6389.12,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff06084',
              indic_id: 529,
              unit_id: 306,
              area_id: 'KOR',
              x_time: '',
              data_value: 6375.6,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff06085',
              indic_id: 529,
              unit_id: 306,
              area_id: 'BGD',
              x_time: '',
              data_value: 6048.9,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff06086',
              indic_id: 529,
              unit_id: 306,
              area_id: 'PHL',
              x_time: '',
              data_value: 5997.68,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff06087',
              indic_id: 529,
              unit_id: 306,
              area_id: 'UZB',
              x_time: '',
              data_value: 2437.081907,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff06088',
              indic_id: 529,
              unit_id: 306,
              area_id: 'KAZ',
              x_time: '',
              data_value: 1842.576,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff06089',
              indic_id: 529,
              unit_id: 306,
              area_id: 'LKA',
              x_time: '',
              data_value: 1429.008753,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff0608a',
              indic_id: 529,
              unit_id: 306,
              area_id: 'NPL',
              x_time: '',
              data_value: 1369.346201,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff0608b',
              indic_id: 529,
              unit_id: 306,
              area_id: 'KHM',
              x_time: '',
              data_value: 1019.822417,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff0608c',
              indic_id: 529,
              unit_id: 306,
              area_id: 'AFG',
              x_time: '',
              data_value: 867.8145971,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff0608d',
              indic_id: 529,
              unit_id: 306,
              area_id: 'AZE',
              x_time: '',
              data_value: 720.4862602,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff0608e',
              indic_id: 529,
              unit_id: 306,
              area_id: 'LAO',
              x_time: '',
              data_value: 671.6015648,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff0608f',
              indic_id: 529,
              unit_id: 306,
              area_id: 'TJK',
              x_time: '',
              data_value: 430.5261495,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff06090',
              indic_id: 529,
              unit_id: 306,
              area_id: 'ARM',
              x_time: '',
              data_value: 408.7262259,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff06091',
              indic_id: 529,
              unit_id: 306,
              area_id: 'MNG',
              x_time: '',
              data_value: 349.210845,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff06092',
              indic_id: 529,
              unit_id: 306,
              area_id: 'GEO',
              x_time: '',
              data_value: 256.6558603,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff06093',
              indic_id: 529,
              unit_id: 306,
              area_id: 'KGZ',
              x_time: '',
              data_value: 209.5107007,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff06094',
              indic_id: 529,
              unit_id: 306,
              area_id: 'FJI',
              x_time: '',
              data_value: 103.7729669,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff06095',
              indic_id: 529,
              unit_id: 306,
              area_id: 'BTN',
              x_time: '',
              data_value: 66.95100427,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff06096',
              indic_id: 529,
              unit_id: 306,
              area_id: 'TLS',
              x_time: '',
              data_value: 54.17881697,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff06097',
              indic_id: 529,
              unit_id: 306,
              area_id: 'VUT',
              x_time: '',
              data_value: 45.96343871,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff06098',
              indic_id: 529,
              unit_id: 306,
              area_id: 'BRN',
              x_time: '',
              data_value: 22.48823914,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff06099',
              indic_id: 529,
              unit_id: 306,
              area_id: 'MYS',
              x_time: '',
              data_value: 4991.152,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff0609a',
              indic_id: 529,
              unit_id: 306,
              area_id: 'MDV',
              x_time: '',
              data_value: 22.16939588,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff0609b',
              indic_id: 529,
              unit_id: 306,
              area_id: 'SGP',
              x_time: '',
              data_value: 20.4514,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff0609c',
              indic_id: 529,
              unit_id: 306,
              area_id: 'TON',
              x_time: '',
              data_value: 17.80983859,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff0609d',
              indic_id: 529,
              unit_id: 306,
              area_id: 'WSM',
              x_time: '',
              data_value: 14.51451513,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff0609e',
              indic_id: 529,
              unit_id: 306,
              area_id: 'KIR',
              x_time: '',
              data_value: 7.436135526,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff0609f',
              indic_id: 529,
              unit_id: 306,
              area_id: 'MHL',
              x_time: '',
              data_value: 6.986936145,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff060a0',
              indic_id: 529,
              unit_id: 306,
              area_id: 'PLW',
              x_time: '',
              data_value: 1.9853592,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff060a1',
              indic_id: 529,
              unit_id: 306,
              area_id: 'TUV',
              x_time: '',
              data_value: 1.677935433,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff060a2',
              indic_id: 529,
              unit_id: 306,
              area_id: 'MMR',
              x_time: '',
              data_value: 0,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff060a3',
              indic_id: 529,
              unit_id: 306,
              area_id: 'NZL',
              x_time: '',
              data_value: 0,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff060a4',
              indic_id: 529,
              unit_id: 306,
              area_id: 'PNG',
              x_time: '',
              data_value: 0,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff060a5',
              indic_id: 529,
              unit_id: 306,
              area_id: 'PRK',
              x_time: '',
              data_value: 0,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff060a6',
              indic_id: 529,
              unit_id: 306,
              area_id: 'TKM',
              x_time: '',
              data_value: 0,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff060a7',
              indic_id: 529,
              unit_id: 306,
              area_id: 'SLB',
              x_time: '',
              data_value: 0,
              tag_id: '',
              metadata_id: ''
            },
            {
              id: '60b488f8c05adbfb4ff060af',
              indic_id: 529,
              unit_id: 306,
              area_id: 'FSM',
              x_time: '',
              data_value: 17.15044111,
              tag_id: '',
              metadata_id: ''
            }
          ]
        };
      }
    },
    chartOptions: {
      type: Object
    }
  },
  data: function () {
    return {
      formattedData: null
    };
  },
  components: {
    BarChart
  },
  watch: {
    data: function () {
      this.initialize();
    },
    chartOptions: function () {
      this.initialize();
    }
  },
  mounted: function () {
    this.initialize();
  },
  methods: {
    initialize: function () {
      if (!this.data || !this.data.rawData) return;

      this.setBarColor();
      const data = this.data;
      const result = [];
      _.each(data.rawData, (d) => {
        const geo = _.find(data.geoes, (geo) => geo.field_iso3 === d.area_id);
        const color = this.chartOptions.barColor
          ? this.chartOptions.barColor
          : geo
            ? geo.field_color
            : '#8F9BB3';
        const obj = {
          label: geo ? geo.name : d.area_id,
          value: d.data_value,
          color: color
        };
        result.push(obj);
      });
      // const unit = _.find(data.units, (d) => d.tid == data.rawData[0].unit_id);
      this.formattedData = {
        data: result
      };
    },
    setBarColor: function () {
      this.chartOptions.barColor = '#BD5F5F';
      const indicIds = this.data.rawData.map((d) => d.indic_id);
      if (indicIds.length === 0) return;

      const firstIndicator = this.data.indicators.find(
        (ind) => ind.tid === indicIds[0]
      );
      const parentId =
        firstIndicator && firstIndicator.parent
          ? firstIndicator.parent
          : firstIndicator.tid;
      if (['1161', '1163'].includes(parentId)) {
        this.chartOptions.barColor = '#00689D';
      }
    }
  }
};
</script>

<style></style>
