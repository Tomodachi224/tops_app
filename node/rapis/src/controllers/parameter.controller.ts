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
import { Parameter } from '../models';
import { ParameterRepository } from '../repositories';

export class ParameterController {
  constructor(
    @repository(ParameterRepository)
    public ParameterRepository: ParameterRepository,
  ) { }

  // @post('/v1/parameter')
  // @response(200, {
  //   description: 'Parameter model instance',
  //   content: { 'application/json': { schema: getModelSchemaRef(Parameter) } },
  // })
  // async create (
  //   @requestBody({
  //     content: {
  //       'application/json': {
  //         schema: getModelSchemaRef(Parameter, {
  //           title: 'NewParameter',
  //           exclude: ['id'],
  //         }),
  //       },
  //     },
  //   })
  //   Parameter: Omit<Parameter, 'id'>,
  // ): Promise<Parameter> {
  //   return this.ParameterRepository.create(Parameter);
  // }

  @get('/v1/parameter/count')
  @response(200, {
    description: 'Parameter model count',
    content: { 'application/json': { schema: CountSchema } },
  })
  async count (
    @param.where(Parameter) where?: Where<Parameter>,
  ): Promise<Count> {
    return this.ParameterRepository.count(where);
  }

  @get('/v1/parameter')
  @response(200, {
    description: 'Array of Parameter model instances',
    content: {
      'application/json': {
        schema: {
          type: 'array',
          items: getModelSchemaRef(Parameter, { includeRelations: true }),
        },
      },
    },
  })
  async find (
    @param.filter(Parameter) filter?: Filter<Parameter>,
  ): Promise<Parameter[]> {
    return this.ParameterRepository.find(filter);
  }

  // @patch('/v1/parameter')
  // @response(200, {
  //   description: 'Parameter PATCH success count',
  //   content: { 'application/json': { schema: CountSchema } },
  // })
  // async updateAll (
  //   @requestBody({
  //     content: {
  //       'application/json': {
  //         schema: getModelSchemaRef(Parameter, { partial: true }),
  //       },
  //     },
  //   })
  //   Parameter: Parameter,
  //   @param.where(Parameter) where?: Where<Parameter>,
  // ): Promise<Count> {
  //   return this.ParameterRepository.updateAll(Parameter, where);
  // }

  // @get('/v1/parameter/{id}')
  // @response(200, {
  //   description: 'Parameter model instance',
  //   content: {
  //     'application/json': {
  //       schema: getModelSchemaRef(Parameter, { includeRelations: true }),
  //     },
  //   },
  // })
  // async findById (
  //   @param.path.string('id') id: string,
  //   @param.filter(Parameter, { exclude: 'where' }) filter?: FilterExcludingWhere<Parameter>
  // ): Promise<Parameter> {
  //   return this.ParameterRepository.findById(id, filter);
  // }

  // @patch('/v1/parameter/{id}')
  // @response(204, {
  //   description: 'Parameter PATCH success',
  // })
  // async updateById (
  //   @param.path.string('id') id: string,
  //   @requestBody({
  //     content: {
  //       'application/json': {
  //         schema: getModelSchemaRef(Parameter, { partial: true }),
  //       },
  //     },
  //   })
  //   Parameter: Parameter,
  // ): Promise<void> {
  //   await this.ParameterRepository.updateById(id, Parameter);
  // }

  // @put('/v1/parameter/{id}')
  // @response(204, {
  //   description: 'Parameter PUT success',
  // })
  // async replaceById (
  //   @param.path.string('id') id: string,
  //   @requestBody() Parameter: Parameter,
  // ): Promise<void> {
  //   await this.ParameterRepository.replaceById(id, Parameter);
  // }

  // @del('/v1/parameter/{id}')
  // @response(204, {
  //   description: 'Parameter DELETE success',
  // })
  // async deleteById (@param.path.string('id') id: string): Promise<void> {
  //   await this.ParameterRepository.deleteById(id);
  // }
}
