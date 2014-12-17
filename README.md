FLMAVAssetExportService
=======================

Simple AVAsset exporting!

```objc
[FLMAVAssetExportService service] exportAsset:asset configuration:[FLMAVAssetExportConfiguration configurationForMobile] completion:^(NSURL *temporaryURL, NSError *error) {
	if (error != nil) {
		NSLog(@"There are some error!");
	}

	NSData *data = [NSData dataWithContentsOfURL:temporaryURL];

	NSLog(@"Exported Video Volume: %ld", data.length);
}];
```

Preset Configurations
---

3 kinds of presets are provided.

```objc
// Suitable for poor network.
[FLMAVAssetExportConfiguration configurationForLowQuality];

// Suitable for mobile use.
[FLMAVAssetExportConfiguration configurationForMobile];

// Suitable for tablet use.
[FLMAVAssetExportConfiguration configurationForTablet];
```

Documentation
---

[appledoc](https://dl.dropboxusercontent.com/u/7817937/___doc___FLMAVAssetExportService/html/index.html) is provided.

LICENSE
---

```
The MIT License (MIT)

Copyright (c) 2014 PicApp inc.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
