module.exports = {
  apps: [{
      name: 'RAPIS',
      script: 'dist/index.js',
      instances: 1,
      autorestart: true,
      watch: false,
      max_memory_restart: '1G',
      env_production: {
          NODE_ENV: 'production',
          SERVER_PATH: 'https://spp.thinkbluedata.com',
          MONGO_HOST: 'localhost',
          MONGO_PORT: 27017,
          MONGO_INITDB_ROOT_USERNAME: '',
          MONGO_INITDB_ROOT_PASSWORD: '',
          MONGO_DATABASE: 'sppdb',
          DRUPAL_API_KEY: ''
      }
  }]
};
