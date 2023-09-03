import { inject } from '@loopback/core';
import { DefaultCrudRepository } from '@loopback/repository';
import { MongoDataSource } from '../datasources';
import { SppData, SppDataRelations } from '../models';

export class SppDataRepository extends DefaultCrudRepository<
  SppData,
  typeof SppData.prototype.id,
  SppDataRelations
> {
  constructor(
    @inject('datasources.mongo') dataSource: MongoDataSource,
  ) {
    super(SppData, dataSource);
  }
}
