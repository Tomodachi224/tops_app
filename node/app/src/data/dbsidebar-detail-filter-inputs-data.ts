export const detailFilterInputs = {
  scenario1: {
    selectedObject: {
      country: '50001',
      scheme_details: [
        {
          scheme: '70001',
          age: [0, 18],
          benefit_percent: 4,
          benefit_currency: 0,
          benefit_ppp: 0,
          admin_cost: 5,
          pmt: 100,
          is_selected: true
        },
        {
          scheme: '70002',
          age: [0, 100],
          benefit_percent: 14,
          benefit_currency: 0,
          benefit_ppp: 0,
          admin_cost: 5,
          pmt: 100,
          is_selected: true
        },
        {
          scheme: '70003',
          age: [65, 100],
          benefit_percent: 16,
          benefit_currency: 0,
          benefit_ppp: 0,
          admin_cost: 5,
          pmt: 100,
          pt: false,
          is_selected: true
        }
      ]
    },
    modeStatus: {
      70001: {
        editMode: {
          age: false,
          benefit_percent: false,
          admin_cost: false,
          pmt: false
        },
        collapseMode: {
          age: false,
          benefit_percent: false,
          admin_cost: false,
          pmt: false
        },
        toggleMode: {
          pmt: false
        }
      },
      70002: {
        editMode: {
          age: false,
          benefit_percent: false,
          admin_cost: false,
          pmt: false
        },
        collapseMode: {
          age: false,
          benefit_percent: false,
          admin_cost: false,
          pmt: false
        },
        toggleMode: {
          pmt: false
        }
      },
      70003: {
        editMode: {
          age: false,
          benefit_percent: false,
          admin_cost: false,
          pmt: false,
          pt: false
        },
        collapseMode: {
          age: false,
          benefit_percent: false,
          admin_cost: false,
          pmt: false,
          pt: false
        },
        toggleMode: {
          pmt: false,
          pt: false
        }
      }
    },
    countryFilters: [
      {
        id: 'scenario1_country',
        label: 'Scenario A:',
        key: 'country',
        items: [
          { value: '50002', label: 'Bangladesh' },
          { value: '50001', label: 'Cambodia' },
          { value: '50017', label: 'Thailand' }
        ],
        class: '',
        no_border: true
      }
    ],
    filters: [
      {
        id: 'scenario1_scheme_detail',
        label: 'Select benefit programme(s):',
        type: 'checkbox_detail',
        key: 'scheme_details',
        items: [
          {
            value: '70001',
            label: 'Child',
            tip_sections: [
              {
                name: 'age',
                order: 2,
                title: 'Age eligibility (years)',
                editable: false,
                type: 'slider',
                slider_settings: {
                  min: 0,
                  max: 18,
                  interval: 1,
                  marks: {
                    0: {
                      label: '0',
                      style: {
                        display: 'block',
                        width: '16px',
                        height: '14px',
                        background: 'white',
                        backgroundRepeat: 'no-repeat',
                        backgroundImage: 'url(/themes/custom/tbdtheme/assets/dist/img/icons/up_mark_fill.svg)',
                        transform: 'translate(-5px, 4px)',
                        borderRadius: '0'
                      }
                    },
                    2: 2,
                    4: 4,
                    6: 6,
                    8: 8,
                    10: 10,
                    12: 12,
                    14: 14,
                    16: 16,
                    18: {
                      label: '18',
                      style: {
                        display: 'block',
                        width: '16px',
                        height: '14px',
                        background: 'white',
                        backgroundRepeat: 'no-repeat',
                        backgroundImage: 'url(/themes/custom/tbdtheme/assets/dist/img/icons/up_mark_fill.svg)',
                        transform: 'translate(-5px, 4px)',
                        borderRadius: '0'
                      }
                    }
                  }
                },
                shortcut_marks: [
                  {
                    name: 'Recommended age range coverage',
                    thumbnail: '/themes/custom/tbdtheme/assets/dist/img/icons/up_mark_fill.svg',
                    value: [0, 18]
                  }
                ]
              },
              {
                name: 'benefit_percent',
                order: 1,
                title: 'Benefit level (% of GDP per capita)',
                title_back: 'Benefit level ([[currency]])',
                editable: true,
                edit_type: 'benefit_currency',
                edit_title: 'in [[currency]]',
                edit_title_back: 'in % of GDP per capita',
                benefit_info: 'This is equivalent to <b>$[[ppp]] PPP</b>, or <b>[[currency]] [[benefit_currency]]</b> per month.',
                benefit_info_back: 'This is equivalent to <b>$[[ppp]] PPP</b>, or <b>[[benefit_percent]]%</b> of GDP per capita per annum.',
                info: 'The transfer value is paid monthly per child, in local currency. Globally, yearly child benefit on average is 4% GDP per capita.',
                type: 'slider',
                slider_settings: {
                  min: 0,
                  max: 16,
                  interval: 1,
                  marks: {
                    0: 0,
                    2: 2,
                    4: {
                      label: 4,
                      style: {
                        display: 'block',
                        width: '16px',
                        height: '32px',
                        background: 'url(/themes/custom/tbdtheme/assets/dist/img/icons/up_mark_stroke.svg) bottom no-repeat, url(/themes/custom/tbdtheme/assets/dist/img/icons/down_mark_fill.svg) top no-repeat',
                        transform: 'translate(-5px, -14px)',
                        borderRadius: '0'
                      }
                    },
                    6: 6,
                    8: 8,
                    10: 10,
                    12: 12,
                    14: 14,
                    16: 16
                  }
                },
                shortcut_marks: [
                  {
                    name: 'Global Average',
                    thumbnail: '/themes/custom/tbdtheme/assets/dist/img/icons/up_mark_stroke.svg',
                    value: 4
                  },
                  {
                    name: 'OECD Average',
                    thumbnail: '/themes/custom/tbdtheme/assets/dist/img/icons/down_mark_fill.svg',
                    value: 4
                  }
                ]
              },
              {
                name: 'admin_cost',
                order: 3,
                title: 'Administrative cost',
                editable: false,
                type: 'slider',
                slider_settings: {
                  min: 0,
                  max: 50,
                  interval: 1,
                  marks: [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50]
                }
              },
              {
                name: 'pmt',
                order: 4,
                title: 'Optional: Proxy Means Tested',
                is_hide_in_comparative: true,
                editable: false,
                type: 'slider',
                toggleable: false,
                toggle_text: 'Make programme means-tested?',
                inner_title: 'Target only the poorest (% of households with children)',
                slider_settings: {
                  min: 0,
                  max: 100,
                  interval: 10,
                  marks: {
                    0: 0,
                    10: 10,
                    20: 20,
                    30: 30,
                    40: 40,
                    50: 50,
                    60: 60,
                    70: 70,
                    80: 80,
                    90: 90,
                    100: 100
                  }
                }
              }
            ]
          },
          {
            value: '70002',
            label: 'Disability',
            tip_sections: [
              {
                name: 'age',
                order: 2,
                title: 'Age eligibility (years)',
                editable: false,
                type: 'slider',
                slider_settings: {
                  min: 0,
                  max: 100,
                  interval: 10,
                  marks: {
                    0: {
                      label: '0',
                      style: {
                        display: 'block',
                        width: '16px',
                        height: '14px',
                        background: 'white',
                        backgroundRepeat: 'no-repeat',
                        backgroundImage: 'url(/themes/custom/tbdtheme/assets/dist/img/icons/up_mark_fill.svg)',
                        transform: 'translate(-5px, 4px)',
                        borderRadius: '0'
                      }
                    },
                    10: 10,
                    20: 20,
                    30: 30,
                    40: 40,
                    50: 50,
                    60: 60,
                    70: 70,
                    80: 80,
                    90: 90,
                    100: {
                      label: '',
                      style: {
                        display: 'block',
                        width: '16px',
                        height: '14px',
                        background: 'white',
                        backgroundRepeat: 'no-repeat',
                        backgroundImage: 'url(/themes/custom/tbdtheme/assets/dist/img/icons/up_mark_fill.svg)',
                        transform: 'translate(-5px, 4px)',
                        borderRadius: '0'
                      }
                    }
                  }
                },
                shortcut_marks: [
                  {
                    name: 'Recommended age range coverage',
                    thumbnail: '/themes/custom/tbdtheme/assets/dist/img/icons/up_mark_fill.svg',
                    value: [0, 100]
                  }
                ]
              },
              {
                name: 'benefit_percent',
                order: 1,
                title: 'Benefit level (% of GDP per capita)',
                title_back: 'Benefit level ([[currency]])',
                editable: true,
                edit_type: 'benefit_currency',
                edit_title: 'in [[currency]]',
                edit_title_back: 'in % of GDP per capita',
                benefit_info: 'This is equivalent to <b>$[[ppp]] PPP</b>, or <b>[[currency]] [[benefit_currency]]</b> per month.',
                benefit_info_back: 'This is equivalent to <b>$[[ppp]] PPP</b>, or <b>[[benefit_percent]]%</b> of GDP per capita per annum.',
                info: 'The transfer value is paid monthly per eligible person, in local currency. Globally, yearly disability benefit on average is 14% of GDP per capita, while among OECD countries it is on average 23%',
                type: 'slider',
                slider_settings: {
                  min: 0,
                  max: 40,
                  interval: 1,
                  marks: {
                    0: 0,
                    5: 5,
                    10: 10,
                    14: {
                      label: '',
                      style: {
                        display: 'block',
                        width: '16px',
                        height: '14px',
                        background: 'white',
                        backgroundRepeat: 'no-repeat',
                        backgroundImage: 'url(/themes/custom/tbdtheme/assets/dist/img/icons/up_mark_stroke.svg)',
                        transform: 'translate(-5px, 4px)',
                        borderRadius: '0'
                      }
                    },
                    15: 15,
                    20: 20,
                    23: {
                      label: '',
                      style: {
                        display: 'block',
                        width: '16px',
                        height: '14px',
                        background: 'white',
                        backgroundRepeat: 'no-repeat',
                        backgroundImage: 'url(/themes/custom/tbdtheme/assets/dist/img/icons/down_mark_fill.svg)',
                        transform: 'translate(-5px, -14px)',
                        borderRadius: '0'
                      }
                    },
                    25: 25,
                    30: 30,
                    35: 35,
                    40: 40
                  }
                },
                shortcut_marks: [
                  {
                    name: 'Global Average',
                    thumbnail: '/themes/custom/tbdtheme/assets/dist/img/icons/up_mark_stroke.svg',
                    value: 14
                  },
                  {
                    name: 'OECD Average',
                    thumbnail: '/themes/custom/tbdtheme/assets/dist/img/icons/down_mark_fill.svg',
                    value: 23
                  }
                ]
              },
              {
                name: 'admin_cost',
                order: 3,
                title: 'Administrative cost',
                editable: false,
                type: 'slider',
                slider_settings: {
                  min: 0,
                  max: 50,
                  interval: 1,
                  marks: [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50]
                }
              },
              {
                name: 'pmt',
                order: 4,
                title: 'Optional: Proxy Means Tested',
                is_hide_in_comparative: true,
                editable: false,
                type: 'slider',
                toggleable: false,
                toggle_text: 'Make programme means-tested?',
                inner_title: 'Target only the poorest (% of households with disabilities)',
                slider_settings: {
                  min: 0,
                  max: 100,
                  interval: 10,
                  marks: {
                    0: 0,
                    10: 10,
                    20: 20,
                    30: 30,
                    40: 40,
                    50: 50,
                    60: 60,
                    70: 70,
                    80: 80,
                    90: 90,
                    100: 100
                  }
                }
              }
            ]
          },
          {
            value: '70003',
            label: 'Old Age',
            tip_sections: [
              {
                name: 'age',
                order: 2,
                title: 'Age eligibility (years)',
                editable: false,
                type: 'slider',
                slider_settings: {
                  min: 50,
                  max: 100,
                  interval: 5,
                  marks: {
                    50: 50,
                    55: 55,
                    60: 60,
                    65: {
                      label: '65',
                      style: {
                        display: 'block',
                        width: '16px',
                        height: '14px',
                        background: 'white',
                        backgroundRepeat: 'no-repeat',
                        backgroundImage: 'url(/themes/custom/tbdtheme/assets/dist/img/icons/up_mark_fill.svg)',
                        transform: 'translate(-5px, 4px)',
                        borderRadius: '0'
                      }
                    },
                    70: 70,
                    75: 75,
                    80: 80,
                    85: 85,
                    90: 90,
                    95: 95,
                    100: {
                      label: '100',
                      style: {
                        display: 'block',
                        width: '16px',
                        height: '14px',
                        background: 'white',
                        backgroundRepeat: 'no-repeat',
                        backgroundImage: 'url(/themes/custom/tbdtheme/assets/dist/img/icons/up_mark_fill.svg)',
                        transform: 'translate(-5px, 4px)',
                        borderRadius: '0'
                      }
                    }
                  }
                },
                shortcut_marks: [
                  {
                    name: 'Recommended age range coverage',
                    thumbnail: '/themes/custom/tbdtheme/assets/dist/img/icons/up_mark_fill.svg',
                    value: [65, 100]
                  }
                ]
              },
              {
                name: 'benefit_percent',
                order: 1,
                title: 'Benefit level (% of GDP per capita)',
                title_back: 'Benefit level ([[currency]])',
                editable: true,
                edit_type: 'benefit_currency',
                edit_title: 'in [[currency]]',
                edit_title_back: 'in % of GDP per capita',
                benefit_info: 'This is equivalent to <b>$[[ppp]] PPP</b>, or <b>[[currency]] [[benefit_currency]]</b> per month.',
                benefit_info_back: 'This is equivalent to <b>$[[ppp]] PPP</b>, or <b>[[benefit_percent]]%</b> of GDP per capita per annum.',
                info: 'The transfer value is paid monthly per eligible person, in local currency. Globally, yearly old age benefit on average is 16% of GDP per capita, while among OECD countries it is on an average 22%',
                type: 'slider',
                slider_settings: {
                  min: 0,
                  max: 40,
                  interval: 1,
                  value: 16,
                  marks: {
                    0: 0,
                    5: 5,
                    10: 10,
                    15: 15,
                    16: {
                      label: '',
                      style: {
                        display: 'block',
                        width: '16px',
                        height: '14px',
                        background: 'white',
                        backgroundRepeat: 'no-repeat',
                        backgroundImage: 'url(/themes/custom/tbdtheme/assets/dist/img/icons/up_mark_stroke.svg)',
                        transform: 'translate(-5px, 4px)',
                        borderRadius: '0'
                      }
                    },
                    20: 20,
                    22: {
                      label: '',
                      style: {
                        display: 'block',
                        width: '16px',
                        height: '14px',
                        background: 'white',
                        backgroundRepeat: 'no-repeat',
                        backgroundImage: 'url(/themes/custom/tbdtheme/assets/dist/img/icons/down_mark_fill.svg)',
                        transform: 'translate(-5px, -14px)',
                        borderRadius: '0'
                      }
                    },
                    25: 25,
                    30: 30,
                    35: 35,
                    40: 40
                  }
                },
                shortcut_marks: [
                  {
                    name: 'Global Average',
                    thumbnail: '/themes/custom/tbdtheme/assets/dist/img/icons/up_mark_stroke.svg',
                    value: 16
                  },
                  {
                    name: 'OECD Average',
                    thumbnail: '/themes/custom/tbdtheme/assets/dist/img/icons/down_mark_fill.svg',
                    value: 22
                  }
                ]
              },
              {
                name: 'admin_cost',
                order: 3,
                title: 'Administrative cost',
                editable: false,
                type: 'slider',
                slider_settings: {
                  min: 0,
                  max: 50,
                  interval: 1,
                  marks: [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50]
                }
              },
              {
                name: 'pmt',
                order: 4,
                title: 'Optional: Proxy Means Tested',
                is_hide_in_comparative: true,
                editable: false,
                type: 'slider',
                toggleable: false,
                toggle_text: 'Make programme means-tested?',
                inner_title: 'Target only the poorest (% of households with older people)',
                slider_settings: {
                  min: 0,
                  max: 100,
                  interval: 10,
                  marks: {
                    0: 0,
                    10: 10,
                    20: 20,
                    30: 30,
                    40: 40,
                    50: 50,
                    60: 60,
                    70: 70,
                    80: 80,
                    90: 90,
                    100: 100
                  }
                }
              },
              {
                name: 'pt',
                order: 5,
                title: 'Optional : Pension Tested',
                editable: false,
                type: 'toggle',
                toggleable: true,
                toggle_text: 'Make programme pension-tested?'
              }
            ]
          }
        ]
      }
    ]
  },
  // eslint-disable-next-line @typescript-eslint/ban-types
  scenario2: {
    selectedObject: {
      country: '50001',
      scheme_details: [
        {
          scheme: '70001',
          age: [0, 18],
          benefit_percent: 4,
          benefit_currency: 0,
          benefit_ppp: 0,
          admin_cost: 5,
          pmt: 100,
          is_selected: true
        },
        {
          scheme: '70002',
          age: [0, 100],
          benefit_percent: 14,
          benefit_currency: 0,
          benefit_ppp: 0,
          admin_cost: 5,
          pmt: 100,
          is_selected: true
        },
        {
          scheme: '70003',
          age: [65, 100],
          benefit_percent: 16,
          benefit_currency: 0,
          benefit_ppp: 0,
          admin_cost: 5,
          pmt: 100,
          pt: false,
          is_selected: true
        }
      ]
    },
    modeStatus: {
      70001: {
        editMode: {
          age: false,
          benefit_percent: false,
          admin_cost: false,
          pmt: false
        },
        collapseMode: {
          age: false,
          benefit_percent: false,
          admin_cost: false,
          pmt: false
        },
        toggleMode: {
          pmt: false
        }
      },
      70002: {
        editMode: {
          age: false,
          benefit_percent: false,
          admin_cost: false,
          pmt: false
        },
        collapseMode: {
          age: false,
          benefit_percent: false,
          admin_cost: false,
          pmt: false
        },
        toggleMode: {
          pmt: false
        }
      },
      70003: {
        editMode: {
          age: false,
          benefit_percent: false,
          admin_cost: false,
          pmt: false,
          pt: false
        },
        collapseMode: {
          age: false,
          benefit_percent: false,
          admin_cost: false,
          pmt: false,
          pt: false
        },
        toggleMode: {
          pmt: false,
          pt: false
        }
      }
    },
    countryFilters: [
      {
        id: 'scenario2_country',
        label: 'Scenario B:',
        key: 'country',
        items: [
          { value: '50002', label: 'Bangladesh' },
          { value: '50001', label: 'Cambodia' },
          { value: '50017', label: 'Thailand' }
        ],
        class: '',
        no_border: true
      }
    ],
    filters: [
      {
        id: 'scenario2_scheme_detail',
        label: 'Select benefit programme(s):',
        type: 'checkbox_detail',
        key: 'scheme_details',
        items: [
          {
            value: '70001',
            label: 'Child',
            tip_sections: [
              {
                name: 'age',
                order: 2,
                title: 'Age eligibility (years)',
                editable: false,
                type: 'slider',
                slider_settings: {
                  min: 0,
                  max: 18,
                  interval: 1,
                  marks: {
                    0: {
                      label: '0',
                      style: {
                        display: 'block',
                        width: '16px',
                        height: '14px',
                        background: 'white',
                        backgroundRepeat: 'no-repeat',
                        backgroundImage: 'url(/themes/custom/tbdtheme/assets/dist/img/icons/up_mark_fill.svg)',
                        transform: 'translate(-5px, 4px)',
                        borderRadius: '0'
                      }
                    },
                    2: 2,
                    4: 4,
                    6: 6,
                    8: 8,
                    10: 10,
                    12: 12,
                    14: 14,
                    16: 16,
                    18: {
                      label: '18',
                      style: {
                        display: 'block',
                        width: '16px',
                        height: '14px',
                        background: 'white',
                        backgroundRepeat: 'no-repeat',
                        backgroundImage: 'url(/themes/custom/tbdtheme/assets/dist/img/icons/up_mark_fill.svg)',
                        transform: 'translate(-5px, 4px)',
                        borderRadius: '0'
                      }
                    }
                  }
                },
                shortcut_marks: [
                  {
                    name: 'Recommended age range coverage',
                    thumbnail: '/themes/custom/tbdtheme/assets/dist/img/icons/up_mark_fill.svg',
                    value: [0, 18]
                  }
                ]
              },
              {
                name: 'benefit_percent',
                order: 1,
                title: 'Benefit level (% of GDP per capita)',
                title_back: 'Benefit level ([[currency]])',
                editable: true,
                edit_type: 'benefit_currency',
                edit_title: 'in [[currency]]',
                edit_title_back: 'in % of GDP per capita',
                benefit_info: 'This is equivalent to <b>$[[ppp]] PPP</b>, or <b>[[currency]] [[benefit_currency]]</b> per month.',
                benefit_info_back: 'This is equivalent to <b>$[[ppp]] PPP</b>, or <b>[[benefit_percent]]%</b> of GDP per capita per annum.',
                info: 'The transfer value is paid monthly per child, in local currency. Globally, yearly child benefit on average is 4% GDP per capita.',
                type: 'slider',
                slider_settings: {
                  min: 0,
                  max: 16,
                  interval: 1,
                  marks: {
                    0: 0,
                    2: 2,
                    4: {
                      label: '4',
                      style: {
                        display: 'block',
                        width: '16px',
                        height: '32px',
                        background: 'url(/themes/custom/tbdtheme/assets/dist/img/icons/up_mark_stroke.svg) bottom no-repeat, url(/themes/custom/tbdtheme/assets/dist/img/icons/down_mark_fill.svg) top no-repeat',
                        transform: 'translate(-5px, -14px)',
                        borderRadius: '0'
                      }
                    },
                    6: 6,
                    8: 8,
                    10: 10,
                    12: 12,
                    14: 14,
                    16: 16
                  }
                },
                shortcut_marks: [
                  {
                    name: 'Global Average',
                    thumbnail: '/themes/custom/tbdtheme/assets/dist/img/icons/up_mark_stroke.svg',
                    value: 4
                  },
                  {
                    name: 'OECD Average',
                    thumbnail: '/themes/custom/tbdtheme/assets/dist/img/icons/down_mark_fill.svg',
                    value: 4
                  }
                ]
              },
              {
                name: 'admin_cost',
                order: 3,
                title: 'Administrative cost',
                editable: false,
                type: 'slider',
                slider_settings: {
                  min: 0,
                  max: 50,
                  interval: 1,
                  marks: [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50]
                }
              },
              {
                name: 'pmt',
                order: 4,
                title: 'Optional: Proxy Means Tested',
                is_hide_in_comparative: true,
                editable: false,
                type: 'slider',
                toggleable: false,
                toggle_text: 'Make programme means-tested?',
                inner_title: 'Target only the poorest (% of households with children)',
                slider_settings: {
                  min: 0,
                  max: 100,
                  interval: 10,
                  marks: {
                    0: 0,
                    10: 10,
                    20: 20,
                    30: 30,
                    40: 40,
                    50: 50,
                    60: 60,
                    70: 70,
                    80: 80,
                    90: 90,
                    100: 100
                  }
                }
              }
            ]
          },
          {
            value: '70002',
            label: 'Disability',
            tip_sections: [
              {
                name: 'age',
                order: 2,
                title: 'Age eligibility (years)',
                editable: false,
                type: 'slider',
                slider_settings: {
                  min: 0,
                  max: 100,
                  interval: 10,
                  marks: {
                    0: {
                      label: '0',
                      style: {
                        display: 'block',
                        width: '16px',
                        height: '14px',
                        background: 'white',
                        backgroundRepeat: 'no-repeat',
                        backgroundImage: 'url(/themes/custom/tbdtheme/assets/dist/img/icons/up_mark_fill.svg)',
                        transform: 'translate(-5px, 4px)',
                        borderRadius: '0'
                      }
                    },
                    10: 10,
                    20: 20,
                    30: 30,
                    40: 40,
                    50: 50,
                    60: 60,
                    70: 70,
                    80: 80,
                    90: 90,
                    100: {
                      label: '',
                      style: {
                        display: 'block',
                        width: '16px',
                        height: '14px',
                        background: 'white',
                        backgroundRepeat: 'no-repeat',
                        backgroundImage: 'url(/themes/custom/tbdtheme/assets/dist/img/icons/up_mark_fill.svg)',
                        transform: 'translate(-5px, 4px)',
                        borderRadius: '0'
                      }
                    }
                  }
                },
                shortcut_marks: [
                  {
                    name: 'Recommended age range coverage',
                    thumbnail: '/themes/custom/tbdtheme/assets/dist/img/icons/up_mark_fill.svg',
                    value: [0, 100]
                  }
                ]
              },
              {
                name: 'benefit_percent',
                order: 1,
                title: 'Benefit level (% of GDP per capita)',
                title_back: 'Benefit level ([[currency]])',
                editable: true,
                edit_type: 'benefit_currency',
                edit_title: 'in [[currency]]',
                edit_title_back: 'in % of GDP per capita',
                type: 'slider',
                benefit_info: 'This is equivalent to <b>$[[ppp]] PPP</b>, or <b>[[currency]] [[benefit_currency]]</b> per month.',
                benefit_info_back: 'This is equivalent to <b>$[[ppp]] PPP</b>, or <b>[[benefit_percent]]%</b> of GDP per capita per annum.',
                info: 'The transfer value is paid monthly per eligible person, in local currency. Globally, yearly disability benefit on average is 14% of GDP per capita, while among OECD countries it is on average 23%',
                slider_settings: {
                  min: 0,
                  max: 40,
                  interval: 1,
                  marks: {
                    0: 0,
                    5: 5,
                    10: 10,
                    14: {
                      label: '',
                      style: {
                        display: 'block',
                        width: '16px',
                        height: '14px',
                        background: 'white',
                        backgroundRepeat: 'no-repeat',
                        backgroundImage: 'url(/themes/custom/tbdtheme/assets/dist/img/icons/up_mark_stroke.svg)',
                        transform: 'translate(-5px, 4px)',
                        borderRadius: '0'
                      }
                    },
                    15: 15,
                    20: 20,
                    23: {
                      label: '',
                      style: {
                        display: 'block',
                        width: '16px',
                        height: '14px',
                        background: 'white',
                        backgroundRepeat: 'no-repeat',
                        backgroundImage: 'url(/themes/custom/tbdtheme/assets/dist/img/icons/down_mark_fill.svg)',
                        transform: 'translate(-5px, -14px)',
                        borderRadius: '0'
                      }
                    },
                    25: 25,
                    30: 30,
                    35: 35,
                    40: 40
                  }
                },
                shortcut_marks: [
                  {
                    name: 'Global Average',
                    thumbnail: '/themes/custom/tbdtheme/assets/dist/img/icons/up_mark_stroke.svg',
                    value: 14
                  },
                  {
                    name: 'OECD Average',
                    thumbnail: '/themes/custom/tbdtheme/assets/dist/img/icons/down_mark_fill.svg',
                    value: 23
                  }
                ]
              },
              {
                name: 'admin_cost',
                order: 3,
                title: 'Administrative cost',
                editable: false,
                type: 'slider',
                slider_settings: {
                  min: 0,
                  max: 50,
                  interval: 1,
                  marks: [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50]
                }
              },
              {
                name: 'pmt',
                order: 4,
                title: 'Optional: Proxy Means Tested',
                is_hide_in_comparative: true,
                editable: false,
                type: 'slider',
                toggleable: false,
                toggle_text: 'Make programme means-tested?',
                inner_title: 'Target only the poorest (% of households with disabilities)',
                slider_settings: {
                  min: 0,
                  max: 100,
                  interval: 10,
                  marks: {
                    0: 0,
                    10: 10,
                    20: 20,
                    30: 30,
                    40: 40,
                    50: 50,
                    60: 60,
                    70: 70,
                    80: 80,
                    90: 90,
                    100: 100
                  }
                }
              }
            ]
          },
          {
            value: '70003',
            label: 'Old Age',
            tip_sections: [
              {
                name: 'age',
                order: 2,
                title: 'Age eligibility (years)',
                editable: false,
                type: 'slider',
                slider_settings: {
                  min: 50,
                  max: 100,
                  interval: 5,
                  marks: {
                    50: 50,
                    55: 55,
                    60: 60,
                    65: {
                      label: '65',
                      style: {
                        display: 'block',
                        width: '16px',
                        height: '14px',
                        background: 'white',
                        backgroundRepeat: 'no-repeat',
                        backgroundImage: 'url(/themes/custom/tbdtheme/assets/dist/img/icons/up_mark_fill.svg)',
                        transform: 'translate(-5px, 4px)',
                        borderRadius: '0'
                      }
                    },
                    70: 70,
                    75: 75,
                    80: 80,
                    85: 85,
                    90: 90,
                    95: 95,
                    100: {
                      label: '100',
                      style: {
                        display: 'block',
                        width: '16px',
                        height: '14px',
                        background: 'white',
                        backgroundRepeat: 'no-repeat',
                        backgroundImage: 'url(/themes/custom/tbdtheme/assets/dist/img/icons/up_mark_fill.svg)',
                        transform: 'translate(-5px, 4px)',
                        borderRadius: '0'
                      }
                    }
                  }
                },
                shortcut_marks: [
                  {
                    name: 'Recommended age range coverage',
                    thumbnail: '/themes/custom/tbdtheme/assets/dist/img/icons/up_mark_fill.svg',
                    value: [65, 100]
                  }
                ]
              },
              {
                name: 'benefit_percent',
                order: 1,
                title: 'Benefit level (% of GDP per capita)',
                title_back: 'Benefit level ([[currency]])',
                editable: true,
                edit_type: 'benefit_currency',
                edit_title: 'in [[currency]]',
                edit_title_back: 'in % of GDP per capita',
                benefit_info: 'This is equivalent to <b>$[[ppp]] PPP</b>, or <b>[[currency]] [[benefit_currency]]</b> per month.',
                benefit_info_back: 'This is equivalent to <b>$[[ppp]] PPP</b>, or <b>[[benefit_percent]]%</b> of GDP per capita per annum.',
                info: 'The transfer value is paid monthly per eligible person, in local currency. Globally, yearly old age benefit on average is 16% of GDP per capita, while among OECD countries it is on an average 22%',
                type: 'slider',
                slider_settings: {
                  min: 0,
                  max: 40,
                  interval: 1,
                  value: 16,
                  marks: {
                    0: 0,
                    5: 5,
                    10: 10,
                    15: 15,
                    16: {
                      label: '',
                      style: {
                        display: 'block',
                        width: '16px',
                        height: '14px',
                        background: 'white',
                        backgroundRepeat: 'no-repeat',
                        backgroundImage: 'url(/themes/custom/tbdtheme/assets/dist/img/icons/up_mark_stroke.svg)',
                        transform: 'translate(-5px, 4px)',
                        borderRadius: '0'
                      }
                    },
                    20: 20,
                    22: {
                      label: '',
                      style: {
                        display: 'block',
                        width: '16px',
                        height: '14px',
                        background: 'white',
                        backgroundRepeat: 'no-repeat',
                        backgroundImage: 'url(/themes/custom/tbdtheme/assets/dist/img/icons/down_mark_fill.svg)',
                        transform: 'translate(-5px, -14px)',
                        borderRadius: '0'
                      }
                    },
                    25: 25,
                    30: 30,
                    35: 35,
                    40: 40
                  }
                },
                shortcut_marks: [
                  {
                    name: 'Global Average',
                    thumbnail: '/themes/custom/tbdtheme/assets/dist/img/icons/up_mark_stroke.svg',
                    value: 16
                  },
                  {
                    name: 'OECD Average',
                    thumbnail: '/themes/custom/tbdtheme/assets/dist/img/icons/down_mark_fill.svg',
                    value: 22
                  }
                ]
              },
              {
                name: 'admin_cost',
                order: 3,
                title: 'Administrative cost',
                editable: false,
                type: 'slider',
                slider_settings: {
                  min: 0,
                  max: 50,
                  interval: 1,
                  marks: [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50]
                }
              },
              {
                name: 'pmt',
                order: 4,
                title: 'Optional: Proxy Means Tested',
                is_hide_in_comparative: true,
                editable: false,
                type: 'slider',
                toggleable: false,
                toggle_text: 'Make programme means-tested?',
                inner_title: 'Target only the poorest (% of households with older people)',
                slider_settings: {
                  min: 0,
                  max: 100,
                  interval: 10,
                  marks: {
                    0: 0,
                    10: 10,
                    20: 20,
                    30: 30,
                    40: 40,
                    50: 50,
                    60: 60,
                    70: 70,
                    80: 80,
                    90: 90,
                    100: 100
                  }
                }
              },
              {
                name: 'pt',
                order: 5,
                title: 'Optional : Pension Tested',
                editable: false,
                type: 'toggle',
                toggleable: true,
                toggle_text: 'Make programme pension-tested?'
              }
            ]
          }
        ]
      }
    ]
  }
};
