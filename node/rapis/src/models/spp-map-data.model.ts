import { Entity, model, property } from '@loopback/repository';

@model({settings: {strict: false}})
export class SppMapData extends Entity {
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
  indicator: string;

  @property({
    type: 'string',
    required: true,
  })
  country: string;

  @property({
    type: 'string',
    required: true,
  })
  region: string;

  @property({
    type: 'any',
    required: true,
  })
  value: any;

  @property({
    type: 'string',
    required: true,
  })
  lat: any;

  @property({
    type: 'string',
    required: true,
  })
  long: any;

  @property({
    type: 'string',
    required: true,
  })
  year: any;

  // Define well-known properties here

  // Indexer property to allow additional data
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  [prop: string]: any;

  constructor(data?: Partial<SppMapData>) {
    super(data);
  }
}

export interface SppMapDataRelations {
  // describe navigational properties here
}

export type SppMapDataWithRelations = SppMapData & SppMapDataRelations;
