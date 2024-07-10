
/*
  T = Type
  p = Param

  T means that this class return a T
  and
  P means that this class get a P
 */
abstract class UseCase<T,P>{
  Future<T> call(P param);
}

/* if we supposed to send no params to out method then we ues this class
to put it on our use case P position
ex: class GetCurrentWeatherUseCase extends UseCase<DataState<CurrentCityEntity>, NoParams>{
    method(NoParams params)
 */
class NoParams{}