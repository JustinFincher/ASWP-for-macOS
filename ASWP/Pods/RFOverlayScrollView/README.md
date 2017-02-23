# RFOverlayScrollView

RFOverlayScrollView is an NSScrollView subclass that shows its NSScroller in iOS style even when a mouse is attached.

![Screenshot](http://f.cl.ly/items/3N1z3g34280W0b0D2t3z/Bildschirmfoto%202012-12-31%20um%2017.15.51.png)

It does little changes to the NSScroller itself to make sure default behaviors like

- dragging too far
- scroller gets darker when the mouse is over the scroller
- scroller gets wider when scrolling with the trackpad and the mouse is over the scroller

stay as intended.

## Installation

### CocoaPods (Recommended)

You know how to use CocoaPods, right?

### Manual

- Drag the `RFOverlayScrollView/RFOverlayScrollView` folder into your project

## Usage

### Interface Builder

- Change the class of your scroll view to `RFOverlayScrollView`

![RFOverlayScrollView Screenshot](http://f.cl.ly/items/0E1V461L1d1V3U0i2y0s/Bildschirmfoto%202012-12-31%20um%2017.21.41.png)

- Change the class of the vertical slider to `RFOverlayScroller`

![RFOlverScroller Screenshot](http://f.cl.ly/items/2G3S2n2b3B1W1r151Z40/Bildschirmfoto%202012-12-31%20um%2017.21.13.png)


## Limitations

Currently, only vertical sliders are supported.

## Credits

RFOverlayScrollView is brought to you by [Rheinfabrik](http://rheinfabrik.de).