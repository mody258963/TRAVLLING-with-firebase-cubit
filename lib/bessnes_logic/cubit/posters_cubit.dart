import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'posters_state.dart';

class PostersCubit extends Cubit<PostersState> {
  PostersCubit() : super(PostersInitial());
}
