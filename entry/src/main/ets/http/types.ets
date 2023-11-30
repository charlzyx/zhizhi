// https://www.cnblogs.com/wzjhoutai/p/7297445.html
export type StoryItem = {
  // 新闻标题
  title: string;
  // 图像地址（官方 API 使用数组形式。 眼下暂未有使用多张图片的情形出现，曾见无 images 属性的情况，请在使用中注意 ）
  images: string[];
  // 0xffffff 渐变主色
  image_hue: string;
  // 作者
  hint: string;
  // 供 Google Analytics 使用
  ga_prefix: string;
  // 作用未知
  type: number;
  // url 与 share_url 中最后的数字（应为内容的 id）
  id: number;
}

export type TopStoryItem = Omit<StoryItem, 'images'> & { image: string }

// 知乎日报 列表 stories/latest
export type Latest = {
  /* YYYYMMDD */
  date: string;
  stories: StoryItem[];
  top_stories: TopStoryItem[]
}

export type History = Omit<Latest, 'top_stories'>

// 知乎日报 正文 {id} story/{id}
export type Story = {
  // HTML 格式的新闻
  body: string;
  // 图片的内容提供方。为了避免被起诉非法使用图片，在显示图片时最好附上其版权信息。
  ["image-source"]: string;
  // 新闻标题
  title: string;
  // 获得的图片同 最新消息 获得的图片分辨率不同。这里获得的是在文章浏览界面中使用的大图。
  image: string;
  image_hue: string;
  // 供在线查看内容与分享至 SNS 用的 URL
  share_url: string;
  // 供手机端的 WebView(UIWebView) 使用
  js: string[];
  // : 这篇文章的推荐者
  recommenders: { avatar: string }[];
  // : 供 Google Analytics 使用
  ga_prefix: string;
  // : 栏目的信息
  section: {
    // : 栏目的缩略图
    thumbnail: string;
    // : 该栏目的 id
    id: number;
    // : 该栏目的名称
    name: string;
  }
  // : 新闻的类型
  type: number;
  // : 新闻的 id
  id: number;
  // : 供手机端的 WebView(UIWebView) 使用 可知，知乎日报的文章浏览界面利用 WebView(UIWebView) 实现
  css: string[]
}

// 知乎日报 过去的 stories/before/{yyyyMMdd}
export type Before = {
  // yyyyMMdd
  date: string;
  stories: StoryItem[]
}


// 知乎日报 评论信息 {id} story-extra/{id}
export type Extra = {
  //长评论总数
  long_comments: number;
  // 点赞总数
  popularity: number;
  // 短评论总数
  short_comments: number;
  //评论总数
  comments: number;
}
// 格式一样
// 知乎日报 长评论 {id}  story/{id}/long-comments
// 知乎日报 短评论 {id} story/{id}/short-comments
export type Comment = {
  // 评论作者
  author: string;
  // 评论者的唯一标识符
  id: number;
  // 评论的内容
  content: string;
  // 评论所获『赞』的数量
  likes: number;
  // 评论时间
  time: number;
  // 用户头像图片的地址
  avatar: string;
}
