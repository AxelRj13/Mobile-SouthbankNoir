import '../../../../core/network/api_response.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/banner_repository.dart';

class GetBannerUseCase implements UseCase<DataState<ApiResponseEntity>, void> {
  final BannerRepository _bannerRepository;

  GetBannerUseCase(this._bannerRepository);

  @override
  Future<DataState<ApiResponseEntity>> call({void params}) {
    return _bannerRepository.getBanners();
  }
}
