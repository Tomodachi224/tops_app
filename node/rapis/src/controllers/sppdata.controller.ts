import {
  Count,
  CountSchema,
  Filter,
  FilterExcludingWhere,
  repository,
  Where
} from '@loopback/repository';
import {
  del, get,
  getModelSchemaRef, param, patch, post, put, requestBody,
  response
} from '@loopback/rest';
import { SppData } from '../models';
import { SppDataRepository } from '../repositories';

export class SppdataController {
  constructor(
    @repository(SppDataRepository)
    public sppDataRepository : SppDataRepository,
  ) {}

  @post('/v1/spp-data')
  @response(200, {
    description: 'SppData model instance',
    content: {'application/json': {schema: getModelSchemaRef(SppData)}},
  })
  async create(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(SppData, {
            title: 'NewSppData',
            exclude: ['id'],
          }),
        },
      },
    })
    sppData: Omit<SppData, 'id'>,
  ): Promise<SppData> {
    return this.sppDataRepository.create(sppData);
  }

  @post('/v1/spp-data-upsert', {
    responses: {
      '200': {
        description: 'multiple insert',
        content: {'application/json': {}},
      },
    },
  })
  async upsertData(@requestBody({
    content: {
      'application/json': {
        schema: {
          type: 'array',
          items: getModelSchemaRef(SppData, {
            title: 'NewData',
            exclude: ['id'],
          }),
        }
      },
    },
  })
  sppDataArray: any): Promise<{}> {
    try {
      // console.log('sppDataArray', sppDataArray);
      // if (typeof(sppDataArray) == 'string') {
      //   sppDataArray = JSON.parse(sppDataArray);
      // }
      const updateData = [];
      const insertData = [];
      for(const sd of sppDataArray) {
        const filterObj = {where: {country: sd.country, indicator: sd.indicator, type_of_result: sd.type_of_result, scheme: sd.scheme, value_type: sd.value_type, label: sd.label, benefit_level: sd.benefit_level, poverty_mean_tested: sd.poverty_mean_tested, special_cov: sd.special_cov, pension_tested: sd.pension_tested}}
        // console.log(filterObj)
        const res = await this.sppDataRepository.find(filterObj);
        // console.log(res);
        if (res.length > 0) {
          for(const r of res) {
            // console.log(r);
            sd.id = r.id;
            sd.value = replaceNaN(sd.value);
            this.sppDataRepository.updateById(sd.id, sd);
            updateData.push(sd);
          }
        } else {
          insertData.push(sd);
        }
      }
      // console.log(updateData.length);
      // console.log(insertData.length);
      // if (updateData.length > 0) {
      //   this.sppDataRepository.updateAll(updateData);
      // }
      if (insertData.length > 0) {
        this.sppDataRepository.createAll(insertData);
      }
      const totalRows = await this.sppDataRepository.count();
      return {total: totalRows, updated: updateData.length, inserted: insertData.length};//.createAll(sppDataArray);
    } catch (e) {
      console.log('ERROR: ', e);
      return {'msg': 'ERROR', 'error': e};
    }
  }

  @get('/v1/spp-data/count')
  @response(200, {
    description: 'SppData model count',
    content: {'application/json': {schema: CountSchema}},
  })
  async count(
    @param.where(SppData) where?: Where<SppData>,
  ): Promise<Count> {
    return this.sppDataRepository.count(where);
  }

  @get('/v1/spp-data')
  @response(200, {
    description: 'Array of SppData model instances',
    content: {
      'application/json': {
        schema: {
          type: 'array',
          items: getModelSchemaRef(SppData, {includeRelations: true}),
        },
      },
    },
  })
  async find(
    @param.filter(SppData) filter?: Filter<SppData>,
  ): Promise<SppData[]> {
    return this.sppDataRepository.find(filter);
  }

  @get('/v1/spp-data-duplicate')
  @response(200, {
    description: 'Duplicate array of SppData model instances by filter',
    content: {
      'application/json': {
        schema: {
          type: 'array',
          items: getModelSchemaRef(SppData, {includeRelations: true}),
        },
      },
    },
  })
  async duplicate(
    @param.filter(SppData) filter?: Filter<SppData>,
  ): Promise<any> {
    try {
      const duplicateData = [];
      const res = await this.sppDataRepository.find(filter);
      // console.log(res);
      if (res.length > 0) {
        for(const r of res) {
          delete r.id;
          r.label = "20057";
          duplicateData.push(r);
        }
      }
      if (duplicateData.length > 0) {
        await this.sppDataRepository.createAll(duplicateData);
      }
      return {total: duplicateData.length}
    } catch (e) {
      console.log('ERROR: ', e);
      return {'msg': 'ERROR', 'error': e};
    }
  }

  @patch('/v1/spp-data')
  @response(200, {
    description: 'SppData PATCH success count',
    content: {'application/json': {schema: CountSchema}},
  })
  async updateAll(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(SppData, {partial: true}),
        },
      },
    })
    sppData: SppData,
    @param.where(SppData) where?: Where<SppData>,
  ): Promise<Count> {
    return this.sppDataRepository.updateAll(sppData, where);
  }

  @get('/v1/spp-data/{id}')
  @response(200, {
    description: 'SppData model instance',
    content: {
      'application/json': {
        schema: getModelSchemaRef(SppData, {includeRelations: true}),
      },
    },
  })
  async findById(
    @param.path.string('id') id: string,
    @param.filter(SppData, {exclude: 'where'}) filter?: FilterExcludingWhere<SppData>
  ): Promise<SppData> {
    return this.sppDataRepository.findById(id, filter);
  }

  @patch('/v1/spp-data/{id}')
  @response(204, {
    description: 'SppData PATCH success',
  })
  async updateById(
    @param.path.string('id') id: string,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(SppData, {partial: true}),
        },
      },
    })
    sppData: SppData,
  ): Promise<void> {
    await this.sppDataRepository.updateById(id, sppData);
  }

  @put('/v1/spp-data/{id}')
  @response(204, {
    description: 'SppData PUT success',
  })
  async replaceById(
    @param.path.string('id') id: string,
    @requestBody() sppData: SppData,
  ): Promise<void> {
    await this.sppDataRepository.replaceById(id, sppData);
  }

  @del('/v1/spp-data/{id}')
  @response(204, {
    description: 'SppData DELETE success',
  })
  async deleteById(@param.path.string('id') id: string): Promise<void> {
    await this.sppDataRepository.deleteById(id);
  }
}

function replaceNaN(val:string) {
    if (val.toLowerCase() == 'nan' || val.toLowerCase() == 'na') {
      return null;
    }
    return val;
}
