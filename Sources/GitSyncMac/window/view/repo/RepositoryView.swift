import Foundation
@testable import Element
@testable import Utils

class RepositoryView:Element{
    lazy var contentContainer:Container = {return self.addSubView(Container(self.width,self.height,self,"content"))}()
    
    var leftSideBar:LeftSideBar?
    func createLeftSideBar() -> LeftSideBar {
        return self.contentContainer.addSubView(LeftSideBar(NaN,self.height,self.contentContainer))
    }
    lazy var detailView:RepositoryDetailView = {
        return self.contentContainer.addSubView(RepositoryDetailView(NaN,self.height,self.contentContainer))//self.addSubView(Section(NaN,self.height,self,"right"))
    }()
    override func resolveSkin() {
        var css:String = "RepositoryView{float:left;clear:left;}"
        css += "RepositoryView Container#content{float:left;clear:left;width:100%;}"
        css += "RepositoryView LeftSideBar{fill:blue;width:200px;float:left;clear:none;padding:12px;}"
        css += "RepositoryView LeftSideBar #list{fill:grey;width:100%;float:left;clear:none;}"
        
        StyleManager.addStyle(css)
        super.resolveSkin()
        _ = contentContainer
        leftSideBar = createLeftSideBar()
        _ = detailView
        Swift.print("⚠️️ height: " + "\(height)")
    }
    override func setSize(_ width: CGFloat, _ height: CGFloat) {
        super.setSize(width, height)
        Swift.print("RepositoryView.setSize(\(width), \(height))")
        Swift.print("detailView.getWidth(): " + "\(detailView.getWidth())")
        //update the skin of columns 🏀
        if let leftSideBar = leftSideBar {leftSideBar.setSize(leftSideBar.getWidth(), height)}
        detailView.setSize(detailView.getWidth(), getHeight())
    }
    /**
     *
     */
    func toggleSideBar(_ hide:Bool){
        Swift.print("toggleSideBar: hide: " + "\(hide)")
        //remove leftSideBar
        if hide {
            if let leftSideBar = leftSideBar {
                leftSideBar.removeFromSuperview()
            }
        }else{
            if leftSideBar == nil{
                self.leftSideBar = createLeftSideBar()
            }
        }
        /*detailView.setSkinState(detailView.getSkinState())*/
        ElementModifier.float(detailView)
        self.setSize(getWidth(),getHeight())
    }
}
class LeftSideBar:Element{
    lazy var list:Element = {
        return self.addSubView(Element(NaN,self.height,self,"list"))
    }()
    override func resolveSkin() {
        super.resolveSkin()
        _ = list
    }
}
