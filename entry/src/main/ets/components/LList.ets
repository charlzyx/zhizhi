import dayjs from 'dayjs'
import { http } from '../http'
import { Awaited, PickArrayItem } from '../type'

type Item = Awaited<ReturnType<typeof http.latest>>
type Story = PickArrayItem<Item["stories"]> & { date?: string }

@Component
export struct LList {
  @State loading: boolean = false;
  @State list: Story[] = [];
  @State touched: Record<string, true> = {}
  private before = dayjs();

  append() {
    if (this.loading) return;
    this.loading = true;
    const last = this.before.subtract(1, 'day')
    http.before(last.format("YYYYMMDD")).then(resp => {
      this.list = [...this.list, { date: last.format("MM 月 DD 日") } as Story, ...resp.stories]
      this.before = last;
    }).finally(() => {
      this.loading = false;
    })
  }

  aboutToAppear() {
    this.loading = true;
    http.latest().then(resp => {
      this.list = [...this.list, ...resp.stories]
    }).finally(() => {
      this.loading = false;
    })
  }

  build() {
    Column() {
      List() {
        ForEach(this.list, (item: Story) => {
          ListItem() {
            if (item.date) {
              Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
                Text(item.date).fontSize(14)
                Flex()
                  .height(1)
                  .backgroundColor($r('app.color.text_hint'))
                  .flexBasis(1)
                  .flexShrink(1)
                  .flexBasis(1)
              }.padding({ left: 16, right: 16 })
            } else {
              Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
                Column() {
                  Text(item.title)
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.touched[item.id] ? $r('app.color.text_hint') : $r('app.color.text_primary'))
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .maxLines(2)
                    .margin({ bottom: 8 })
                  Text(item.hint + " · " + "n分钟阅读").fontSize(12).fontColor($r('app.color.text_hint'))
                }
                .alignItems(HorizontalAlign.Start)
                .justifyContent(FlexAlign.SpaceBetween)
                .flexGrow(1)
                .flexShrink(1)
                .flexBasis(1)

                Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.SpaceBetween }) {
                  Image(item.images[0]).objectFit(ImageFit.Cover).width(72).height(72).borderRadius(3)
                }.width(90).height(90).padding(9)
              }
              .padding({ left: 16, right: 16 })
              .height(100)
            }
          }
        }, (item: Story) => (item.id ?? item.date).toString())
      }
      .listDirection(Axis.Vertical)
      .onReachEnd(() => this.append())
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')

  }
}