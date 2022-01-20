import 'package:flutter/material.dart';
import 'package:nocapricho3/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();
  final nome = TextEditingController();
  final confSenha = TextEditingController();

  bool isLogin = true;
  bool loading = false;
  late String titulo;
  late String actionButton;
  late String toggleButton;

  @override
  void initState() {
    super.initState();
    setFormAction(true);
  }

  setFormAction(bool acao) {
    setState(() {
      isLogin = acao;
      if (isLogin) {
        titulo = 'Bem-Vindo(a)';
        actionButton = 'Login';
        toggleButton = 'Ainda não tem uma conta? Cadastre-se Agora!';
      } else {
        titulo = 'Crie sua conta agora!';
        actionButton = 'Cadastrar';
        toggleButton = 'Voltar ao Login';
      }
    });
  }

  login() async {
    setState(() {
      loading = true;
    });
    try {
      await context.read<AuthService>().login(email.text, senha.text);
    } on AuthException catch (e) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  registrar() async {
    setState(() {
      loading = true;
    });
    try {
      await context
          .read<AuthService>()
          .registrar(email.text, senha.text, nome.text);
    } on AuthException catch (e) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 100),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  titulo,
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1.5),
                ),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informe o Email corretamente!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: TextFormField(
                    controller: senha,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Senha'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informe uma senha!';
                      } else if (value.length < 6) {
                        return 'Sua senha precisa ter no mínimo 6 caracteres';
                      }
                      return null;
                    },
                  ),
                ),
                isLogin
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.all(24),
                        child: TextFormField(
                          controller: confSenha,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Repita a senha'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe uma senha!';
                            } else if (value.length < 6) {
                              return 'Sua senha precisa ter no mínimo 6 caracteres';
                            } else if (!value.contains(senha.text)) {
                              return 'As senhas precisam ser idênticas';
                            }
                            return null;
                          },
                        ),
                      ),
                isLogin
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.all(24),
                        child: TextFormField(
                          controller: nome,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Digite seu nome'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe um nome!';
                            }
                            return null;
                          },
                        ),
                      ),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (isLogin) {
                          login();
                        } else {
                          registrar();
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: (loading)
                          ? [
                              Padding(
                                  padding: EdgeInsets.all(16),
                                  child: SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      )))
                            ]
                          : [
                              Icon(Icons.check),
                              Padding(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  actionButton,
                                  style: TextStyle(fontSize: 20),
                                ),
                              )
                            ],
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () => setFormAction(!isLogin),
                    child: Text(toggleButton))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
