import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/storage/user_mode.dart';
import 'package:tapiten_app/ui/profile_edit/profile_edit_view_model.dart';

class ProfileName extends StatefulWidget {
  @override
  _ProfileNameState createState() => _ProfileNameState();
}

class _ProfileNameState extends State<ProfileName> {
  String userName = '';

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<ProfileEditViewModel>(context);
    if (UserMode.isGod) {
      userName = (viewModel.godName != null) ? viewModel.godName : '';
    } else {
      userName = (viewModel.sheepName != null) ? viewModel.sheepName : '';
    }

    return Container(
      padding: EdgeInsets.only(bottom: 25),
      child: Center(
        child: Text(
          userName,
          style: TextStyle(
            color: Color(0xFF909090),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
