export const regionalCompSectionData = {
  section1: {
    name: 'section1',
    tag: 'POVERTY',
    title: 'Simulated impact in poverty rates',
    subTitle: 'Percentage, based on international poverty lines',
    chartOptions: {
      title: 'Bar',
      groupByField: 'benefit_level_label',
      labelField: 'country',
      insight: 'The ﬁgure shows the simulated impact on poverty rates for the whole population, indicating the share of the total population living below national poverty lines.',
      textOptions: {
        yLabel: 'Poverty Rate (%)',
        xLabel: ''
      },
      groupAxisOptions: {
        groupField: 'poverty_type'
      },
      averageLines: [{ stroke: 'black', strokeDasharray: '1.9', strokeWidth: 2 }]
    },
    filterObject: {
      where: {
        indicator: { inq: ['40007'] },
        special_cov: false,
        pension_tested: false,
        label: { inq: ['20024', '20025'] },
        scheme: { inq: ['70001', '70002', '70003', '70001_70002_70003'] },
        poverty_mean_tested: { inq: ['80001'] }
      }
    },
    sectionDetail: 'The figure below presents the simulated reduction in poverty following the introduction of social protection schemes based on the default scenario of ESCAP Social Protection Simulator, as selected above. Poverty reduction is represented as percentage change before and after the introduction of social protection packages for 19 countries at international poverty lines that are commensurate to their level of income. At a minimum, 12% poverty reduction is observed in Bangladesh at $3.2 international poverty line. At a maximum, 78% poverty reduction is observed in Thailand.',
    isformatNoSchemeIndicator: false,
    chartBoxHeight: 315
  },
  section2: {
    name: 'section2',
    tag: 'INEQUALITY',
    title: 'Simulated impact in inequality',
    subTitle: 'Change in indicator',
    chartOptions: {
      title: 'Bar',
      groupByField: 'benefit_level_label',
      labelField: 'country',
      insight: 'The figure shows the inequality reduction as measured by the Gini coefficient, the Palma ratio, and the Quintile ratio.',
      textOptions: {
        yLabel: 'Value',
        xLabel: ''
      },
      groupAxisOptions: {
        groupField: 'region'
      },
      averageLines: [{ stroke: 'black', strokeDasharray: '1.9', strokeWidth: 2 }]
    },
    filterObject: {
      where: {
        indicator: { inq: ['40011'] },
        special_cov: false,
        pension_tested: false,
        label: { inq: ['20026', '20027', '20028'] },
        scheme: { inq: ['70001', '70002', '70003', '70001_70002_70003'] },
        poverty_mean_tested: { inq: ['80001'] }
      }
    },
    sectionDetail: 'The figure below presents the simulated reduction in inequality following the introduction of social protection schemes based on the default scenario of ESCAP Social Protection Simulator, as selected above. Reduction in inequality is represented as percentage change in palma ratio before and after the introduction of social protection packages for 19 countries. Inequality is simulated to decrease by over 20% in India, the Philippines, Sri Lanka, Cook Islands and Georgia. On average, 14% decrease in inequality is expected.',
    isformatNoSchemeIndicator: true,
    chartBoxHeight: 350
  },
  section3: {
    name: 'section3',
    tag: 'COST',
    title: 'Simulated cost',
    subTitle: 'Percentage of GDP, for introducing universal social protection schemes',
    chartOptions: {
      title: 'Bar',
      groupByField: 'benefit_level_label',
      labelField: 'country',
      insight: "The figure shows the estimated annual spending of the programme(s) as a percentage of gross domestic product (GDP) in 2021 and up to 2030. This is equivalent to <b>[[currentYearValue]] per cent of [[country]]'s GDP in [[currentYear]]</b>. The projected annual spending in 2030 would reach <b>[[2030_yearValue]] per cent of [[country]]'s GDP in 2030</b>.",
      textOptions: {
        yLabel: 'GDP (%)',
        xLabel: ''
      },
      groupAxisOptions: {
        groupField: 'region'
      },
      averageLines: [{ stroke: 'black', strokeDasharray: '1.9', strokeWidth: 2 }]
    },
    filterObject: {
      where: {
        indicator: { inq: ['40012'] },
        special_cov: false,
        pension_tested: false,
        value_type: { inq: ['10010'] },
        label: { inq: ['20038'] },
        scheme: { inq: ['70001', '70002', '70003', '70001_70002_70003'] },
        poverty_mean_tested: { inq: ['80001'] }
      }
    },
    sectionDetail: 'In Asia-Pacific, average social protection spending remains low at around 4.9% of GDP. This average spending is much lower than the global average of 11% of GDP and 17% of GDP among OECD countries. The cost projections for 2021 range between 2.6% GDP in Bangladesh and 4.6% of GDP in Sri Lanka. However, the cost projections presented below refer to only three non-contributory social protection schemes. As such, they do not take into account other non-contributory schemes, contributory schemes and active labor market policies.',
    chartBoxHeight: 335
  },
  section4: {
    name: 'section4',
    tag: 'COVERAGE',
    title: 'Simulated coverage',
    subTitle: 'Percentage of total population, of universal social protection schemes',
    chartOptions: {
      title: 'Bar',
      groupByField: 'benefit_level_label',
      labelField: 'country',
      insight: 'The figure shows the simulated impact of the reforms on coverage by different household types. It shows that <b>[[20012_labelIdValue]] per cent of couple households with children</b> would be covered, while <b>[[20013_labelIdValue]] per cent of couple households with no children</b> are covered. About <b>[[20015_labelIdValue]] per cent of one-person household (60+ years)</b> would be recipients.',
      textOptions: {
        yLabel: 'Total population (%)',
        xLabel: ''
      },
      groupAxisOptions: {
        groupField: 'region'
      },
      averageLines: [{ stroke: 'black', strokeDasharray: '1.9', strokeWidth: 2 }]
    },
    filterObject: {
      where: {
        indicator: { inq: ['40002'] },
        special_cov: false,
        pension_tested: false,
        value_type: { inq: ['10001'] },
        label: { inq: ['20039'] },
        scheme: { inq: ['70001', '70002', '70003', '70001_70002_70003'] },
        poverty_mean_tested: { inq: ['80001'] }
      }
    },
    sectionDetail: 'The figure below compares the share of population covered by at least one social protection scheme (SDG 1.3.1) in blue bar with the simulated coverage following the introduction of social protection schemes based on the default scenario of the ESCAP Social Protection Simulator. The simulated coverage reaches beyond 80% of the whole population in the majority of countries. On average, the simulated coverage is twice as high as the current reality for social protection coverage in Asia-Pacific. The gap between reality and simulation is particularly wide in Cambodia, Bhutan, Pakistan and Nepal.',
    chartBoxHeight: 335
  },
  section5: {
    name: 'section5',
    tag: 'CONSUMPTION',
    title: 'Simulated impact in consumption',
    subTitle: 'Percentage change among the poorest 10%, following the introduction of social protection schemes',
    chartOptions: {
      title: 'Bar',
      groupByField: 'benefit_level_label',
      labelField: 'country',
      insight: 'The ﬁgure shows the simulated increase in household consumption expenditure of the whole population by consumption expenditure deciles. Simulations indicate an increase in per capita consumption expenditure by <b>[[20011_labelIdValue]] per cent on average</b>. Across consumption expenditure deciles, increases will range from <b>[[20001_labelIdValue]] per cent in the lowest</b> consumption expenditure decile, to <b>[[20010_labelIdValue]] per cent in the highest</b> consumption expenditure decile.',
      textOptions: {
        yLabel: 'Change in consumption (%)',
        xLabel: ''
      },
      groupAxisOptions: {
        groupField: 'region'
      },
      averageLines: [{ stroke: 'black', strokeDasharray: '1.9', strokeWidth: 2 }]
    },
    filterObject: {
      where: {
        indicator: { inq: ['40004'] },
        special_cov: false,
        pension_tested: false,
        value_type: { inq: ['10001'] },
        label: { inq: ['20001'] },
        scheme: { inq: ['70001', '70002', '70003', '70001_70002_70003'] },
        poverty_mean_tested: { inq: ['80001'] }
      }
    },
    sectionDetail: 'The impact on poverty and inequality is driven by boosting consumption which increases by multiple folds among households in the bottom 4 deciles relative to the 10th decile. The figure below compares the 4th decile with the 10th decile. The increase in household consumption expenditure per capita reaches 5-fold and more in Indonesia, Turkey, Georgia, Bhutan and Thailand.',
    chartBoxHeight: 345
  }
};
