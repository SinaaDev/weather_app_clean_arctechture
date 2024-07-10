import 'package:equatable/equatable.dart';

import '../../data/models/suggest_city_model.dart';

class SuggestCityEntity extends Equatable{
  final List<Data>? data;
  final Metadata? metadata;

  SuggestCityEntity({
    required this.data,
    required this.metadata,
});

  @override
  // TODO: implement props
  List<Object?> get props => [
    data,
    metadata,
  ];
}
