export const chartSectionData = {
  section1: {
    title: 'Poverty reduction by scheme and national and international poverty lines',
    tag: 'POVERTY',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scheme',
        labelField: 'label',
        insight: `<p><b>Poverty rate</b> measured at <u>national poverty line</u> would decrease by <b>[[value]]%</b> following the selected schemes.</p>
        <p><b>[[maxValScheme]]</b> leads to the largest poverty reduction impact among the selected schemes particularly for extreme poverty.</p>`,
        textOptions: {
          xLabel: 'Poverty Reduction (% change)',
          yLabel: 'Poverty Line'
        }
      }
    ],
    tabs: [],
    child: 'poverty0',
    topic: 'poverty'
  },
  section2: {
    title: 'Simulated change in inequality by scheme and inequality metric',
    tag: 'INEQUALITY',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scheme',
        labelField: 'label',
        insight: `<p><b>Inequality</b> as measured by Gini coefficient would decrease by [[value]]%.</p>
        <p>Simulated impact on inequality is modest and similar across different measures. <b>[[maxValScheme]]</b> contributes to reduction in inequality the most.</p>`,
        insightOptions: {
          baseValue: 10
        },
        textOptions: {
          xLabel: 'Inequality reduction impact (% change)',
          yLabel: 'Inequality Metric'
        }
      }
    ],
    tabs: [],
    child: 'inequality0',
    topic: 'inequality'
  },
  section3: {
    title: 'Cost as % GDP, by scheme',
    tag: 'COST',
    tabTypes: [
      {
        title: 'Line',
        type: 'line',
        groupByField: 'scheme',
        labelField: 'label',
        insight: `<p>The <b>cost</b> of the scheme(s) would be <b>[[value]]%</b>, [[compare_text]] than Asia-Pacific average of 1.3% in tax financed non-contributory social protection schemes.</p>
        <p>The total cost is set to decrease over time with old-age benefits becoming increasingly more important relative to child benefits.</p>`,
        textOptions: {
          xLabel: 'Year',
          yLabel: 'Cost as % of GDP'
        }
      }
    ],
    tabs: [],
    child: 'cost0',
    topic: 'cost'
  },
  section4: {
    title: 'Simulated coverage of scheme(s) (% whole population)',
    tag: 'COVERAGE',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'label',
        labelField: 'scheme',
        insight: `<p>The scheme(s) would provide <b>coverage</b> by <b>[[value]]%</b> of the whole population in <b>[[country]]</b>.</p>
        <p>All children (0-17) older persons (65+) and persons with severe disabilities are covered. <b>[[maxValScheme]]</b> penetrate <b>[[maxVal]]%</b> of households in <b>[[country]]</b>.</p>`,
        textOptions: {
          xLabel: 'Coverage (%)',
          yLabel: 'Schemes'
        }
      }
    ],
    tabs: [],
    child: 'coverage0',
    topic: 'coverage'
  },
  section5: {
    title: 'Impact on household expenditure per capita (% change)',
    tag: 'CONSUMPTION',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'label',
        labelField: 'scheme',
        insight: 'The scheme(s) would boost household expenditure per capita by [[value]]% among the bottom 10%.',
        textOptions: {
          xLabel: 'Increase in per capita consumption expenditure (%)',
          yLabel: 'Schemes'
        }
      }
    ],
    tabs: [],
    child: 'expenditure0',
    topic: 'expenditure'
  },
  poverty0: {
    title: 'Poverty reduction by scheme and national and international poverty lines',
    tag: 'POVERTY',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scheme',
        labelField: 'label',
        insight: `<p><b>Poverty rate</b> measured at <u>national poverty line</u> would decrease by <b>[[value]]%</b> following the selected schemes.</p>
        <p><b>[[maxValScheme]]</b> leads to the largest poverty reduction impact among the selected schemes particularly for extreme poverty.</p>`,
        textOptions: {
          xLabel: 'Poverty Reduction (% change)',
          yLabel: 'Poverty Line'
        }
      }
    ],
    tabs: [],
    parent: 'section1',
    topic: 'poverty',
    childrenList: [
      { label: 'Overview', value: 'poverty0', selected: true },
      { label: 'Chart 1', value: 'poverty2' },
      { label: 'Chart 2', value: 'poverty1' },
      { label: 'Chart 3', value: 'poverty4' },
      { label: 'Chart 4', value: 'poverty3' }
    ]
  },
  poverty1: {
    title: undefined,
    tempTitle: 'Poverty rates, whole population',
    tag: 'POVERTY',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scheme',
        labelField: 'label',
        insight: 'The ﬁgure shows the simulated impact on poverty rates for the whole population, indicating the share of the total population living below national and international poverty lines.',
        textOptions: {
          xLabel: 'Poverty Reduction (% change)',
          yLabel: 'Poverty Line'
        }
      },
      {
        title: 'Table',
        customTitle: 'Simulated poverty rates, whole population',
        type: 'table',
        insight: ''
      }
    ],
    tabs: [],
    parent: 'section1',
    topic: 'poverty',
    childrenList: [
      { label: 'Overview', value: 'poverty0' },
      { label: 'Chart 1', value: 'poverty2' },
      { label: 'Chart 2', value: 'poverty1', selected: true },
      { label: 'Chart 3', value: 'poverty4' },
      { label: 'Chart 4', value: 'poverty3' }
    ],
    isUseCustomFilter: true
  },
  poverty2: {
    title: undefined,
    tempTitle: 'Poverty rates, recipient households',
    tag: 'POVERTY',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scheme',
        labelField: 'label',
        insight: 'The ﬁgure shows the simulated impact on poverty rates among recipient households, indicating the share of recipient households living below national and international poverty lines.',
        textOptions: {
          xLabel: 'Poverty Reduction (% change)',
          yLabel: 'Poverty Line'
        }
      },
      {
        title: 'Table',
        customTitle: 'Simulated poverty rates, recipient households',
        type: 'table',
        insight: ''
      }
    ],
    tabs: [],
    parent: 'section1',
    topic: 'poverty',
    childrenList: [
      { label: 'Overview', value: 'poverty0' },
      { label: 'Chart 1', value: 'poverty2', selected: true },
      { label: 'Chart 2', value: 'poverty1' },
      { label: 'Chart 3', value: 'poverty4' },
      { label: 'Chart 4', value: 'poverty3' }
    ],
    isUseCustomFilter: true
  },
  poverty3: {
    title: undefined,
    tempTitle: 'Poverty gap index, whole population',
    tag: 'POVERTY',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scheme',
        labelField: 'label',
        insight: 'The ﬁgure shows the simulated impact on poverty gap index for the whole population, indicating the average percentage shortfall in income from the poverty line.',
        textOptions: {
          xLabel: 'Poverty Reduction (% change)',
          yLabel: 'Poverty Line'
        }
      },
      {
        title: 'Table',
        type: 'table',
        insight: ''
      }
    ],
    tabs: [],
    parent: 'section1',
    topic: 'poverty',
    childrenList: [
      { label: 'Overview', value: 'poverty0' },
      { label: 'Chart 1', value: 'poverty2' },
      { label: 'Chart 2', value: 'poverty1' },
      { label: 'Chart 4', value: 'poverty4' },
      { label: 'Chart 3', value: 'poverty3', selected: true }
    ],
    isUseCustomFilter: true
  },
  poverty4: {
    title: undefined,
    tempTitle: 'Poverty gap index, recipient households',
    tag: 'POVERTY',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scheme',
        labelField: 'label',
        insight: 'The ﬁgure shows the simulated impact on poverty gap index for among recipient households, indicating the average percentage shortfall in income from the poverty line.',
        textOptions: {
          xLabel: 'Poverty Reduction (% change)',
          yLabel: 'Poverty Line'
        }
      },
      {
        title: 'Table',
        type: 'table',
        insight: ''
      }
    ],
    tabs: [],
    parent: 'section1',
    topic: 'poverty',
    childrenList: [
      { label: 'Overview', value: 'poverty0' },
      { label: 'Chart 1', value: 'poverty2' },
      { label: 'Chart 2', value: 'poverty1' },
      { label: 'Chart 4', value: 'poverty4', selected: true },
      { label: 'Chart 3', value: 'poverty3' }
    ],
    isUseCustomFilter: true
  },
  poverty5_comparison: {
    title: 'Poverty Reduction with Basic Benefits at National Poverty Line (% change in poverty rate)',
    tempTitle: 'Poverty reduction regional comparison',
    tag: 'POVERTY',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scheme',
        labelField: 'country',
        insight: 'The ﬁgure shows the simulated impact on poverty rates for the whole population, indicating the share of the total population living below national poverty lines.',
        textOptions: {
          xLabel: 'Poverty Reduction (% change)',
          yLabel: 'Country'
        },
        averageLines: [
          {
            stroke: 'black',
            strokeDasharray: '1.9',
            strokeWidth: 2
          }
        ]
      }
    ],
    tabs: [],
    parent: 'section1',
    topic: 'poverty',
    childrenList: [
      { label: 'Overview', value: 'poverty0' },
      { label: 'Chart 1', value: 'poverty2' },
      { label: 'Chart 2', value: 'poverty1' },
      { label: 'Chart 3', value: 'poverty4' },
      { label: 'Chart 4', value: 'poverty3' }
    ],
    isUseCustomFilter: true,
    isRegionalComparison: true
  },
  inequality0: {
    title: 'Simulated change in inequality by scheme and inequality metric',
    tag: 'INEQUALITY',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scheme',
        labelField: 'label',
        insight: `<p><b>Inequality</b> as measured by Gini coefficient would decrease by [[value]]%.</p>
        <p>Simulated impact on inequality is modest and similar across different measures. <b>[[maxValScheme]]</b> contributes to reduction in inequality the most.</p>`,
        textOptions: {
          xLabel: 'Inequality reduction impact (% change)',
          yLabel: 'Inequality Metric'
        }
      }
    ],
    tabs: [],
    parent: 'section2',
    topic: 'inequality',
    childrenList: [
      { label: 'Overview', value: 'inequality0', selected: true },
      { label: 'Chart 1', value: 'inequality1' }
    ]
  },
  inequality1: {
    title: undefined,
    tempTitle: 'Inequality',
    tag: 'INEQUALITY',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scheme',
        labelField: 'label',
        insight: 'The figure shows the inequality reduction as measured by the Gini coefficient, the Palma ratio, and the Quintile ratio.',
        textOptions: {
          xLabel: 'Inequality reduction impact (% change)',
          yLabel: 'Inequality Metric'
        }
      },
      {
        title: 'Table',
        type: 'table',
        insight: ''
      }
    ],
    tabs: [],
    parent: 'section2',
    topic: 'inequality',
    childrenList: [
      { label: 'Overview', value: 'inequality0' },
      { label: 'Chart 1', value: 'inequality1', selected: true }
    ],
    isUseCustomFilter: true
  },
  inequality2_comparison: {
    title: 'Reduction in Inequality (% change in Gini)',
    tempTitle: 'Inequality',
    tag: 'INEQUALITY',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scheme',
        labelField: 'country',
        insight: 'The figure shows the inequality reduction as measured by the Gini coefficient, the Palma ratio, and the Quintile ratio.',
        textOptions: {
          xLabel: 'Inequality reduction impact (% change)',
          yLabel: 'Country'
        },
        averageLines: [
          {
            stroke: 'black',
            strokeDasharray: '1.9',
            strokeWidth: 2
          }
        ]
      }
    ],
    tabs: [],
    parent: 'section2',
    topic: 'inequality',
    childrenList: [
      { label: 'Overview', value: 'inequality0' },
      { label: 'Chart 1', value: 'inequality1' }
    ],
    isUseCustomFilter: true,
    isRegionalComparison: true
  },
  cost0: {
    title: 'Cost as % GDP, by scheme',
    tag: 'COST',
    tabTypes: [
      {
        title: 'Line',
        type: 'line',
        groupByField: 'scheme',
        labelField: 'label',
        insight: `<p>The <b>cost</b> of the scheme(s) would be <b>[[value]]%</b>, [[compare_text]] than Asia-Pacific average of 1.3% in tax financed non-contributory social protection schemes.</p>
        <p>The total cost is set to decrease over time with old-age benefits becoming increasingly more important relative to child benefits.</p>`,
        textOptions: {
          xLabel: 'Year',
          yLabel: 'Cost as % of GDP'
        }
      }
    ],
    tabs: [],
    parent: 'section3',
    topic: 'cost',
    childrenList: [
      { label: 'Overview', value: 'cost0', selected: true },
      { label: 'Chart 1', value: 'cost1' },
      { label: 'Chart 2', value: 'cost2' },
      { label: 'Chart 3', value: 'cost3' },
      { label: 'Chart 4', value: 'cost4' }
    ]
  },
  cost1: {
    title: undefined,
    tempTitle: 'Projected annual spending (% of GDP), by programme, by year',
    tag: 'COST',
    tabTypes: [
      {
        title: 'Line',
        type: 'line',
        groupByField: 'scheme',
        labelField: 'label',
        insight: "The figure shows the estimated annual spending of the programme(s) as a percentage of gross domestic product (GDP) in 2021 and up to 2030. This is equivalent to <b>[[currentYearValue]] per cent of [[country]]'s GDP in [[currentYear]]</b>. The projected annual spending in 2030 would reach <b>[[2030_yearValue]] per cent of [[country]]'s GDP in 2030</b>.",
        textOptions: {
          xLabel: 'Year',
          yLabel: 'Cost as % of GDP'
        }
      }
    ],
    tabs: [],
    parent: 'section3',
    topic: 'cost',
    childrenList: [
      { label: 'Overview', value: 'cost0' },
      { label: 'Chart 1', value: 'cost1', selected: true },
      { label: 'Chart 2', value: 'cost2' },
      { label: 'Chart 3', value: 'cost3' },
      { label: 'Chart 4', value: 'cost4' }
    ],
    isUseCustomFilter: true
  },
  cost2: {
    title: undefined,
    tempTitle: 'Required investment as a percentage of government revenue, by year',
    tag: 'COST',
    tabTypes: [
      {
        title: 'Info',
        type: 'paragraph',
        groupByField: 'scheme',
        labelField: 'label',
        insight: '',
        textOptions: {
          xLabel: 'Year',
          yLabel: 'Percentage of government revenue'
        }
      }
    ],
    tabs: [],
    parent: 'section3',
    topic: 'cost',
    childrenList: [
      { label: 'Overview', value: 'cost0' },
      { label: 'Chart 1', value: 'cost1' },
      { label: 'Chart 2', value: 'cost2', selected: true },
      { label: 'Chart 3', value: 'cost3' },
      { label: 'Chart 4', value: 'cost4' }
    ],
    isUseCustomFilter: true
  },
  cost3: {
    title: undefined,
    tempTitle: 'Public spending on functional expenses as % of GDP',
    tag: 'COST',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        orderByField: 'sum_value',
        sortOrder: 'ASC',
        groupByField: 'scheme',
        labelField: 'label',
        insight: 'One option is to reallocate current government expenditure. The figure shows current government expenditure breakdown by functional expenses , compared to the required spending.',
        textOptions: {
          xLabel: 'Functional expenses as % of GDP',
          yLabel: ''
        },
        averageLines: [
          {
            xField: {
              key: 'value_type_id',
              value: '10016'
            },
            stroke: 'black',
            strokeDasharray: '1.9',
            strokeWidth: 2
          }
        ]
      }
    ],
    tabs: [],
    parent: 'section3',
    topic: 'cost',
    childrenList: [
      { label: 'Overview', value: 'cost0' },
      { label: 'Chart 1', value: 'cost1' },
      { label: 'Chart 2', value: 'cost2' },
      { label: 'Chart 3', value: 'cost3', selected: true },
      { label: 'Chart 4', value: 'cost4' }
    ],
    isUseCustomFilter: true
  },
  cost4: {
    title: undefined,
    tempTitle: 'Government tax revenue from income and corporate taxes',
    tag: 'COST',
    tabTypes: [
      {
        title: 'Info',
        type: 'paragraph',
        groupByField: 'scheme',
        labelField: 'label',
        insight: '',
        textOptions: {
          xLabel: 'Year',
          yLabel: 'Cost as % of GDP'
        }
      }
    ],
    tabs: [],
    parent: 'section3',
    topic: 'cost',
    childrenList: [
      { label: 'Overview', value: 'cost0' },
      { label: 'Chart 1', value: 'cost1' },
      { label: 'Chart 2', value: 'cost2' },
      { label: 'Chart 3', value: 'cost3' },
      { label: 'Chart 4', value: 'cost4', selected: true }
    ],
    isUseCustomFilter: true
  },
  cost5_comparison: {
    title: 'Cost as % GDP',
    tempTitle: 'Projected annual spending (% of GDP), by programme, by year',
    tag: 'COST',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scheme',
        labelField: 'country',
        insight: "The figure shows the estimated annual spending of the programme(s) as a percentage of gross domestic product (GDP) in 2021 and up to 2030. This is equivalent to <b>[[currentYearValue]] per cent of [[country]]'s GDP in [[currentYear]]</b>. The projected annual spending in 2030 would reach <b>[[2030_yearValue]] per cent of [[country]]'s GDP in 2030</b>.",
        textOptions: {
          xLabel: '% GDP',
          yLabel: 'Country'
        },
        averageLines: [
          {
            stroke: 'black',
            strokeDasharray: '1.9',
            strokeWidth: 2
          }
        ]
      }
    ],
    tabs: [],
    parent: 'section3',
    topic: 'cost',
    childrenList: [
      { label: 'Overview', value: 'cost0' },
      { label: 'Chart 1', value: 'cost1' },
      { label: 'Chart 2', value: 'cost2' },
      { label: 'Chart 3', value: 'cost3' },
      { label: 'Chart 4', value: 'cost4' }
    ],
    isUseCustomFilter: true,
    isRegionalComparison: true
  },
  coverage0: {
    title: 'Simulated coverage of scheme(s) (% whole population)',
    tag: 'COVERAGE',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'label',
        labelField: 'scheme',
        insight: `<p>The scheme(s) would provide <b>coverage</b> by <b>[[value]]%</b> of the whole population in <b>[[country]]</b>.</p>
        <p>All children (0-17) older persons (65+) and persons with severe disabilities are covered. <b>[[maxValScheme]]</b> penetrate <b>[[maxVal]]%</b> of households in <b>[[country]]</b>.</p>`,
        textOptions: {
          xLabel: 'Coverage (%)',
          yLabel: 'Schemes'
        }
      }
    ],
    tabs: [],
    parent: 'section4',
    topic: 'coverage',
    childrenList: [
      { label: 'Overview', value: 'coverage0', selected: true },
      { label: 'Chart 1', value: 'coverage1' },
      { label: 'Chart 2', value: 'coverage2' },
      { label: 'Chart 3', value: 'coverage3' },
      { label: 'Exclusion', value: 'coverage5_exclusion', isHiddenByMode: 'normal' }
    ]
  },
  coverage1: {
    title: undefined,
    tempTitle: 'Simulated coverage of the whole population, by consumption expenditure deciles',
    tag: 'COVERAGE',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'value_type',
        labelField: 'label',
        insight: 'The figure depicts the simulated coverage by consumption expenditure deciles after the proposed reforms. Simulations indicate that <b>[[20011_labelIdValue]] per cent of the population</b> are likely to benefit directly or indirectly from the programme(s). Across welfare deciles, coverage will range from <b>[[20001_labelIdValue]] per cent in the lowest decile</b> and <b>[[20010_labelIdValue]] per cent in the highest decile</b>.',
        textOptions: {
          xLabel: 'Coverage (%)',
          yLabel: 'Deciles'
        },
        averageLines: [
          {
            xField: {
              key: 'label_id',
              value: '20011'
            },
            stroke: 'black',
            strokeDasharray: '1.9',
            strokeWidth: 2
          }
        ]
      }
    ],
    tabs: [],
    parent: 'section4',
    topic: 'coverage',
    childrenList: [
      { label: 'Overview', value: 'coverage0' },
      { label: 'Chart 1', value: 'coverage1', selected: true },
      { label: 'Chart 2', value: 'coverage2' },
      { label: 'Chart 3', value: 'coverage3' },
      { label: 'Exclusion', value: 'coverage5_exclusion', isHiddenByMode: 'normal' }
    ],
    isUseCustomFilter: true
  },
  coverage2: {
    title: undefined,
    tempTitle: 'Simulated coverage of the whole population, by different types of households',
    tag: 'COVERAGE',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'value_type',
        labelField: 'label',
        insight: 'The figure shows the simulated impact of the reforms on coverage by different household types. It shows that <b>[[20012_labelIdValue]] per cent of couple households with children</b> would be covered, while <b>[[20013_labelIdValue]] per cent of couple households with no children</b> are covered. About <b>[[20015_labelIdValue]] per cent of one-person household (60+ years)</b> would be recipients.',
        textOptions: {
          xLabel: 'Coverage (%)',
          yLabel: 'Household Type'
        },
        averageLines: [
          {
            xField: {
              key: 'label_id',
              value: '20039'
            },
            stroke: 'black',
            strokeDasharray: '1.9',
            strokeWidth: 2
          }
        ]
      }
    ],
    tabs: [],
    parent: 'section4',
    topic: 'coverage',
    childrenList: [
      { label: 'Overview', value: 'coverage0' },
      { label: 'Chart 1', value: 'coverage1' },
      { label: 'Chart 2', value: 'coverage2', selected: true },
      { label: 'Chart 3', value: 'coverage3' },
      { label: 'Exclusion', value: 'coverage5_exclusion', isHiddenByMode: 'normal' }
    ],
    isUseCustomFilter: true
  },
  coverage3: {
    title: undefined,
    tempTitle: 'Coverage with existing schemes and post reforms',
    tag: 'COVERAGE',
    tabTypes: [
      {
        title: 'Table',
        type: 'table',
        insight: ''
      }
    ],
    tabs: [],
    parent: 'section4',
    topic: 'coverage',
    childrenList: [
      { label: 'Overview', value: 'coverage0' },
      { label: 'Chart 1', value: 'coverage1' },
      { label: 'Chart 2', value: 'coverage2' },
      { label: 'Chart 3', value: 'coverage3', selected: true },
      { label: 'Exclusion', value: 'coverage5_exclusion', isHiddenByMode: 'normal' }
    ],
    isUseCustomFilter: true
  },
  coverage4_comparison: {
    title: 'Universal Social Protection and Coverage of the whole population in Asia and those Pacific',
    tempTitle: 'Simulated coverage of the whole population, by different types of households',
    tag: 'COVERAGE',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scheme',
        labelField: 'country',
        insight: 'The figure shows the simulated impact of the reforms on coverage by different household types. It shows that <b>[[20012_labelIdValue]] per cent of couple households with children</b> would be covered, while <b>[[20013_labelIdValue]] per cent of couple households with no children</b> are covered. About <b>[[20015_labelIdValue]] per cent of one-person household (60+ years)</b> would be recipients.',
        textOptions: {
          xLabel: 'Coverage (%)',
          yLabel: 'Country'
        },
        averageLines: [
          {
            stroke: 'black',
            strokeDasharray: '1.9',
            strokeWidth: 2
          }
        ]
      }
    ],
    tabs: [],
    parent: 'section4',
    topic: 'coverage',
    childrenList: [
      { label: 'Overview', value: 'coverage0' },
      { label: 'Chart 1', value: 'coverage1' },
      { label: 'Chart 2', value: 'coverage2' },
      { label: 'Chart 3', value: 'coverage3' },
      { label: 'Exclusion', value: 'coverage5_exclusion', isHiddenByMode: 'normal' }
    ],
    isUseCustomFilter: true,
    isRegionalComparison: true
  },
  coverage5_exclusion: {
    title: 'Failure to protect : Exclusion of Eligible in Poverty-Targeted Schemes',
    tempTitle: '',
    tag: 'COVERAGE',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_stacked',
        groupByField: 'value_type',
        labelField: 'label',
        insight: 'The figure depicts the simulated coverage by consumption expenditure deciles after the proposed reforms. Simulations indicate that <b>[[20011_labelIdValue]] per cent of the population</b> are likely to benefit directly or indirectly from the programme(s). Across welfare deciles, coverage will range from <b>[[20001_labelIdValue]] per cent in the lowest decile</b> and <b>[[20010_labelIdValue]] per cent in the highest decile</b>.',
        textOptions: {
          xLabel: '% of recipient wrongly excluded/included',
          yLabel: 'Deciles'
        }
      }
    ],
    tabs: [],
    parent: 'section4',
    topic: 'coverage',
    childrenList: [
      { label: 'Overview', value: 'coverage0' },
      { label: 'Chart 1', value: 'coverage1' },
      { label: 'Chart 2', value: 'coverage2' },
      { label: 'Chart 3', value: 'coverage3' },
      { label: 'Exclusion', value: 'coverage5_exclusion', isHiddenByMode: 'normal', selected: true }
    ],
    isUseCustomFilter: true,
    isExclusionChartType: true
  },
  expenditure0: {
    title: 'Impact on household expenditure per capita (% change)',
    tag: 'CONSUMPTION',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'label',
        labelField: 'scheme',
        insight: 'The scheme(s) would boost household expenditure per capita by [[value]]% among the bottom 10%.',
        textOptions: {
          xLabel: 'Increase in per capita consumption expenditure (%)',
          yLabel: 'Schemes'
        }
      }
    ],
    tabs: [],
    parent: 'section5',
    topic: 'expenditure',
    childrenList: [
      { label: 'Overview', value: 'expenditure0', selected: true },
      { label: 'Chart 2', value: 'expenditure2' },
      { label: 'Chart 1', value: 'expenditure1' },
      { label: 'Chart 3', value: 'expenditure3' }
    ]
  },
  expenditure1: {
    title: undefined,
    tempTitle: 'Whole population',
    tag: 'CONSUMPTION',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'value_type',
        labelField: 'label',
        insight: 'The ﬁgure shows the simulated increase in household consumption expenditure of the whole population by consumption expenditure deciles. Simulations indicate an increase in per capita consumption expenditure by <b>[[20011_labelIdValue]] per cent on average</b>. Across consumption expenditure deciles, increases will range from <b>[[20001_labelIdValue]] per cent in the lowest</b> consumption expenditure decile, to <b>[[20010_labelIdValue]] per cent in the highest</b> consumption expenditure decile.',
        textOptions: {
          xLabel: 'Increase in per capita consumption expenditure (%)',
          yLabel: 'Deciles'
        },
        averageLines: [
          {
            xField: {
              key: 'label_id',
              value: '20011'
            },
            stroke: 'black',
            strokeDasharray: '1.9',
            strokeWidth: 2
          }
        ]
      }
    ],
    tabs: [],
    parent: 'section5',
    topic: 'expenditure',
    childrenList: [
      { label: 'Overview', value: 'expenditure0' },
      { label: 'Chart 2', value: 'expenditure2' },
      { label: 'Chart 1', value: 'expenditure1', selected: true },
      { label: 'Chart 3', value: 'expenditure3' }
    ],
    isUseCustomFilter: true
  },
  expenditure2: {
    title: undefined,
    tempTitle: 'By consumption expenditure deciles',
    tag: 'CONSUMPTION',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'value_type',
        labelField: 'label',
        insight: 'The ﬁgure shows the simulated increase in household consumption expenditure among recipient households by consumption expenditure deciles. Simulations indicate an increase in per capita consumption expenditure by <b>[[20011_labelIdValue]] per cent, on average</b>. Across consumption expenditure deciles, increases will range from <b>[[20001_labelIdValue]] per cent in the lowest</b> consumption expenditure decile, to <b>[[20010_labelIdValue]] per cent in the highest</b> consumption expenditure decile.',
        textOptions: {
          xLabel: 'Increase in per capita consumption expenditure (%)',
          yLabel: 'Deciles'
        },
        averageLines: [
          {
            xField: {
              key: 'label_id',
              value: '20011'
            },
            stroke: 'black',
            strokeDasharray: '1.9',
            strokeWidth: 2
          }
        ]
      }
    ],
    tabs: [],
    parent: 'section5',
    topic: 'expenditure',
    childrenList: [
      { label: 'Overview', value: 'expenditure0' },
      { label: 'Chart 2', value: 'expenditure2', selected: true },
      { label: 'Chart 1', value: 'expenditure1' },
      { label: 'Chart 3', value: 'expenditure3' }
    ],
    isUseCustomFilter: true
  },
  expenditure3: {
    title: undefined,
    tempTitle: 'By diﬀerent household types',
    tag: 'CONSUMPTION',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'value_type',
        labelField: 'label',
        insight: 'The ﬁgure shows the simulated increase in household consumption expenditure among recipient households, by diﬀerent household types. Simulations indicate an average increase in per capita consumption expenditure by <b>[[20012_labelIdValue]] per cent for couple households with children</b>, <b>[[20013_labelIdValue]] per cent for couple households with no children</b>, and <b>[[20015_labelIdValue]] per cent for one-person households (60+ years)</b>.',
        textOptions: {
          xLabel: 'Increase in per capita consumption expenditure (%)',
          yLabel: 'Household type'
        },
        averageLines: [
          {
            xField: {
              key: 'label_id',
              value: '20039'
            },
            stroke: 'black',
            strokeDasharray: '1.9',
            strokeWidth: 2
          }
        ]
      }
    ],
    tabs: [],
    parent: 'section5',
    topic: 'expenditure',
    childrenList: [
      { label: 'Overview', value: 'expenditure0' },
      { label: 'Chart 2', value: 'expenditure2' },
      { label: 'Chart 1', value: 'expenditure1' },
      { label: 'Chart 3', value: 'expenditure3', selected: true }
    ],
    isUseCustomFilter: true
  },
  expenditure4_comparison: {
    title: 'Universal Social Protection and household consumption expenditure for the total population in Asia and the Pacific',
    tempTitle: 'Whole population',
    tag: 'CONSUMPTION',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scheme',
        labelField: 'country',
        insight: 'The ﬁgure shows the simulated increase in household consumption expenditure of the whole population by consumption expenditure deciles. Simulations indicate an increase in per capita consumption expenditure by <b>[[20011_labelIdValue]] per cent on average</b>. Across consumption expenditure deciles, increases will range from <b>[[20001_labelIdValue]] per cent in the lowest</b> consumption expenditure decile, to <b>[[20010_labelIdValue]] per cent in the highest</b> consumption expenditure decile.',
        textOptions: {
          xLabel: 'Increase in per capita consumption expenditure (%)',
          yLabel: 'Country'
        },
        averageLines: [
          {
            stroke: 'black',
            strokeDasharray: '1.9',
            strokeWidth: 2
          }
        ]
      }
    ],
    tabs: [],
    parent: 'section5',
    topic: 'expenditure',
    childrenList: [
      { label: 'Overview', value: 'expenditure0' },
      { label: 'Chart 2', value: 'expenditure2' },
      { label: 'Chart 1', value: 'expenditure1' },
      { label: 'Chart 3', value: 'expenditure3' }
    ],
    isUseCustomFilter: true,
    isRegionalComparison: true
  },
  sectionCompare1: {
    title: 'Poverty Reduction by Benefit Scheme (% change)',
    tag: 'POVERTY',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scenario',
        labelField: 'scheme',
        insight: `<p><b>Poverty rate</b> measured at national poverty line would decrease in <b>Scenario A</b> by <b>[[s1_value]]%</b> and <b>Scenario B</b> by <b>[[s2_value]]%</b> following the selected scheme(s).</p>
        <p>Selected scheme(s) can reduce poverty in <b>[[s1_country]] (Scenario A)</b> by <b>[[s1_value]]%</b> and in <b>[[s2_country]] (Scenario B)</b> by <b>[[s2_value]]%</b>.</p>`,
        textOptions: {
          xLabel: 'Poverty Reduction (% change)',
          yLabel: 'Schemes'
        }
      }
    ],
    tabs: [],
    child: 'scPoverty0',
    topic: 'poverty'
  },
  sectionCompare2: {
    title: 'Inequality Reduction by All Schemes (% change)',
    tag: 'INEQUALITY',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scenario',
        labelField: 'scheme',
        insight: `<p><b>Inequality</b> as measured by GINI coefficient would decrease in <b>Scenario A</b> by <b>[[s1_value]]%</b> and Scenario B by <b>[[s2_value]]%</b>.</p>
        <p>The reduction in inequality is much less pronounced in <b>[[compare_base_countries]] [[baseValue]]%</b> reduction in Gini index.</p>`,
        textOptions: {
          xLabel: 'Gini index (% change)',
          yLabel: 'Schemes'
        }
      }
    ],
    tabs: [],
    child: 'scInequality0',
    topic: 'inequality'
  },
  sectionCompare3: {
    title: 'Cost as % of GDP, by scheme (% ), 2022',
    tag: 'COST',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scenario',
        labelField: 'scheme',
        insight: 'The <b>cost</b> of selected scheme(s) reach <b>[[s1_value]]%</b> of GDP in <b>[[s1_country]] (Scenario A)</b> and <b>[[s2_value]]%</b> in <b>[[s2_country]] (Scenario B)</b>',
        textOptions: {
          xLabel: 'Cost as % of GDP',
          yLabel: 'Schemes'
        }
      }
    ],
    tabs: [],
    child: 'scCost0',
    topic: 'cost'
  },
  sectionCompare4: {
    title: 'Coverage (Total Deciles) of Schemes (share of whole population)',
    tag: 'COVERAGE',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scenario',
        labelField: 'scheme',
        insight: `<p>The scheme(s) would provide coverage in <b>Scenario A</b> by <b>[[s1_value]]%</b> of the whole population and <b>Scenario B</b> by <b>[[s2_value]]%</b> of the whole population.</p>
        <p>Universal schemes ensure that all eligible people are covered. This leads to majority of households benefiting.</p>`,
        textOptions: {
          xLabel: 'Coverage (Total Deciles)',
          yLabel: 'Schemes'
        }
      }
    ],
    tabs: [],
    child: 'scCoverage0',
    topic: 'coverage'
  },
  sectionCompare5: {
    title: 'Change in Household Expenditure (per capita, %) (Lowest Deciles)',
    tag: 'CONSUMPTION',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scenario',
        labelField: 'scheme',
        insight: 'Among recipient households, expenditure per capita can increase by <b>[[s1_value]]%</b> in <b>[[s1_country]] (Scenario A)</b> for poorest households. The increase is <b>[[s2_value]]%</b> in <b>[[s2_country]] (Scenario B)</b>.',
        textOptions: {
          xLabel: 'Increase in per capita',
          yLabel: 'Schemes'
        }
      }
    ],
    tabs: [],
    child: 'scExpenditure0',
    topic: 'expenditure'
  },
  scPoverty0: {
    title: 'Poverty Reduction by Benefit Scheme (% change)',
    tag: 'POVERTY',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scenario',
        labelField: 'scheme',
        insight: `<p><b>Poverty rate</b> measured at national poverty line would decrease in <b>Scenario A</b> by <b>[[s1_value]]%</b> and <b>Scenario B</b> by <b>[[s2_value]]%</b> following the selected scheme(s).</p>
        <p>Selected scheme(s) can reduce poverty in <b>[[s1_country]] (Scenario A)</b> by <b>[[s1_value]]%</b> and in <b>[[s2_country]] (Scenario B)</b> by <b>[[s2_value]]%</b>.</p>`,
        textOptions: {
          xLabel: 'Poverty Reduction (% change)',
          yLabel: 'Schemes'
        }
      }
    ],
    tabs: [],
    parent: 'sectionCompare1',
    topic: 'poverty',
    childrenList: [
      { label: 'Overview', value: 'scPoverty0', selected: true },
      { label: 'Chart 1', value: 'scPoverty2' },
      { label: 'Chart 2', value: 'scPoverty1' },
      { label: 'Chart 3', value: 'scPoverty4' },
      { label: 'Chart 4', value: 'scPoverty3' }
    ]
  },
  scPoverty1: {
    title: undefined,
    tempTitle: 'Poverty rates, whole population',
    tag: 'POVERTY',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scenario',
        labelField: 'label',
        insight: 'Simulated national poverty rate reduction after the introduction of the programme(s), by poverty lines and Scenarios',
        textOptions: {
          xLabel: 'Poverty Reduction (% change)',
          yLabel: 'Schemes'
        }
      }
    ],
    tabs: [],
    parent: 'sectionCompare1',
    topic: 'poverty',
    childrenList: [
      { label: 'Overview', value: 'scPoverty0' },
      { label: 'Chart 2', value: 'scPoverty2' },
      { label: 'Chart 1', value: 'scPoverty1', selected: true },
      { label: 'Chart 3', value: 'scPoverty4' },
      { label: 'Chart 4', value: 'scPoverty3' }
    ],
    isUseCustomFilter: true
  },
  scPoverty2: {
    title: undefined,
    tempTitle: 'Poverty rates, recipient households',
    tag: 'POVERTY',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scenario',
        labelField: 'label',
        insight: 'Simulated national poverty rate reduction after the introduction of the programme(s), by poverty lines and Scenarios',
        textOptions: {
          xLabel: 'Poverty Reduction (% change)',
          yLabel: 'Schemes'
        }
      }
    ],
    tabs: [],
    parent: 'sectionCompare1',
    topic: 'poverty',
    childrenList: [
      { label: 'Overview', value: 'scPoverty0' },
      { label: 'Chart 2', value: 'scPoverty2', selected: true },
      { label: 'Chart 1', value: 'scPoverty1' },
      { label: 'Chart 3', value: 'scPoverty4' },
      { label: 'Chart 4', value: 'scPoverty3' }
    ],
    isUseCustomFilter: true
  },
  scPoverty3: {
    title: undefined,
    tempTitle: 'Poverty gap index, whole population',
    tag: 'POVERTY',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scenario',
        labelField: 'label',
        insight: 'Simulated national poverty gap reduction after the introduction of the programme, by poverty lines and Scenarios',
        textOptions: {
          xLabel: 'Poverty Reduction (% change)',
          yLabel: 'Schemes'
        }
      }
    ],
    tabs: [],
    parent: 'sectionCompare1',
    topic: 'poverty',
    childrenList: [
      { label: 'Overview', value: 'scPoverty0' },
      { label: 'Chart 1', value: 'scPoverty2' },
      { label: 'Chart 2', value: 'scPoverty1' },
      { label: 'Chart 4', value: 'scPoverty4' },
      { label: 'Chart 3', value: 'scPoverty3', selected: true }
    ],
    isUseCustomFilter: true
  },
  scPoverty4: {
    title: undefined,
    tempTitle: 'Poverty gap index, recipient households',
    tag: 'POVERTY',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scenario',
        labelField: 'label',
        insight: 'Simulated national poverty gap reduction after the introduction of the programme, by poverty lines and Scenarios',
        textOptions: {
          xLabel: 'Poverty Reduction (% change)',
          yLabel: 'Schemes'
        }
      }
    ],
    tabs: [],
    parent: 'sectionCompare1',
    topic: 'poverty',
    childrenList: [
      { label: 'Overview', value: 'scPoverty0' },
      { label: 'Chart 1', value: 'scPoverty2' },
      { label: 'Chart 2', value: 'scPoverty1' },
      { label: 'Chart 4', value: 'scPoverty4', selected: true },
      { label: 'Chart 3', value: 'scPoverty3' }
    ],
    isUseCustomFilter: true
  },
  scInequality0: {
    title: 'Inequality Reduction by All Schemes (% change)',
    tag: 'INEQUALITY',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scenario',
        labelField: 'scheme',
        insight: `<p><b>Inequality</b> as measured by GINI coefficient would decrease in <b>Scenario A</b> by <b>[[s1_value]]%</b> and Scenario B by <b>[[s2_value]]%</b>.</p>
        <p>The reduction in inequality is much less pronounced in <b>[[compare_base_countries]] [[baseValue]]%</b> reduction in Gini index.</p>`,
        textOptions: {
          xLabel: 'Gini index (% change)',
          yLabel: 'Schemes'
        }
      }
    ],
    tabs: [],
    parent: 'sectionCompare2',
    topic: 'inequality',
    childrenList: [
      { label: 'Overview', value: 'scInequality0', selected: true },
      { label: 'Chart 1', value: 'scInequality1' }
    ]
  },
  scInequality1: {
    title: undefined,
    tempTitle: 'Inequality Reduction by All Schemes (% change)',
    tag: 'INEQUALITY',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scenario',
        labelField: 'label',
        insight: 'The figure shows the inequality reduction as measured by the Gini coefficient, the Palma ratio, and the Quintile ratio of Scenarios.',
        insightOptions: {
          baseValue: 10
        },
        textOptions: {
          xLabel: 'Gini index (% change)',
          yLabel: 'Schemes'
        }
      }
    ],
    tabs: [],
    parent: 'sectionCompare2',
    topic: 'inequality',
    childrenList: [
      { label: 'Overview', value: 'scInequality0' },
      { label: 'Chart 1', value: 'scInequality1', selected: true }
    ],
    isUseCustomFilter: true
  },
  scCost0: {
    title: 'Cost as % of GDP, by scheme (% ), 2022',
    tag: 'COST',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scenario',
        labelField: 'scheme',
        insight: 'The <b>cost</b> of selected scheme(s) reach <b>[[s1_value]]%</b> of GDP in <b>[[s1_country]] (Scenario A)</b> and <b>[[s2_value]]%</b> in <b>[[s2_country]] (Scenario B)</b>',
        textOptions: {
          xLabel: 'Cost as % of GDP',
          yLabel: 'Schemes'
        }
      }
    ],
    tabs: [],
    parent: 'sectionCompare3',
    topic: 'cost',
    childrenList: [
      { label: 'Overview', value: 'scCost0', selected: true },
      { label: 'Chart 1', value: 'scCost1' },
      { label: 'Chart 2', value: 'scCost2' },
      { label: 'Chart 3', value: 'scCost3' },
      { label: 'Chart 4', value: 'scCost4' }
    ]
  },
  scCost1: {
    title: undefined,
    tempTitle: 'Projected annual spending (% of GDP), by programme, by year',
    tag: 'COST',
    tabTypes: [
      {
        title: 'Line',
        type: 'line',
        groupByField: 'scenario',
        labelField: 'label',
        insight: 'This figure shows how much it would cost to implement the simulated programme(s), year by year, from 2022 to 2031. The estimates do not account for the country’s current expenditure on social protection. If a country already provides non-contributory schemes similar to those simulated, the cost projections do not refer to the additional resources needed to implement the proposed scheme(s) but to the total resources, including those that are already being spent on the existing schemes. The figure also highlights a few of the possible ﬁnancing streams that can make the proposed simulated programmes aﬀordable. For more information on sustainable financing options, see “How to finance inclusive social protection”. The tool uses data on economic growth and population projections sourced from IMF and UN DESA from 2019.',
        textOptions: {
          xLabel: 'Year',
          yLabel: 'Scenarios'
        }
      }
    ],
    tabs: [],
    parent: 'sectionCompare3',
    topic: 'cost',
    childrenList: [
      { label: 'Overview', value: 'scCost0' },
      { label: 'Chart 1', value: 'scCost1', selected: true },
      { label: 'Chart 2', value: 'scCost2' },
      { label: 'Chart 3', value: 'scCost3' },
      { label: 'Chart 4', value: 'scCost4' }
    ],
    isUseCustomFilter: true
  },
  scCost2: {
    title: undefined,
    tempTitle: 'Required investment as a percentage of government revenue, by year',
    tag: 'COST',
    tabTypes: [
      {
        title: 'Info',
        type: 'paragraph',
        groupByField: 'scenario',
        labelField: 'label',
        insight: '',
        textOptions: {
          xLabel: 'Year',
          yLabel: 'Scenarios'
        }
      }
    ],
    tabs: [],
    parent: 'sectionCompare3',
    topic: 'cost',
    childrenList: [
      { label: 'Overview', value: 'scCost0' },
      { label: 'Chart 1', value: 'scCost1' },
      { label: 'Chart 2', value: 'scCost2', selected: true },
      { label: 'Chart 3', value: 'scCost3' },
      { label: 'Chart 4', value: 'scCost4' }
    ],
    isUseCustomFilter: true
  },
  scCost3: {
    title: undefined,
    tempTitle: 'Public spending on functional expenses as % of GDP',
    tag: 'COST',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scenario',
        labelField: 'label',
        insight: '',
        textOptions: {
          xLabel: 'Functional expenses as % of GDP',
          yLabel: ''
        },
        averageLines: [
          {
            xField: {
              key: 'value_type_id',
              value: '10016'
            },
            stroke: 'black',
            strokeDasharray: '1.9',
            strokeWidth: 2
          }
        ]
      }
    ],
    tabs: [],
    parent: 'sectionCompare3',
    topic: 'cost',
    childrenList: [
      { label: 'Overview', value: 'scCost0' },
      { label: 'Chart 1', value: 'scCost1' },
      { label: 'Chart 2', value: 'scCost2' },
      { label: 'Chart 3', value: 'scCost3', selected: true },
      { label: 'Chart 4', value: 'scCost4' }
    ],
    isUseCustomFilter: true
  },
  scCost4: {
    title: undefined,
    tempTitle: 'Government tax revenue from income and corporate taxes',
    tag: 'COST',
    tabTypes: [
      {
        title: 'Info',
        type: 'paragraph',
        groupByField: 'scenario',
        labelField: 'label',
        insight: '',
        textOptions: {
          xLabel: 'Cost as % of GDP',
          yLabel: 'Schemes'
        }
      }
    ],
    tabs: [],
    parent: 'sectionCompare3',
    topic: 'cost',
    childrenList: [
      { label: 'Overview', value: 'scCost0' },
      { label: 'Chart 1', value: 'scCost1' },
      { label: 'Chart 2', value: 'scCost2' },
      { label: 'Chart 3', value: 'scCost3' },
      { label: 'Chart 4', value: 'scCost4', selected: true }
    ],
    isUseCustomFilter: true
  },
  scCoverage0: {
    title: 'Coverage (Total Deciles) of Schemes (share of whole population)',
    tag: 'COVERAGE',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scenario',
        labelField: 'scheme',
        insight: `<p>The scheme(s) would provide coverage in <b>Scenario A</b> by <b>[[s1_value]]%</b> of the whole population and <b>Scenario B</b> by <b>[[s2_value]]%</b> of the whole population.</p>
        <p>Universal schemes ensure that all eligible people are covered. This leads to majority of households benefiting.</p>`,
        textOptions: {
          xLabel: 'Coverage (Total Deciles)',
          yLabel: 'Schemes'
        }
      }
    ],
    tabs: [],
    parent: 'sectionCompare4',
    topic: 'coverage',
    childrenList: [
      { label: 'Overview', value: 'scCoverage0', selected: true },
      { label: 'Chart 1', value: 'scCoverage1' },
      { label: 'Chart 2', value: 'scCoverage2' },
      { label: 'Chart 3', value: 'scCoverage3' }
    ]
  },
  scCoverage1: {
    title: undefined,
    tempTitle: 'Simulated coverage of the whole population, by consumption expenditure deciles',
    tag: 'COVERAGE',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scenario',
        labelField: 'label',
        insight: 'Simulated coverage of direct and indirect recipients among national population, by consumption expenditure deciles and Scenarios',
        textOptions: {
          xLabel: 'Coverage (%)',
          yLabel: 'Deciles'
        },
        averageLines: [
          {
            xField: {
              key: 'label_id',
              value: '20011'
            },
            stroke: 'black',
            strokeDasharray: '1.9',
            strokeWidth: 2
          }
        ]
      }
    ],
    tabs: [],
    parent: 'sectionCompare4',
    topic: 'coverage',
    childrenList: [
      { label: 'Overview', value: 'scCoverage0' },
      { label: 'Chart 1', value: 'scCoverage1', selected: true },
      { label: 'Chart 2', value: 'scCoverage2' },
      { label: 'Chart 3', value: 'scCoverage3' }
    ],
    isUseCustomFilter: true
  },
  scCoverage2: {
    title: undefined,
    tempTitle: 'Simulated coverage of the whole population, by different types of households',
    tag: 'COVERAGE',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scenario',
        labelField: 'label',
        insight: 'Simulated coverage of direct and indirect recipients among national population, by household structure and Scenarios',
        textOptions: {
          xLabel: 'Coverage (%)',
          yLabel: 'Household Type'
        },
        averageLines: [
          {
            xField: {
              key: 'label_id',
              value: '20039'
            },
            stroke: 'black',
            strokeDasharray: '1.9',
            strokeWidth: 2
          }
        ]
      }
    ],
    tabs: [],
    parent: 'sectionCompare4',
    topic: 'coverage',
    childrenList: [
      { label: 'Overview', value: 'scCoverage0' },
      { label: 'Chart 1', value: 'scCoverage1' },
      { label: 'Chart 2', value: 'scCoverage2', selected: true },
      { label: 'Chart 3', value: 'scCoverage3' }
    ],
    isUseCustomFilter: true
  },
  scCoverage3: {
    title: undefined,
    tempTitle: 'Coverage with existing schemes and post reforms',
    tag: 'COVERAGE',
    tabTypes: [
      {
        title: 'Table',
        type: 'table',
        insight: ''
      }
    ],
    tabs: [],
    parent: 'sectionCompare4',
    topic: 'coverage',
    childrenList: [
      { label: 'Overview', value: 'scCoverage0' },
      { label: 'Chart 1', value: 'scCoverage1' },
      { label: 'Chart 2', value: 'scCoverage2' },
      { label: 'Chart 3', value: 'scCoverage3', selected: true }
    ],
    isUseCustomFilter: true
  },
  scExpenditure0: {
    title: 'Change in Household Expenditure (per capita, %) (Lowest Deciles)',
    tag: 'CONSUMPTION',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scenario',
        labelField: 'scheme',
        insight: 'Among recipient households, expenditure per capita can increase by <b>[[s1_value]]%</b> in <b>[[s1_country]] (Scenario A)</b> for poorest households. The increase is <b>[[s2_value]]%</b> in <b>[[s2_country]] (Scenario B)</b>.',
        textOptions: {
          xLabel: 'Increase in per capita',
          yLabel: 'Schemes'
        }
      }
    ],
    tabs: [],
    parent: 'sectionCompare5',
    topic: 'expenditure',
    childrenList: [
      { label: 'Overview', value: 'scExpenditure0', selected: true },
      { label: 'Chart 2', value: 'scExpenditure2' },
      { label: 'Chart 1', value: 'scExpenditure1' },
      { label: 'Chart 3', value: 'scExpenditure3' }
    ]
  },
  scExpenditure1: {
    title: undefined,
    tempTitle: 'Whole population',
    tag: 'CONSUMPTION',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scenario',
        labelField: 'label',
        insight: 'Simulated increase in household consumption expenditure among national population, by consumption expenditure deciles and Scenarios',
        textOptions: {
          xLabel: 'Increase in per capita',
          yLabel: 'Schemes'
        },
        averageLines: [
          {
            xField: {
              key: 'label_id',
              value: '20011'
            },
            stroke: 'black',
            strokeDasharray: '1.9',
            strokeWidth: 2
          }
        ]
      }
    ],
    tabs: [],
    parent: 'sectionCompare5',
    topic: 'expenditure',
    childrenList: [
      { label: 'Overview', value: 'scExpenditure0' },
      { label: 'Chart 2', value: 'scExpenditure2' },
      { label: 'Chart 1', value: 'scExpenditure1', selected: true },
      { label: 'Chart 3', value: 'scExpenditure3' }
    ],
    isUseCustomFilter: true
  },
  scExpenditure2: {
    title: undefined,
    tempTitle: 'By consumption expenditure deciles',
    tag: 'CONSUMPTION',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scenario',
        labelField: 'label',
        insight: 'Simulated increase in household consumption expenditure among recipients, by consumption expenditure deciles and Scenarios',
        textOptions: {
          xLabel: 'Increase in per capita',
          yLabel: 'Schemes'
        },
        averageLines: [
          {
            xField: {
              key: 'label_id',
              value: '20011'
            },
            stroke: 'black',
            strokeDasharray: '1.9',
            strokeWidth: 2
          }
        ]
      }
    ],
    tabs: [],
    parent: 'sectionCompare5',
    topic: 'expenditure',
    childrenList: [
      { label: 'Overview', value: 'scExpenditure0' },
      { label: 'Chart 2', value: 'scExpenditure2', selected: true },
      { label: 'Chart 1', value: 'scExpenditure1' },
      { label: 'Chart 3', value: 'scExpenditure3' }
    ],
    isUseCustomFilter: true
  },
  scExpenditure3: {
    title: undefined,
    tempTitle: 'By diﬀerent household types',
    tag: 'CONSUMPTION',
    tabTypes: [
      {
        title: 'Bar',
        type: 'bar_horizontal_grouped',
        groupByField: 'scenario',
        labelField: 'label',
        insight: '',
        textOptions: {
          xLabel: 'Increase in per capita',
          yLabel: 'Schemes'
        },
        averageLines: [
          {
            xField: {
              key: 'label_id',
              value: '20039'
            },
            stroke: 'black',
            strokeDasharray: '1.9',
            strokeWidth: 2
          }
        ]
      }
    ],
    tabs: [],
    parent: 'sectionCompare5',
    topic: 'expenditure',
    childrenList: [
      { label: 'Overview', value: 'scExpenditure0' },
      { label: 'Chart 2', value: 'scExpenditure2' },
      { label: 'Chart 1', value: 'scExpenditure1' },
      { label: 'Chart 3', value: 'scExpenditure3', selected: true }
    ],
    isUseCustomFilter: true
  }
};
