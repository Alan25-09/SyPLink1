import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhubv2_0/models/response/bookmarks/all_bookmarks.dart';
import 'package:jobhubv2_0/services/helpers/book_helper.dart';
import 'package:jobhubv2_0/views/common/exports.dart';

class BookNotifier extends ChangeNotifier {
  late Future<List<AllBookMarks>> bookmarks;

  bool _bookmark = false;
  bool get bookmark => _bookmark;
  set isBookMark(bool newState) {
    if (_bookmark != newState) {
      _bookmark = newState;
      notifyListeners();
    }
  }

  String _bookmarkId = '';
  String get bookmarkId => _bookmarkId;
  set isBookMarkId(String newState) {
    if (_bookmarkId != newState) {
      _bookmarkId = newState;
      notifyListeners();
    }
  }

  addBookMark(String model) async {
    BookMarkHelper.addBookmark(model).then((bookmark) {});
  }

  getBookMark(String vacantId) {
    var bookmark = BookMarkHelper.getBookMark(vacantId);

    bookmark.then((value) => {
          if (value == null)
            {isBookMark = false, isBookMarkId = ''}
          else
            {isBookMark = true, isBookMarkId = value.bookmarkId}
        });
  }

  deleteBookMark(String vacantId) {
    BookMarkHelper.deleteBookMarks(vacantId).then((value) {
      if (value) {
        Get.snackbar('El marcador se eliminó con éxito',
            'Visita la página de favoritos para ver los cambios',
            colorText: Color(kLight.value),
            backgroundColor: Color(kVerde.value),
            icon: const Icon(Icons.bookmark_remove_outlined));
      }
      isBookMark = false;
    });
  }

  Future<List<AllBookMarks>> getBookMarks() {
    bookmarks = BookMarkHelper.getAllBookmarks();
    return bookmarks;
  }
}
