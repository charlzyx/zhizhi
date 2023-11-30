import router from '@ohos.router';
import { http } from '../http'
import { Awaited } from '../type'
import { HueImage } from '../components/HueImage'
import webview from '@ohos.web.webview';


type Story = Awaited<ReturnType<typeof http.detail>>;

@Entry
@Component
struct Info {
  @State nid: number = 0;
  @State story: Story = null;
  @State loading: boolean = false;
  private webview = new webview.WebviewController();
  private scroller = new Scroller();
  // static userAgent: string = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36 Edg/119.0.0.0'

  onBackPress() {
    router.back()
  }

  onPageShow() {
    const params = router.getParams();
    this.nid = +params['id'];
    if (this.nid) {
      http.detail(this.nid).then(data => {
        this.story = data
        setTimeout(() => {
          this.loadHtml();
        }, 200)

      })
    }
  }

  loadHtml() {
    const header = this.story.css.map(link => `<link rel="stylesheet" href="${link}" />`).join("\n")
    const html = `${header}${this.story.body}`
    try {
      this.webview.loadData(html, 'text/html', 'UTF-8')
    } catch (error) {
      console.error(`ErrorCode: ${error.code},  Message: ${error.message}`);
    }
  }

  build() {
    if (this.story === null) {
      Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
        LoadingProgress().width('20%').height('20%')
      }.width('100%').height('100%')
    } else {
      Scroll() {
        // Column() {
        //   HueImage({ image: this.story.image, hue: +this.story.image_hue, title: this.story.title, hint: '' })
        // }
        // .width('100%')
        // .height(360)
        // .borderWidth(2)
        // .borderColor("red")
        // .borderStyle(BorderStyle.Dashed)

        Web({ src: 'www.example.com', controller: this.webview })
          // .userAgent(Info.userAgent)
          .width('100%')
          .height('100%')
          .borderWidth(2)
          .borderColor("blue")
          .borderStyle(BorderStyle.Dashed)
      }
      .width('100%')
      .height('100%')
      .borderWidth(2)
      .borderColor("green")
      .borderStyle(BorderStyle.Dashed)
    }
  }
}
