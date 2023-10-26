import UIKit

class CustomTabBar: UITabBar {
    private var shadowLayer: CAShapeLayer?

    override func draw(_ rect: CGRect) {
        addShadow()
        
    }

    private func addShadow() {
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer?.path = UIBezierPath(roundedRect: bounds, cornerRadius: 10.0).cgPath
            shadowLayer?.fillColor = UIColor.white.cgColor

            shadowLayer?.shadowColor = UIColor.gray.cgColor
            shadowLayer?.shadowPath = shadowLayer?.path
            shadowLayer?.shadowOffset = CGSize(width: 0, height: -2)
            shadowLayer?.shadowOpacity = 0.5
            shadowLayer?.shadowRadius = 3

            layer.insertSublayer(shadowLayer!, at: 0)
        }
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 100.0  // Örnek olarak 100 piksel
        return sizeThatFits
    }
}

#Preview{
    NewsTabBarController()
}
