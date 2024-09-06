import UIKit
import ComponentsKit

final class StatementViewController: UIViewController {
    // MARK: - Views

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(TransactionCell.self, forCellReuseIdentifier: TransactionCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = Color.primaryMain
        return refreshControl
    }()

    // MARK: - Properties

    private let viewModel: StatementViewModelProtocol
    private var skeletonStackView: UIStackView?
    // MARK: - Initializer

    init(with viewModel: StatementViewModelProtocol) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupNavigationBar()
        setupRightButton()
    }

    // MARK: - Methods

    private func setup() {
        setupBindings()
        setupViewStyle()
        viewModel.fetch()
    }

    private func setupBindings() {
        viewModel.isLoading.bind { [weak self] isLoading in
            isLoading ? self?.showLoader2() : self?.hideLoader()

            if !isLoading {
                self?.refreshControl.endRefreshing()
            }
        }

        viewModel.shouldReloadData.bind { [weak self] isLoading in
            self?.tableView.reloadData()
        }
    }

    private func setupViewStyle() {
        view.backgroundColor = Color.white
        title = Strings.statementNavigationTitle

        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)

        setupViewHierarchy()
        setupViewConstraints()
    }

    private func setupViewHierarchy() {
        view.addSubview(tableView)
    }

    private func setupViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupRightButton() {
        let buttonItem = UIBarButtonItem(
            image: Images.share,
            style: .plain,
            target: self,
            action: #selector(didTapShareButton)
        )
        buttonItem.tintColor = Color.primaryMain

        navigationItem.rightBarButtonItem = buttonItem
    }

    // MARK: - Actions

    @objc private func didPullToRefresh() {
        viewModel.fetch()
    }

    @objc private func didTapShareButton() {
//        viewModel.openFavorites()
    }
}

// MARK: - UITableViewDataSource

extension StatementViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TransactionCell.reuseIdentifier,
            for: indexPath
        ) as? TransactionCell else {
            return UITableViewCell()
        }

        if let viewObject = viewModel.cellForRowAt(indexPath: indexPath) {
            cell.setupViewObject(viewObject: viewObject)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(section: section)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
}

// MARK: - UITableViewDelegate

extension StatementViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath: indexPath)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = TransactionHeaderView()
        header.setupViewObject(title: viewModel.getSectionTitle(section: section))
        return header
    }
}

extension StatementViewController {


    private func showLoader2() {
        let numberOfSkeletons = 10 // Número de skeletons que você quer mostrar
        var skeletonViews = [SkeletonView]()

        for _ in 0..<numberOfSkeletons {
            let skeletonView = SkeletonView()
            skeletonView.translatesAutoresizingMaskIntoConstraints = false
            skeletonView.heightAnchor.constraint(equalToConstant: 60).isActive = true // Define uma altura fixa
            skeletonViews.append(skeletonView)
        }

        let stackView = UIStackView(arrangedSubviews: skeletonViews)
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear

        view.addSubview(stackView)
        skeletonStackView = stackView // Guardar referência para remoção posterior

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        print("Loader is showing")
    }

    private func hideLoader2() {
        print("Loader is hiding")
        skeletonStackView?.removeFromSuperview()
        skeletonStackView = nil
    }
}



import UIKit

final class SkeletonView: UIView {
    private let gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
