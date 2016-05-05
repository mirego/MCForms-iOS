# MCForms-iOS

## About
**MCForms** is an iOS framework, built in Swift, to help create forms!
While there are so many *open-source* libs out there to create forms rapidly, they all have a specific layout (à la UITableView) - which does not always suit our designer's creativity. **MCForms** is different in this way : you can layout the form however you want and manage the views hierarchy yourself as well.

Checkout the *Demo* in the repository.

What makes **MCForms** cool :

* Clean and flexible API
* Does most of the heavy-lifting of creating and managing forms
* Layout and view hierarchy not imposed (*default & helpers provided*)

## Installation

### Carthage
```
github "mirego/MCForms-iOS" "master"
```
### CocoaPods
As the framework is written in swift, you'll have to enable frameworks.
```
use_frameworks!
pod 'MCForms-iOS', :git => 'git@github.com:mirego/MCForms-iOS.git'
```

## Usage

Start with the import
```swift
import MCForms
```

### Creation
As simple as :
```swift
let form = Form()
```
Or with default values
```swift
let form = Form(defaultValues: ["bool1" : true, "choice1" : 1, "bool2" : false])
```

### Setup the form
```swift
form.addRowGroup(withTitle: "First section".uppercaseString) { (group) in
  group.addInputRow(FormBooleanRow(withQuestion: "Enable the matrix") { (formBooleanRow) in
    print(formBooleanRow)
  }, identifier: "bool1")
}
```
The controls will have the default values specified when creating the form.

Each Row type offers a callback that is triggered when the value changes.

Current Row types include :

* FormBooleanRow
* FormMultipleChoiceRow
* FormTextRow

More will be added with time (i.e FormSliderRow, FormDatePickerRow, etc...).

### Views & Layout

To add the controls/labels in the view hierarchy :
```swift
form.setupSuperview(superview: scrollView)
```
This will add each controls and labels as a subview of the specified superview and will also add a tap gesture on it to dismiss the keyboard.

Doing this is optionnal - you can choose to manage the hierarchy yourself.

To layout the controls/labels (in *layoutSubviews* callback) :

```swift
let formSize = form.layoutForm(withBoundingRect: CGSize(width: frame.size.width, height: .max),
                                  contentInsets: UIEdgeInsets(top: 30, left: 10, bottom: 10, right: 10))
        
scrollView.frame = bounds
scrollView.contentSize = formSize
```
If you'd like a custom layout, simply create your own Layouter conforming to the *FormLayouter* protocol and set it to the *layouter* property of the Form object before calling this *layoutForm* method.

### Customize the UI

All controls and labels are customizable via the UIAppearance proxy mechanism. For this purpose, the framework uses custom subclasses of each UIKit classes instead of using them directly.

```swift
FormRowQuestionLabel.appearance()._textColor = UIColor.darkGrayColor()
```
See the *FormStylesheet* class (Stylesheet.swift) for more examples.

### Collect the data whenever
```swift
let allValues = form.currentValues()
```
You'll have a dictionary of the control values with their *identifiers* as keys.
You can add a "Save" button at the bottom of the form if you'd like.

## Who is using this ?
This lib was built in anticipation of future projects needing the same form engine. Time will tell if it was usabled.

* Sépaq (https://github.com/mirego/sepaq-inspections-ios)

## Contributions
Pull-requests are welcome !
