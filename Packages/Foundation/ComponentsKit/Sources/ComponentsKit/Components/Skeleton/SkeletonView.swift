import UIKit

final class SkeletonView: UIView {
    // MARK: - Views
    
    private let gradientLayer = CAGradientLayer()

    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupGradientLayer()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    // MARK: - Methods

    private func setupView() {
        backgroundColor = Color.gray3
        layer.cornerRadius = Border.CornerRadius.xs
        layer.masksToBounds = true
    }

    private func setupGradientLayer() {
        gradientLayer.colors = [
            UIColor(white: 0.85, alpha: 1).cgColor,
            UIColor(white: 0.95, alpha: 1).cgColor,
            UIColor(white: 0.85, alpha: 1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = bounds
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.cornerRadius = Border.CornerRadius.xs
        layer.addSublayer(gradientLayer)
        startShimmerAnimation()
    }

    private func startShimmerAnimation() {
        let shimmerAnimation = CABasicAnimation(keyPath: "locations")
        shimmerAnimation.fromValue = [0, 0.5, 1]
        shimmerAnimation.toValue = [1, 1.5, 2]
        shimmerAnimation.duration = 1.5
        shimmerAnimation.repeatCount = .infinity
        gradientLayer.add(shimmerAnimation, forKey: "shimmerAnimation")
    }
}
