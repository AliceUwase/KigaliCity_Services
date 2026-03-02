import 'package:flutter_bloc/flutter_bloc.dart';
import 'directory_state.dart';

class DirectoryCubit extends Cubit<DirectoryState> {
  DirectoryCubit() : super(const DirectoryState());

  void setPlaces(List<Map<String, dynamic>> places) {
    emit(state.copyWith(allPlaces: places));
  }

  void selectCategory(String category) {
    emit(state.copyWith(selectedCategory: category));
  }

  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }
}
