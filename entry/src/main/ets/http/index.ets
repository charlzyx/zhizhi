import { req } from './req'
// https://www.cnblogs.com/wzjhoutai/p/7297445.html

export const http = {
  // 知乎日报 列表
  latest() {
    return req.get('stories/latest');
  },
  // 知乎日报 过去的 {yyyyMMdd}
  before(day: string) {
    return req.get(`stories/before/${day}`);
  },
  // 知乎日报 正文 {id}
  detail(id: string) {
    return req.get(`story/${id}`);
  },
  // 知乎日报 评论信息 {id}
  comments(id: string) {
    return req.get(`story-extra/${id}`);
  },
  // 知乎日报 长评论 {id}
  longComments(sid: string, id: string) {
    return req.get(`story/${sid}/long-comments/${id}`);
  },
  // 知乎日报 短评论 {id}
  shortComments(sid: string, id: string) {
    return req.get(`story/${sid}/short-comments/${id}`);
  }
}