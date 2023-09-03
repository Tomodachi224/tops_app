import _ from 'lodash';
export default function getCsvDownloadData (dataArr: any) {
  // Conditional check for advanced mode as advanced mode do not have id
  if ('id' in dataArr[0]) {
    dataArr = _.uniqBy(dataArr, 'id');
  }
  const result = _.map(dataArr, (d) => {
    const resObj: any = {
      country: d.country,
      scheme: d.scheme,
      value_type: d.value_type,
      label: d.label,
      value: d.value,
      benefit_level: d.benefit_level_label,
      poverty_mean_tested: d.poverty_mean_tested_label,
      special_cov: d.special_cov,
      pension_tested: d.pension_tested,
      type_of_result: d.type_of_result_label,
      indicator: d.indicator_label
    };

    if (d.region) {
      resObj.region = d.region;
      if (d.indicator === '40007') {
        resObj.poverty_type = d.poverty_type;
      }
    }

    return resObj;
  });
  // Filter out objects with a value of 0 for "% ineligible included" and "% eligible excluded"
  const filteredResult = _.filter(result, (d) => {
    if (d.value_type === '% ineligible included' || d.value_type === '% eligible excluded') {
      return d.value !== 0;
    }
    return true; // Include all other objects
  });

  return filteredResult;
}
