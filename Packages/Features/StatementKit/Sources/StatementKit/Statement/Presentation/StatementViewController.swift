import UIKit
import ComponentsKit

final class StatementViewController: UIViewController {
    // MARK: - Views

    private let filterView = FilterView()

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
            guard let self else { return }
            
            if isLoading {
                self.showSkeletonLoader(in: self.view)
                self.tableView.isHidden = true
            } else {
                self.refreshControl.endRefreshing()
                self.tableView.isHidden = false
                self.hideSkeletonLoader()
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
        view.addSubview(filterView)
        view.addSubview(tableView)
    }

    private func setupViewConstraints() {
        NSLayoutConstraint.activate([
            filterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filterView.heightAnchor.constraint(equalToConstant: 50),

            tableView.topAnchor.constraint(equalTo: filterView.bottomAnchor),
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

// MARK: - FilterViewDelegate

extension StatementViewController: FilterViewDelegate {
    func filterView(didSelectFilter filter: FilterType) {
        viewModel.didSelectFilter(filter: filter)
    }
}
