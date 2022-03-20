import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State createState() => _MyHomePageState();
}

class _MyHomePageState extends State with MyDirty {
  double contentWidth  = 0.0;
  double contentHeight = 0.0;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();

  // チェックボックス
  bool _checkboxValue = false;
  void _onCheckboxChanged(bool? value) {
    setState(() {
      _checkboxValue = value!;
    });
  }

  // スイッチ
  bool _switchValue = false;
  void _onSwitchChanged(bool value) {
    setState(() {
      _switchValue = value;
    });
  }

  // ラジオボタン
  int _radioValue = 0;
  void _onRadioChanged(int? value) {
    setState(() {
      _radioValue = value!;
    });
  }

  // ドロップダウンメニュー
  final Map<String, String> _dropdownMenu = {
    '0': 'メニュー1',
    '1': 'メニュー2',
    '2': 'メニュー3',
  };
  String? _dropdownValue;
  void _onDropdownChanged(value) {
    setState(() {
      _dropdownValue = value;
    });
  }

  // 編集されているかどうかのフラグ
  bool _isDirty = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        _controller1.text = 'あいうえお';
        _controller2.text = '';
        _controller3.text = '';
        _checkboxValue = false;
        _switchValue = false;
        _radioValue = 0;
        _dropdownValue = null; // 選択が必須の場合、初期値をnullに
      });

      clearDirty(); // 現在の値を編集前の値とする
      _isDirty = false;
    });
  }

  // 現在の値を取得する
  @override
  List<dynamic> getValues(List<dynamic> values) {
    values.add(_controller1.text);
    values.add(_controller2.text);
    values.add(_controller3.text);
    values.add(_checkboxValue);
    values.add(_switchValue);
    values.add(_radioValue);
    values.add(_dropdownValue);
    return values;
  }

  @override
  Widget build(BuildContext context) {
    contentWidth  = MediaQuery.of( context ).size.width;
    contentHeight = MediaQuery.of( context ).size.height - MediaQuery.of( context ).padding.top - MediaQuery.of( context ).padding.bottom;

    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 0
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _controller1,
                    decoration: const InputDecoration(
                      hintText: '入力は必須です',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return '入力は必須です';
                      }
                      return null;
                    },
                  ),
                  Container( height: 5 ),
                  TextFormField(
                    controller: _controller2,
                    decoration: const InputDecoration(
                      hintText: '入力は必須です',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return '入力は必須です';
                      }
                      return null;
                    },
                  ),
                  Container( height: 5 ),
                  TextFormField(
                    controller: _controller3,
                    decoration: const InputDecoration(
                      hintText: '入力は任意です（半角英数字のみ）',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      if (value != null && value.isNotEmpty && !RegExp('^[a-zA-Z0-9]+\$').hasMatch(value)) {
                        return '入力は半角英数字のみです';
                      }
                      return null;
                    },
                  ),
                  Container( height: 5 ),
                  CheckboxListTile(
                      title: const Text('チェックボックス'),
                      value: _checkboxValue,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: _onCheckboxChanged
                  ),
                  Container( height: 5 ),
                  SwitchListTile(
                      title: const Text('スイッチ'),
                      value: _switchValue,
                      controlAffinity: ListTileControlAffinity.trailing,
                      onChanged: _onSwitchChanged
                  ),
                  Container( height: 5 ),
                  Row(children: [
                    Container(width: contentWidth / 3, height: 64, alignment: Alignment.center,
                      child: RadioListTile(
                          title: Row(children: [ SizedBox(
                              width: 32,
                              height: 32,
                              child: Image.asset('assets/icon1.png', fit: BoxFit.fill)
                          ) ] ),
                          value: 0,
                          groupValue: _radioValue,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: _onRadioChanged
                      ),
                    ),
                    Container(width: contentWidth / 3, height: 64, alignment: Alignment.center,
                      child: RadioListTile(
                          title: Row(children: [ SizedBox(
                              width: 32,
                              height: 32,
                              child: Image.asset('assets/icon4.png', fit: BoxFit.fill)
                          ) ] ),
                          value: 1,
                          groupValue: _radioValue,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: _onRadioChanged
                      ),
                    ),
                    Container(width: contentWidth / 3, height: 64, alignment: Alignment.center,
                      child: RadioListTile(
                          title: Row(children: [ SizedBox(
                              width: 32,
                              height: 32,
                              child: Image.asset('assets/icon5.png', fit: BoxFit.fill)
                          ) ] ),
                          value: 2,
                          groupValue: _radioValue,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: _onRadioChanged
                      ),
                    ),
                  ] ),
                  Container( height: 5 ),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      hintText: '選択は必須です',
                    ),
                    items: _dropdownMenu.entries.map((entry) {
                      return DropdownMenuItem(
                        child: Text(entry.value),
                        value: entry.key,
                      );
                    }).toList(),
                    value: _dropdownValue,
                    onChanged: _onDropdownChanged,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return '選択は必須です';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            Container( height: 5 ),
            Row( children: [
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    clearDirty(); // 現在の値を編集前の値とする
                    setState(() {
                      _isDirty = false;
                    });
                  }
                },
                child: const Text('決定'),
              ),
              Container( width: 10 ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isDirty = isDirty();
                  });
                },
                child: const Text('編集チェック'),
              ),
            ] ),
            Container( height: 5 ),
            Text(
              _isDirty ? '編集されています！' : '編集されていません',
              style: TextStyle(
                  color: _isDirty ? Colors.red : Colors.grey
              ),
            ),
          ],
        ),
      ),
    );
  }
}

abstract class MyDirty {
  List<dynamic>? _initValues; // 編集前の値

  // 現在の値を取得する
  List<dynamic> getValues(List<dynamic> values);

  // 現在の値を編集前の値とする
  void clearDirty() {
    _initValues = getValues([]);
  }

  // 編集されているかチェックする
  bool isDirty() {
    return !listEquals(_initValues, getValues([]));
  }
}
