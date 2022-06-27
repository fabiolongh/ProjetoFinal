import 'package:flutter/material.dart';
import 'package:telalogin/components/transactio_list.dart';
import 'package:telalogin/components/transaction_form.dart';
import 'package:telalogin/models/transaction.dart';
import 'dart:math';
import 'package:telalogin/models/login_screen.dart';
import 'package:telalogin/models/user.dart';
import 'package:telalogin/models/login_response.dart';

main() => runApp(LoginPage() /*ExpensesApp()*/);

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginCallBack {
  late BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  late String _username, _password;
  late LoginResponse _response;
  _LoginPageState() {
    _response = new LoginResponse(this);
  }
  void _submit() {
    final form = formKey.currentState;
    if (form!.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _response.doLogin(_username, _password);
      });
    }
  }

  void _showSnackBar(String text) {
    // ignore: deprecated_member_use
    scaffoldKey.currentState!.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var loginBtn = new RaisedButton(
      onPressed: _submit,
      child: new Text("Login"),
      color: Colors.green,
    );
    var loginForm = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _username = val!,
                  decoration: new InputDecoration(labelText: "Username"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _password = val!,
                  decoration: new InputDecoration(labelText: "Password"),
                ),
              )
            ],
          ),
        ),
        loginBtn
      ],
    );
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Login Page"),
      ),
      key: scaffoldKey,
      body: new Container(
        child: new Center(
          child: loginForm,
        ),
      ),
    );
  }

  @override
  void onLoginError(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) async {
    if (user != null) {
      Navigator.of(context).pushNamed("/home");
    } else {
      // TODO: implement onLoginSuccess
      _showSnackBar("Login Gagal, Silahkan Periksa Login Anda");
      setState(() {
        _isLoading = false;
      });
    }
  }
}

/*------------------------------------------------------------------*/
/*class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MyHomePage(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          secondaryHeaderColor: Colors.red,
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _transaction = [
    //A lista é final porque o Homepage é Stateless (Lista estatica, homepagetb)
    Transaction(
      id: 't1',
      title: 'Novo Tenis de corrida',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 211.76,
      date: DateTime.now(),
    ),
  ];
  _addTransaction(String title, double value, int opcao) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: DateTime.now());
    if (opcao == 1) {
      setState(() {
        _transaction.add(newTransaction);
      });
    }
    if (opcao == 3) {
      Navigator.pop(context);
    } else {
      if (_transaction.length > 0)
        setState(() {
          _transaction.removeLast();
          Navigator.pop(context);
        });
    }
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Despesas Pessoais',
            style:
                TextStyle(fontSize: 28, color: Color.fromARGB(255, 0, 0, 0))),
        actions: <Widget>[
          IconButton(
              onPressed: () => _openTransactionFormModal(context),
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        //É o que permite que você possa arrastar a tela pra baixo
        child: Column(
          crossAxisAlignment: CrossAxisAlignment
              .stretch, //Posição padrão dos Children dele, nesse caso do centro
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              height: 80,
              //width: double.infinity, // Não precisa pois tem o stretch
              //height: 80,
              child: Card(
                color: Colors.blue,
                child: const Text('GRÁFICO'),
                elevation: 5,
              ),
            ),
            TransactionList(_transaction),
            //TransactionUser(),
            //TransactionList(_transaction),
            //TransactionForm()
            /*Como essa parte da minha aplicação vai ser mutavel, ou seja
            vai se alterar toda hora, essas contas vao mudar, as transações vao mudar
            e acontecer, então não pode ficar dentro de um componente STATELESS
            Pois seu estado muda constantemente/
          */
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}*/
