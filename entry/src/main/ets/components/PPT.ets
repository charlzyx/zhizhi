import { http } from '../http'
import { Awaited, PickArrayItem } from '../type'

type Item = Awaited<ReturnType<typeof http.latest>>
type TopStory = PickArrayItem<Item["top_stories"]>

class TopDs implements IDataSource {
  private list: TopStory[] = []
  private listener: DataChangeListener;

  constructor(list: TopStory[]) {
    this.list = list;
    console.log("this.list", this.list)
  }

  totalCount() {
    return this.list.length;
  }

  getData(index: number): TopStory {
    return this.list[index]
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    this.listener = listener
  }

  unregisterDataChangeListener() {

  }
}

@Component
export struct PPT {
  @State list: TopDs = new TopDs([])
  @State loading: boolean = true;
  private swiper: SwiperController = new SwiperController();

  aboutToAppear() {
    this.loading = true;
    console.log('loading....')
    http.latest().then(resp => {
      this.list = new TopDs(resp.top_stories || []);
      console.log('loading then....', resp)
    }).finally(() => {
      this.loading = false;
      console.log('loading finally....')
    })
  }

  build() {
    Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
      if (this.loading) {
        LoadingProgress().color($r('app.color.text_hl')).width("20%")
      } else {
        Swiper(this.swiper) {
          LazyForEach(this.list, (item: TopStory) => {
            Stack({ alignContent: Alignment.Bottom }) {
              Stack({ alignContent: Alignment.Bottom }) {
                Column() {
                }.width('100%').height(200).linearGradient(
                  {
                    colors: [
                      ['rgba(255, 255, 255, 0.1)', 0.0],
                      ['rgba(255, 255, 255, 0.3)', 0.3],
                      [+item.image_hue, 0.7],
                      [+item.image_hue, 1.0],
                    ]
                  }
                ).opacity(0.9)

                Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.SpaceBetween }) {
                  Text(item.title)
                    .fontColor($r('app.color.white'))
                    .fontSize(24)
                    .maxLines(2)
                    .width('100%')
                    .textOverflow({
                      overflow: TextOverflow.Ellipsis
                    })

                  Text(item.hint)
                    .width('100%')
                    .fontColor($r('app.color.light')).fontSize(14).textAlign(TextAlign.Start)
                }.width('100%').height(100).padding(16)
              }
              .width('100%').height('100%').backgroundImage(item.image).backgroundImageSize(ImageSize.Cover)

            }
          }, (item: TopStory) => item.id.toString())
        }
        .autoPlay(true)
        .interval(4000)
        .indicator(true)
        .indicatorStyle({
          right: 16,
          bottom: 16,
          color: "rgba(255, 255, 255, .3)",
          selectedColor: "rgba(255, 255, 255, .9)"
        })
        .loop(true)
        .duration(1000)
        .itemSpace(0)
        .curve(Curve.Linear)
      }

    }.width('100%').height('100%').backgroundColor($r('app.color.text_hint'))
  }
}