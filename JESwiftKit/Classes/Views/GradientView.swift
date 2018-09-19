import UIKit

@IBDesignable
open class GradientView: UIView {
    
    public enum Orientation: String {
        case horizontal, vertical, diagonalLeft, diagonalRight
    }
    
    @IBInspectable public dynamic var orientation: String = "diagonalLeft"
    @IBInspectable public dynamic var color1: UIColor?
    @IBInspectable public dynamic var color2: UIColor?
    
    private var orientationEnum: Orientation { return Orientation(rawValue: self.orientation) ?? .horizontal }
    private var colors: [UIColor] { return color1.flatMap { (col1) in color2.map { (col2) in return [col1, col2] }} ?? []}

    override open func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        context.clear(bounds)
        context.addRect(bounds)
        
        let start: CGPoint
        let end: CGPoint
        
        switch orientationEnum {
        case .horizontal:
            start = CGPoint(x: 0, y: bounds.midY)
            end = CGPoint(x: bounds.maxX, y: bounds.midY)
        case .vertical:
            start = CGPoint(x: bounds.midX, y: 0)
            end = CGPoint(x: bounds.midX, y: bounds.maxY)
        case .diagonalLeft:
            start = CGPoint(x: bounds.minX, y: 0)
            end = CGPoint(x: bounds.maxX, y: bounds.maxY)
        case .diagonalRight:
            start = CGPoint(x: bounds.maxX, y: 0)
            end = CGPoint(x: bounds.minX, y: bounds.maxY)
        }
        
        var colorArray: [CGFloat] = []
        
        for color in self.colors {
            var red: CGFloat = 0.0
            var green: CGFloat = 0.0
            var blue: CGFloat = 0.0
            var alpha: CGFloat = 0.0
            
            color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            colorArray += [red, green, blue, alpha]
        }
        
        if let gradient = CGGradient(colorSpace: CGColorSpaceCreateDeviceRGB(), colorComponents: colorArray, locations: [0.0, 1.0], count: self.colors.count) {
            context.drawLinearGradient(gradient, start: start, end: end, options: [])
        }
    }
}
