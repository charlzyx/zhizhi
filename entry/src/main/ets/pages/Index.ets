import { Header } from '../components/Header'
import { PPT } from '../components/PPT'
import { LList } from '../components/LList'

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  build() {
    Flex({ direction: FlexDirection.Column }) {
      Column() {
        Header()
      }.height(64)

      Column() {
        PPT()
      }.height(360)

      Flex() {
        LList()
      }
      .flexGrow(1)
      .flexShrink(1)
      .flexBasis(1)

    }
    .height('100%')
  }
}