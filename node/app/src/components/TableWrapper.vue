<template>
  <div>
    <data-table
      :data="dataObjectStr">
      </data-table>
  </div>
</template>

<script>
import DataTable from '@wc/data-table/data-table.vue';

export default {
  props: {
    tableDataId: { type: String }
  },
  data () {
    return {
      dataObj: {},
      dataObjectStr: '{"data":[],"colums":[]}',
      chartOptionsObjStr: ''
    };
  },
  components: {
    DataTable
  },
  mounted () {
    this.getTableData();
  },
  methods: {
    getTableData: function () {
      let dataObj = {
        columns: [],
        data: [],
        allowSearch: false
      };
      if (this.tableDataId === '1') {
        dataObj = {
          columns: [
            {
              name: 'Country',
              type: 'string'
            },
            {
              name: 'Survey year',
              type: 'string'
            }
          ],
          data: [
            ['Armenia', '2019'],
            ['Bangladesh', '2016'],
            ['Bhutan', '2017'],
            ['Cambodia', '2019-2020'],
            ['Cook Islands', '2015'],
            ['Georgia', '2021'],
            ['India', '2011-2012'],
            ['Indonesia', '2017'],
            ['Kiribati', '2019-2020'],
            ['Kyrgyzstan', '2018'],
            ['Lao PDR', '2018-2019'],
            ['Maldives', '2019'],
            ['Marshall Islands', '2019-2020'],
            ['Micronesia', '2013-2014'],
            ['Mongolia', '2018'],
            ['Myanmar', '2015'],
            ['Nepal', '2015-2016'],
            ['Pakistan', '2015-2016'],
            ['Philippines', '2019'],
            ['Sri Lanka', '2016'],
            ['Thailand', '2018'],
            ['Türkiye', '2019'],
            ['Uzbekistan', '2018'],
            ['Viet Nam', '2016']
          ],
          allowSearch: true
        };
      } else if (this.tableDataId === '2') {
        dataObj = {
          columns: [
            {
              name: 'Country',
              type: 'string'
            },
            {
              name: 'Child Benefit',
              type: 'string'
            },
            {
              name: 'Disability Benefit',
              type: 'string'
            },
            {
              name: 'Old age Benefit',
              type: 'string'
            },
            {
              name: 'Household Benefit',
              type: 'string'
            }
          ],
          data: [
            ['Armenia', 'Child Benefit', 'Disability Benefit', 'Old Age Benefit', 'Household Benefit'],
            ['Bangladesh', '', '', 'Old Age Allowance Programme (OAP)', ''],
            ['Cook Islands', 'Child Benefit', 'Infirm Benefit', 'Old Age Pension', ''],
            ['Georgia', '', '', 'Old Age Pension (OAP)', 'Targeted Social Assistance (TSA)'],
            ['India', '', 'Indira Gandhi National Disability Pension Scheme (IGNDPS)', 'Indira Gandhi National Old Age Pension Scheme (IGNOAPS)', ''],
            ['Indonesia', '', '', '', 'Program Keluarga Harapan (PKH)'],
            ['Kiribati', '', '', 'Elderly Fund Scheme', ''],
            ['Kyrgyzstan', '', 'Disability Allowance', 'Social assistance allowance (old age)', ''],
            ['Lao PDR', '', '', '', ''],
            ['Maldives', 'Single Parent Allowance, Foster Parent Allowance', 'Disability Allowance', 'Old Age Basic Pension', ''],
            ['Marshall Islands', '', '', '', ''],
            ['Micronesia', '', '', '', ''],
            ['Mongolia', 'Child Money Programme', 'Social Welfare Pensions and Allowance for the Disabled', 'Social Welfare Pensions and Allowance for the Elderly', ''],
            ['Myanmar', "Children's education", '', 'Old Age pension', ''],
            ['Nepal', 'Child Grant', '', "Senior Citizen's Allowance", ''],
            ['Pakistan', '', '', '', 'Benazir Income Support Programme (BISP)'],
            ['Philippines', '', '', 'Social Pension for Indigent Senior Citizens', 'Pantawid Pamilyang Pilipino Program (4Ps)'],
            ['Sri Lanka', '', '', '', 'Divineguma Programme (previously Samurdhi)'],
            ['Thailand', '', 'Allowances for people living with disabilities', 'Universal Pension Scheme', ''],
            ['Türkiye', '', '', '', 'Allowances for people in target groups'],
            ['Uzbekistan', '', '', '', ''],
            ['Viet Nam', '', '', 'Social Pension Scheme', '']
          ],
          allowSearch: true
        };
      } else if (this.tableDataId === '3') {
        dataObj = {
          columns: [
            {
              name: 'Country',
              type: 'string'
            },
            {
              name: 'Dataset includes questions on disability',
              type: 'string'
            },
            {
              name: 'National prevalence (%)',
              type: 'string'
            },
            {
              name: 'Children Age',
              type: 'string'
            },
            {
              name: 'Children %',
              type: 'string'
            },
            {
              name: 'Adult Age',
              type: 'string'
            },
            {
              name: 'Adult %',
              type: 'string'
            },
            {
              name: 'Older persons Age',
              type: 'string'
            },
            {
              name: 'Older persons %',
              type: 'string'
            },
            {
              name: 'Total',
              type: 'string'
            }
          ],
          data: [
            ['Armenia', 'Yes', '5.1', '0-17 years', '3.9', '18-59 years', '46', '60+ years', '50', '100'],
            ['Bangladesh', 'Yes', '6.7', '0-15 years', '24.4', '16-59 years', '43.1', '60+ years', '32.5', '100'],
            ['Bhutan', 'Yes', '2.8', '0-17 years', '16.5', '18-59 years', '32', '60+ years', '51.4', '100'],
            ['Cambodia', 'Yes', '62', '0-17 years', '0', '18-59 years', '37.2', '60+ years', '62.8', '100'],
            ['Cook Islands', 'No', '1.7', '0-14 years', '6.8', '15-59 years', '76.2', '60+ years', '17', '100'],
            ['Georgia', 'No', '3.2', '0-14 years', '5', '15-59 years', '60', '60+ years', '35', '100'],
            ['India', 'Yes', '2.1', '0-15 years', '10.1', '16-59 years', '31.8', '60+ years', '58.1', '100'],
            ['Indonesia', 'No', '2.5', '0-17 years', '8.8', '18-59 years', '45.4', '60+ years', '45.8', '100'],
            ['Kiribati', 'Yes', '5.8', '0-17 years', '31.9', '18-59 years', '36.8', '60+ years', '31.3', '100'],
            ['Kyrgyzstan', 'No', '2.5', '0-14 years', '5', '15-59 years', '60', '60+ years', '35', '100'],
            ['Lao PDR', 'No', '0.91', '5-17 years', '36.12', '18-59 years', '55.79', '60+ years', '8.09', '100'],
            ['Maldives', 'No', '10.9', '5-14 years', '12.1', '15-49 years', '40.5', '50+ years', '47.4', '100'],
            ['Marshall Islands', 'Yes', '3.5', '5-17 years', '13.47', '18-59 years', '46.57', '60+ years', '39.96', '100'],
            ['Micronesia', 'No', '11', '0-17 years', '40.6', '18-59 years', '52.72', '60+ years', '6.68', '100'],
            ['Mongolia', 'Yes', '3.9', '0-17 years', '9.9', '18-59 years', '66.4', '60+ years', '23.7', '100'],
            ['Myanmar', 'No', '13', '5-17 years', '34.5', '18-59 years', '54.84', '60+ years', '10.65', '100'],
            ['Nepal', 'No', '1.9', '0-19 years', '25.2', '20-59 years', '48.3', '60+ years', '25.6', '100'],
            ['Pakistan', 'No', '2.5', '0-14 years', '5', '15-59 years', '60', '60+ years', '35', '100'],
            ['Philippines', 'No', '1.6', '0-14 years', '18.9', '15-59 years', '52.9', '60+ years', '28.2', '100'],
            ['Sri Lanka', 'Yes', '8.7', '0-14 years', '3.6', '15-59 years', '43.2', '60+ years', '53.2', '100'],
            ['Thailand', 'Yes', '3.2', '0-15 years', '5.6', '16-59 years', '44.9', '60+ years', '49.5', '100'],
            ['Türkiye', 'Yes', '3.8', '0-17 years', '14', '18-59 years', '41.2', '60+ years', '44.8', '100'],
            ['Uzbekistan', 'Yes', '3.5', '0-17 years', '33.42', '18-59 years', '58.42', '60+ years', '8.16', '100'],
            ['Vietnam', 'No', '7.8', '5-15 years', '3.8', '16-59 years', '41.8', '60+ years', '54.6', '100']
          ],
          allowSearch: true
        };
      } else if (this.tableDataId === '4') {
        dataObj = {
          columns: [
            {
              name: 'Acronym',
              type: 'string'
            },
            {
              name: 'Name',
              type: 'string'
            }
          ],
          data: [
            ['4Ps', 'Pantawid Pamilyang Pilipino Program'],
            ['AHS', 'Annual Household Survey'],
            ['APIS', 'Annual Poverty Indicator Survey, Philippines'],
            ['BLSS', 'Bhutan Living Standard Survey'],
            ['BISP', 'Benazir Income Support Programme'],
            ['CSES', 'Cambodia Socio-Economic Survey'],
            ['EA', 'Economic Affairs'],
            ['FGT', 'Foster-Greer-Thorbecke'],
            ['GDP', 'Gross Domestic Product'],
            ['GEL', 'Georgian Lari'],
            ['GFS', 'Government Finance Statistics, IMF'],
            ['GPS', 'General Public Services'],
            ['HIES', 'Household Integrated Economic Survey, Pakistan'],
            ['HIICS', 'Household Integrated Income & Consumption survey'],
            ['HILCS', "Households' Integrated Living Conditions Survey"],
            ['HSES', 'Household Socio-Economic Survey, Mongolia'],
            ['IDR', 'Indonesian Rupiah'],
            ['IFF', 'Illicit Financial Flows'],
            ['IGNDPS', 'Indira Gandhi National Disability Pension Scheme'],
            ['IGNOAPS', 'Indira Gandhi National Old Age Pension Scheme'],
            ['IHDS', 'India Human Development Survey, India'],
            ['IMF', 'International Monetary Fund'],
            ['INR', 'Indian Rupee'],
            ['KIHS', 'Kyrgyz Integrated Household Survey'],
            ['MNT', 'Mongolian Tugrik'],
            ['OAP', 'Old Age Pension'],
            ['PHP', 'Philippine Piso'],
            ['PKH', 'Program Keluarga Harapan'],
            ['PKR', 'Pakistani Rupee'],
            ['PMT', 'Proxy Means test'],
            ['POS', 'Public order services'],
            ['PPP', 'Purchasing Power Parity'],
            ['SES', '(Household) Socio-Economic Survey'],
            ['SP', 'Social Protection'],
            ['SUSENAS', 'Survei Sosial Ekonomi Nasional, National Socio-Economic Survey'],
            ['TSA', 'Targeted Social Assistant, Georgia'],
            ['UNDESA', 'United Nations Department of Economic and Social Affairs'],
            ['USD', 'United States Dollar'],
            ['VHLSS', 'Vietnam Household Living Standards Survey'],
            ['VND', 'Vietnamese Dong'],
            ['WMS', 'Household Incomes and Expenditures Survey (HIES), Georgia']
          ],
          allowSearch: true
        };
      } else if (this.tableDataId === '5') {
        dataObj = {
          columns: [
            {
              name: 'Variables',
              type: 'string',
              orderable: false
            },
            {
              name: 'Armenia',
              type: 'string',
              orderable: false
            },
            {
              name: 'Bangladesh',
              type: 'string',
              orderable: false
            },
            {
              name: 'Bhutan',
              type: 'string',
              orderable: false
            },
            {
              name: 'Cambodia',
              type: 'string',
              orderable: false
            },
            {
              name: 'Cook Islands',
              type: 'string',
              orderable: false
            },
            {
              name: 'Georgia',
              type: 'string',
              orderable: false
            },
            {
              name: 'India',
              type: 'string',
              orderable: false
            },
            {
              name: 'Indonesia',
              type: 'string',
              orderable: false
            },
            {
              name: 'Kiribati',
              type: 'string',
              orderable: false
            },
            {
              name: 'Kyrgyzstan',
              type: 'string',
              orderable: false
            },
            {
              name: 'Maldives',
              type: 'string',
              orderable: false
            },
            {
              name: 'Mongolia',
              type: 'string',
              orderable: false
            },
            {
              name: 'Nepal',
              type: 'string',
              orderable: false
            }
          ],
          data: [
            ['Number of children', '0.0524**', '0.0850***', '0.155***', '0.0795***', '0.0193', '0.181***', '0.101***', '0.0660***', '0.0761***', '0.0912***', '0.0738***', '0.0277', '0.0650***', '0.0749***', '0.0639***', '0.152***', '0.186***', '0.0953***', '0.138***'],
            ['Standard error', '(0.022)', '(0.012)', '(0.014)', '(0.013)', '(0.056)', '(0.039)', '(0.008)', '(0.012)', '(0.022)', '(0.017)', '(0.019)', '(0.018)', '(0.018)', '(0.008)', '(0.008)', '(0.012)', '(0.010)', '(0.018)', '(0.016)'],
            ['Proportion of children', '-0.595***', '-0.620***', '-0.820***', '-0.606***', '-0.360*', '-1.047***', '-0.725***', '-0.752***', '-0.869***', '-0.636***', '-0.944***', '-0.373***', '-0.510***', '-0.870***', '-0.939***', '-0.716***', '-1.116***', '-1.039***', '-0.723***'],
            ['Standard error', '(0.109)', '(0.052)', '(0.061)', '(0.062)', '(0.189)', '(0.177)', '(0.043)', '(0.052)', '(0.125)', '(0.073)', '(0.098)', '(0.091)', '(0.089)', '(0.052)', '(0.041)', '(0.048)', '(0.038)', '(0.083)', '(0.067)'],
            ['Female head of household', '-0.0465**', '0.155***', '0.00277', '-0.0597***', '0.0461', '-0.0940***', '-0.0946***', '-0.0529***', '-0.0327', '-0.0712***', '-0.0053', '-0.0368**', '-0.0446**', '0.0703**', '0.0590***', '-0.00937', '-0.0196***', '-0.00678', '0.0214*'],
            ['Standard error', '(0.022)', '(0.013)', '(0.011)', '(0.018)', '(0.053)', '(0.033)', '(0.020)', '(0.018)', '(0.029)', '(0.024)', '(0.021)', '(0.014)', '(0.018)', '(0.031)', '(0.012)', '(0.011)', '(0.006)', '(0.019)', '(0.013)'],
            ['Asset index', '', '0.0964***', '0.110***', '0.127***', '0.0837***', '0.147***', '0.509***', '0.418***', '', '', '-0.130***', '0.106***', '0.106***', '0.0923***', '0.163***', '0.172***', '0.102***', '0.0971***', '0.260***'],
            ['Standard error', '', '(0.002)', '(0.003)', '(0.003)', '(0.011)', '(0.007)', '(0.014)', '(0.009)', '', '', '(0.006)', '(0.003)', '(0.005)', '(0.006)', '(0.003)', '(0.002)', '(0.001)', '(0.004)', '(0.005)'],
            ['Number of rooms', '', '0.0829***', '0.0457***', '0.0719***', '0.0344**', '', '0.0723***', '', '0.0912***', '-0.0224', '', '0.135***', '0.300***', '', '0.136***', '0.0787***', '0.0706***', ''],
            ['Standard error', '', '(0.009)', '(0.003)', '(0.007)', '(0.016)', '', '(0.008)', '(0.013)', '(0.025)', '(0.018)', '(0.012)', '', '(0.012)', '(0.007)', '(0.008)', ''],
            ['Size of the dwelling', '', '0.0634***', '', '', '', '0.119*** ', '', '0.102***', '', '', '', '', '', '', '0.0541***', '', '', '', '0.160***'],
            ['Standard error', '', '(0.006)', '', '', '', '(0.022)', '', '(0.009)', '', '', '', '', '', '', '(0.006)', '', '', '', '(0.010)'],
            ['Presence of children who work', '-0.108', '0.0226', '-0.0486', '', '0.0098', '0.028', '0.0420**', '0.110***', '0.0117', '', '-0.0946', '0.106***', '', '-0.0169', '0.0333*', '0.0509', '0.0145*', '', '-0.00659'],
            ['Standard error', '(0.094)', '(0.046)', '(0.042)', '', '(0.101)', '(0.054)', '(0.017)', '(0.022)', '(0.066)', '', '(0.067)', '(0.036)', '', '(0.013)', '(0.017)', '(0.038)', '(0.009)', '', '(0.018)'],
            ['Wage employment', '-0.136***', '', '-0.0179', '-0.0487***', '0.239***', '0.194***', '0.0931***', '', '0.156**', '', '0.0867***', '-0.0671***', '', '0.0106', '0.0980***', '-0.125***', '0.141***', '0.161***', '-0.0162'],
            ['Standard error', '(0.048)', '', '(0.016)', '(0.017)', '(0.075)', '(0.039)', '(0.014)', '', '(0.071)', '', '(0.023)', '(0.011)', '', '(0.075)', '(0.009)', '(0.024)', '(0.018)', '(0.016)', '(0.011)'],
            ['Self-employment', '-0.172***', '', '0.0328**', '0.00695', '0.842***', '', '', '', '0.0482', '', '0.0454', '', '', '', '', '-0.138***', '0.0601***', '0.205***', ''],
            ['Standard error', '(0.049)', '', '(0.014)', '(0.016)', '(0.149)', '', '', '', '(0.050)', '', '(0.038)', '', '', '', '', '(0.024)', '(0.018)', '(0.019)', ''],
            ['Working', '0.192', '', '', '', '0.0567', '', '', '', '-0.0251', '', '', '0.207***', '', '', '0.0462***', '0.134***', '-0.0266', '', '-0.01'],
            ['Standard error', '(0.049)', '', '', '', '(0.084)', '', '', '', '(0.070)', '', '', '(0.012)', '', '', '(0.013)', '(0.024)', '(0.019)', '', '(0.019)'],
            ['Wage employment (agriculture)', '', '0.0409', '', '', '', '', '', '', '', '0.0458*', '', '', '', '', '', '', '', '', ''],
            ['Standard error', '', '(0.047)', '', '', '', '', '', '', '', '(0.024)', '', '', '', '', '', '', '', '', ''],
            ['Wage employment (not agriculture)', '', '0.0490***', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''],
            ['Standard error', '', '(0.009)', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''],
            ['Self-employment (agriculture)', '', '0.0669***', '', '', '', '-0.0481', '-0.0249**', '', '', '', '', '0.00501', '', '0.0883', '', '', '', '', '-0.0966***'],
            ['Standard error', '', '(0.011)', '', '', '', '(0.031)', '(0.012)', '', '', '', '', '(0.067)', '', '(0.075)', '', '', '', '', '(0.012)'],
            ['Self-employment (not agriculture)', '', '0.0998***', '', '', '', '', '0.0423***', '', '', '', '', '', '', '0.0993', '', '', '', '', '0.0409***'],
            ['Standard error', '', '(0.011)', '', '', '', '', '(0.016)', '', '', '', '', '', '', '(0.076)', '', '', '', '', '(0.012)'],
            ['Type of work 1', '', '', '', '', '', '', '', '0.00841', '', '', '', '', '', '', '', '', '', '', ''],
            ['Standard error', '', '', '', '', '', '', '', '(0.016)', '', '', '', '', '', '', '', '', '', '', ''],
            ['Type of work 2', '', '', '', '', '', '', '', '-0.0427**', '', '', '', '', '', '', '', '', '', '', ''],
            ['Standard error', '', '', '', '', '', '', '', '(0.017)', '', '', '', '', '', '', '', '', '', '', ''],
            ['Type of work 3', '', '', '', '', '', '', '', '0.176***', '', '', '', '', '', '', '', '', '', '', ''],
            ['Standard error', '', '', '', '', '', '', '', '(0.025)', '', '', '', '', '', '', '', '', '', '', ''],
            ['Type of work 4', '', '', '', '', '', '', '', '0.0520***', '', '', '', '', '', '', '', '', '', '', ''],
            ['Standard error', '', '', '', '', '', '', '', '(0.016)', '', '', '', '', '', '', '', '', '', '', ''],
            ['Type of work 5', '', '', '', '', '', '', '', '-0.0543***', '', '', '', '', '', '', '', '', '', '', ''],
            ['Standard error', '', '', '', '', '', '', '', '(0.019)', '', '', '', '', '', '', '', '', '', '', ''],
            ['Type of work 6', '', '', '', '', '', '', '', '0.0168', '', '', '', '', '', '', '', '', '', '', ''],
            ['Standard error', '', '', '', '', '', '', '', '(0.049)', '', '', '', '', '', '', '', '', '', '', ''],
            ['Household size', '-0.0474***', '-0.142***', '-0.191***', '-0.139***', '-0.166***', '-0.131***', '-0.132***', '-0.141***', '-0.107***', '-0.149***', '-0.0927***', '-0.172***', '-0.113***', '-0.111***', '-0.117***', '-0.198***', '-0.185***', '-0.167***', '-0.186***'],
            ['Standard error', '(0.006)', '(0.005)', '(0.005)', '(0.005)', '(0.030)', '(0.012)', '(0.003)', '(0.005)', '(0.009)', '(0.008)', '(0.008)', '(0.006)', '(0.007)', '(0.005)', '(0.004)', '(0.004)', '(0.003)', '(0.007)', '(0.005)'],
            ['Age', '-0.0116***', '0.00973***', '-0.00508**', '0.00749***', '-0.00264', '-0.00726', '0.00867***', '-0.00223', '0.00672', '0.0170***', '-0.0124', '0.00116', '-0.00356', '0.0143***', '-0.00204', '-0.00334**', '-0.00448***', '0.0162***', '0.00778***'],
            ['Standard error', '(0.003)', '(0.002)', '(0.002)', '(0.002)', '(0.008)', '(0.007)', '(0.002)', '(0.002)', '(0.005)', '(0.004)', '(0.004)', '(0.002)', '(0.003)', '(0.003)', '(0.002)', '(0.002)', '(0.001)', '(0.003)', '(0.002)'],
            ['Age squared', '6.36e-05**', '-7.51e-05***', '0.00000241', '-9.31e-05***', '0.00000854', '0.0000202', '-8.34e-05***', '-0.0000228', '-0.000101*', '-0.000152***', '-0.0000292', '0.0000107', '0.0000116', '-0.000124***', '-3.42E-06', '-9.91E-06', '-3.74E-06', '-0.000138***', '-7.58e-05***'],
            ['Standard error', '(0.000)', '(0.000)', '(0.000)', '(0.000)', '(0.000)', '(0.000)', '(0.000)', '(0.000)', '(0.000)', '(0.000)', '(0.000)', '(0.000)', '(0.000)', '(0.000)', '(0.000)', '(0.000)', '(0.000)', '(0.000)', '(0.000)'],
            ['Location (urban/rural)', '0.00643', '-0.0539***', '-0.0963***', '0.0398***', '-0.0823', '0.0929***', '', '-0.0236***', '-0.544***', '0.0155', '', '0.200***', '', '', '-0.0859***', '', '', '', '0.133***'],
            ['Standard error', '(0.018)', '(0.009)', '(0.014)', '(0.011)', '(0.057)', '(0.028)', '', '(0.009)', '(0.062)', '(0.020)', '', '(0.009)', '', '', '(0.009)', '', '', '', '(0.011)'],
            ['Location 1', '', '', '', '', '', '', '-0.143***', '', '', '', '', '', '', '', '', '', '', '', ''],
            ['Standard error', '', '', '', '', '', '', '(0.011)', '', '', '', '', '', '', '', '', '', '', '', ''],
            ['Location 2', '', '', '', '', '', '', '-0.011', '', '', '', '', '', '', '', '', '', '', '', ''],
            ['Standard error', '', '', '', '', '', '', '(0.013)', '', '', '', '', '', '', '', '', '', '', '', ''],
            ['Location 3', '', '', '', '', '', '', '0.000598', '', '', '', '', '', '', '', '', '', '', '', ''],
            ['Standard error', '', '', '', '', '', '', '(0.014)', '', '', '', '', '', '', '', '', '', '', '', ''],
            ['Presence of orphan children', '', '', '', '', '', '', '0.018', '', '', '', '', '', '', '0.0133', '', '', '', '', '-0.0295'],
            ['Standard error', '', '', '', '', '', '', '(0.040)', '', '', '', '', '', '', '(0.025)', '', '', '', '', '(0.020)'],
            ['Constant', '11.61***', '8.094***', '9.851***', '13.28***', '6.886***', '5.883***', '7.163***', '13.68***', '5.846***', '8.698***', '9.098***', '12.72***', '9.132***', '7.887***', '8.503***', '10.12***', '9.582***', '6.857***', '4.900***'],
            ['Standard error', '(0.157)', '(0.067)', '(0.061)', '(0.063)', '(0.392)', '(0.373)', '(0.066)', '(0.061)', '(0.164)', '(0.112)', '(0.115)', '(0.062)', '(0.074)', '(0.108)', '(0.056)', '(0.059)', '(0.090)', '(0.070)', '(0.080)'],
            ['Observations', '4,920', '26,558', '11,660', '10,067', '684', '4,484', '41,357', '27,959', '2,182', '5,015', '4,746', '16,450', '4,500', '11,549', '39,310', '21,756', '44,609', '11,521', '9,347'],
            ['R-squared', '0.226', '0.55', '0.587', '0.525', '0.558', '0.403', '0.447', '0.528', '0.407', '0.425', '0.485', '0.474', '0.442', '0.648', '0.576', '0.512', '0.67', '0.56', '0.705']
          ],
          allowSearch: true
        };
      }

      this.dataObj = { ...dataObj };
      this.dataObjectStr = JSON.stringify(this.dataObj);
    }
  }
};
</script>
