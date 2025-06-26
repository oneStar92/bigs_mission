import 'dart:convert';

import 'package:bigs/src/core/core.dart';
import 'package:bigs/src/data/dto/dto.dart';
import 'package:bigs/src/domain/entity/category/category.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'auth/auth_data_source.dart';
part 'auth/auth_service.dart';
part 'board/board_data_source.dart';
part 'board/board_service.dart';
part 'source.g.dart';
