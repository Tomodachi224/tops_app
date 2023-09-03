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
import { Indicator } from '../models';
import { IndicatorRepository } from '../repositories';

export class IndicatorController {
  constructor(
    @repository(IndicatorRepository)
    public IndicatorRepository: IndicatorRepository,
  ) { }

  // @post('/v1/indicator')
  // @response(200, {
  //   description: 'Indicator model instance',
  //   content: { 'application/json': { schema: getModelSchemaRef(Indicator) } },
  // })
  // async create (
  //   @requestBody({
  //     content: {
  //       'application/json': {
  //         schema: getModelSchemaRef(Indicator, {
  //           title: 'NewIndicator',
  //           exclude: ['id'],
  //         }),
  //       },
  //     },
  //   })
  //   Indicator: Omit<Indicator, 'id'>,
  // ): Promise<Indicator> {
  //   return this.IndicatorRepository.create(Indicator);
  // }

  @get('/v1/indicator/count')
  @response(200, {
    description: 'Indicator model count',
    content: { 'application/json': { schema: CountSchema } },
  })
  async count (
    @param.where(Indicator) where?: Where<Indicator>,
  ): Promise<Count> {
    return this.IndicatorRepository.count(where);
  }

  @get('/v1/indicator')
  @response(200, {
    description: 'Array of Indicator model instances',
    content: {
      'application/json': {
        schema: {
          type: 'array',
          items: getModelSchemaRef(Indicator, { includeRelations: true }),
        },
      },
    },
  })
  async find (
    @param.filter(Indicator) filter?: Filter<Indicator>,
  ): Promise<Indicator[]> {
    return this.IndicatorRepository.find(filter);
  }

  // @patch('/v1/indicator')
  // @response(200, {
  //   description: 'Indicator PATCH success count',
  //   content: { 'application/json': { schema: CountSchema } },
  // })
  // async updateAll (
  //   @requestBody({
  //     content: {
  //       'application/json': {
  //         schema: getModelSchemaRef(Indicator, { partial: true }),
  //       },
  //     },
  //   })
  //   Indicator: Indicator,
  //   @param.where(Indicator) where?: Where<Indicator>,
  // ): Promise<Count> {
  //   return this.IndicatorRepository.updateAll(Indicator, where);
  // }

  // @get('/v1/indicator/{id}')
  // @response(200, {
  //   description: 'Indicator model instance',
  //   content: {
  //     'application/json': {
  //       schema: getModelSchemaRef(Indicator, { includeRelations: true }),
  //     },
  //   },
  // })
  // async findById (
  //   @param.path.string('id') id: string,
  //   @param.filter(Indicator, { exclude: 'where' }) filter?: FilterExcludingWhere<Indicator>
  // ): Promise<Indicator> {
  //   return this.IndicatorRepository.findById(id, filter);
  // }

  // @patch('/v1/indicator/{id}')
  // @response(204, {
  //   description: 'Indicator PATCH success',
  // })
  // async updateById (
  //   @param.path.string('id') id: string,
  //   @requestBody({
  //     content: {
  //       'application/json': {
  //         schema: getModelSchemaRef(Indicator, { partial: true }),
  //       },
  //     },
  //   })
  //   Indicator: Indicator,
  // ): Promise<void> {
  //   await this.IndicatorRepository.updateById(id, Indicator);
  // }

  // @put('/v1/indicator/{id}')
  // @response(204, {
  //   description: 'Indicator PUT success',
  // })
  // async replaceById (
  //   @param.path.string('id') id: string,
  //   @requestBody() Indicator: Indicator,
  // ): Promise<void> {
  //   await this.IndicatorRepository.replaceById(id, Indicator);
  // }

  // @del('/v1/indicator/{id}')
  // @response(204, {
  //   description: 'Indicator DELETE success',
  // })
  // async deleteById (@param.path.string('id') id: string): Promise<void> {
  //   await this.IndicatorRepository.deleteById(id);
  // }
}
