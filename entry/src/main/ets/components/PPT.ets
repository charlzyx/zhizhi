import router from '@ohos.router'
import { http } from '../http'
import { Awaited, PickArrayItem } from '../type'
import { HueImage } from './HueImage'

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
              HueImage({ image: item.image !, hue: +item.image_hue, title: item.title !, hint: item.hint ! })
            }.onClick(() => {
              router.replaceUrl({ url: 'pages/Info', params: {
                id: item.id
              } }, router.RouterMode.Single, (err) => {
                if (err) {
                  console.error(`Invoke replaceUrl failed, code is ${err.code}, message is ${err.message}`);
                  return;
                }
                console.info('Invoke replaceUrl succeeded.');
              })
            })
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