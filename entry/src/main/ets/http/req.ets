import http from '@ohos.net.http';
import * as qs from 'qs'

const biu = http.createHttp();
const baseUrl = 'https://news-at.zhihu.com/api/4/'; //基础url


export const req = {
  get<T extends Record<string, any>, R extends Record<string, any> = Record<string, any>>(url: string, params?: T) {
    return biu.request(`${baseUrl}/${url}${params ? '?' + qs.stringify(params) : ''}`, {
      method: http.RequestMethod.GET,
      extraData: params,
      header: { 'Content-Type': 'application/json' }
    }).then((resp) => {
      return resp.result as R;
    })
  },
  post<T extends Record<string, any>, R extends Record<string, any> = Record<string, any>>(url: string, data?: T) {
    return biu.request(`${baseUrl}/${url}`, {
      method: http.RequestMethod.POST,
      extraData: data,
      header: { 'Content-Type': 'application/json' }
    }).then((resp) => {
      return resp.result as R;
    })
  }
}