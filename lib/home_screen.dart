import "dart:convert";

import "package:ecosort/logged_screen.dart";
import "package:ecosort/provider/login_provider.dart";
import "package:ecosort/signup_screen.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:http/http.dart";
import "package:provider/provider.dart";



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String error = "";

  @override
  Widget build(BuildContext context) {
    // getData();
    final loginProvider = Provider.of<LoginProvider>(context);

    // loginProvider.checkLogin("Emma", "emma");
    return  Scaffold(
      backgroundColor: const Color.fromRGBO(107,125,92, 1.0),
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
        padding: const EdgeInsets.only(left: 40, right: 40, top: 80),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisSize: MainAxisSize.max,
          children: [
              Align(
              alignment: Alignment.topCenter,
              child:  Text(error),
            ),
            // const Align(
            //   alignment: Alignment.center,
            //   child: Text("Welcome user", style: TextStyle(
            //       fontSize: 40,
            //       color: Colors.grey,
            //       fontWeight: FontWeight.w400,
            //   )),
            // ),
            const Align(
              child: SizedBox(
                height: 20,
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child:  Text("Sign in", style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.w400
              ),),
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
                                  const Icon(Icons.email, color: Colors.white, size: 30,),
                                 Expanded(
                                   child: Container(
                                       margin: const EdgeInsets.only(left: 15),

                                       child:  TextField(
                                         controller: emailController,
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
                           Consumer<LoginProvider>(
                             builder: (context, value, child){
                               if(value.loading==false && value.userError == true){
                                 return Container(
                                   padding: const EdgeInsets.only(top: 20),
                                   child: const Text("Username Field is Empty", style: TextStyle(
                                     color: Colors.red,
                                     fontSize: 18
                                   ),),
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
                          Consumer<LoginProvider>(
                            builder: (context, value, child){
                              if(value.loading==false && value.passError == true){
                                return Container(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: const Text("Password Field is Empty", style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 18
                                  ),),
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

                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                width: double.tryParse("200"),
                height: double.tryParse("50"),
                margin: const EdgeInsets.only(top: 40),
                child: ElevatedButton(
                  onPressed: (){
                    loginProvider.checkLogin(emailController.text, passwordController.text);

                    // print(context.read<LoginProvider>().loading);
                    // if(context.read<LoginProvider>().loginStatus == true){
                    //     Navigator.push(context,
                    //     MaterialPageRoute(builder: (context)=> LoggedScreen())
                    //     );
                    // }
                  },
                  child: loginProvider.loading == true ? const CircularProgressIndicator(): const Text("Submit", style: TextStyle(
                    color: Color.fromRGBO(107,125,92, 1.0),
                    fontSize: 18
                  ),
                  ),

                ),
              ),
            ),
            const SizedBox(height: 40,),
             Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Create new Account? ", style: TextStyle(color: Colors.white, fontSize: 18),),
                  GestureDetector(
                      onTap: (){
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>  SignupPage()),
                        );
                      },
                      child: const Text("Sign Up", style: TextStyle(color: Color.fromRGBO(107,125,92, 1.0), fontSize: 20))),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Consumer<LoginProvider>(
              builder: (context, value, child){
                if(value.loading==false && value.credentials == false){
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: const Text("Invalid Credentials", style: TextStyle(
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