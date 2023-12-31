import { Entity, model, property } from '@loopback/repository';

@model({settings: {strict: false}})
export class Indicator extends Entity {
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
  name: string;

  // Define well-known properties here

  // Indexer property to allow additional data
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  [prop: string]: any;

  constructor(data?: Partial<Indicator>) {
    super(data);
  }
}

export interface IndicatorRelations {
  // describe navigational properties here
}

export type IndicatorWithRelations = Indicator & IndicatorRelations;
