import { Entity, model, property } from '@loopback/repository';

@model({settings: {strict: false}})
export class Parameter extends Entity {
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
  scheme: string;

  @property({
    type: 'number',
  })
  age_eligibility_min?: number;

  @property({
    type: 'number',
  })
  age_eligibility_max?: number;

  @property({
    type: 'number',
  })
  benefit_amount?: number;

  @property({
    type: 'boolean',
  })
  poverty_tested?: boolean;

  @property({
    type: 'number',
  })
  admin_cost?: number;

  // @property({
  //   type: 'array',
  //   itemType: 'string',
  // })
  // sub_ids?: string[];

  // Define well-known properties here

  // Indexer property to allow additional data
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  [prop: string]: any;

  constructor(data?: Partial<Parameter>) {
    super(data);
  }
}

export interface ParameterRelations {
  // describe navigational properties here
}

export type ParameterWithRelations = Parameter & ParameterRelations;
