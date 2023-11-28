// https://www.cnblogs.com/wzjhoutai/p/7297445.html
export type Story = {
  // 新闻标题
  title: string;
  // 图像地址（官方 API 使用数组形式。 眼下暂未有使用多张图片的情形出现，曾见无 images 属性的情况，请在使用中注意 ）
  images: string[];
  // 供 Google Analytics 使用
  ga_prefix: string;
  // 作用未知
  type: number;
  // url 与 share_url 中最后的数字（应为内容的 id）
  id: number;
  // 消息是否包括多张图片（仅出如今包括多图的新闻中）
  multipic: boolean
}

export type Latest = {
  /* YYYYMMDD */
  date: string;
  stories: Story[];
  top_stories: Story[]
}
