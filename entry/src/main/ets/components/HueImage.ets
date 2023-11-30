@Component
export struct HueImage {
  @Prop image: string;
  @Prop hue: number;
  @Prop title: string;
  @Prop hint: string;

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
      }.width('100%').height(200).linearGradient(
        {
          colors: [
            ['rgba(255, 255, 255, 0.1)', 0.0],
            ['rgba(255, 255, 255, 0.3)', 0.3],
            [this.hue, 0.7],
            [this.hue, 1.0],
          ]
        }
      ).opacity(0.9)

      Flex({ direction: FlexDirection.Column, justifyContent: this.hint ? FlexAlign.SpaceBetween : FlexAlign.End }) {
        Text(this.title)
          .fontColor($r('app.color.white'))
          .fontSize(24)
          .maxLines(2)
          .width('100%')
          .textOverflow({
            overflow: TextOverflow.Ellipsis
          })

        if (this.hint !== '') {
          Text(this.hint)
            .width('100%')
            .fontColor($r('app.color.light')).fontSize(14).textAlign(TextAlign.Start)
        }

      }.width('100%').height(100).padding(16)
    }
    .width('100%').height('100%').backgroundImage(this.image).backgroundImageSize(ImageSize.Cover)

  }
}