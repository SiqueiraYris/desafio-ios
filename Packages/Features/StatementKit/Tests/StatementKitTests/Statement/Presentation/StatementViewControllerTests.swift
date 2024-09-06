import XCTest
import ComponentsKit
@testable import StatementKit

final class StatementViewControllerTests: XCTestCase {
    // MARK: - Tests

    func test_init_shouldInitializeComponentsCorrectly() {
        let (sut, _) = makeSUT()
        let mirror = makeMirror(viewController: sut)

        XCTAssertFalse(mirror.filterView!.translatesAutoresizingMaskIntoConstraints)

        XCTAssertFalse(mirror.tableView!.translatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(mirror.tableView?.backgroundColor, Color.white)

        XCTAssertEqual(mirror.refreshControl?.tintColor, Color.primaryMain)
    }

    func test_viewDidLoad_shouldTriggerViewModelFetch() {
        let (sut, viewModelSpy) = makeSUT()

        _ = sut.view

        XCTAssertEqual(viewModelSpy.receivedMessages, [.fetch])
    }

    func test_viewWillAppear_shouldSetupNavigationBarAndRightButton() {
        let (sut, _) = makeSUT()
        
        sut.viewWillAppear(false)

        XCTAssertEqual(sut.title, Strings.statementNavigationTitle)
    }

    func test_bindings_shouldHandleLoadingStateCorrectly() {
        let (sut, viewModelSpy) = makeSUT()
        let mirror = makeMirror(viewController: sut)

        viewModelSpy.isLoading.value = true
        XCTAssertTrue(mirror.tableView!.isHidden)

        viewModelSpy.isLoading.value = false
        XCTAssertFalse(mirror.tableView!.isHidden)
        XCTAssertFalse(mirror.refreshControl!.isRefreshing)
    }

    func test_didSelectRowAt_shouldTriggerViewModelDidSelectRow() {
        let dummyTableView = makeUITableView()
        let indexPath = IndexPath(row: 0, section: 0)
        let (sut, viewModelSpy) = makeSUT()

        sut.tableView(dummyTableView, didSelectRowAt: indexPath)

        XCTAssertEqual(viewModelSpy.receivedMessages, [.fetch,
                                                       .didSelectRowAt(indexPath: indexPath)])
    }

    func test_numberOfRowsInSection_shouldTriggerViewModelCorrectly() {
        let dummyTableView = makeUITableView()
        let expectedNumberOfRows = 3
        let (sut, viewModelSpy) = makeSUT()

        viewModelSpy.numberOfRowsToBeReturned = expectedNumberOfRows
        let numberOfRowsInSection = sut.tableView(dummyTableView, numberOfRowsInSection: 0)

        XCTAssertEqual(viewModelSpy.receivedMessages, [.fetch,
                                                       .numberOfRowsInSection(section: 0)])
        XCTAssertEqual(numberOfRowsInSection, expectedNumberOfRows)
    }

    func test_cellForRowAt_shouldTriggerViewModelCorrectly() {
        let dummyTableView = makeUITableView()
        let indexPath = IndexPath(row: 0, section: 0)
        let (sut, viewModelSpy) = makeSUT()

        viewModelSpy.rowToBeReturned = StatementViewObject.Row(
            id: "any-id", 
            type: "any-type",
            icon: nil,
            title: nil,
            subtitle: nil,
            subtitleColor: nil,
            description: "Test Description",
            time: "any-time"
        )
        let cell = sut.tableView(dummyTableView, cellForRowAt: indexPath)

        XCTAssertEqual(viewModelSpy.receivedMessages, [.fetch,
                                                       .cellForRowAt(indexPath: indexPath)])
        XCTAssertTrue(cell is TransactionCell)
    }

    func test_viewForHeaderInSection_shouldTriggerViewModelGetSectionTitle() {
        let dummyTableView = makeUITableView()
        let section = 0
        let (sut, viewModelSpy) = makeSUT()

        viewModelSpy.sectionTitleToBeReturned = "Test Section"
        _ = sut.tableView(dummyTableView, viewForHeaderInSection: section)

        XCTAssertEqual(viewModelSpy.receivedMessages, [.fetch,
                                                       .getSectionTitle(section: section)])
    }

    func test_didSelectFilter_shouldTriggerViewModelDidSelectFilter() {
        let filter = FilterType.all
        let (sut, viewModelSpy) = makeSUT()

        sut.filterView(didSelectFilter: filter)

        XCTAssertEqual(viewModelSpy.receivedMessages, [.fetch, .didSelectFilter(filter: filter)])
    }

    // MARK: - Helpers

    private func makeSUT() -> (
        sut: StatementViewController,
        viewModelSpy: StatementViewModelSpy
    ) {
        let viewModelSpy = StatementViewModelSpy()
        let sut = StatementViewController(with: viewModelSpy)

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(viewModelSpy)

        return (sut, viewModelSpy)
    }

    private func makeMirror(viewController: StatementViewController) -> StatementViewControllerMirror {
        return StatementViewControllerMirror(viewController: viewController)
    }

    private func makeUITableView() -> UITableView {
        let dummyTableView = UITableView()
        dummyTableView.register(TransactionCell.self, forCellReuseIdentifier: TransactionCell.reuseIdentifier)
        return dummyTableView
    }
}
