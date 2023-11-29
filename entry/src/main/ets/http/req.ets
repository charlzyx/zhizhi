import http from '@ohos.net.http';
import action from '@ohos.promptAction'

const biu = http.createHttp();
const baseUrl = 'https://news-at.zhihu.com/api/4'; //基础url


const qs = <O extends Record<string, any>>(o: O) => {
  return Object.keys(o).reduce((s, k) => {
    // Demo 而已, 不做处理啦
    if (Array.isArray(o[k])) {
      return s;
    }
    return `${s}&${k}=${o[k]}`
  })
}

export const req = {
  get<T extends Record<string, any>, R extends Record<string, any> = Record<string, any>>(url: string, params?: T) {
    const to = `${baseUrl}/${url}${params ? '?' + qs(params) : ''}`;
    return biu.request(to, {
      method: http.RequestMethod.GET,
      extraData: params,
      header: { 'Content-Type': 'application/json' }
    }).then((resp) => {
      return JSON.parse(resp.result as string) as R;
    }).catch(err => {
      action.showToast({
        message: err.message || "哎呀!请求出错啦, 请稍后重试"
      })
      throw err;
    })

  },
  post<T extends Record<string, any>, R extends Record<string, any> = Record<string, any>>(url: string, data?: T) {
    return biu.request(`${baseUrl}/${url}`, {
      method: http.RequestMethod.POST,
      extraData: data,
      header: { 'Content-Type': 'application/json' }
    }).then((resp) => {
      return JSON.parse(resp.result as string) as R;
    }).catch(err => {
      action.showToast({
        message: err.message || "哎呀!请求出错啦, 请稍后重试"
      })
      throw err;
    })
  }
}