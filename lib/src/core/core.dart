import 'package:bigs/src/domain/entity/entity.dart';
import 'package:bigs/src/presentation/view/create/create_screen.dart';
import 'package:bigs/src/presentation/view/detail/detail_screen.dart';
import 'package:bigs/src/presentation/view/home/home_screen.dart';
import 'package:bigs/src/presentation/view/login/login_screen.dart';
import 'package:bigs/src/presentation/view/signup/signup_screen.dart';
import 'package:bigs/src/presentation/view/update/update_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

part 'constants/constants.dart';
part 'dio_client/dio_client.dart';
part 'router/router.dart';
part 'token_storage/token_storage.dart';
