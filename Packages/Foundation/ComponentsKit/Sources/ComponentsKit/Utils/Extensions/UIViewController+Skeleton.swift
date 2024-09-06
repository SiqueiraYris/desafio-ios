import UIKit

public extension UIViewController {
    struct SkeletonViewConstants {
        public static let largeHeight: CGFloat = 38
        public static let smallHeight: CGFloat = 16
        public static let spacing: CGFloat = 16
        public static let pairPadding: CGFloat = 12
        public static let numberOfPairs = 5
    }

    private struct AssociatedKeys {
        static var skeletonStackView = UnsafeRawPointer(bitPattern: "skeletonStackView".hashValue)
    }

    func showSkeletonLoader(in parentView: UIView, numberOfPairs: Int = SkeletonViewConstants.numberOfPairs) {
        var skeletonViews = [UIView]()
        for i in 0..<numberOfPairs {
            let largeSkeletonView = SkeletonView()
            largeSkeletonView.translatesAutoresizingMaskIntoConstraints = false
            largeSkeletonView.heightAnchor.constraint(equalToConstant: SkeletonViewConstants.largeHeight).isActive = true
            skeletonViews.append(largeSkeletonView)

            let smallSkeletonView = SkeletonView()
            smallSkeletonView.translatesAutoresizingMaskIntoConstraints = false
            smallSkeletonView.heightAnchor.constraint(equalToConstant: SkeletonViewConstants.smallHeight).isActive = true
            skeletonViews.append(smallSkeletonView)

            if i < numberOfPairs - 1 {
                let paddingView = UIView()
                paddingView.translatesAutoresizingMaskIntoConstraints = false
                paddingView.heightAnchor.constraint(equalToConstant: SkeletonViewConstants.pairPadding).isActive = true
                skeletonViews.append(paddingView)
            }
        }

        let stackView = UIStackView(arrangedSubviews: skeletonViews)
        stackView.axis = .vertical
        stackView.spacing = SkeletonViewConstants.spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear

        parentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor, constant: SkeletonViewConstants.spacing),
            stackView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: SkeletonViewConstants.spacing),
            stackView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -SkeletonViewConstants.spacing)
        ])

        if let skeletonStackView = AssociatedKeys.skeletonStackView {
            objc_setAssociatedObject(self, skeletonStackView, stackView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func hideSkeletonLoader() {
        guard let skeletonStackView = AssociatedKeys.skeletonStackView else { return }
        if let stackView = objc_getAssociatedObject(self, skeletonStackView) as? UIStackView {
            stackView.removeFromSuperview()
            objc_setAssociatedObject(self, skeletonStackView, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
