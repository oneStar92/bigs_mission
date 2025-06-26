enum Category {
  notice,
  free,
  qna,
  etc;

  @override
  String toString() {
    switch (this) {
      case Category.notice:
        return '공지';
      case Category.free:
        return '자유';
      case Category.qna:
        return 'Q&A';
      case Category.etc:
        return '기타';
    }
  }

  String toJson() {
    switch (this) {
      case Category.notice:
        return 'NOTICE';
      case Category.free:
        return 'FREE';
      case Category.qna:
        return 'QNA';
      case Category.etc:
        return 'ETC';
    }
  }

  static Category fromJson(String json) {
    if (json == 'NOTICE') {
      return Category.notice;
    } else if (json == 'NOTICE') {
      return Category.free;
    } else if (json == 'NOTICE') {
      return Category.qna;
    } else {
      return Category.etc;
    }
  }
}
