Deep Drop Upload
==========

[Example](http://labs.astrobunny.net/cappdemos/deepdrop/)
[Example Sources](https://github.com/davidsiaw/deepdrop-example)

These classes allow you to turn any CPView in a [Cappuccino](http://github.com/cappuccino/cappuccino) app into a file upload drop zone.  It supports multiple files dropped at once.  It works in Safari and Chrome.  Firefox support is possible, but hasn't been added.

The most useful classes are:

* DCFileDropController.j
* DCFileUploadManager.j
* DCFileUpload.j


## Usage

Import these classes:

```objectivej
@import <DeepDrop/DCFileDropController.j>
@import <DeepDrop/DCFileUploadManager.j>
```

Create an upload manager:

```objectivej
var uploadManager = [[DCFileUploadManager alloc] init];
```

Apply a DCFileDropController to any CPView:

```objectivej
var fileDropUploadController = [[DCFileDropController alloc] 
	initWithView:anyView 
	dropDelegate:self 
	uploadURL:[CPURL URLWithString:@"upload.php"] 
	uploadManager:uploadManager];
[fileDropUploadController setEnabled:YES];
```

If you want to change visual state of the view, you can do that with this dropDelegate method:

```objectivej
- (void)fileDropUploadController:(DCFileDropController *)theController setState:(BOOL)visible {
	if (visible) {
		[theController.view setBackgroundColor:[CPColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.2]];
	} else {
		[theController.view setBackgroundColor:[CPColor clearColor]];
	}
}
```

If you want to display progress, you can use the DCFileUploadsView

```objectivej
@import <DeepDrop/DCFileUploadsView.j>

- (void)setupUploadPanel
{
	// This panel will show us the uploads we have made and their status
	var uploadsPanel = [[CPPanel alloc] initWithContentRect:CGRectMake(400.0, 50.0, 250.0, 300.0)
										styleMask: CPClosableWindowMask | CPResizableWindowMask];

	[uploadsPanel setTitle:"Uploads"];

	// We have a very simple upload list that we add to the panel.
	var uploadsPanelContentView = [uploadsPanel contentView];

	uploadTable = [[DCFileUploadsView alloc] initWithFrame:[uploadsPanelContentView bounds]];

	// The upload manager has a list of file uploads that we can use to see
	[uploadTable setUploadList:[uploadManager fileUploads]]

	[[uploadsPanel contentView] addSubview: uploadTable];
	[uploadsPanel orderFront:self];

	// set up this class to receive the events
	[uploadManager setDelegate:self];
}
	
- (void)fileUploadManagerDidChange:(DCFileUploadManager)theManager
{
	[uploadTable reloadData];
}
	
```

And process it with this method:

```objectivej
- (void)fileUploadManagerDidChange:(DCFileUploadManager *)theManager {
	var fileUploads = [theManager fileUploads];
}
```


## Attribution

This technique is based on code from [CSS Ninja](http://www.thecssninja.com/javascript/gmail-upload).

* David Cann
* Alexander Ljungberg


## License

[MIT License](http://www.opensource.org/licenses/mit-license.php)
