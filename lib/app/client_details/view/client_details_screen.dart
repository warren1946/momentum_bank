import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:momentum_bank/app/client_details/model/client_details_response.dart';
import 'package:momentum_bank/app/client_details/view_model/client_details_view_model.dart';
import 'package:momentum_bank/app/utils/app_alert_dialog.dart';
import 'package:ndialog/ndialog.dart';

class ClientDetailsScreen extends StatefulWidget {
  @override
  _ClientDetailsScreen createState() => _ClientDetailsScreen();
}

class _ClientDetailsScreen extends State<ClientDetailsScreen> {
  ClientDetailsResponse _clientDetailsResponse;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _accountNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<ClientDetailsResponse> loadData() async {
    _clientDetailsResponse = await ClientDetailsViewModel().fetchClientDetails();
    return _clientDetailsResponse;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Home')),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: FutureBuilder<ClientDetailsResponse>(
          future: loadData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<int> data = snapshot.data.accounts;
              return Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: _clientDetails(context, snapshot.data),
                  ),
                  Expanded(
                    flex: 8,
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(data[index].toString()),
                          subtitle: Text('Click to view'),
                          onTap: () {
                            int accountNumber = data[index];
                          },
                          trailing: Wrap(
                            spacing: 12, // space between two icons
                            children: <Widget>[
                              Icon(Icons.arrow_forward_ios), // icon-2
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: _addNewAccount(context),
    );
  }

  Widget _addNewAccount(BuildContext context) {
    return FloatingActionButton.extended(
      icon: Icon(Icons.add),
      label: Text('Add Account'),
      onPressed: () async {
        await showInformationDialog(context);
      },
    );
  }

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        bool isChecked = false;
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _accountNumberController,
                      validator: (value) {
                        {
                          return value.isNotEmpty ? null : "Please enter an account number!";
                        }
                      },
                      decoration: InputDecoration(hintText: "Account Number"),
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                )),
            title: Text('New Account'),
            actions: <Widget>[
              InkWell(
                child: Text('OK   '),
                onTap: () async {
                  if (_formKey.currentState.validate()) {
                    ProgressDialog progressDialog =
                        AppAlertDialog().progressDialog(context: context, text: 'Adding Account, Please wait...');
                    progressDialog.show();

                    ClientDetailsResponse clientData = await loadData();
                    clientData.accounts.add(int.parse(_accountNumberController.text));
                    dynamic _response = await ClientDetailsViewModel().updateClientAccounts(accountList: clientData.accounts);

                    if (_response != null) {
                      _accountNumberController.clear();
                      setState(() {});
                      progressDialog.dismiss();
                      AppAlertDialog().showSnackBar(context: context, text: 'New account added successfully');
                      Navigator.of(context).pop(true);
                    } else {
                      progressDialog.dismiss();
                      AppAlertDialog().showSnackBar(context: context, text: 'An error has occurred, please try again!');
                    }
                  }
                },
              ),
            ],
          );
        });
      },
    );
  }

  Widget _clientDetails(BuildContext context, ClientDetailsResponse data) {
    return Card(
      margin: EdgeInsets.all(10.0),
      elevation: 1.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Container(
          decoration: BoxDecoration(gradient: RadialGradient(colors: [Color(0xFF80afff), Color(0xFF80afff)])),
          padding: EdgeInsets.all(5.0),
          // color: Color(0xFF015FFF),
          child: Column(
            children: <Widget>[
              SizedBox(height: 15.0),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text('Welcome', style: TextStyle(color: Colors.white, fontSize: 18.0)),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text('${_clientDetailsResponse.name}(${_clientDetailsResponse.age})',
                      style: TextStyle(color: Colors.white, fontSize: 25.0)),
                ),
              ),
            ],
          )),
    );
  }
}
