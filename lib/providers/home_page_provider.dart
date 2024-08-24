import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/home_page_controller.dart';
import '../models/data/home_page_data.dart';

final homePageControllerProvider =
    StateNotifierProvider<HomePageController, HomePageData>((ref) {
  return HomePageController(HomePageData.initial());
});
