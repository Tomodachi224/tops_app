import { inject, lifeCycleObserver, LifeCycleObserver } from '@loopback/core';
import { juggler } from '@loopback/repository';

const MONGO_INITDB_ROOT_USERNAME = process.env.MONGO_INITDB_ROOT_USERNAME;
const MONGO_INITDB_ROOT_PASSWORD = process.env.MONGO_INITDB_ROOT_PASSWORD;
const MONGO_HOST = process.env.MONGO_HOST;
const MONGO_PORT = process.env.MONGO_PORT;
// const MONGO_PATH = process.env.MONGO_PATH;
const MONGO_PATH = `${MONGO_HOST}:${MONGO_PORT}`;
const MONGO_DATABASE = 'sppdb';

const config = {
  name: 'mongo',
  connector: 'mongodb',
  url: 'mongodb://' + ((MONGO_INITDB_ROOT_USERNAME) ? MONGO_INITDB_ROOT_USERNAME + ':' + MONGO_INITDB_ROOT_PASSWORD
    + '@' + MONGO_PATH : MONGO_PATH) + '/' + MONGO_DATABASE,
  host: MONGO_HOST,
  port: MONGO_PORT,
  user: MONGO_INITDB_ROOT_USERNAME,
  password: MONGO_INITDB_ROOT_PASSWORD,
  database: MONGO_DATABASE,
  useNewUrlParser: true,
  authSource: 'admin'
};

// Observe application's life cycle to disconnect the datasource when
// application is stopped. This allows the application to be shut down
// gracefully. The `stop()` method is inherited from `juggler.DataSource`.
// Learn more at https://loopback.io/doc/en/lb4/Life-cycle.html
@lifeCycleObserver('datasource')
export class MongoDataSource extends juggler.DataSource
  implements LifeCycleObserver {
  static dataSourceName = 'mongo';
  static readonly defaultConfig = config;

  constructor(
    @inject('datasources.config.mongo', { optional: true })
    dsConfig: object = config,
  ) {
    super(dsConfig);
  }
}
