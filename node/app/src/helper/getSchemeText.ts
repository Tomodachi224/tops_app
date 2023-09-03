export default function getSchemeText (schemeId: string) {
  // TODO: Get from api/ store
  const obj: { [key: string]: string } = {
    70001: 'Child',
    70002: 'Disability',
    70003: 'Old Age'
  };
  return obj[schemeId];
}
