import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sandhasen_connect/resources/strings.dart';
import 'package:sandhasen_connect/view/pages/admin_page.dart';
import 'package:sandhasen_connect/view/pages/main_page.dart';
import 'package:sandhasen_connect/view/widgets/message.dart';

class AdminFragment extends StatefulWidget {
  const AdminFragment({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AdminFragmentState();
}

class _AdminFragmentState extends State<AdminFragment> {
  final _passwordController = TextEditingController();
  bool _pwVisible = false;
  final String adminPw = "Montag123";

  void login() {
    if (_passwordController.text == adminPw) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const AdminPage()));
    } else {
      Message.show(context, "Password falsch.");
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
                child: const Text('Anmelden'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
