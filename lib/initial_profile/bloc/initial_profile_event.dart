part of 'initial_profile_bloc.dart';

abstract class InitialProfileEvent extends Equatable {
  const InitialProfileEvent();

  @override
  List<Object> get props => [];
}

class InitialProfileRegisterPressedEvent extends InitialProfileEvent {
  final int phoneNumber;
  final String petType;
  final String breed;
  final DateTime birthday;
  final String gender;
  final File image;
  final String petFirstName;
  final String petLastName;
  final String weight;
  final String bloodGroup;
  const InitialProfileRegisterPressedEvent(
      {this.phoneNumber,
      this.petType,
      this.breed,
      this.birthday,
      this.gender,
      this.image,
      this.petFirstName,
      this.petLastName,
      this.weight,
      this.bloodGroup});

  @override
  List<Object> get props => [
        petType,
        breed,
        birthday,
        gender,
        image,
        petFirstName,
        petLastName,
        weight,
        bloodGroup,
      ];
}

class InitialProfileIntializeEvent extends InitialProfileEvent {}
