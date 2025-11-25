import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../data/repositories/note_repository_impl.dart';
import '../../domain/repositories/note_repository.dart';
import '../controllers/note_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetStorage>(() => GetStorage());
    Get.lazyPut<NoteRepository>(() => NoteRepositoryImpl(storage: Get.find<GetStorage>()));
    Get.lazyPut<NoteController>(() => NoteController(repository: Get.find<NoteRepository>()));
  }
}
