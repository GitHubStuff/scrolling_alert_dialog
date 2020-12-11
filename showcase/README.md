# Example to showcase `scrolling_alert_dialog`

Flexible Alert dialog - Scrollable content, multiple buttons...

## Purpose

To simplify presenting `showDialog` with `FlatButton` that dismiss the dialog *and* offer a callback to handle each action. It also allows for the `AlertDialog(content:)` to be scrollable where the `Flatbutton` widgets are disabled until the user has scrolled to the bottom of the content. Each dialog is also iOS/Android specific.

## Getting Started

```dart
class ScrollingAlertDialog extends StatefulWidget {
  final Widget header;
  final Widget bodyWidget;
  final ScrollAlertButton dismissButton;
  final List<ScrollAlertButton> buttons;

  const ScrollingAlertDialog({
    @required this.header,
    @required this.bodyWidget,
    @required this.dismissButton,
    this.buttons,
  })  : assert(header != null),
        assert(bodyWidget != null),
        assert(dismissButton != null);

```

- `header` - Widget that used as the `AlertDialog` header.
- `bodyWidget` - Scrollable content that makes up the `AlertDialog` body
- `dismissButton` - A **required** button of `ScrollAlertButton` type that will dismiss the `AlertDialog` and optionally return *callback*
- `buttons` - A `List<ScrollAlertButton>` that appear to the left of the `dismissButton` button, that are optional response actions.

## Example Call

```dart
showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => ScrollingAlertDialog(
       header: Text('HEADER!'),
       bodyWidget: Text(
          string,
          style: TextStyle(fontSize: 26.0),
       ),
       dismissButton: ScrollAlertButton(
          body: Text('Dismiss'),
            onTapCallback: () {
               debugPrint('Dismiss');
            },
              ),
       buttons: null,
    ),
);
```

## Implementation

The **Buttons** that are passed (dismissButton: and buttons:) are of type `ScrollAlertButton`, a custom `FlatButton` that takes provided parameters and wraps them into `Flatbutton child:` and `FlatButton onPressed:`, that also allows the button to dismiss the `AlertDialog`. Each button has a callback to optional information make to the caller, each button will also dismiss the `AlertDialog`

```dart
class ScrollAlertButton implements ScrollAlertButtonWidget {
  ScrollAlertButton({
    @required this.body,
    @required this.onTapCallback,
  })

  @override
    Function onTap() => onTapCallback();

    final Function() onTapCallback;

    @override
    Widget body;

  @override
    Widget makeButton(BuildContext context, bool makeActive) {
      return FlatButton(
          child: body,
          onPressed: !makeActive
              ? null
              : () {
                  Navigator.of(context, rootNavigator: true).pop();
                  onTap();
                });
  }
}
```

## Summary

Be kind to each other
