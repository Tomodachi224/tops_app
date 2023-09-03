import { Entity, model, property } from '@loopback/repository';

@model({settings: {strict: false}})
export class SppData extends Entity {
  @property({
    type: 'string',
    id: true,
    generated: true,
  })
  id?: string;

  @property({
    type: 'string',
    required: true,
  })
  parameter: string;

  @property({
    type: 'string',
    required: true,
  })
  country: string;

  @property({
    type: 'string',
    required: true,
  })
  indicator: string;

  @property({
    type: 'string',
  })
  type_of_result?: string;

  @property({
    type: 'string',
  })
  scheme?: string;

  @property({
    type: 'string',
  })
  value_type?: string;

  @property({
    type: 'string',
    required: true,
  })
  label: string;

  @property({
    type: 'any',
    required: false,
  })
  value: any;

  @property({
    type: 'string',
    required: true,
  })
  benefit_level: string;

  @property({
    type: 'string',
    required: true,
  })
  poverty_mean_tested: string;

  @property({
    type: 'boolean',
    required: true,
  })
  special_cov: boolean;

  @property({
    type: 'boolean',
    required: true,
  })
  pension_tested: boolean;

  // Define well-known properties here

  // "nameContactUniqueIndex": {
  //   "keys": {
  //      "country": 1,
  //      "indicator": 1,
  //      "type_of_result": 1,
  //      "scheme": 1,
  //      "value_type": 1,
  //      "label": 1,
  //      "benefit_level": 1,
  //      "poverty_mean_tested": 1
  //    },
  //    "options": {
  //      "unique": true
  //    }
  // }

  // Indexer property to allow additional data
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  [prop: string]: any;

  constructor(data?: Partial<SppData>) {
    super(data);
  }
}

export interface SppDataRelations {
  // describe navigational properties here
}

export type SppDataWithRelations = SppData & SppDataRelations;
