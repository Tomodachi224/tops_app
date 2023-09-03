'use strict';
import axios from '@axios';

export default async function getTextFromTemplate (templateText: string, dataObj: any): Promise<string> {
  const re = /(\[\[).+?(?=\]\])/g;
  let result = templateText;
  const matches = templateText.match(re);
  let compareText = '';
  if (matches) {
    for (const match_ of matches) {
      const match = match_.split('[[')[1];
      if (match === 'compare_text') {
        if (dataObj.value > dataObj.compareVal) {
          compareText = 'higher than';
        } else if (dataObj.value < dataObj.compareVal) {
          compareText = 'lower than';
        } else {
          compareText = 'equal to';
        }
        result = result.replace(`[[${match}]]`, compareText);
      } else if (match === 'value') {
        const absoluteVal = Math.abs(dataObj[match]);
        result = result.replace(`[[${match}]]`, String(absoluteVal));
        if (isNaN(absoluteVal)) {
          result = 'N/A';
        }
      } else if (match === 'valueRound10') {
        let valueRound = Math.floor(dataObj.value / 10) * 10;
        if (dataObj.value < 10) {
          valueRound = Math.floor(dataObj.value);
        }
        result = result.replace(`[[${match}]]`, String(valueRound));
        if (isNaN(valueRound)) {
          result = 'N/A';
        }
      } else if (match === 'valueRound') {
        let absoluteVal = Math.round(Math.abs(dataObj.value));
        if (Math.abs(dataObj.value) < 1) {
          absoluteVal = Math.abs(dataObj.value);
        }
        result = result.replace(`[[${match}]]`, String(absoluteVal));
        if (isNaN(absoluteVal)) {
          result = 'N/A';
        }
      } else if (match === 'isNeg') {
        if (dataObj.value < 0) {
          const iconPath = '/themes/custom/tbdtheme/assets/dist/img/icons/arrow-down.svg';
          const iconHtmlRes = await axios.get(iconPath);
          const iconHtml = iconHtmlRes && iconHtmlRes.data ? iconHtmlRes.data : iconPath;
          result = result.replace(`[[${match}]]`, iconHtml);
        } else {
          result = result.replace(`[[${match}]]`, '');
        }
      } else if (match === 'isPos') {
        if (dataObj.value > 0) {
          const iconPath = '/themes/custom/tbdtheme/assets/dist/img/icons/arrow-up.svg';
          const iconHtmlRes = await axios.get(iconPath);
          const iconHtml = iconHtmlRes && iconHtmlRes.data ? iconHtmlRes.data : iconPath;
          result = result.replace(`[[${match}]]`, iconHtml);
        } else {
          result = result.replace(`[[${match}]]`, '');
        }
      } else if (match === 'moreThanSign') {
        const iconPath = '/themes/custom/tbdtheme/assets/dist/img/icons/arrow-right.svg';
        const iconHtmlRes = await axios.get(iconPath);
        const iconHtml = iconHtmlRes && iconHtmlRes.data ? iconHtmlRes.data : iconPath;
        result = result.replace(`[[${match}]]`, iconHtml);
      } else if (match === 'currentYear') {
        result = result.replace(`[[${match}]]`, String(new Date().getFullYear()));
      } else {
        result = result.replace(`[[${match}]]`, dataObj[match]);
      }
    }
  }
  return result;
}
