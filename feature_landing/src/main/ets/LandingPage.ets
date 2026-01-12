import { Logger } from 'commons_library';

@Builder
export function LandingPageBuilder(name: string, param: Object) {
  LandingPage()
}

@Component
export struct LandingPage {
  pageInfos: NavPathStack = new NavPathStack();

  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 4 }) {
          Column() {
            Text('Fast Reading Exercises')
              .fontSize(13)
              .fontColor('#ffffff') // Beyaz metin - siyah arka planda yeterli kontrast
              .fontWeight(FontWeight.Bold)

          }
          .width('100%')
          .padding({ top: 12 })
          .margin({ bottom: 5 })

          this.buildMenuItem('Find The Letter', $r('app.media.icon_monochrome'), '#0051a8', '#ffffff', '#0051a8',
            () => {
              this.pageInfos.pushPathByName('LetterFindingPage', null);
            })

          this.buildMenuItem('Accelerator', $r('app.media.bookiconss'), '#c62828', '#ffffff', '#c62828', () => {
            this.pageInfos.pushPathByName('ReadingAccelerator', null);
          })

          this.buildMenuItem('Schulte Table', $r('app.media.tick'), '#1e8449', '#ffffff', '#1e8449', () => {
            this.pageInfos.pushPathByName('SchulteTablePage', null);
          })

          this.buildMenuItem('Similar Words', $r('app.media.icon_cropped'), '#c74a1a', '#ffffff', '#c74a1a',
            () => {
              this.pageInfos.pushPathByName('SimilarWordsPage', null);
            })

          Blank().height(20)
        }
        .padding(12)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#000000')
    }
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack
      Logger.info(`current page config info is ` + JSON.stringify(context.getConfigInRouteMap()));
    })
  }

  @Builder
  buildMenuItem(label: string, icon: ResourceStr | string, iconColor: string, textColor: string, bgColor: string,
    action: () => void) {
    Row({ space: 10 }) {
      if (icon) {

        Row() {
          Image(icon)
            .width(32)
            .height(12)
            .borderRadius(16)
        }
        .backgroundColor(iconColor)
        .borderRadius(16)
        .width(21)
        .visibility(Visibility.Hidden)
        .height(21)

      } else {
        Text('SOS')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#ffffff')
          .padding(4)
          .backgroundColor('#c62828')
          .borderRadius(14)
      }

      Text(label)
        .fontSize(12)
        .fontColor(textColor)
        .fontWeight(FontWeight.Bold)
    }
    .padding({
      left: 8,
      right: 8,
      top: 6,
      bottom: 6
    })
    .backgroundColor(bgColor)
    .borderRadius(20)
    .width('80%')
    .onClick(action)
  }
}