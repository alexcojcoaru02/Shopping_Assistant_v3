import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final nameController = TextEditingController();
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);


    size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xfff0f1f5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 800,
              ),
              padding: const EdgeInsets.all(18),
              height: size.height,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150,
                    child: RichText(
                        text: const TextSpan(
                            text: 'Your',
                            style: TextStyle(
                              fontSize: 32,
                              color: Color(0xffff4590),
                              fontWeight: FontWeight.bold,
                            ),
                            children: <TextSpan>[
                          TextSpan(
                              text: ' shopping partner',
                              style: TextStyle(
                                color: Colors.black87,
                              ))
                        ])),
                  ),
                  SizedBox(
                    width: size.width,
                    height: size.height * .3,
                    child: Image.asset('assets/images/welcome_page.png'),
                  ),
                  Container(
                    height: size.height * .3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.2),
                          spreadRadius: 2,
                          blurRadius: 20,
                          offset: const Offset(0, 0),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28, vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(
                                width: double.infinity,
                                child: Text(
                                  'Register Here',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: nameController,
                                      cursorColor: Colors.grey,
                                      style: const TextStyle(
                                        color: Colors.black54,
                                      ),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '    Popescu Ion',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              ),
                              Container(
                                constraints: const BoxConstraints(
                                  maxWidth: 700,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: size.width < 573 ? size.width - 170 : 423,
                                      child: const Text(
                                        'Acesta va fi numele sub care veti putea adauga comentarii!',
                                        textAlign: TextAlign.center,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black54,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),                                    
                                    FloatingActionButton(
                                      onPressed: () {
                                        String userName = nameController.text;
                                        authProvider.login(userName);

                                        // Navigator.pushReplacement(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) => const ExempluListare(),
                                        //   ),
                                        // );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(22),
                                        height: 60,
                                        width: 60,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                                Color(0xff382743),
                                                Color(0xffff4590),
                                              ],
                                              stops: [
                                                0.0,
                                                1.0
                                              ],
                                              begin: FractionalOffset.topLeft,
                                              end:
                                                  FractionalOffset.bottomRight),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.asset(
                                            'assets/images/right-arrow.png'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
