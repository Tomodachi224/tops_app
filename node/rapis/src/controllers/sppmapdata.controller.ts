import {
    Count,
    CountSchema,
    Filter, repository,
    Where
} from '@loopback/repository';
import {
    get,
    getModelSchemaRef, param, response
} from '@loopback/rest';
import { SppMapData } from '../models';
import { SppMapDataRepository } from '../repositories';

export class SppMapDataController {
  constructor(
    @repository(SppMapDataRepository)
    public SppMapDataRepository: SppMapDataRepository,
  ) { }

  @get('/v1/spp-map-data/count')
  @response(200, {
    description: 'SppMapData model count',
    content: { 'application/json': { schema: CountSchema } },
  })
  async count (
    @param.where(SppMapData) where?: Where<SppMapData>,
  ): Promise<Count> {
    return this.SppMapDataRepository.count(where);
  }

  @get('/v1/spp-map-data')
  @response(200, {
    description: 'Array of SppMapData model instances',
    content: {
      'application/json': {
        schema: {
          type: 'array',
          items: getModelSchemaRef(SppMapData, { includeRelations: true }),
        },
      },
    },
  })
  async find (
    @param.filter(SppMapData) filter?: Filter<SppMapData>,
  ): Promise<SppMapData[]> {
    return this.SppMapDataRepository.find(filter);
  }
}
