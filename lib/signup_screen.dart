import 'package:ecosort/logged_screen.dart';
import 'package:ecosort/provider/signup_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
   SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController userController = TextEditingController();

  String username = "";

  String email = "";

  String password = "";

  @override
  Widget build(BuildContext context) {

    // final signProvider = Provider.of<SignupProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.brown,
      body: Container(
        decoration:  BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(1),
            ],
          ),
        ),
        padding: const EdgeInsets.only(left: 40, right: 40, top: 40),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisSize: MainAxisSize.max,
          children: [
             Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: const Row(
                  children: [
                    Icon(Icons.arrow_back_ios_rounded, size: 40, color: Colors.black87,),
                    Text("Go to login page")
                  ],
                ),
              ),
            ),
            const Align(
              child: SizedBox(
                height: 40,
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child: Text("Register User", style: TextStyle(
                fontSize: 40,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              )),
            ),
            const Align(
              child: SizedBox(
                height: 20,
              ),
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Username",style:  TextStyle(
                              fontSize: 18,
                              color: Colors.white
                          ),),
                          Container(
                            margin:  const EdgeInsets.only(top: 10),
                            padding:   const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 15),
                            decoration:   BoxDecoration(
                              color:  const Color.fromRGBO(107,125,92, 1.0),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12, //New
                                    blurRadius: 1.0,
                                    spreadRadius: 3.0
                                )
                              ],
                            ),
                            child:  Row(

                              children: [
                                const Icon(Icons.person, color: Colors.white, size: 30,),
                                Expanded(
                                  child: Container(
                                      margin: const EdgeInsets.only(left: 15),

                                      child:  TextField(
                                        controller: userController,
                                        onChanged: (text){
                                         setState(() {
                                           username = text;
                                         });
                                        },
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Enter your Username",
                                          focusColor: Colors.red,

                                        ),

                                      )
                                  ),
                                )
                              ],
                            ),
                          ),
                          // Consumer<SignupProvider>(
                          //   builder: (context, value, child){
                          //     if(value.loading==false && value.userError == true){
                          //       return Container(
                          //         padding: const EdgeInsets.only(top: 20),
                          //         child: const Text("Username Field is Empty", style: TextStyle(
                          //             color: Colors.red,
                          //             fontSize: 18
                          //         ),),
                          //       );
                          //     }
                          //     else{
                          //       return const Text("");
                          //     }
                          //   },
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Email",style:  TextStyle(
                              fontSize: 18,
                              color: Colors.white
                          ),),
                          Container(
                            margin:  const EdgeInsets.only(top: 10),
                            padding:   const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 15),
                            decoration:   BoxDecoration(
                              color:  const Color.fromRGBO(107,125,92, 1.0),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12, //New
                                    blurRadius: 1.0,
                                    spreadRadius: 3.0
                                )
                              ],
                            ),
                            child:  Row(

                              children: [
                                const Icon(Icons.email, color: Colors.white, size: 30,),
                                Expanded(
                                  child: Container(
                                      margin: const EdgeInsets.only(left: 15),

                                      child:  TextField(
                                        controller: emailController,
                                        onChanged: (text){
                                          setState(() {
                                            email = text;
                                          });
                                        },
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Enter your Email",
                                          focusColor: Colors.red,

                                        ),

                                      )
                                  ),
                                )
                              ],
                            ),
                          ),
                          // Consumer<SignupProvider>(
                          //   builder: (context, value, child){
                          //     if(value.loading==false && value.emailError == true){
                          //       return Container(
                          //         padding: const EdgeInsets.only(top: 20),
                          //         child: const Text("Email Field is Empty", style: TextStyle(
                          //             color: Colors.red,
                          //             fontSize: 18
                          //         ),),
                          //       );
                          //     }
                          //     else{
                          //       return const Text("");
                          //     }
                          //   },
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Password",style:  TextStyle(
                              fontSize: 18,
                              color: Colors.white
                          ),),
                          Container(
                            margin:  const EdgeInsets.only(top: 10),
                            padding:   const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 15),
                            decoration:   BoxDecoration(
                              color:  const Color.fromRGBO(107,125,92, 1.0),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12, //New
                                    blurRadius: 1.0,
                                    spreadRadius: 3.0
                                )
                              ],
                            ),
                            child:  Row(

                              children: [
                                const Icon(Icons.lock, color: Colors.white, size: 30,),
                                Expanded(
                                  child: Container(
                                      margin: const EdgeInsets.only(left: 15),

                                      child:  TextField(
                                        controller: passwordController,
                                        obscureText: true,
                                        onChanged: (text){
                                          setState(() {
                                            password = text;
                                          });
                                        },
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Enter your Password",
                                          focusColor: Colors.red,

                                        ),

                                      )
                                  ),
                                )
                              ],
                            ),
                          ),
                          // Consumer<SignupProvider>(
                          //   builder: (context, value, child){
                          //
                          //     if(value.loading==false && value.passError == true){
                          //       return Container(
                          //         padding: const EdgeInsets.only(top: 20),
                          //         child: const Text("Password Field is Empty", style: TextStyle(
                          //             color: Colors.red,
                          //             fontSize: 18
                          //         ),),
                          //       );
                          //     }
                          //     else{
                          //       return const Text("");
                          //     }
                          //   },
                          // ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Consumer<SignupProvider>(
              builder: (context, signProvider, child){

                if(signProvider.loginStatus == true && signProvider.loading == false){
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    // add your code here.
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>  LoggedScreen()),
                    );
                  });

                }
                return Visibility(
                  visible: (username.trim() != "" && email.trim() != "" && password.trim() != "" ) ? true : false,
                  child: Center(
                    child: Container(
                      width: double.tryParse("200"),
                      height: double.tryParse("50"),
                      margin: const EdgeInsets.only(top: 40),
                      child: ElevatedButton(
                        onPressed: (){
                            signProvider.checkLogin(userController.text,emailController.text, passwordController.text);
                        },
                        child: signProvider.loading == true ? const CircularProgressIndicator(): const Text("Register", style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 18
                        ),),
                        // child: const Text("Register"),

                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 0,),

            const SizedBox(height: 0,),
            Consumer<SignupProvider>(
              builder: (context, value, child){
                if(value.loading==false && value.credentials == false){
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: const Text("User with the username already exists.", style: TextStyle(
                          color: Colors.red,
                          fontSize: 18
                      ),),
                    ),
                  );
                }
                else if(value.loading==false && value.emailError == true){
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: const Text("Enter a valid email address.", style: TextStyle(
                          color: Colors.red,
                          fontSize: 18
                      ),),
                    ),
                  );
                }
                else{
                  return const Text("");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
