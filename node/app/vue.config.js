const path = require('path');

module.exports = {
  outputDir: path.resolve(__dirname, '../../public/web/themes/custom/tbdtheme/assets/dist-vue'),
  chainWebpack: config => {
    config.performance
      .maxEntrypointSize(10000000) // 10mb
      .maxAssetSize(10000000); // 10mb
  //   config
  //     .plugin('html')
  //     .tap(args => {
  //       args[0].title = 'IDD::APDRN'
  //       return args
  //     })
  },
  devServer: {
    proxy: {
      '^/api': {
        target: 'http://localhost',
        changeOrigin: true,
        logLevel: 'debug'
      }
    }
  },
  configureWebpack: {
    resolve: {
      alias: {
        '@axios': path.resolve(__dirname, 'src/libs/axios'),
        '@c': path.resolve(__dirname, 'src/components'),
        '@wc': path.resolve(__dirname, '../webcomponents/src')
      },
      extensions: ['.js', '.vue', '.json']
    },
    optimization: {
      splitChunks: false
    }
  }
};
