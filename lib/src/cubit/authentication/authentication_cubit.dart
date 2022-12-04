


import 'package:firebase_app/src/helper/storage_helper.dart';
import 'package:firebase_app/src/helper/storage_keys.dart';
import 'package:firebase_app/src/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_app/src/cubit/authentication/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';


part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationRepository _repository = AuthenticationRepository();

  AuthenticationCubit() : super(AuthenticationInitial());
void createUser(UserModel userModel)async {
  emit(AuthenticationLoading());
  try {
    UserCredential user = await _repository.createUser(
        userModel.email, userModel.password ?? "");
    String token = await user.user!.getIdToken();
    String uid = user.user!.uid;
    StorageHelper.writeData(StorageKeys.token.name, token);
    StorageHelper.writeData(StorageKeys.uid.name, uid);
    userModel.id = uid;
    await _repository.storeUserData(userModel);
    emit(AuthenticationSuccess());
  }catch(ex){
    emit(AuthenticationFailure("something went wrong"));
  }
}
  loginUser(String email, String password)async {
    emit(AuthenticationLoading());
    try {
      UserCredential user = await _repository.loginUser(
         email,password );
      String? token = await user.user!.getIdToken();
      String? uid = user.user!.uid;
      StorageHelper.writeData(StorageKeys.token.name, token);
      StorageHelper.writeData(StorageKeys.uid.name, uid);
      emit(AuthenticationSuccess());
    } catch (ex) {
emit( const AuthenticationFailure("something went wrong"));
    }
  }
}