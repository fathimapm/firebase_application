import 'package:firebase_app/src/cubit/authentication/authentication_cubit.dart';
import 'package:firebase_app/src/models/user_model.dart';
import 'package:firebase_app/src/pages/home_page.dart';
import 'package:firebase_app/src/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthenticationCubit(),
        child: Scaffold(

              appBar: AppBar(


              ),
              body:

              Form(
                child: Column(
                  children: [
                    TextField(
                      controller:_nameController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          hintText: "Name",
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller:_emailController,
                      style: TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          hintText: "Email",
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: _passwordController,
                      style: TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          hintText: " password",
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    SizedBox(
                      height: 40,
                    ),

                    TextField(
                      controller: _addressController,
                      style: TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          hintText: " Address",
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    SizedBox(
                      height: 40,
                    ),

                    BlocConsumer<AuthenticationCubit,AuthenticationState>(
                        listener: (context,state){
                          if (state is AuthenticationSuccess){
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) =>LoginPage()));
                          }else if(state is AuthenticationFailure){

                          }
                        },
                        builder: (context,state) {
                          if (state is AuthenticationLoading){
                            return CircularProgressIndicator();
                          }
                          return ElevatedButton(

                            onPressed: () {
                              UserModel userModel =UserModel(email: _emailController.text, address: _addressController.text,password:_passwordController.text,mobileNo: "9048165269");
                            context.read<AuthenticationCubit>().createUser(userModel);
                            },
                            child: Text("Signup"),
                          );
                        }
                    ),





                  ],
                ),
              )
          ),



    );

  }
}