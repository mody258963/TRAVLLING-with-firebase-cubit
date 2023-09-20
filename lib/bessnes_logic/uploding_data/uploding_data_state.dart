sealed class UplodingDataState {}

final class UplodingDataInitial extends UplodingDataState {}

class Loading extends UplodingDataState {}

class ErrorOccurred extends UplodingDataState {
  final String errorMsg;

  ErrorOccurred({required this.errorMsg});
}

class PhonwNumberSumbited extends UplodingDataState {}

class PhoneOTPVerified extends UplodingDataState {}
