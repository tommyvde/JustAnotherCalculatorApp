import 'package:flutter/material.dart';
import 'main.dart';


/// creates a fixed grid of OutlinedButtons
///
/// will call the [_onPressCallBack] function on Press
/// for now only the Padding and Spacing can be changed in one variable
/// TODO: make this Grid creation more dynamic
class ButtonsGrid extends StatelessWidget {

  final int _crossAxisCount;
  final double _buttonPaddingSpacing;
  final int _itemCount;
  final Function? _onPressCallBack;
  final List<String> _buttons;

  const ButtonsGrid({
    super.key,
    required int crossAxisCount,
    required itemCount,
    required List<String> buttonTextList,
    Function? onPressCallBack,
    double buttonPaddingSpacing = 0,
  })  : _crossAxisCount = crossAxisCount,
        _buttonPaddingSpacing = buttonPaddingSpacing,
        _itemCount = itemCount,
        _onPressCallBack = onPressCallBack,
        _buttons = buttonTextList;

  @override
  Widget build(BuildContext context) {
    List<Row> rows = [];

    return Padding(
        padding: EdgeInsets.all(_buttonPaddingSpacing),
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          int width = constraints.maxWidth.floor();

          // generates a Grid of buttons
          for (int mainAxisIndex = 0;
              mainAxisIndex < _itemCount / _crossAxisCount;
              mainAxisIndex++) {
            List<Padding> rowOfButtons = [];

            // generates one row of buttons with crossAxisCount as element count
            for (int crossAxisIndex = 0;
                crossAxisIndex < _crossAxisCount;
                crossAxisIndex++) {
              int index = 4 * mainAxisIndex + crossAxisIndex;

              rowOfButtons.add(Padding(
                  padding: EdgeInsets.fromLTRB(_buttonPaddingSpacing, 0,
                      _buttonPaddingSpacing, _buttonPaddingSpacing),
                  child: Container(
                      constraints: BoxConstraints(
                          minWidth: width / _crossAxisCount -
                              2 * _buttonPaddingSpacing,
                          minHeight: width / _crossAxisCount -
                              2 * _buttonPaddingSpacing),
                      child: OutlinedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll<Color>(themeColor),
                            shape: MaterialStatePropertyAll<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                          ),
                          onPressed: () {
                            _onPressCallBack?.call(_buttons[index]);
                          },
                          child: Text(_buttons[index],
                              style:
                                  const TextStyle(color: Colors.black54))))));
            }

            rows.add(Row(children: rowOfButtons));
          }
          return Column(children: rows);
        }));
  }
}
