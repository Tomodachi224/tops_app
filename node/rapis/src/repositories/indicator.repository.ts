import {inject} from '@loopback/core';
import {DefaultCrudRepository} from '@loopback/repository';
import {MongoDataSource} from '../datasources';
import {Indicator, IndicatorRelations} from '../models';

export class IndicatorRepository extends DefaultCrudRepository<
  Indicator,
  typeof Indicator.prototype.id,
  IndicatorRelations
> {
  constructor(
    @inject('datasources.mongo') dataSource: MongoDataSource,
  ) {
    super(Indicator, dataSource);
  }
}
