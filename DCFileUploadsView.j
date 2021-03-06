@import <AppKit/CPPanel.j>
@import "DCFileUploadManager.j"
@import "DCFileUploadsRowView.j"

@implementation DCFileUploadsView : CPView {
	CPArray uploadList @accessors;
	CPTableView tableView;
}

- (id)initWithFrame:(CGRect)theFrame {

	self = [super initWithFrame:theFrame];

	if (self) {
		var bounds = [self bounds];
		bounds.size.height -= 20.0;

		// create the table view
		tableView = [[CPTableView alloc] initWithFrame:bounds];
		[tableView setDataSource:self];
		[tableView setDelegate:self];

		var dataRowView = [[DCFileUploadsRowView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];

		var column = [[CPTableColumn alloc] initWithIdentifier:"uploads"];
		[[column headerView] setStringValue:"Uploads"];
		[column setWidth:220.0];
		[column setMinWidth:50.0];
		[column setEditable:NO];
		[column setDataView:dataRowView];

		[tableView addTableColumn:column];
		[tableView setColumnAutoresizingStyle:CPTableViewLastColumnOnlyAutoresizingStyle];
		[tableView setRowHeight:46.0];
		[tableView setSelectionHighlightStyle:CPTableViewSelectionHighlightStyleNone];
		[[tableView headerView] setFrame:CGRectMake(0, 0, [[tableView headerView] frame].size.width, 0)];
		[[tableView cornerView] setFrame:CGRectMake(0, 0, [[tableView cornerView] frame].size.width, 0)];

		var scrollView = [[CPScrollView alloc] initWithFrame:bounds];
		[scrollView setDocumentView:tableView];
		[scrollView setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];
		[scrollView setAutohidesScrollers:YES];
		[self addSubview:scrollView];

		[[scrollView verticalScroller] setTheme:[CPTheme themeNamed:@"Aristo-HUD"]];
		[[scrollView horizontalScroller] setTheme:[CPTheme themeNamed:@"Aristo-HUD"]];
		[tableView setBackgroundColor:[CPColor clearColor]];
		[scrollView setBackgroundColor:[CPColor clearColor]];

	}
	return self;
}

- (void)reloadData
{
	[tableView reloadData];
}

// ******************** CPTableView Delegate *********************

- (void)tableViewSelectionDidChange:(CPNotification)aNotification {
	var selectedRow = [tableView selectedRow];
}

- (id)tableView:(CPTableView)aTableView objectValueForTableColumn:(int)aColumn row:(int)aRow {
	return [uploadList objectAtIndex:aRow];
}

- (int)numberOfRowsInTableView:(CPTableView)aTableView {
	return [uploadList count];
}


@end
