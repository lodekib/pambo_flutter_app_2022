import 'package:equatable/equatable.dart';
import 'package:new_pambo/model/data_model.dart';

abstract class CubitStates extends Equatable{}

class InitialState extends CubitStates{
  @override
  // TODO: implement props
  List<Object> get props => [];

}


class LoadingState extends CubitStates{
  @override
  // TODO: implement props
  List<Object?> get props =>[];

}

class LoadedState extends CubitStates{
  LoadedState(this.uploads);
  final List<DataModel> uploads;
  @override
  // TODO: implement props
  List<Object?> get props =>[uploads];

}

class DetailState extends CubitStates{
  DetailState(this.upload);
   final DataModel upload;
  @override
  // TODO: implement props
  List<Object?> get props => [upload];

}

class FragranceState extends CubitStates{
  final dynamic frags ;
  FragranceState(this.frags);

  @override
  // TODO: implement props
  List<Object?> get props =>[frags];
}


