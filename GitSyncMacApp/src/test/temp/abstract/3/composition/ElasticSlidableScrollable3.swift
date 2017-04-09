import Cocoa
@testable import Element
@testable import Utils

protocol ElasticSlidableScrollable3:Slidable3,ElasticScrollable3{}
extension ElasticSlidableScrollable3{
    /**
     * PARAM: value represents real contentContainer x/y value, not 0-1 val
     */
    func setProgress(_ value:CGFloat, _ dir:Dir) {
        Swift.print("ElasticSlidableScrollable3.setProgress()")
        (self as Elastic3).setProgress(value,dir)
        let sliderProgress = ElasticUtils.progress(value,contentSize[dir],maskSize[dir])
        Swift.print("sliderProgress: " + "\(sliderProgress)")
        (self as Slidable3).setProgress(sliderProgress,dir)
    }
    func onScrollWheelEnter() {
        showSlider()
    }
    func scrollWheelExitedAndIsStationary() {
        hideSlider()
    }
}

extension SlideView3{
    /*override func scrollWheel(with event: NSEvent) {
     if(event.phase == NSEventPhase.changed){
     if((self as! Elastic3).moverGroup!.isDirectlyManipulating){
     (self as! Elastic3).setProgress((self as! Elastic3).moverGroup!.result)
     }
     }
     }*/
}
