export type Awaited<T> = T extends Promise<infer P> ? P : T;

export type PickArrayItem<T> = T extends Array<infer P> ? P : never;
