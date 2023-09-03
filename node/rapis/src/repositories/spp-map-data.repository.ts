import { inject } from '@loopback/core';
import { DefaultCrudRepository } from '@loopback/repository';
import { MongoDataSource } from '../datasources';
import { SppMapData, SppMapDataRelations } from '../models';

export class SppMapDataRepository extends DefaultCrudRepository<
  SppMapData,
  typeof SppMapData.prototype.id,
  SppMapDataRelations
> {
  constructor(
    @inject('datasources.mongo') dataSource: MongoDataSource,
  ) {
    super(SppMapData, dataSource);
  }
}
