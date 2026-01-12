import { Logger } from 'commons_library';
import {
  ArcButton,
  ArcButtonOptions,
  ArcButtonPosition,
  ArcButtonStatus,
  ArcButtonStyleMode,
  LengthMetrics,
  LengthUnit,
  UIContext
} from '@kit.ArkUI';
import { ReadingAcceleratorLogic } from './ReadingAcceleratorLogic';

@Builder
export function ReadingAcceleratorBuilder(name: string, param: Object) {
  ReadingAccelerator()
}

@Component
export struct ReadingAccelerator {
  pageInfos: NavPathStack = new NavPathStack();
  @State viewModel: ReadingAcceleratorLogic = new ReadingAcceleratorLogic()

  private getRandomInt(max: number): number {
    return Math.floor((Date.now() % 10000) / 10000 * max);
  }

  aboutToAppear() {
    this.viewModel.words = this.viewModel.text[this.getRandomInt(5)].split(' ');

    this.viewModel.currentWordIndex = -1;

    this.viewModel.topOptions = new ArcButtonOptions({
      label: this.viewModel.startLabel,
      status: ArcButtonStatus.NORMAL,
      position: ArcButtonPosition.TOP_EDGE,
      styleMode: ArcButtonStyleMode.EMPHASIZED_LIGHT,
      fontSize: new LengthMetrics(15, LengthUnit.FP),
      shadowEnabled: true,
      onClick: () => {
        this.viewModel.startReading()
      }
    })


    this.viewModel.bottomOptions = new ArcButtonOptions({
      label: 'Stop',
      status: ArcButtonStatus.NORMAL,
      styleMode: ArcButtonStyleMode.EMPHASIZED_LIGHT,
      position: ArcButtonPosition.BOTTOM_EDGE,
      fontSize: new LengthMetrics(15, LengthUnit.FP),
      shadowEnabled: true,
      onClick: () => {
        this.viewModel.stopReading()
      }
    })
  }

  build() {

    NavDestination() {

      Row() {
        Column({ space: 2 }) {

          ArcButton({ options: this.viewModel.topOptions })
            .enabled(!this.viewModel.isStarted)


          Scroll(this.viewModel.scroller) {

            Flex({ direction: FlexDirection.Row, wrap: FlexWrap.Wrap }) {
              Text('    ').visibility(Visibility.Hidden)
              ForEach(this.viewModel.words, (word: string, idx: number) => {
                Text(word + ` `)
                  .fontSize(15)
                  .fontColor(this.viewModel.currentWordIndex === idx ? '#ff000000' : '#fff')
                  .fontWeight(this.viewModel.currentWordIndex === idx ? FontWeight.Bold : FontWeight.Normal)
                  .backgroundColor(this.viewModel.currentWordIndex === idx ? 0xCCDDFF : 0x00000000)
                  .padding(3)
                  .borderRadius(5)
                  .id(`word_${idx}`)
                  .onAreaChange((_, area: Area) => {

                    if (this.viewModel.currentWordIndex === idx) {

                      UIContext.prototype.animateTo({
                        duration: 800,
                        curve: Curve.EaseOut,
                        onFinish: () => {
                        }
                      }, () => {
                        this.viewModel.yoffset = Number(area.position.y) - 65;
                      });
                    }
                  })
              }, (item: string, index: number) => item)

            }
            .margin({
              bottom: 0,
              top: 0,
              left: 19,
              right: 19
            })

          }
          .height('55%')
          .scrollable(ScrollDirection.Vertical)
          .scrollBar(BarState.Auto)
          .edgeEffect(EdgeEffect.Spring)

          ArcButton({ options: this.viewModel.bottomOptions })
            .enabled(this.viewModel.isStarted)


        }
        .width('100%')
        .height('100%')
        .align(Alignment.Center)
      }.width('100%').height('100%')

    }
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack
      Logger.info(`current page config info is ` + JSON.stringify(context.getConfigInRouteMap()));
    })

  }
}
