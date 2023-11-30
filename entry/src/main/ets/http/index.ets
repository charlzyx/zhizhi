import { req } from './req'
// https://www.cnblogs.com/wzjhoutai/p/7297445.html
import { Before, Comment, Extra, History, Latest, Story, StoryItem } from './types'

export const http = {
  // 知乎日报 列表
  latest() {
    return req.get<never, Latest>('stories/latest');
  },
  // 知乎日报 过去的 {yyyyMMdd}
  before(day: string) {
    return req.get<never, History>(`stories/before/${day}`);
  },
  // 知乎日报 正文 {id}
  detail(id: number) {
    return req.get<never, Story>(`story/${id}`);
  },
  // 知乎日报 评论信息 {id}
  comments(id: number) {
    return req.get<never, Extra>(`story-extra/${id}`);
  },
  // 知乎日报 长评论 {id}
  longComments(id: number) {
    return req.get<never, { comments: Comment[] }>(`story/${id}/long-comments`);
  },
  // 知乎日报 短评论 {id}
  shortComments(id: number) {
    return req.get<never, { comments: Comment[] }>(`story/${id}/short-comments`);
  }
}