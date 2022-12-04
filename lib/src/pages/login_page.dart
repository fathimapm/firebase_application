import 'package:firebase_app/src/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_app/src/cubit/authentication/authentication_cubit.dart';
import 'package:firebase_app/src/pages/home_page.dart';
import 'package:firebase_app/src/pages/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key :key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   TextEditingController _emailController = TextEditingController();
   TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return   BlocProvider(
  create: (context) => AuthenticationCubit(),
  child: Scaffold(

        body:SingleChildScrollView(
          child: SafeArea(
              child:_buildLoginForm(context)
          ),
        )

    ),
);


  }
  _buildLoginForm(BuildContext context){
    return
      Center(
        child:   BlocListener<AuthenticationCubit, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationSuccess){
            Navigator.of(context).push( MaterialPageRoute(builder:(context)=>HomePage()));
            }

          },
          child:
          Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
              maxWidth: MediaQuery.of(context).size.width,
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green,
                    Colors.blue,
                  ],
                  begin:  Alignment.topLeft,
                  end: Alignment.centerRight,
                )
            ),
            child:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex:2,
                    child:Padding(
                      padding:const EdgeInsets.symmetric(vertical: 36.0,horizontal: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Text("Welcome back",style: TextStyle(color: Colors.white,fontSize: 35.0,fontWeight: FontWeight.w600),)


                        ],

                      ),
                    ),
                  ),
                  Expanded(
                      flex: 5,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 100,right: 100),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("LOGIN",style: TextStyle(color: Colors.teal,fontSize: 35.0,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                                SizedBox(height: 30,),
                                Container(
                                  decoration: BoxDecoration(
                                      border:Border(
                                        bottom: BorderSide(color:Colors.teal ),
                                      )
                                  ),
                                  child: TextField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                        hintText: "Email",
                                        suffixIcon: Icon(Icons.person,color: Colors.teal,),
                                        hintStyle: TextStyle(color: Colors.teal)

                                    ),
                                  ),
                                ),
                                SizedBox(height: 50,),
                                Container(
                                  decoration: BoxDecoration(
                                      border:Border(
                                        bottom: BorderSide(color:Colors.teal ),
                                      )
                                  ),
                                  child: TextField(
                                    controller: _passwordController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        hintText: "Password",
                                        hintStyle: TextStyle(color: Colors.teal)

                                    ),
                                  ),

                                ),
                                SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment:  MainAxisAlignment.end,
                                  children: [
                                    TextButton(onPressed: (){}, child: Text("Forget Password?",style: TextStyle(color: Colors.teal),))
                                  ],
                                ),
                                SizedBox(height: 25,),
                                BlocBuilder<AuthenticationCubit, AuthenticationState>(
                                  builder: (context, state) {
                                    if (state is AuthenticationLoading){
                                      return  Center(child: CircularProgressIndicator(),);
                                    }
                                    return Container(
                                        height: 60,
                                        width: double.infinity,
                                        decoration:   BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            color: Colors.teal
                                        ),
                                        child: MaterialButton(
                                          onPressed: (){
                                           context.read<AuthenticationCubit>().loginUser(_emailController.text.trim(), _passwordController.text);
                                          },
                                          child: Text("LOGIN",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w600),),
                                        )
                                    );
                                  },
                                ),

                                SizedBox(height: 25,),
                                
TextButton(onPressed: (){
  Navigator.of(context).push(MaterialPageRoute(builder:(_) =>MyHomePage()));
},
    child: Text("Sign up"))










                              ]
                          ),
                        ),
                      )),


                ]
            ),
          ),
        ),


      );

  }
}
