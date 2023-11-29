import dayjs from 'dayjs'

const toCN = (x: number) => {
  return ['_', '一', '二', '三', '四', '五', '六', '七', '八', '九', '十', '十一', '十二'][x]

}

@Component
export struct Header {
  private dd = dayjs().format("DD")
  private mm = toCN(+dayjs().format("MM"))

  build() {
    Flex({
      direction: FlexDirection.Row, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center
    }) {

      Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
        Text(this.dd).fontColor($r('app.color.text_2nd')).fontSize(22).fontWeight(FontWeight.Bold)
        Text(`${this.mm}月`).fontColor($r('app.color.text_2nd')).fontSize(12).margin({ top: 4 })
      }.width(80)

      Row() {
      }.width(1).height(40).margin({ right: 10 }).backgroundColor($r('app.color.text_hint'))

      Flex({ alignItems: ItemAlign.Center }) {
        Text("知乎日报·遥遥领先!").fontColor($r('app.color.text_primary')).fontSize(26).fontWeight(FontWeight.Medium)
      }.flexGrow(1).flexShrink(1)
      // .border({ style: BorderStyle.Dashed, color: $r("app.color.text_hint"), width: 1 })

      Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center
      }) {
        Image("https://picx.zhimg.com/v2-e2361d82ce7465808260f87bed4a32d0_l.jpg").objectFit(ImageFit.Contain)
          .width(40).height(40).borderRadius(40)
      }
      .width(60).height(60).margin({ right: 12 })
      // .border({ style: BorderStyle.Dashed, color: $r("app.color.text_hint"), width: 1 })

    }
    .padding(4)
    .width('100%')
    .height('100%')
    // .border({ style: BorderStyle.Dashed, color: $r("app.color.text_hint"), width: 1 })

  }
}
