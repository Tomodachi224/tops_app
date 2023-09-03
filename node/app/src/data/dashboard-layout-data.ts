export const layoutData = [
  {
    pages: ['home'],
    layout: {
      default: [
        { x: 0, y: 0, w: 2, h: 3 },
        { x: 2, y: 0, w: 2, h: 3 },
        { x: 0, y: 3, w: 2, h: 3 },
        { x: 2, y: 3, w: 2, h: 3 },
        { x: 0, y: 6, w: 2, h: 3 },
        { x: 2, y: 6, w: 2, h: 3 }
      ],
      xs: [
        { x: 0, y: 0, w: 4, h: 3 },
        { x: 0, y: 3, w: 4, h: 3 },
        { x: 0, y: 6, w: 4, h: 3 },
        { x: 0, y: 9, w: 4, h: 3 },
        { x: 0, y: 12, w: 4, h: 3 },
        { x: 0, y: 15, w: 4, h: 3 }
      ]
      // xs: [
      //   { x: 0, y: 0, w: 2, h: 3 },
      //   { x: 2, y: 0, w: 2, h: 3 },
      //   { x: 0, y: 3, w: 2, h: 3 },
      //   { x: 2, y: 3, w: 2, h: 3 },
      //   { x: 0, y: 6, w: 2, h: 3 },
      //   { x: 2, y: 6, w: 2, h: 3 }
      // ]
    },
    sectionList: {
      default: ['section1', 'section2', 'section5', 'section4', 'section3', 'section6']
    },
    sectionListCompare: {
      default: ['sectionCompare1', 'sectionCompare2', 'sectionCompare5', 'sectionCompare4', 'sectionCompare3', 'section6']
    }
  },
  {
    pages: ['section1', 'section2', 'section3', 'section4', 'section5', 'section6',
      'sectionCompare1', 'sectionCompare2', 'sectionCompare3', 'sectionCompare4', 'sectionCompare5'],
    layout: {
      default: [
        { x: 0, y: 0, w: 1, h: 3 },
        { x: 1, y: 0, w: 1, h: 3 },
        { x: 0, y: 3, w: 1, h: 3 },
        { x: 1, y: 3, w: 1, h: 3 },
        { x: 0, y: 6, w: 1, h: 3 },
        { x: 1, y: 6, w: 1, h: 3 },
        { x: 2, y: 0, w: 2, h: 9 }
      ],
      xs: [
        { x: 0, y: 9, w: 4, h: 3 },
        { x: 0, y: 12, w: 4, h: 3 },
        { x: 0, y: 15, w: 4, h: 3 },
        { x: 0, y: 18, w: 4, h: 3 },
        { x: 0, y: 21, w: 4, h: 3 },
        { x: 0, y: 24, w: 4, h: 3 },
        { x: 0, y: 0, w: 4, h: 9 }
      ]
      // xs: [
      //   { x: 0, y: 9, w: 2, h: 3 },
      //   { x: 2, y: 9, w: 2, h: 3 },
      //   { x: 0, y: 12, w: 2, h: 3 },
      //   { x: 2, y: 12, w: 2, h: 3 },
      //   { x: 0, y: 15, w: 2, h: 3 },
      //   { x: 2, y: 15, w: 2, h: 3 },
      //   { x: 0, y: 0, w: 4, h: 9 }
      // ]
    },
    sectionList: {
      default: ['section1', 'section2', 'section5', 'section4', 'section3', 'section6', 'sectionDetail']
    },
    sectionListCompare: {
      default: ['sectionCompare1', 'sectionCompare2', 'sectionCompare5', 'sectionCompare4', 'sectionCompare3', 'section6', 'sectionDetail']
    }
  },
  {
    pages: ['poverty0', 'poverty1', 'poverty2', 'poverty3', 'poverty4', 'poverty5_comparison',
      'inequality0', 'inequality1', 'inequality2_comparison',
      'cost0', 'cost1', 'cost2', 'cost3', 'cost4', 'cost5_comparison',
      'coverage0', 'coverage1', 'coverage2', 'coverage3', 'coverage4_comparison',
      'expenditure0', 'expenditure1', 'expenditure2', 'expenditure3', 'expenditure4_comparison', 'coverage5_exclusion',
      'scPoverty0', 'scPoverty1', 'scPoverty2', 'scPoverty3', 'scPoverty4',
      'scInequality0', 'scInequality1',
      'scCost0', 'scCost1', 'scCost2', 'scCost3', 'scCost4',
      'scCoverage0', 'scCoverage1', 'scCoverage2', 'scCoverage3',
      'scExpenditure0', 'scExpenditure1', 'scExpenditure2', 'scExpenditure3'
    ],
    layout: {
      default: [
        { x: 0, y: 0, w: 1, h: 3 },
        { x: 1, y: 0, w: 1, h: 3 },
        { x: 0, y: 3, w: 1, h: 3 },
        { x: 1, y: 3, w: 1, h: 3 },
        { x: 0, y: 6, w: 1, h: 3 },
        { x: 1, y: 6, w: 1, h: 3 },
        { x: 2, y: 0, w: 2, h: 9 }
      ],
      xs: [
        { x: 0, y: 9, w: 4, h: 3 },
        { x: 0, y: 12, w: 4, h: 3 },
        { x: 0, y: 15, w: 4, h: 3 },
        { x: 0, y: 18, w: 4, h: 3 },
        { x: 0, y: 21, w: 4, h: 3 },
        { x: 0, y: 24, w: 4, h: 3 },
        { x: 0, y: 0, w: 4, h: 9 }
      ]
      // xs: [
      //   { x: 0, y: 9, w: 2, h: 3 },
      //   { x: 2, y: 9, w: 2, h: 3 },
      //   { x: 0, y: 12, w: 2, h: 3 },
      //   { x: 2, y: 12, w: 2, h: 3 },
      //   { x: 0, y: 15, w: 2, h: 3 },
      //   { x: 2, y: 15, w: 2, h: 3 },
      //   { x: 0, y: 0, w: 4, h: 9 }
      // ]
    },
    sectionList: {
      default: ['section1', 'section2', 'section5', 'section4', 'section3', 'section6', 'sectionDetail']
    },
    sectionListCompare: {
      default: ['sectionCompare1', 'sectionCompare2', 'sectionCompare5', 'sectionCompare4', 'sectionCompare3', 'section6', 'sectionDetail']
    },
    childPageList: {
      default: [
        'poverty0', 'poverty1', 'poverty2', 'poverty3', 'poverty4', 'poverty5_comparison',
        'inequality0', 'inequality1', 'inequality2_comparison',
        'cost0', 'cost1', 'cost2', 'cost3', 'cost4', 'cost5_comparison',
        'coverage0', 'coverage1', 'coverage2', 'coverage3', 'coverage4_comparison',
        'expenditure0', 'expenditure1', 'expenditure2', 'expenditure3', 'expenditure4_comparison', 'coverage5_exclusion'
      ],
      compare: [
        'scPoverty0', 'scPoverty1', 'scPoverty2', 'scPoverty3', 'scPoverty4',
        'scInequality0', 'scInequality1',
        'scCost0', 'scCost1', 'scCost2', 'scCost3', 'scCost4',
        'scCoverage0', 'scCoverage1', 'scCoverage2', 'scCoverage3',
        'scExpenditure0', 'scExpenditure1', 'scExpenditure2', 'scExpenditure3'
      ]
    }
  }
  // {
  //   pages: ['poverty_home'],
  //   layout: {
  //     default: [
  //       { x: 0, y: 0, w: 2, h: 3 },
  //       { x: 2, y: 0, w: 2, h: 3 },
  //       { x: 0, y: 3, w: 2, h: 3 },
  //       { x: 2, y: 3, w: 2, h: 3 },
  //       { x: 0, y: 6, w: 2, h: 1 },
  //       { x: 2, y: 6, w: 2, h: 1 },
  //       { x: 0, y: 7, w: 2, h: 1 },
  //       { x: 2, y: 7, w: 2, h: 1 },
  //       { x: 0, y: 8, w: 2, h: 1 },
  //       { x: 2, y: 8, w: 2, h: 1 }
  //     ]
  //   },
  //   sectionList: {
  //     default: ['poverty1', 'poverty2', 'poverty3', 'poverty4', 'small_info1', 'small_info2', 'small_info3', 'small_info4', 'small_info5', 'section6']
  //   }
  // },
  // {
  //   pages: ['poverty1', 'poverty2', 'poverty3', 'poverty4'],
  //   layout: {
  //     default: [
  //       { x: 0, y: 0, w: 1, h: 3 },
  //       { x: 1, y: 0, w: 1, h: 3 },
  //       { x: 0, y: 3, w: 1, h: 3 },
  //       { x: 1, y: 3, w: 1, h: 3 },
  //       { x: 0, y: 6, w: 1, h: 1 },
  //       { x: 1, y: 6, w: 1, h: 1 },
  //       { x: 0, y: 7, w: 1, h: 1 },
  //       { x: 1, y: 7, w: 1, h: 1 },
  //       { x: 0, y: 8, w: 1, h: 1 },
  //       { x: 1, y: 8, w: 1, h: 1 },
  //       { x: 2, y: 0, w: 2, h: 9 }
  //     ]
  //   },
  //   sectionList: {
  //     default: ['poverty1', 'poverty2', 'poverty3', 'poverty4', 'small_info1', 'small_info2', 'small_info3', 'small_info4', 'small_info5', 'section6', 'sectionDetail']
  //   }
  // },
  // {
  //   pages: ['inequality_home'],
  //   layout: {
  //     default: [
  //       { x: 0, y: 0, w: 4, h: 6 },
  //       { x: 0, y: 6, w: 2, h: 1 },
  //       { x: 2, y: 6, w: 2, h: 1 },
  //       { x: 0, y: 7, w: 2, h: 1 },
  //       { x: 2, y: 7, w: 2, h: 1 },
  //       { x: 0, y: 8, w: 2, h: 1 },
  //       { x: 2, y: 8, w: 2, h: 1 }
  //     ]
  //   },
  //   sectionList: {
  //     default: ['inequality1', 'small_info1', 'small_info2', 'small_info3', 'small_info4', 'small_info5', 'section6']
  //   }
  // },
  // {
  //   pages: ['inequality1'],
  //   layout: {
  //     default: [
  //       { x: 0, y: 0, w: 2, h: 6 },
  //       { x: 0, y: 6, w: 1, h: 1 },
  //       { x: 1, y: 6, w: 1, h: 1 },
  //       { x: 0, y: 7, w: 1, h: 1 },
  //       { x: 1, y: 7, w: 1, h: 1 },
  //       { x: 0, y: 8, w: 1, h: 1 },
  //       { x: 1, y: 8, w: 1, h: 1 },
  //       { x: 2, y: 0, w: 2, h: 9 }
  //     ]
  //   },
  //   sectionList: {
  //     default: ['inequality1', 'small_info1', 'small_info2', 'small_info3', 'small_info4', 'small_info5', 'section6', 'sectionDetail']
  //   }
  // },
  // {
  //   pages: ['cost_home'],
  //   layout: {
  //     default: [
  //       { x: 0, y: 0, w: 2, h: 3 },
  //       { x: 2, y: 0, w: 2, h: 3 },
  //       { x: 0, y: 3, w: 2, h: 3 },
  //       { x: 2, y: 3, w: 2, h: 3 },
  //       { x: 0, y: 6, w: 2, h: 1 },
  //       { x: 2, y: 6, w: 2, h: 1 },
  //       { x: 0, y: 7, w: 2, h: 1 },
  //       { x: 2, y: 7, w: 2, h: 1 },
  //       { x: 0, y: 8, w: 2, h: 1 },
  //       { x: 2, y: 8, w: 2, h: 1 }
  //     ]
  //   },
  //   sectionList: {
  //     default: ['cost1', 'cost2', 'cost3', 'cost4', 'small_info1', 'small_info2', 'small_info3', 'small_info4', 'small_info5', 'section6']
  //   }
  // },
  // {
  //   pages: ['cost1', 'cost2', 'cost3', 'cost4'],
  //   layout: {
  //     default: [
  //       { x: 0, y: 0, w: 1, h: 3 },
  //       { x: 1, y: 0, w: 1, h: 3 },
  //       { x: 0, y: 2, w: 1, h: 3 },
  //       { x: 1, y: 2, w: 1, h: 3 },
  //       { x: 0, y: 6, w: 1, h: 1 },
  //       { x: 1, y: 6, w: 1, h: 1 },
  //       { x: 0, y: 7, w: 1, h: 1 },
  //       { x: 1, y: 7, w: 1, h: 1 },
  //       { x: 0, y: 8, w: 1, h: 1 },
  //       { x: 1, y: 8, w: 1, h: 1 },
  //       { x: 2, y: 0, w: 2, h: 9 }
  //     ]
  //   },
  //   sectionList: {
  //     default: ['cost1', 'cost2', 'cost3', 'cost4', 'small_info1', 'small_info2', 'small_info3', 'small_info4', 'small_info5', 'section6', 'sectionDetail']
  //   }
  // },
  // {
  //   pages: ['coverage_home'],
  //   layout: {
  //     default: [
  //       { x: 0, y: 0, w: 2, h: 3 },
  //       { x: 2, y: 0, w: 2, h: 3 },
  //       { x: 0, y: 3, w: 4, h: 3 },
  //       { x: 0, y: 6, w: 2, h: 1 },
  //       { x: 2, y: 6, w: 2, h: 1 },
  //       { x: 0, y: 7, w: 2, h: 1 },
  //       { x: 2, y: 7, w: 2, h: 1 },
  //       { x: 0, y: 8, w: 2, h: 1 },
  //       { x: 2, y: 8, w: 2, h: 1 }
  //     ]
  //   },
  //   sectionList: {
  //     default: ['coverage1', 'coverage2', 'coverage3', 'small_info1', 'small_info2', 'small_info3', 'small_info4', 'small_info5', 'section6']
  //   }
  // },
  // {
  //   pages: ['coverage1', 'coverage2', 'coverage3'],
  //   layout: {
  //     default: [
  //       { x: 0, y: 0, w: 1, h: 3 },
  //       { x: 1, y: 0, w: 1, h: 3 },
  //       { x: 0, y: 3, w: 2, h: 3 },
  //       { x: 0, y: 6, w: 1, h: 1 },
  //       { x: 1, y: 6, w: 1, h: 1 },
  //       { x: 0, y: 7, w: 1, h: 1 },
  //       { x: 1, y: 7, w: 1, h: 1 },
  //       { x: 0, y: 8, w: 1, h: 1 },
  //       { x: 1, y: 8, w: 1, h: 1 },
  //       { x: 2, y: 0, w: 2, h: 9 }
  //     ]
  //   },
  //   sectionList: {
  //     default: ['coverage1', 'coverage2', 'coverage3', 'small_info1', 'small_info2', 'small_info3', 'small_info4', 'small_info5', 'section6', 'sectionDetail']
  //   }
  // },
  // {
  //   pages: ['expenditure_home'],
  //   layout: {
  //     default: [
  //       { x: 0, y: 0, w: 2, h: 3 },
  //       { x: 2, y: 0, w: 2, h: 3 },
  //       { x: 0, y: 3, w: 4, h: 3 },
  //       { x: 0, y: 6, w: 2, h: 1 },
  //       { x: 2, y: 6, w: 2, h: 1 },
  //       { x: 0, y: 7, w: 2, h: 1 },
  //       { x: 2, y: 7, w: 2, h: 1 },
  //       { x: 0, y: 8, w: 2, h: 1 },
  //       { x: 2, y: 8, w: 2, h: 1 }
  //     ]
  //   },
  //   sectionList: {
  //     default: ['expenditure1', 'expenditure2', 'expenditure3', 'small_info1', 'small_info2', 'small_info3', 'small_info4', 'small_info5', 'section6']
  //   }
  // },
  // {
  //   pages: ['expenditure1', 'expenditure2', 'expenditure3'],
  //   layout: {
  //     default: [
  //       { x: 0, y: 0, w: 1, h: 3 },
  //       { x: 1, y: 0, w: 1, h: 3 },
  //       { x: 0, y: 3, w: 2, h: 3 },
  //       { x: 0, y: 6, w: 1, h: 1 },
  //       { x: 1, y: 6, w: 1, h: 1 },
  //       { x: 0, y: 7, w: 1, h: 1 },
  //       { x: 1, y: 7, w: 1, h: 1 },
  //       { x: 0, y: 8, w: 1, h: 1 },
  //       { x: 1, y: 8, w: 1, h: 1 },
  //       { x: 2, y: 0, w: 2, h: 9 }
  //     ]
  //   },
  //   sectionList: {
  //     default: ['expenditure1', 'expenditure2', 'expenditure3', 'small_info1', 'small_info2', 'small_info3', 'small_info4', 'small_info5', 'section6', 'sectionDetail']
  //   }
  // }
];
