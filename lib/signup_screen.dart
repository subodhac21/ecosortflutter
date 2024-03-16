import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                              color:  const Color.fromRGBO(75,147,233, 1.0),
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
                          // Consumer<LoginProvider>(
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
                              color:  const Color.fromRGBO(75,147,233, 1.0),
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
                                          hintText: "Enter your Email",
                                          focusColor: Colors.red,

                                        ),

                                      )
                                  ),
                                )
                              ],
                            ),
                          ),
                          // Consumer<LoginProvider>(
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
                              color:  const Color.fromRGBO(75,147,233, 1.0),
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
                          // Consumer<LoginProvider>(
                          //   builder: (context, value, child){
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
            Center(
              child: Container(
                width: double.tryParse("200"),
                height: double.tryParse("50"),
                margin: const EdgeInsets.only(top: 40),
                child: ElevatedButton(
                  onPressed: (){
                    //loginProvider.checkLogin(emailController.text, passwordController.text);
                  },
                  // child: loginProvider.loading == true ? const CircularProgressIndicator(): const Text("Submit", style: TextStyle(
                  //     color: Colors.lightBlue,
                  //     fontSize: 18
                  // ),),
                  child: Text("Register"),

                ),
              ),
            ),
            const SizedBox(height: 40,),

            const SizedBox(height: 20,),
            // Consumer<LoginProvider>(
            //   builder: (context, value, child){
            //     if(value.loading==false && value.credentials == false){
            //       return Center(
            //         child: Container(
            //           padding: const EdgeInsets.only(top: 20),
            //           child: const Text("Invalid Credentials", style: TextStyle(
            //               color: Colors.red,
            //               fontSize: 18
            //           ),),
            //         ),
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
    );
  }
}
