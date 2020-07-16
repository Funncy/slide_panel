# slide_panel
---

This is a slide panel that can be dragged from side to side.

![이미지](https://Funncy.github.io/assets/img/custom_drawer/2020-07-15-SLIDE_PANEL.gif "SLIDE PANEL")


## Features
---
+ Slide ends when main body is clicked.
+ Enable/Disable left-right slide panel


## Usage
---

```dart
 @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Slide Panel"),
        ),
        body: SlidePanel(
          slideHandlerWidth: 10, 
          slidePanelHeight: 300,
          slidePanelWidth: 280,
          slideOffBodyTap: true, // If set to true, can close slide panel when tap the body widget.
          leftPanelVisible: true, // If set to false, it is not visible.
          rightPanelVisible: true, // If set to false, it is not visible.
          appbarIsExist: true, //default ture
          body: BodyConatiner() // User widget,
          leftSlide: LeftSlideConatiner() // User widget,
          rightSlide: RightSlideContainer() // User widget,
        ),
    );
  }
```
