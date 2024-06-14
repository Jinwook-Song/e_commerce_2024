import 'package:e_commerce/data/data_source/local/display.dao.dart';
import 'package:e_commerce/data/data_source/mock/display/display.mock_api.dart';
import 'package:e_commerce/data/data_source/remote/display.api.dart';
import 'package:e_commerce/data/dto/common/response_wrapper/response_wrapper.dart';
import 'package:e_commerce/data/dto/display/menu/menu.dto.dart';
import 'package:e_commerce/data/mapper/common.mapper.dart';
import 'package:e_commerce/data/mapper/display.mapper.dart';
import 'package:e_commerce/data/repository_impl/display_repository_impl.dart';
import 'package:e_commerce/domain/model/display/menu/menu.model.dart';
import 'package:e_commerce/domain/repository/display.repository.dart';
import 'package:e_commerce/presentation/screens/main/cubit/mall_type_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDisplayApi extends Mock implements DisplayApi {}

void main() {
  late DisplayRepository displayRepository;
  late DisplayApi displayApi;
  late DisplayDao displayDao;

  setUpAll(() {
    displayApi = MockDisplayApi();
    displayDao = DisplayDao();
    displayRepository = DisplayRepositoryImpl(displayApi, displayDao);
  });

  test('의존성 주입 및 객체 생성 완료', () => expect(displayRepository, isNotNull));

  group('메뉴 리스트 불러오기', () {
    test(
      'Api 호출 완료',
      () async {
        try {
          await displayRepository.getMenusByMallType(mallType: MallType.market);
        } catch (_) {}

        verify(() => displayApi.getMenusByMallType(any())).called(1);
      },
    );

    test('Api 호출 실패', () async {
      final exception = Exception('error');
      when(() => displayApi.getMenusByMallType(any())).thenThrow(exception);
      expect(
        () => displayRepository.getMenusByMallType(mallType: MallType.market),
        throwsA(exception),
      );
    });

    test('메뉴 리스트 불러오기 성공 ', () async {
      const mallType = MallType.market;

      final ResponseWrapper<List<MenuDto>> mockingApiData =
          await DisplayMockApi().getMenusByMallType(mallType.name);

      when(() => displayApi.getMenusByMallType(mallType.name))
          .thenAnswer((_) async => mockingApiData);

      final actual =
          await displayRepository.getMenusByMallType(mallType: mallType);

      final expected = mockingApiData.toModel<List<Menu>>(
        mockingApiData.data?.map((e) => e.toModel()).toList() ?? [],
      );
      expect(actual, expected);
    });
  });
}
