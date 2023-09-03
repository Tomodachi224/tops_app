export const filterPanelInputs = {
  pageLevel: {
    selectedObject: {
      scheme: ['70001', '70002', '70003']
    },
    filters: [
      {
        label: 'Select benefit programme(s):',
        type: 'checkbox',
        key: 'scheme',
        items: [
          { value: '70001', label: 'Child' },
          { value: '70002', label: 'Disability' },
          { value: '70003', label: 'Old Age' }
        ],
        style: '',
        class: '',
        no_border: true
      }
    ]
  },
  scenario1: {
    selectedObject: {
      country: '50004',
      benefit_level: '30002',
      poverty_mean_tested: '80001'
    },
    countryFilters: [
      {
        label: 'Scenario A:',
        key: 'country',
        items: [
          { value: '50002', label: 'Bangladesh' },
          { value: '50004', label: 'Cambodia' },
          { value: '50017', label: 'Thailand' }
        ],
        style: '',
        class: '',
        no_border: true
      }
    ],
    filters: [
      {
        id: 'scenario1_benefit_level',
        label: 'Select benefit level:',
        key: 'benefit_level',
        type: 'radio',
        items: [
          {
            value: '30002',
            label: 'Global Average',
            tooltip_text: `
            <table class="table table-borderless m-0">
              <thead class="text-grey-additional" style="font-size: 0.7rem;">
                <tr class="align-top">
                  <th class="p-1 fw-light">Benefit programme</th>
                  <th class="p-1 fw-light text-nowrap">Benefit level</br>(% GDP per capita)</th>
                </tr>
              </thead>
              <tbody class="text-main-body-text fw-bold" style="font-size: 0.8rem;">
                <tr class="border-1 border-top-0 border-start-0 border-end-0 border border-light-blue-grey3">
                  <td class="p-1">Child</td>
                  <td class="p-1 text-end">4%</td>
                </tr>
                <tr class="border-1 border-top-0 border-start-0 border-end-0 border border-light-blue-grey3">
                  <td class="p-1">Disability</td>
                  <td class="p-1 text-end">14%</td>
                </tr>
                <tr>
                  <td class="p-1">Old age</td>
                  <td class="p-1 text-end">16%</td>
                </tr>
              </tbody>
            </table>
            `
          },
          {
            value: '30003',
            label: 'OECD Average',
            tooltip_text: `
            <table class="table table-borderless m-0">
              <thead class="text-grey-additional" style="font-size: 0.7rem;">
                <tr class="align-top">
                  <th class="p-1 fw-light">Benefit programme</th>
                  <th class="p-1 fw-light text-nowrap">Benefit level</br>(% GDP per capita)</th>
                </tr>
              </thead>
              <tbody class="text-main-body-text fw-bold" style="font-size: 0.8rem;">
                <tr class="border-1 border-top-0 border-start-0 border-end-0 border border-light-blue-grey3">
                  <td class="p-1">Child</td>
                  <td class="p-1 text-end">4%</td>
                </tr>
                <tr class="border-1 border-top-0 border-start-0 border-end-0 border border-light-blue-grey3">
                  <td class="p-1">Disability</td>
                  <td class="p-1 text-end">23%</td>
                </tr>
                <tr>
                  <td class="p-1">Old age</td>
                  <td class="p-1 text-end">22%</td>
                </tr>
              </tbody>
            </table>
            `
          }
        ],
        style: '',
        class: ''
      },
      {
        id: 'scenario1_pmt',
        label: 'Select eligibility:',
        key: 'poverty_mean_tested',
        type: 'radio',
        visible: false,
        no_border: true,
        items: [
          {
            value: '80001',
            label: 'Universal',
            tooltip_text: `
            <p class="text-main-body-text" style="font-size: 0.8rem;">All households with individuals in a given category are covered:</p>
            <table class="table table-borderless m-0">
              <thead class="text-grey-additional" style="font-size: 0.7rem;">
                <tr class="align-top">
                  <th class="p-1 fw-light">Benefit programme</th>
                  <th class="p-1 fw-light">Category</th>
                </tr>
              </thead>
              <tbody class="text-main-body-text fw-bold" style="font-size: 0.8rem;">
                <tr class="border-1 border-top-0 border-start-0 border-end-0 border border-light-blue-grey3">
                  <td class="p-1">Child</td>
                  <td class="p-1">0-18</td>
                </tr>
                <tr class="border-1 border-top-0 border-start-0 border-end-0 border border-light-blue-grey3">
                  <td class="p-1">Disability</td>
                  <td class="p-1">0 and above</td>
                </tr>
                <tr>
                  <td class="p-1">Old age</td>
                  <td class="p-1">65 and above</td>
                </tr>
              </tbody>
            </table>
            `
          },
          {
            value: '80002',
            label: 'Targeted',
            tooltip_text: `
            <p class="text-main-body-text m-0" style="font-size: 0.8rem;">Restrict recipients to those living in poorest 40 per cent of households.</p>
            `
          }
        ],
        style: '',
        class: ''
      }
    ]
  },
  scenario2: {
    selectedObject: {
      country: '50004',
      benefit_level: '30002',
      poverty_mean_tested: '80001'
    },
    countryFilters: [
      {
        label: 'Scenario B:',
        key: 'country',
        items: [
          { value: '50002', label: 'Bangladesh' },
          { value: '50004', label: 'Cambodia' },
          { value: '50017', label: 'Thailand' }
        ],
        style: '',
        class: '',
        no_border: true
      }
    ],
    filters: [
      {
        id: 'scenario2_benefit_level',
        label: 'Select benefit level:',
        key: 'benefit_level',
        type: 'radio',
        items: [
          {
            value: '30002',
            label: 'Global Average',
            tooltip_text: `
            <table class="table table-borderless m-0">
              <thead class="text-grey-additional" style="font-size: 0.7rem;">
                <tr class="align-top">
                  <th class="p-1 fw-light">Benefit programme</th>
                  <th class="p-1 fw-light text-nowrap">Benefit level</br>(% GDP per capita)</th>
                </tr>
              </thead>
              <tbody class="text-main-body-text fw-bold" style="font-size: 0.8rem;">
                <tr class="border-1 border-top-0 border-start-0 border-end-0 border border-light-blue-grey3">
                  <td class="p-1">Child</td>
                  <td class="p-1 text-end">4%</td>
                </tr>
                <tr class="border-1 border-top-0 border-start-0 border-end-0 border border-light-blue-grey3">
                  <td class="p-1">Disability</td>
                  <td class="p-1 text-end">14%</td>
                </tr>
                <tr>
                  <td class="p-1">Old age</td>
                  <td class="p-1 text-end">16%</td>
                </tr>
              </tbody>
            </table>
            `
          },
          {
            value: '30003',
            label: 'OECD Average',
            tooltip_text: `
            <table class="table table-borderless m-0">
              <thead class="text-grey-additional" style="font-size: 0.7rem;">
                <tr class="align-top">
                  <th class="p-1 fw-light">Benefit programme</th>
                  <th class="p-1 fw-light text-nowrap">Benefit level</br>(% GDP per capita)</th>
                </tr>
              </thead>
              <tbody class="text-main-body-text fw-bold" style="font-size: 0.8rem;">
                <tr class="border-1 border-top-0 border-start-0 border-end-0 border border-light-blue-grey3">
                  <td class="p-1">Child</td>
                  <td class="p-1 text-end">4%</td>
                </tr>
                <tr class="border-1 border-top-0 border-start-0 border-end-0 border border-light-blue-grey3">
                  <td class="p-1">Disability</td>
                  <td class="p-1 text-end">23%</td>
                </tr>
                <tr>
                  <td class="p-1">Old age</td>
                  <td class="p-1 text-end">22%</td>
                </tr>
              </tbody>
            </table>
            `
          }
        ],
        style: '',
        class: ''
      },
      {
        id: 'scenario2_pmt',
        label: 'Select eligibility:',
        key: 'poverty_mean_tested',
        type: 'radio',
        visible: false,
        no_border: true,
        items: [
          {
            value: '80001',
            label: 'Universal',
            tooltip_text: `
            <p class="text-main-body-text" style="font-size: 0.8rem;">All households with individuals in a given category are covered:</p>
            <table class="table table-borderless m-0">
              <thead class="text-grey-additional" style="font-size: 0.7rem;">
                <tr class="align-top">
                  <th class="p-1 fw-light">Benefit programme</th>
                  <th class="p-1 fw-light">Category</th>
                </tr>
              </thead>
              <tbody class="text-main-body-text fw-bold" style="font-size: 0.8rem;">
                <tr class="border-1 border-top-0 border-start-0 border-end-0 border border-light-blue-grey3">
                  <td class="p-1">Child</td>
                  <td class="p-1">0-18</td>
                </tr>
                <tr class="border-1 border-top-0 border-start-0 border-end-0 border border-light-blue-grey3">
                  <td class="p-1">Disability</td>
                  <td class="p-1">0 and above</td>
                </tr>
                <tr>
                  <td class="p-1">Old age</td>
                  <td class="p-1">65 and above</td>
                </tr>
              </tbody>
            </table>
            `
          },
          {
            value: '80002',
            label: 'Targeted',
            tooltip_text: `
            <p class="text-main-body-text m-0" style="font-size: 0.8rem;">Restrict recipients to those living in poorest 40 per cent of households.</p>
            `
          }
        ],
        style: '',
        class: ''
      }
    ]
  }
};
