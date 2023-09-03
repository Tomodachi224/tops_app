export const mockGridData = [
  {
    parent: 'home',
    id: '1000',
    type: 'chart-section',
    layout: { x: 0, y: 0, w: 8, h: 24, i: '1000' },
    data: {
      title: 'Simulated coverage of the whole population, by consumption expenditure deciles',
      tabs: [
        {
          title: 'Bar',
          isVertical: true,
          chart: {
            name: 'bar-chart',
            params: {
              autoWidth: true,
              height: 485,
              marginBottom: 100,
              marginLeft: 180,
              isHeightByData: true,
              data: '{"data":{"x_label":"Coverage (%)","y_label":"Deciles","x_unit_label":"","tooltip_unit_label":"","tooltip":{"value":"<strong>[[internal#label]]</strong><br>Value: [[internal#percentage]]"},"data":[{"label":"2","order":2,"values":{"Urban":92,"Rural":93.1},"max_sum":{"id":"61ee5a41885965000864098a","parameter":"1","country":"50004","indicator":"40001","type_of_result":"60001","scheme":"70001","value_type":"Urban","label":"2","value":92,"benefit_level":"30001","poverty_mean_tested":"80001","value_type_id":"10002","order":2}},{"label":"3","order":3,"values":{"Urban":87.1,"Rural":91.9},"max_sum":{"id":"61ee5a41885965000864098b","parameter":"1","country":"50004","indicator":"40001","type_of_result":"60001","scheme":"70001","value_type":"Urban","label":"3","value":87.1,"benefit_level":"30001","poverty_mean_tested":"80001","value_type_id":"10002","order":3}},{"label":"4","order":4,"values":{"Urban":85.6,"Rural":88.9},"max_sum":{"id":"61ee5a41885965000864098c","parameter":"1","country":"50004","indicator":"40001","type_of_result":"60001","scheme":"70001","value_type":"Urban","label":"4","value":85.6,"benefit_level":"30001","poverty_mean_tested":"80001","value_type_id":"10002","order":4}},{"label":"5","order":5,"values":{"Urban":86.9,"Rural":86.9},"max_sum":{"id":"61ee5a41885965000864098d","parameter":"1","country":"50004","indicator":"40001","type_of_result":"60001","scheme":"70001","value_type":"Urban","label":"5","value":86.9,"benefit_level":"30001","poverty_mean_tested":"80001","value_type_id":"10002","order":5}},{"label":"6","order":6,"values":{"Urban":83.8,"Rural":84.1},"max_sum":{"id":"61ee5a41885965000864098e","parameter":"1","country":"50004","indicator":"40001","type_of_result":"60001","scheme":"70001","value_type":"Urban","label":"6","value":83.8,"benefit_level":"30001","poverty_mean_tested":"80001","value_type_id":"10002","order":6}},{"label":"7","order":7,"values":{"Urban":79.7,"Rural":82.5},"max_sum":{"id":"61ee5a41885965000864098f","parameter":"1","country":"50004","indicator":"40001","type_of_result":"60001","scheme":"70001","value_type":"Urban","label":"7","value":79.7,"benefit_level":"30001","poverty_mean_tested":"80001","value_type_id":"10002","order":7}},{"label":"8","order":8,"values":{"Urban":76.7,"Rural":76.5},"max_sum":{"id":"61ee5a418859650008640990","parameter":"1","country":"50004","indicator":"40001","type_of_result":"60001","scheme":"70001","value_type":"Urban","label":"8","value":76.7,"benefit_level":"30001","poverty_mean_tested":"80001","value_type_id":"10002","order":8}},{"label":"9","order":9,"values":{"Urban":69.2,"Rural":72.8},"max_sum":{"id":"61ee5a418859650008640991","parameter":"1","country":"50004","indicator":"40001","type_of_result":"60001","scheme":"70001","value_type":"Urban","label":"9","value":69.2,"benefit_level":"30001","poverty_mean_tested":"80001","value_type_id":"10002","order":9}},{"label":"Lowest","order":1,"values":{"Urban":95.3,"Rural":94.9},"max_sum":{"id":"61ee5a418859650008640989","parameter":"1","country":"50004","indicator":"40001","type_of_result":"60001","scheme":"70001","value_type":"Urban","label":"Lowest","value":95.3,"benefit_level":"30001","poverty_mean_tested":"80001","value_type_id":"10002","order":1}},{"label":"Highest","order":10,"values":{"Urban":66.5,"Rural":70.3},"max_sum":{"id":"61ee5a418859650008640992","parameter":"1","country":"50004","indicator":"40001","type_of_result":"60001","scheme":"70001","value_type":"Urban","label":"Highest","value":66.5,"benefit_level":"30001","poverty_mean_tested":"80001","value_type_id":"10002","order":10}},{"label":"Total","order":11,"values":{"Urban":80.7,"Rural":86.8},"max_sum":{"id":"61ee5a418859650008640993","parameter":"1","country":"50004","indicator":"40001","type_of_result":"60001","scheme":"70001","value_type":"Urban","label":"Total","value":80.7,"benefit_level":"30001","poverty_mean_tested":"80001","value_type_id":"10002","order":11}}],"sort_order":"DESC","colors":{"Urban":"#2971b4","Rural":"#a0cdf8"}}}',
              orderByField: 'order',
              barOrientation: 'horizontal-grouped'
            }
          },
          insight: 'This figure depicts the simulated coverage by consumption expenditure deciles after the proposed reforms. Simulations indicate that 87 per cent of the population are likely to benefit directly or indirectly from the programme(s). Across welfare deciles, coverage will range from 95 per cent in the lowest decile and 74 per cent in the highest decile.',
          legend: {
            name: 'chart-legend',
            params: {
              input: '{"data":[{"label":"Urban","color":"#2971b4"},{"label":"Rural","color":"#a0cdf8"}]}'
            }
          },
          active: true
        }
      ]
    }
  },
  {
    parent: 'home',
    id: '1001',
    layout: { x: 8, y: 0, w: 4, h: 8, i: '1001' },
    type: 'chart-section',
    data: {
      title: 'Poverty reduction impact by scheme and international poverty line (IPL)',
      tabs: [
        {
          title: 'Bar',
          chart: {
            name: 'bar-chart',
            params: {
              autoWidth: true,
              height: 485,
              marginBottom: 100,
              marginLeft: 50,
              isHeightByData: true,
              data: '{"data":{"x_label":"Poverty Reduction (% change)","y_label":"Poverty Line","x_unit_label":"","tooltip_unit_label":"","tooltip":{"value":"<strong>[[internal#label]]</strong><br>Value: [[internal#percentage]]"},"data":[{"label":"National","order":9999,"values":{"Child Benefit":-22.02380952380952,"Disability Benefit":-2.976190476190479,"Old Age Benefit":-9.226190476190478,"Combined":-38.69047619047619},"max_sum":-22.02380952380952},{"label":"International (PPP $1.9)","order":9999,"values":{"Child Benefit":-61.76470588235294,"Disability Benefit":-8.823529411764714,"Old Age Benefit":-11.764705882352951,"Combined":-70.58823529411765},"max_sum":-61.76470588235294},{"label":"International (PPP $3.2)","order":9999,"values":{"Child Benefit":-23.076923076923077,"Disability Benefit":-5.955334987593057,"Old Age Benefit":-8.933002481389586,"Combined":-36.47642679900744},"max_sum":-23.076923076923077},{"label":"International (PPP $5.5)","order":9999,"values":{"Child Benefit":-8.079324274697022,"Disability Benefit":-2.3136246786632353,"Old Age Benefit":-5.104663973558577,"Combined":-15.056922511935369},"max_sum":-8.079324274697022}],"sort_order":"DESC","colors":{"Child Benefit":"blue","Disability Benefit":"orange","Old Age Benefit":"grey","Combined":"yellow"}}}',
              orderByField: 'order',
              barOrientation: 'horizontal-grouped',
              marginRight: 180
            }
          },
          active: true
        }
      ]
    }
  },
  {
    parent: 'home',
    id: '1003',
    type: 'info-graphic',
    layout: { x: 8, y: 8, w: 4, h: 8, i: '1003' },
    data: {
      value: 90.8,
      description: 'The scheme(s) would provide <b>coverage</b> by 90.8% of the whole population in .',
      thumbnail: '/themes/custom/tbdtheme/assets/dist/img/template/placeholder.png',
      unit: '%'
    }
  },
  {
    parent: 'home',
    id: '1002',
    layout: { x: 12, y: 0, w: 4, h: 8, i: '1002' }
  },
  {
    parent: 'home',
    id: '1004',
    layout: { x: 12, y: 8, w: 4, h: 8, i: '1004' }
  },
  {
    parent: 'home',
    id: '1005',
    layout: { x: 8, y: 16, w: 4, h: 8, i: '1005' }
  },
  {
    parent: 'home',
    id: '1006',
    layout: { x: 12, y: 16, w: 4, h: 4, i: '1006' }
  },
  {
    parent: 'home',
    id: '1007',
    layout: { x: 12, y: 20, w: 2, h: 4, i: '1007' }
  },
  {
    parent: 'home',
    id: '1008',
    layout: { x: 14, y: 20, w: 2, h: 4, i: '1008' }
  },
  {
    parent: '1001',
    type: 'chart-section',
    id: '10011',
    layout: { x: 0, y: 0, w: 8, h: 24, i: '10011' },
    data: {
      title: ' Cost as % GDP, by scheme',
      tabs: [
        {
          title: 'Line',
          isVertical: true,
          chart: {
            name: 'multi-line-chart',
            params: {
              data: {
                data: [
                  {
                    label: 'Child Benefit',
                    data: [
                      {
                        x: '2020-12-31T17:00:00.000Z',
                        y: 1.52
                      },
                      {
                        x: '2021-12-31T17:00:00.000Z',
                        y: 1.49
                      },
                      {
                        x: '2022-12-31T17:00:00.000Z',
                        y: 1.46
                      },
                      {
                        x: '2023-12-31T17:00:00.000Z',
                        y: 1.43
                      },
                      {
                        x: '2024-12-31T17:00:00.000Z',
                        y: 1.4
                      },
                      {
                        x: '2025-12-31T17:00:00.000Z',
                        y: 1.37
                      },
                      {
                        x: '2026-12-31T17:00:00.000Z',
                        y: 1.33
                      },
                      {
                        x: '2027-12-31T17:00:00.000Z',
                        y: 1.3
                      },
                      {
                        x: '2028-12-31T17:00:00.000Z',
                        y: 1.26
                      },
                      {
                        x: '2029-12-31T17:00:00.000Z',
                        y: 1.23
                      }
                    ]
                  },
                  {
                    label: 'Disability Benefit',
                    data: [
                      {
                        x: '2020-12-31T17:00:00.000Z',
                        y: 0.57
                      },
                      {
                        x: '2021-12-31T17:00:00.000Z',
                        y: 0.57
                      },
                      {
                        x: '2022-12-31T17:00:00.000Z',
                        y: 0.57
                      },
                      {
                        x: '2023-12-31T17:00:00.000Z',
                        y: 0.57
                      },
                      {
                        x: '2024-12-31T17:00:00.000Z',
                        y: 0.57
                      },
                      {
                        x: '2025-12-31T17:00:00.000Z',
                        y: 0.57
                      },
                      {
                        x: '2026-12-31T17:00:00.000Z',
                        y: 0.56
                      },
                      {
                        x: '2027-12-31T17:00:00.000Z',
                        y: 0.56
                      },
                      {
                        x: '2028-12-31T17:00:00.000Z',
                        y: 0.56
                      },
                      {
                        x: '2029-12-31T17:00:00.000Z',
                        y: 0.55
                      }
                    ]
                  }
                ],
                metadata: {
                  x_datatype: 'datetime',
                  y_datatype: 'number',
                  name: 'Test Data',
                  color: {
                    'Child Benefit': 'blue',
                    'Disability Benefit': 'orange'
                  }
                }
              },
              chartOptions: {
                width: 300,
                height: 400,
                margin: {
                  bottom: 100,
                  left: 100
                },
                rotateX: null,
                xField: 'x',
                xLabel: 'Year',
                yField: 'y',
                yLabel: 'Cost as % of GDP',
                isTrend: false,
                showLegend: false,
                timeFormat: '%Y',
                decimalPoint: 2,
                yAxisMin: 0,
                timeLabelFormat: '%Y',
                xUnitLabel: ''
              }
            }
          },
          insight: 'This figure depicts the simulated coverage by consumption expenditure deciles after the proposed reforms. Simulations indicate that 87 per cent of the population are likely to benefit directly or indirectly from the programme(s). Across welfare deciles, coverage will range from 95 per cent in the lowest decile and 74 per cent in the highest decile.',
          legend: {
            name: 'chart-legend',
            params: {
              input: '{"data":[{"label":"Child Benefit","color":"blue"},{"label":"Disability Benefit","color":"orange"},{"label":"Old Age Benefit","color":"grey"},{"label":"Combined","color":"yellow"}]}'
            }
          },
          active: true
        }
      ]
    }
  },
  {
    parent: '10011',
    id: '100111',
    layout: { x: 0, y: 0, w: 8, h: 24, i: '100111' }
  },
  {
    parent: '10011',
    id: '100112',
    layout: { x: 8, y: 0, w: 8, h: 24, i: '100112' }
  },
  {
    parent: '1001',
    id: '10012',
    type: 'chart-section',
    layout: { x: 8, y: 0, w: 8, h: 24, i: '10012' },
    data: {
      title: 'Poverty Reduction by Benefit Scheme (% change)',
      tabs: [
        {
          title: 'Bar',
          isVertical: true,
          chart: {
            name: 'bar-chart',
            params: {
              autoWidth: true,
              height: 485,
              marginBottom: 100,
              marginLeft: 50,
              isHeightByData: true,
              data: '{"data":{"x_label":"Poverty Reduction (% change)","y_label":"Scheme","x_unit_label":"","tooltip_unit_label":"","tooltip":{"value":"<strong>[[internal#label]]</strong><br>Value: [[internal#percentage]]"},"data":[{"label":"Child Benefit","order":9999,"values":{"Scenario 1":2.62,"Scenario 2":3.36},"max_sum":3.36},{"label":"Disability Benefit","order":9999,"values":{"Scenario 1":3.26,"Scenario 2":3.09},"max_sum":3.26},{"label":"Old Age Benefit","order":9999,"values":{"Scenario 1":3.05,"Scenario 2":2.93},"max_sum":3.05},{"label":"Combined","order":9999,"values":{"Scenario 1":2.06,"Scenario 2":2.74},"max_sum":2.74}],"sort_order":"DESC","colors":{"Scenario 1":"#0d3562","Scenario 2":"#a0cdf8"}}}',
              orderByField: 'order',
              barOrientation: 'horizontal-grouped',
              marginRight: 180
            }
          },
          insight: 'This figure depicts the simulated coverage by consumption expenditure deciles after the proposed reforms. Simulations indicate that 87 per cent of the population are likely to benefit directly or indirectly from the programme(s). Across welfare deciles, coverage will range from 95 per cent in the lowest decile and 74 per cent in the highest decile.',
          legend: {
            name: 'chart-legend',
            params: {
              input: '{"data":[{"label":"Scenario 1","color":"#0d3562"},{"label":"Scenario 2","color":"#a0cdf8"}]}'
            }
          },
          active: true
        }
      ]
    }
  },
  {
    parent: '10012',
    id: '100121',
    layout: { x: 0, y: 0, w: 16, h: 12, i: '100121' }
  },
  {
    parent: '10012',
    id: '100122',
    layout: { x: 0, y: 12, w: 16, h: 12, i: '100122' }
  },
  {
    parent: '1000',
    id: '10001',
    layout: { x: 0, y: 0, w: 8, h: 12, i: '10001' }
  },
  {
    parent: '1000',
    id: '10002',
    layout: { x: 8, y: 0, w: 8, h: 12, i: '10002' }
  },
  {
    parent: '1000',
    id: '10003',
    layout: { x: 0, y: 12, w: 8, h: 12, i: '10003' }
  },
  {
    parent: '1000',
    id: '10004',
    layout: { x: 8, y: 12, w: 8, h: 12, i: '10004' }
  }
];

export const pageLayoutData = [
  {
    id: 'home',
    layout: [
      { x: 0, y: 0, w: 8, h: 24, i: '1000' },
      { x: 8, y: 0, w: 4, h: 8, i: '1001' },
      { x: 12, y: 0, w: 4, h: 8, i: '1002' },
      { x: 8, y: 8, w: 4, h: 8, i: '1003' },
      { x: 12, y: 8, w: 4, h: 8, i: '1004' },
      { x: 8, y: 16, w: 4, h: 8, i: '1005' },
      { x: 12, y: 16, w: 4, h: 4, i: '1006' },
      { x: 12, y: 20, w: 2, h: 4, i: '1007' },
      { x: 14, y: 20, w: 2, h: 4, i: '1008' }
    ]
  }
];
