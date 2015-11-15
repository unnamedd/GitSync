import Cocoa


//Continue here, add GradientDecorator , CircleDecorator, DropShadowDecorator, others?
//then think throguh how you want to name things. 
//then move code into Element

//I think its cool that it worked, but is it performant? I mean what about setting up all the decorations 
//and then calling an initialize method that would run trhough all the different calls and make the graphic one time, not many like now
//this way you can also limit the extending of NSView to only Skin and Element

//Try to optimize the process a bit
//implmiment the Gradient to see it work


class WinViewTest:FlippedView {
    override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    override func drawRect(dirtyRect: NSRect) {
        let skinLayer:SkinLayer = SkinLayer()
        addSubview(skinLayer)
    }
}
class SkinLayer:Graphic{//container class that hold the decorator structure.
    override func drawRect(dirtyRect: NSRect) {
        Swift.print("SkinLayer.drawRect() ")
        //create the structure here
        var grapix:IGrapixDecorator = Grapix()
        grapix = RectGrapix(grapix)
        grapix = RoundRectGrapix(grapix)
        grapix = GradientGrapix(grapix)
        grapix.initialize()//runs trough all the different calls and makes the graphic in one go.
    }
}
protocol IGrapixDecorator{
    func getGrapix() -> Grapix
    func fill()
    func beginFill()
    func drawFill()
    func stylizeFill()
    func initialize()
}
class GrapixDecorator:AbstractGrapixDecorator{
    var decoratable:IGrapixDecorator
    init(_ decoratable:IGrapixDecorator){
        self.decoratable = decoratable
    }
    override func initialize(){
        fill()
    }
    override func fill(){
        beginFill()
        drawFill()
        stylizeFill()
    }
    override func beginFill(){
        decoratable.beginFill()
    }
    override func drawFill(){
        decoratable.drawFill()
    }
    override func stylizeFill(){
        decoratable.stylizeFill()
    }
    override func getGrapix() -> Grapix{
        return self.decoratable.getGrapix()
    }
}
class AbstractGrapixDecorator:IGrapixDecorator{
    func initialize(){
    }
    func fill(){
    }
    func beginFill(){
    }
    func drawFill(){
    }
    func stylizeFill(){
    }
    func getGrapix() -> Grapix{
        fatalError("Must be overridden in subClass")
    }
}
//TODO: make an abstractDecorator that holds all the decorator methods

class Grapix:AbstractGrapixDecorator{//base class for decorators
    lazy var graphics:Graphics = Graphics()
    var path:CGPath = CGPathCreateMutable()
    
    override func beginFill(){
        GraphicModifier.applyProperties(getGrapix().graphics, FillStyle(NSColor.purpleColor())/*, lineStyle*/)//apply style
    }
    override func stylizeFill(){
        GraphicModifier.stylize(getGrapix().path,getGrapix().graphics)//realize style on the graphic
    }
    override func getGrapix()->Grapix{
        return self
    }
}
class RectGrapix:GrapixDecorator{//adds rectangular path
    override init(_ decoratable: IGrapixDecorator) {
        super.init(decoratable)
    }
    override func drawFill() {
        getGrapix().path = CGPathParser.rect(CGFloat(100), CGFloat(100))//Shapes
    }
}
class RoundRectGrapix:GrapixDecorator{//adds round-rectangular path
    override init(_ decoratable: IGrapixDecorator) {
        super.init(decoratable)
    }
    override func drawFill() {
        let fillet:Fillet = Fillet(20)
        getGrapix().path = CGPathParser.roundRect(0,0,CGFloat(200), CGFloat(200),CGFloat(fillet.topLeft), CGFloat(fillet.topRight), CGFloat(fillet.bottomLeft), CGFloat(fillet.bottomRight))//Shapes
        //getGrapix().path = CGPathParser.rect(CGFloat(150), CGFloat(50))//Shapes
    }
}
class GradientGrapix:GrapixDecorator{//adds Gradient fill
    override init(_ decoratable: IGrapixDecorator) {
        super.init(decoratable)
    }
    override func beginFill() {
        let randomColor:NSColor = NSColor.orangeColor()//ColorUtils.randomColor()
        GraphicModifier.applyProperties(getGrapix().graphics, FillStyle(randomColor)/*, lineStyle*/)//apply style
    }
}