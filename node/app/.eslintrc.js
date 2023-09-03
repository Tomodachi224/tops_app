module.exports = {
  root: true,
  env: {
    browser: true,
    es2020: true,
    node: true
  },
  extends: [
    'eslint:recommended',
    // 'plugin:vue/recommended',
    'plugin:@typescript-eslint/recommended',
    'plugin:vue/essential',
    '@vue/standard',
    '@vue/typescript/recommended'
  ],
  parserOptions: {
    ecmaVersion: 2020,
    parser: '@typescript-eslint/parser',
    sourceType: 'module'
  },
  plugins: [
    'vue',
    '@typescript-eslint'
  ],
  rules: {
    '@typescript-eslint/no-explicit-any': 'off',
    '@typescript-eslint/explicit-module-boundary-types': 'off',
    '@typescript-eslint/no-this-alias': [
      'error',
      {
        allowedNames: ['self']
      }
    ],
    'no-console': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
    'no-debugger': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
    'vue/max-attributes-per-line': ['error', {
      singleline: 6
    }],
    semi: [2, 'always'],
    camelcase: 'off',
    '@typescript-eslint/camelcase': ['off']
  },
  overrides: [
    {
      files: [
        '**/__tests__/*.{j,t}s?(x)',
        '**/tests/unit/**/*.spec.{j,t}s?(x)'
      ],
      env: {
        jest: true
      }
    },
    {
      files: ['vue.config.js'],
      rules: {
        '@typescript-eslint/no-var-requires': 'off'
      }
    }
  ]
};
