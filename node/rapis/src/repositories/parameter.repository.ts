import {inject} from '@loopback/core';
import {DefaultCrudRepository} from '@loopback/repository';
import {MongoDataSource} from '../datasources';
import {Parameter, ParameterRelations} from '../models';

export class ParameterRepository extends DefaultCrudRepository<
  Parameter,
  typeof Parameter.prototype.id,
  ParameterRelations
> {
  constructor(
    @inject('datasources.mongo') dataSource: MongoDataSource,
  ) {
    super(Parameter, dataSource);
  }
}
