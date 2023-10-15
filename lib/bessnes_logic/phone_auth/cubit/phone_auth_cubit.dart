import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  late String verificationId;
  PhoneAuthCubit() : super(PhoneAuthInitial());

  Future<void> sumbitPhoneNumbr(String phoneNumber) async {
    emit(Loading());
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2$phoneNumber',
      timeout: const Duration(seconds: 120),
      verificationCompleted: verificationcomplated,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void verificationcomplated(PhoneAuthCredential credential) async {
    print("===================== completed");
    await signIn(credential);
  }

  Future<void> verificationFailed(FirebaseAuthException error) async {
    print("===================== failed : ${error.toString()}");
    emit(ErrorOccurred(errorMsg: error.toString()));
  }

  void codeSent(String verificationId, int? resendToken) {
    print("===============code sent");
    this.verificationId = verificationId;
    emit(PhonwNumberSumbited());
  }

  void codeAutoRetrievalTimeout(String verificationId) async {
    print("========================codeAutoRetrievalTimeout");
  }

  Future<void> submitOPT(String otpcode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpcode);
    await signIn(credential);
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(PhoneOTPVerified());
    } catch (error) {
      emit(ErrorOccurred(errorMsg: error.toString()));
      print('===============$error');
    }
  }

  User getloginUser() {
    return FirebaseAuth.instance.currentUser!;
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
