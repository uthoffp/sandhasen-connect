import 'package:flutter/material.dart';
import 'package:sandhasen_connect/resources/strings.dart';
import 'package:sandhasen_connect/view/pages/admin/admin_page.dart';
import 'package:sandhasen_connect/view/widgets/message.dart';

import '../home/fragment_interface.dart';

class AdminFragment extends StatefulWidget implements Fragment{
  const AdminFragment({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AdminFragmentState();

  @override
  Future<void> refresh() async {
    createState();
  }
}

class _AdminFragmentState extends State<AdminFragment> {
  final _passwordController = TextEditingController();
  bool _pwVisible = false;

  void login() {
    if (_passwordController.text == Strings.adminPassword) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const AdminPage()));
    } else {
      Message.show(context, Strings.errorWrongPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          children: [
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.text,
              obscureText: !_pwVisible,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: Strings.hintPw,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                hintText: Strings.hintPw,
                prefixIcon: const Icon(Icons.vpn_key),
                suffixIcon: IconButton(
                  icon: Icon(
                    _pwVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _pwVisible = !_pwVisible;
                    });
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () => login(),
                child: const Text(Strings.login),
              ),
            )
          ],
        ),
      ),
    );
  }
}
