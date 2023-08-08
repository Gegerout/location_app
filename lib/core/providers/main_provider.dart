import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/data/repository/data_repository.dart';

final getUserDataProvider = FutureProvider((ref) async {
   final data = await DataRepository().getUserDataFromStorage();
   if(data != null) {
     return data.data;
   }
   return null;
});