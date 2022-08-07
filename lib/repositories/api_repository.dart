import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:pet_perfect_app/authentication/authentication.dart';
import 'package:pet_perfect_app/authentication/models/user.dart';
import 'package:pet_perfect_app/common/models/message.dart';
import 'package:pet_perfect_app/SideBarPages/models/pet_registration.dart';
import 'package:pet_perfect_app/common/models/user_data.dart';
import 'package:pet_perfect_app/home/export.dart';
import 'package:pet_perfect_app/home/models/deworming.dart';
import 'package:pet_perfect_app/home/models/filePicture.dart';
import 'package:pet_perfect_app/home/models/measurement.dart';
import 'package:pet_perfect_app/home/models/picture.dart';
import 'package:pet_perfect_app/home/models/vaccination.dart';
import 'package:pet_perfect_app/initial_profile/models/Breeds.dart';
import 'package:pet_perfect_app/initial_profile/models/BloodGroups.dart';
import 'package:pet_perfect_app/logger.dart';
import 'package:pet_perfect_app/profile/models/documents.dart';
import 'package:pet_perfect_app/profile/models/pet_profile_model.dart';
import 'package:pet_perfect_app/registration/models/Registration.dart';
import 'package:pet_perfect_app/initial_profile/models/petRegisteredId.dart';
import 'dart:io';

import 'package:pet_perfect_app/registration/registration.dart';
import 'package:pet_perfect_app/home/models/pet_records_and_notes.dart';
import 'package:pet_perfect_app/screens/Food/models/food.dart';
import 'package:pet_perfect_app/screens/Info/models/insight.dart';
import 'package:pet_perfect_app/screens/Info/models/insights.dart';
import 'package:pet_perfect_app/services/models/service.dart';
import 'package:pet_perfect_app/shop/models/shop.dart';
import 'package:pet_perfect_app/utils/local_db_hive.dart';

class ApiRepository {
  static const url = "http://ec2-13-232-92-13.ap-south-1.compute.amazonaws.com";
  static const validStatusCodes = [200, 201, 202];
  String thumbnail =
      "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no";
  static const debug = true;
  static const debugAPi = false;
  BaseOptions options;
  ApiRepository() {
    options = BaseOptions(
      connectTimeout: 60 * 1000, // 60 seconds
      receiveTimeout: 60 * 1000, // 60 seconds
      baseUrl: url,
      receiveDataWhenStatusError: true,
      contentType: "application/json",
    );
  }

  String localPetId = "790624d5-481f-43b";
  // int localPhoneNumber = 7417316302;
  // String breed = "Abyssinian";
  // error Handler
  void handleError(DioError e) {
    print(e);
    var error = json.decode(e.response.toString());
    throw error["message"];
  }

  // Mobile Authentication
  Future<Authentication> registrationAuthApi(int phoneNumber) async {
    try {
      if (debug && debugAPi)
        return Authentication(
            message: "Successfully sent the OTP", sessionId: "2000");
      logger.d(
          "Sending POST request: url/user/send-registration-code, with queryParameters: phoneNumber: $phoneNumber ");
      final response = await Dio(options)
          .post(url + "/user/send-registration-code", queryParameters: {
        "phoneNumber": phoneNumber,
      });
      logger.i(response.data);

      return Authentication.fromJson(response.data);
    } on DioError catch (e) {
      logger.e(e.error);
      handleError(e);
    }
  }

  // Mobile Registration
  Future<Registration> registrationApi(String sessionId, int code, user) async {
    try {
      if (debug && debugAPi)
        return Registration(
            accessToken: 'accessToken',
            message: 'Successfully Registered the user',
            expires: 100,
            phoneNumber: 9560922267,
            firstName: 'Yash',
            lastName: 'Bansal',
            refreshToken: 'refreshToken');
      logger.d(
          "Sending POST request: url/user/verify-registration-code, with data: sessionId: $sessionId, code: $code, userMeta: ${toRegistrationJson(user)}, and options: $options");
      final response = await Dio(options).post(
        url + '/user/verify-registration-code',
        data: {
          "sessionId": sessionId,
          "code": code,
          "userMeta": toRegistrationJson(user),
        },
      );

      logger.i("registrationApi Response:   $response");

      return Registration.fromJson(response.data);
    } on DioError catch (e) {
      logger.e(e.error);
      handleError(e);
    }
  }

  // Mobile Authentication
  Future<Authentication> loginAuthApi(int phoneNumber) async {
    try {
      if (debug && debugAPi)
        return Authentication(
            message: "Successfully sent the OTP", sessionId: "2000");

      logger.d(
          "Sending POST request: url/user/verify-registration-code, with queryParameters: phoneNumber: $phoneNumber, and options: $options");
      final response = await Dio(options)
          .post(url + "/user/send-login-code", queryParameters: {
        "phoneNumber": phoneNumber,
      });
      logger.i(response);

      return Authentication.fromJson(response.data);
    } on DioError catch (e) {
      logger.e(e.error);
      handleError(e);
    }
  }

  // Mobile Registration
  Future<Registration> loginApi(
      int phoneNumber, String sessionId, int enteredOtp) async {
    try {
      if (debug && debugAPi)
        return Registration(
            accessToken: 'accessToken',
            message: 'Successfully Registered the user',
            expires: 100,
            phoneNumber: 9560922267,
            firstName: 'Yash',
            lastName: 'Bansal',
            refreshToken: 'refreshToken');
      logger.d(
          "Sending POST request: url/user/verify-login-code, with queryParameters: phoneNumber: $phoneNumber, sessionId: $sessionId, code: $enteredOtp and options: $options");
      final response = await Dio().post(
        url + "/user/verify-login-code",
        queryParameters: {
          'sessionId': sessionId,
          'code': enteredOtp,
          'phoneNumber': phoneNumber.toString(),
        },
      );
      print(response.data);

      return Registration.fromJson(response.data);
    } on DioError catch (e) {
      logger.e(e);
      handleError(e);
    }
  }

// List of breeds of cat and dogs
  Future<List<String>> getBreedList(String type, String accessToken) async {
    try {
      if (type == null || type == '') type = 'DOG';
      if (debug && debugAPi) {
        print("returning");
        if (type.toUpperCase() == 'DOG')
          return ["German Shepherd", "Dogo Argentino"];
        else
          return ['Sphinx', 'Persian'];
      }
      logger.d(
          "Making GET request to /pet/breeds,with queryParams: petId: ${type.toUpperCase()}, and access token: $accessToken");
      final response = await Dio().get(
        url + "/pet/breeds",
        queryParameters: {
          "petType": type.toUpperCase(),
        },
        options: Options(
          headers: {"Authorization": accessToken},
        ),
      );
      if (debug) print(response);

      return Breeds.fromJson(response.data).breedsArray;
    } on DioError catch (e) {
      logger.e(e);
      handleError(e);
    }
  }

  // List of blood Groups of cats and dogs
  Future<List<String>> getBloodGroupsList(
      String type, String accessToken) async {
    try {
      if (type == null || type == '') type = 'DOG';
      if (debug && debugAPi) {
        print("returning");
        if (type.toUpperCase() == 'DOG')
          return ["DAE 1.1", "DAE 1.2"];
        else
          return ['DAE 1.1', 'DAE 2'];
      }
      logger.d(
          "Making GET request to /pet/bloodgroups,with queryParams: petId: ${type.toUpperCase()}, and access token: $accessToken");
      final response = await Dio().get(
        url + "/pet/bloodgroups",
        queryParameters: {
          "petType": type.toUpperCase(),
        },
        options: Options(
          headers: {"Authorization": accessToken},
        ),
      );
      print(response);

      return BloodGroups.fromJson(response.data).bloodGroupsArray;
    } on DioError catch (e) {
      logger.e(e);
      handleError(e);
    }
  }

  Future<PetIdAndMessage> intialPetProfileRegistration(
    int phoneNumber,
    String petType,
    String breed,
    DateTime birthday,
    String gender,
    File image,
    String petFirstName,
    String petLastName,
    String weight,
    String bloodGroup,
    String accessToken,
  ) async {
    String fileName = image.path.split("/").last;
    FormData formData = new FormData.fromMap({
      "verificationImage": await MultipartFile.fromFile(
        image.path,
        filename: fileName,
      ),
    });

    final obj = {
      'phoneNumber': phoneNumber.toString(),
      'petProfile': {
        'firstName': petFirstName,
        'lastName': petLastName,
        'petType': petType,
        'breed': breed,
        'birthday': birthday.millisecondsSinceEpoch,
        'gender': gender,
        'weight': weight,
        'bloodGroup': bloodGroup
      },
    };
    try {
      if (debug && debugAPi) {
        print("returning");
        return PetIdAndMessage(
            petId: "petId1234",
            message: "Created the pet Profile Successfully!");
      }
      logger.d(
          "Sending POST request: url/pet/create, with data: $obj, and options: $options , accessToken: $accessToken");
      final response = await Dio().post(
        url + "/pet/create",
        data: obj,
        options: Options(
          headers: {"Authorization": accessToken},
        ),
      );
      print(response.data);
      return PetIdAndMessage.fromJson(response.data);
    } on DioError catch (e) {
      logger.e(e);
      handleError(e);
    }
  }

//getting dummy news api for testing bloc
  Future<PetRecordsAndNotes> getPetRecordsAndNotes(
      String petId, String accessToken) async {
    try {
      if (debug && debugAPi) {
        List<Picture> pictures = [
          Picture(
              thumbnail: thumbnail,
              url:
                  "https://i.pinimg.com/474x/49/78/e8/4978e8faed9b7b3ff1e7a76d9533291f.jpg",
              date: DateTime.now(),
              age: 10),
          Picture(
              thumbnail: thumbnail,
              url:
                  "https://i.pinimg.com/474x/49/78/e8/4978e8faed9b7b3ff1e7a76d9533291f.jpg",
              date: DateTime.now(),
              age: 20),
          Picture(
              thumbnail: thumbnail,
              url:
                  "https://i.pinimg.com/474x/49/78/e8/4978e8faed9b7b3ff1e7a76d9533291f.jpg",
              date: DateTime.now(),
              age: 30),
        ];

        List<Measurement> measurements = [
          Measurement(
              height: 95, weight: 10, age: 09, timestamp: DateTime.now()),
          Measurement(
              height: 95, weight: 20, age: 15, timestamp: DateTime.now()),
          Measurement(
              height: 95, weight: 10, age: 75, timestamp: DateTime.now()),
          Measurement(
              height: 95, weight: 20, age: 65, timestamp: DateTime.now()),
        ];
        VaccinationForStatus vaccinations = VaccinationForStatus(
          completedVaccination: [
            Vaccination(
                date: DateTime.now(),
                name: "DPT",
                status: "completed",
                req: true,
                age: 12,
                description: "Description"),
            Vaccination(
                date: DateTime.now(),
                name: "Parvo",
                status: "completed",
                req: true,
                age: 12,
                description: "Description"),
          ],
          pendingVaccination: [
            Vaccination(
                date: DateTime.now(),
                name: "DPT2",
                status: "pending",
                req: true,
                age: 16,
                description: "Description"),
            Vaccination(
                date: DateTime.now(),
                name: "Parvo2",
                status: "pending",
                req: true,
                age: 16,
                description: "Description"),
          ],
          upcomingVaccination: [
            Vaccination(
                date: DateTime.now(),
                name: "DPT3",
                status: "upcoming",
                req: true,
                age: 123,
                description: "Description"),
            Vaccination(
                date: DateTime.now(),
                name: "Parvo3",
                status: "upcoming",
                req: true,
                age: 123,
                description: "Description"),
          ],
        );
        DewormingForStatus dewormings = DewormingForStatus(
          completedDeworming: [
            Deworming(date: DateTime.now(), age: 45, status: "completed"),
            Deworming(date: DateTime.now(), age: 30, status: "completed"),
          ],
          pendingDeworming: [
            Deworming(date: DateTime.now(), age: 60, status: "pending"),
            Deworming(date: DateTime.now(), age: 75, status: "pending"),
          ],
          upcomingDeworming: [
            Deworming(date: DateTime.now(), age: 90, status: "upcoming"),
            Deworming(date: DateTime.now(), age: 105, status: "upcoming"),
          ],
        );
        return PetRecordsAndNotes(
            pictures: pictures,
            measurements: measurements,
            vaccinations: vaccinations,
            dewormings: dewormings,
            notes: "Hello There, Dummy Note!");
      }

      logger.d(
          "Making GET request to /pet/bloodgroups,with queryParams: petId: ${LocalDb.userPetId} and access token: $accessToken");
      final response = await Dio().get(
        url + "/pet/records",
        queryParameters: {
          "petId": LocalDb.userPetId,
        },
        options: Options(
          headers: {"Authorization": accessToken},
        ),
      );
      print("pet records:" + response.data["result"].toString());

      return PetRecordsAndNotes.fromJson(response.data["result"]);
    } on DioError catch (e) {
      logger.e(e);
      // handleError(e);
      print(e);
    }
  }

//getting dummy news api for testing bloc
  Future<TopicsData> getTopicsData(String petId, String accessToken) async {
    try {
      if (debug) {
        List<TopicData> topicsData = [
          TopicData(
              imageUrl:
                  "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no",
              thumbnail:
                  "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no",
              title: "news 1"),
          TopicData(
              imageUrl:
                  "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no",
              thumbnail:
                  "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no",
              title: "news 2"),
          TopicData(
              imageUrl:
                  "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no",
              thumbnail:
                  "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no",
              title: "news 3"),
          TopicData(
              imageUrl:
                  "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no",
              thumbnail:
                  "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no",
              title: "news 4"),
        ];
        return TopicsData(topics: topicsData);
      }
      logger.d(
          "Making GET Request: /pet/topicsData, queryParams: petId: ${LocalDb.userPetId}, and Options: headers: {Authorization: $accessToken}, ");
      final response = await Dio().get(
        url + "/pet/topicsData",
        queryParameters: {
          "petId": LocalDb.userPetId,
        },
        options: Options(
          headers: {"Authorization": accessToken},
        ),
      );

      return TopicsData.fromJson(response.data);
    } on DioError catch (e) {
      logger.e(e);
      handleError(e);
    }
  }

  Future getNotification(int phoneNumber) async {
    try {
      logger.d("Making GET Request: /user/notification/$phoneNumber");
      final response = await Dio().get("/user/notification/$phoneNumber");
      print("notification:" + response.data);
    } on DioError catch (e) {
      logger.e(e);
      handleError(e);
    }
  }

  Future createNotification(int phoneNumber) async {
    try {
      logger.d("Making GET Request: /user/notification/$phoneNumber");
      final response = await Dio().get("/user/notification/$phoneNumber");
      print("notification:" + response.data);
    } on DioError catch (e) {
      logger.e(e);
      handleError(e);
    }
  }

  Future getAPetWithId() async {
    try {
      logger.d(
          "Making GET request: url/pet/get with queryParams: petId: ${LocalDb.userPetId}");

      final response = await Dio().get(
        "/pet/get",
        queryParameters: {
          "petId": LocalDb.userPetId,
        },
      );
      print("get a pet with id:" + response.data);
    } on DioError catch (e) {
      logger.e(e);
      handleError(e);
    }
  }

//**************************************** FOOD APIS ***********************//
//food items list
// suggested food items
// user food items
// required nutritional value

  Future<FoodData> getFoodData() async {
    try {
      if (debug) {
        List<Food> foods = [
          Food(name: "Rice", multiplier: 3, quantity: 100, unit: "g"),
          Food(name: "Milk", multiplier: 2, quantity: 100, unit: "ml"),
          Food(name: "Cabbage", multiplier: 2, quantity: 50, unit: "g"),
          Food(name: "Pizza", multiplier: 3, quantity: 100, unit: "g"),
          Food(name: "Cheese", multiplier: 2, quantity: 100, unit: "ml"),
        ];

        return FoodData(foods: foods);
      }
      logger.d("Making GET request: url/food");

      final response = await Dio().get(
        url + "/food/",
      );
      return FoodData.fromJson(response.data);
    } on DioError catch (e) {
      logger.e(e);
      handleError(e);
    }
  }

  Future<FoodData> getSuggestedFoodData() async {
    try {
      if (debug) {
        List<Food> foods = [
          Food(name: "Rice", multiplier: 3, quantity: 100, unit: "g"),
          Food(name: "Milk", multiplier: 2, quantity: 100, unit: "ml"),
          Food(name: "Cabbage", multiplier: 2, quantity: 50, unit: "g"),
        ];

        return FoodData(foods: foods);
      }

      logger.d("Making GET request: url/foods");

      final response = await Dio().get(
        url + "/food/",
      );
      return FoodData.fromJson(response.data);
    } on DioError catch (e) {
      logger.e(e);
      handleError(e);
    }
  }

// Future<FoodData> getAllFoodData() async {
//   try{
//     if(debug){
//       List<Food> foods = [
//           Food(name: "Rice",multiplier: 3,quantity: 100,unit: "g"),
//           Food(name: "Milk",multiplier: 2,quantity: 100,unit: "ml"),
//           Food(name: "Cabbage",multiplier: 2,quantity: 50,unit: "g"),
//         ];

//         return FoodData(foods: foods);
//     }
//     final response = await Dio().get(
//         url + "/food/",
//       );
//       return FoodData.fromJson(response.data);
//     } on DioError catch (e) {
//       handleError(e);
//   }
// }

  Future<List<String>> getAllFoodList(String parameter) async {
    try {
      if (debug) {
        return [
          "Biscuits",
          "Milk",
          "Pedigree",
          "Dog Biscuit",
        ];
      }
      logger.d("Making GET request: url/pet/foods");
      final response = await Dio().get(
        url + "/pet/foods",
      );
      print(response);
    } on DioError catch (e) {
      logger.e(e);
      handleError(e);
    }
  }

  Future<RefillFood> getRefillTracker() async {
    try {
      if (debug) {
        return RefillFood(
            date: DateTime.now(),
            daysLeft: 18,
            foodName: "Pedigree",
            packSize: 10,
            multiplier: 3,
            quantity: 10);
      }
      logger.d("Making GET request: url/daysleft");
      final response = await Dio().get(
        url + "/daysleft",
      );
      logger.i(response);
      return RefillFood.fromJson(response.data);
    } on DioError catch (e) {
      logger.e(e);
      handleError(e);
    }
  }

  Future postCurrentDietOfAPet(Food food, String petId) async {
    logger.d("Sending POST request: url/pet/diet/update, with data: $food ");
    final response = await Dio().post(
      "/pet/diet/update",
      data: {food}, //add petId here
    );
    print(response.data);
  }

  Future getIdealDietOfAPetAsPerAge(String breed) async {
    try {
      logger.d("Making GET request to url/ideal/$breed ");

      final response = await Dio().get("/ideal/$breed");
      logger.i(response);
      return FoodData.fromJson(response.data);
    } on DioError catch (e) {
      logger.e(e);
      handleError(e);
    }
  }

  Future getCurrentDietOfAPetAsPerAge(String petId) async {
    try {
      logger.d(
          "Making GET request to /pet/diet/current queryParams:{petId: $petId}");

      final response = await Dio().get("/pet/diet/current", queryParameters: {
        "petId": petId,
      });
      print(response.data);
      logger.i(response);
      return FoodData.fromJson(response.data);
    } on DioError catch (e) {
      logger.e(e);
      handleError(e);
    }
  }

  Future getAllFoodItemsWithNutrients() async {
    try {
      logger.d("Making GET request to url/nutrient");
      final response = await Dio().get("/nutrient");
      logger.i(response);
      // print(response.data);
      return FoodData.fromJson(response.data);
    } on DioError catch (e) {
      logger.e(e);
      handleError(e);
    }
  }

  Future setRefillTracker(RefillFood refillFood) async {
    FormData formData = new FormData.fromMap({
      "daysLeft": refillFood.daysLeft,
      "date": refillFood.date,
      "foodName": refillFood.foodName,
      "multiplier": refillFood.multiplier,
      "packSize": refillFood.packSize,
      "quantity": refillFood.quantity,
    });

    try {
      logger.d(
          "Sending POST request: url/pet/refillTracker, with data: $refillFood");
      final response = await Dio().post(
        url + "/pet/refillTracker",
        data: refillFood,
      );
      logger.i(response);

      print(response);
    } on DioError catch (e) {
      logger.e(e);
      handleError(e);
    }
  }

  // Future<Services> getServicesLists() async {
  //   try {
  //     if (debug) {
  //       List<Service> groomers = [
  //         Service(
  //           address:
  //               "D1, Amaltash Marg, Block D, Sector 12, Noida, Uttar Pradesh 201301",
  //           name: "Groomers 1",
  //           rating: 3.5,
  //           numRatings: 53,
  //           phoneNumber: "09910664343",
  //           holiday: 0,
  //           timings: ["9am-9pm"],
  //           distance: 2.2,
  //           latitude: 88.023,
  //           longitude: 88.23,
  //           images: [
  //             "https://maps.gstatic.com/tactile/pane/default_geocode-1x.png"
  //           ],
  //           thumbnail: thumbnail,
  //         ),
  //         Service(
  //           address:
  //               "D1, Amaltash Marg, Block D, Sector 12, Noida, Uttar Pradesh 201301",
  //           name: "Groomers 2",
  //           rating: 3.5,
  //           numRatings: 53,
  //           phoneNumber: "09910664343",
  //           holiday: 0,
  //           timings: ["9am-9pm"],
  //           distance: 2.2,
  //           latitude: 88.023,
  //           longitude: 88.23,
  //           images: [
  //             "https://maps.gstatic.com/tactile/pane/default_geocode-1x.png"
  //           ],
  //           thumbnail: thumbnail,
  //         ),
  //       ];
  //       List<Service> boarders = [
  //         Service(
  //           address:
  //               "D1, Amaltash Marg, Block D, Sector 12, Noida, Uttar Pradesh 201301",
  //           name: "Boarders 2",
  //           rating: 3.5,
  //           numRatings: 53,
  //           phoneNumber: "09910664343",
  //           holiday: 0,
  //           timings: ["9am-9pm"],
  //           distance: 2.2,
  //           latitude: 88.023,
  //           longitude: 88.23,
  //           images: [
  //             "https://maps.gstatic.com/tactile/pane/default_geocode-1x.png"
  //           ],
  //           thumbnail: thumbnail,
  //         ),
  //         Service(
  //           address:
  //               "D1, Amaltash Marg, Block D, Sector 12, Noida, Uttar Pradesh 201301",
  //           name: "Boarders 2",
  //           rating: 3.5,
  //           numRatings: 53,
  //           phoneNumber: "09910664343",
  //           holiday: 0,
  //           timings: ["9am-9pm"],
  //           distance: 2.2,
  //           latitude: 88.023,
  //           longitude: 88.23,
  //           images: [
  //             "https://maps.gstatic.com/tactile/pane/default_geocode-1x.png"
  //           ],
  //           thumbnail: thumbnail,
  //         ),
  //       ];
  //       List<Service> trainers = [
  //         Service(
  //           address:
  //               "D1, Amaltash Marg, Block D, Sector 12, Noida, Uttar Pradesh 201301",
  //           name: "Trainers 1",
  //           rating: 3.5,
  //           numRatings: 53,
  //           phoneNumber: "09910664343",
  //           holiday: 0,
  //           timings: ["9am-9pm"],
  //           distance: 2.2,
  //           latitude: 88.023,
  //           longitude: 88.23,
  //           images: [
  //             "https://maps.gstatic.com/tactile/pane/default_geocode-1x.png"
  //           ],
  //           thumbnail: thumbnail,
  //         ),
  //         Service(
  //           address:
  //               "D1, Amaltash Marg, Block D, Sector 12, Noida, Uttar Pradesh 201301",
  //           name: "Trainers 2",
  //           rating: 3.5,
  //           numRatings: 53,
  //           phoneNumber: "09910664343",
  //           holiday: 0,
  //           timings: ["9am-9pm"],
  //           distance: 2.2,
  //           latitude: 88.023,
  //           longitude: 88.23,
  //           images: [
  //             "https://maps.gstatic.com/tactile/pane/default_geocode-1x.png"
  //           ],
  //           thumbnail: thumbnail,
  //         ),
  //       ];
  //       List<Service> vets = [
  //         Service(
  //           address:
  //               "D1, Amaltash Marg, Block D, Sector 12, Noida, Uttar Pradesh 201301",
  //           name: "Vets",
  //           rating: 3.5,
  //           numRatings: 53,
  //           phoneNumber: "09910664343",
  //           holiday: 0,
  //           timings: ["9am-9pm"],
  //           distance: 2.2,
  //           latitude: 88.023,
  //           longitude: 88.23,
  //           images: [
  //             "https://maps.gstatic.com/tactile/pane/default_geocode-1x.png"
  //           ],
  //           thumbnail: thumbnail,
  //         ),
  //         Service(
  //           address:
  //               "Plot 147, Pocket B, 6, C Block, Sector 8B, Sector 8, Rohini, New Delhi, Delhi 110085",
  //           name: "Doggy World",
  //           rating: 4.2,
  //           numRatings: 1074,
  //           phoneNumber: "9835230802",
  //           holiday: 2,
  //           timings: ["10am–2pm", "5–9pm"],
  //           distance: 4,
  //           latitude: 88.023,
  //           longitude: 88.23,
  //           images: [
  //             "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no",
  //             "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w529-h298-k-no",
  //             "https://lh5.googleusercontent.com/p/AF1QipNXfH08fDSKCv2jBnxjMvU5BITjVLzExR_BFQAj=w298-h298-k-no",
  //             "https://lh5.googleusercontent.com/p/AF1QipPf7UjCXf_tmE-iAIVUXjDiqmcLaf5KXK5ty_2a=w446-h298-k-no",
  //           ],
  //           thumbnail: thumbnail,
  //         ),
  //         Service(
  //           address:
  //               "Plot 147, Pocket B, 6, C Block, Sector 8B, Sect  or 8, Rohini, New Delhi, Delhi 110085",
  //           name: "Doggy World",
  //           rating: 4.2,
  //           numRatings: 1074,
  //           phoneNumber: "09811299059",
  //           holiday: 2,
  //           timings: ["10am–2pm", "5–9pm"],
  //           distance: 4,
  //           latitude: 88.023,
  //           longitude: 88.23,
  //           images: [
  //             "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no",
  //             "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w529-h298-k-no",
  //             "https://lh5.googleusercontent.com/p/AF1QipNXfH08fDSKCv2jBnxjMvU5BITjVLzExR_BFQAj=w298-h298-k-no",
  //             "https://lh5.googleusercontent.com/p/AF1QipPf7UjCXf_tmE-iAIVUXjDiqmcLaf5KXK5ty_2a=w446-h298-k-no",
  //           ],
  //           thumbnail: thumbnail,
  //         ),
  //         Service(
  //           address:
  //               "D1, Amaltash Marg, Block D, Sector 12, Noida, Uttar Pradesh 201301",
  //           name: "GoDogee Dog Boarding & Gromming Services in Noida & NCR",
  //           rating: 3.5,
  //           numRatings: 53,
  //           phoneNumber: "09910664343",
  //           holiday: 0,
  //           timings: ["9am-9pm"],
  //           distance: 2.2,
  //           latitude: 88.023,
  //           longitude: 88.23,
  //           images: [
  //             "https://maps.gstatic.com/tactile/pane/default_geocode-1x.png"
  //           ],
  //           thumbnail: thumbnail,
  //         ),
  //         Service(
  //           address:
  //               "D1, Amaltash Marg, Block D, Sector 12, Noida, Uttar Pradesh 201301",
  //           name: "GoDogee Dog Boarding & Gromming Services in Noida & NCR",
  //           rating: 3.5,
  //           numRatings: 53,
  //           phoneNumber: "09910664343",
  //           holiday: 0,
  //           timings: ["9am-9pm"],
  //           distance: 2.2,
  //           latitude: 88.023,
  //           longitude: 88.23,
  //           images: [
  //             "https://maps.gstatic.com/tactile/pane/default_geocode-1x.png"
  //           ],
  //           thumbnail: thumbnail,
  //         ),
  //       ];
  //       return Services(
  //           vets: vets,
  //           groomers: groomers,
  //           boarders: boarders,
  //           trainers: trainers);
  //     }
  //     final response = await Dio().get(
  //       url + "service/all",
  //     );
  //     return Services.fromJson(response.data);
  //   } on DioError catch (e) {
  //     handleError(e);
  //   }
  // }

  Future serviceSearch(String accessToken, String search, String serviceType,
      {int pageNumber}) async {
    int pageSize = 15;
    try {
      logger.d(
          "Making GET Request to url/service/search with queryParameters type: $serviceType, search: $search, pageNumber: $pageNumber, pageSize: $pageSize, and accessToken: $accessToken");

      Response response = await Dio().get(
        url + "/service/search",
        queryParameters: {
          'type': serviceType.toLowerCase(),
          'search': search,
          'pageNumber': pageNumber,
          'pageSize': pageSize
        },
        options: Options(
          headers: {"Authorization": accessToken},
        ),
      );
      logger.i(response);
      return {
        "services": List<Service>.from(response.data["result"]
                ["PaginatedResults"]
            .map((x) => Service.fromJson(x))),
        "count": response.data["result"]["totalCount"].length == 0
            ? 0
            : response.data["result"]["totalCount"][0]["count"],
      };
    } catch (e) {
      logger.e(e);
    }
  }

  Future getParticularServiceList(String serviceType, String accessToken,
      {bool sortByRating = false,
      int pageNumber,
      double longitude,
      double latitude}) async {
    print("access");
    print(accessToken);
    try {
      if (debug && false) {
        return [
          Service(
            address:
                "D1, Amaltash Marg, Block D, Sector 12, Noida, Uttar Pradesh 201301",
            name: "GoDogee Dog Boarding & Gromming Services in Noida & NCR",
            rating: 3.5,
            numRatings: 53,
            phoneNumber: "09910664343",
            holiday: 0,
            timings: {
              "0": ["0000", "2400", "0000", "2400"],
              "1": [],
              "2": [],
              "3": [],
              "4": ["0000", "2400"],
              "5": ["0000", "2400"],
              "6": ["0000", "2400"]
            },
            distance: 2.2,
            latitude: 88.023,
            longitude: 88.23,
            images: [
              "https://maps.gstatic.com/tactile/pane/default_geocode-1x.png"
            ],
          ),
          Service(
            address:
                "Plot 147, Pocket B, 6, C Block, Sector 8B, Sector 8, Rohini, New Delhi, Delhi 110085",
            name: "Doggy World",
            rating: 4.2,
            numRatings: 1074,
            phoneNumber: "09811299059",
            holiday: 2,
            timings: {
              "0": [],
              "1": ["0000", "2400"],
              "2": [],
              "3": ["0000", "2400"],
              "4": ["0000", "2400"],
              "5": ["0000", "2400"],
              "6": ["0000", "2400"]
            },
            distance: 4,
            latitude: 88.023,
            longitude: 88.23,
            images: [
              "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no",
              "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w529-h298-k-no",
              "https://lh5.googleusercontent.com/p/AF1QipNXfH08fDSKCv2jBnxjMvU5BITjVLzExR_BFQAj=w298-h298-k-no",
              "https://lh5.googleusercontent.com/p/AF1QipPf7UjCXf_tmE-iAIVUXjDiqmcLaf5KXK5ty_2a=w446-h298-k-no",
            ],
          ),
          Service(
            address:
                "Plot 147, Pocket B, 6, C Block, Sector 8B, Sector 8, Rohini, New Delhi, Delhi 110085",
            name: "Doggy World",
            rating: 4.2,
            numRatings: 1074,
            phoneNumber: "09811299059",
            holiday: 2,
            timings: {
              "0": ["0000", "2400"],
              "1": ["0000", "2400"],
              "2": [],
              "3": ["0000", "2400"],
              "4": ["0000", "2400"],
              "5": ["0000", "2400"],
              "6": ["0000", "2400"]
            },
            distance: 4,
            latitude: 88.023,
            longitude: 88.23,
            images: [
              "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no",
              "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w529-h298-k-no",
              "https://lh5.googleusercontent.com/p/AF1QipNXfH08fDSKCv2jBnxjMvU5BITjVLzExR_BFQAj=w298-h298-k-no",
              "https://lh5.googleusercontent.com/p/AF1QipPf7UjCXf_tmE-iAIVUXjDiqmcLaf5KXK5ty_2a=w446-h298-k-no",
            ],
          ),
          Service(
            address:
                "D1, Amaltash Marg, Block D, Sector 12, Noida, Uttar Pradesh 201301",
            name: "GoDogee Dog Boarding & Gromming Services in Noida & NCR",
            rating: 3.5,
            numRatings: 53,
            phoneNumber: "09910664343",
            holiday: 0,
            timings: {
              "0": ["0000", "2400"],
              "1": ["0000", "2400"],
              "2": ["0000", "2400"],
              "3": ["0000", "2400"],
              "4": ["0000", "2400"],
              "5": ["0000", "2400"],
              "6": ["0000", "2400"]
            },
            distance: 2.2,
            latitude: 88.023,
            longitude: 88.23,
            images: [
              "https://maps.gstatic.com/tactile/pane/default_geocode-1x.png"
            ],
          ),
          Service(
            address:
                "D1, Amaltash Marg, Block D, Sector 12, Noida, Uttar Pradesh 201301",
            name: "GoDogee Dog Boarding & Gromming Services in Noida & NCR",
            rating: 3.5,
            numRatings: 53,
            phoneNumber: "09910664343",
            holiday: 0,
            timings: {
              "0": ["0000", "2400"],
              "1": ["0000", "2400"],
              "2": ["0000", "2400"],
              "3": ["0000", "2400"],
              "4": ["0000", "2400"],
              "5": ["0000", "2400"],
              "6": ["0000", "2400"]
            },
            distance: 2.2,
            latitude: 88.023,
            longitude: 88.23,
            images: [
              "https://maps.gstatic.com/tactile/pane/default_geocode-1x.png"
            ],
          ),
          Service(
            address:
                "Plot 147, Pocket B, 6, C Block, Sector 8B, Sector 8, Rohini, New Delhi, Delhi 110085",
            name: "Doggy World",
            rating: 4.2,
            numRatings: 1074,
            phoneNumber: "09811299059",
            holiday: 2,
            timings: {
              "0": ["0000", "2400"],
              "1": ["0000", "2400"],
              "2": ["0000", "2400"],
              "3": ["0000", "2400"],
              "4": ["0000", "2400"],
              "5": ["0000", "2400"],
              "6": ["0000", "2400"]
            },
            distance: 4,
            latitude: 88.023,
            longitude: 88.23,
            images: [
              "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no",
              "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w529-h298-k-no",
              "https://lh5.googleusercontent.com/p/AF1QipNXfH08fDSKCv2jBnxjMvU5BITjVLzExR_BFQAj=w298-h298-k-no",
              "https://lh5.googleusercontent.com/p/AF1QipPf7UjCXf_tmE-iAIVUXjDiqmcLaf5KXK5ty_2a=w446-h298-k-no",
            ],
          ),
          Service(
            address:
                "Plot 147, Pocket B, 6, C Block, Sector 8B, Sector 8, Rohini, New Delhi, Delhi 110085",
            name: "Doggy World",
            rating: 4.2,
            numRatings: 1074,
            phoneNumber: "09811299059",
            holiday: 2,
            timings: {
              "0": ["0000", "2400"],
              "1": ["0000", "2400"],
              "2": ["0000", "2400"],
              "3": ["0000", "2400"],
              "4": ["0000", "2400"],
              "5": ["0000", "2400"],
              "6": ["0000", "2400"]
            },
            distance: 4,
            latitude: 88.023,
            longitude: 88.23,
            images: [
              "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no",
              "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w529-h298-k-no",
              "https://lh5.googleusercontent.com/p/AF1QipNXfH08fDSKCv2jBnxjMvU5BITjVLzExR_BFQAj=w298-h298-k-no",
              "https://lh5.googleusercontent.com/p/AF1QipPf7UjCXf_tmE-iAIVUXjDiqmcLaf5KXK5ty_2a=w446-h298-k-no",
            ],
          ),
        ];
      }
      logger.d(
          "Making GET request to url/service/get with queryParameters: serviceType: ${serviceType.toLowerCase()} , longitude: $longitude , latitude: $latitude , sortType: ${sortByRating ? 2 : 1}, pageSize: 15, pageNumber: ${pageNumber ?? 1}and options: header: {Authorization: $accessToken}");
      final response = await Dio().get(
        url + "/service/get",
        queryParameters: {
          "type": serviceType.toLowerCase(),
          "sortType": sortByRating ? 2 : 1,
          "pageNumber": pageNumber ?? 1,
          "pageSize": 15,
          "longitude": longitude,
          "latitude": latitude
        },
        options: Options(
          headers: {"Authorization": accessToken},
        ),
      );
      logger.i(response);
      logger.e(response.data["result"]["totalCount"][0]["count"]);
      //TODO: MAP
      return {
        "services": List<Service>.from(response.data["result"]
                ["PaginatedResults"]
            .map((x) => Service.fromJson(x))),
        "count": response.data["result"]["totalCount"].length == 0
            ? 0
            : response.data["result"]["totalCount"][0]["count"],
      };
    } on DioError catch (e) {
      logger.e(e);
      print("apppy" + e.message);
      handleError(e);
    }
  }

  Future<Message> savePicture(FilePicture filePicture) async {
    String fileName = filePicture.image.path.split("/").last;
    FormData formData = new FormData.fromMap({
      "petImage": await MultipartFile.fromFile(
        filePicture.image.path,
        filename: fileName,
      ),
      "date": filePicture.date,
    });
    try {
      logger.d("Sending POST request: url/pet/pictures, data: $formData");
      final response = await Dio().post(
        url + "/pet/pictures",
        data: formData,
      );
      logger.i(response);

      return Message.fromJson(response.data);
    } on DioError catch (e) {
      logger.e(e);
      handleError(e);
    }
  }

  Future<Message> saveVaccination(List<Map> vaccinations, String petId) async {
    var response;
    for (Map vaccination in vaccinations) {
      try {
        print(vaccination);
        if (!debug) {
          logger.d(
              "Making PUT Request to url/pet/vaccination/update with queryParams: petId: $petId, recordType:vaccination, and data: updateBody: { vaccination: ${vaccination["name"]}, status:${vaccination["status"]} }");
          response = await Dio()
              .put(url + "/pet/vaccination/update", queryParameters: {
            "petId": petId,
            "recordType": "vaccination"
          }, data: {
            "updateBody": {
              "vaccination": vaccination["name"],
              "status": vaccination["status"]
            }
          });
          print(response.data);
        }
      } on DioError catch (e) {
        logger.e(e);
        handleError(e);
      }
    }
    // return Message.fromJson(response.data);
  }

  Future<Message> saveDeworming(List<Map> dewormings, String petId) async {
    var response;
    for (Map deworming in dewormings) {
      try {
        print(deworming);
        if (!debug) {
          logger.d(
              "Making PUT Request to url/pet/deworming/update with queryParams: petId: $petId, recordType:deworming, and data: updateBody: {age: ${deworming["age"]}, status:${deworming["status"]} }");

          response =
              await Dio().put(url + "/pet/deworming/update", queryParameters: {
            "petId": petId,
            "recordType": "deworming"
          }, data: {
            "updateBody": {
              "age": deworming["age"],
              "status": deworming["status"]
            }
          });
          print(response.data);
        }
      } on DioError catch (e) {
        logger.e(e);
        handleError(e);
      }
    }
    // return Message.fromJson(response.data);
  }

  Future<Message> saveMeasurement(Map measurement, String petId) async {
    try {
      if (!debug) {
        logger.d(
            "Making PUT Request to url/pet/measurement/update with queryParams: petId: $petId, recordType:measurement, and data: updateBody: {weight: ${measurement["weight"]}, height:${measurement["height"]} }");
        var response =
            await Dio().put(url + "/pet/measurement/update", queryParameters: {
          "petId": petId,
          "recordType": "measurement"
        }, data: {
          "updateBody": {
            "weight": measurement["weight"],
            "height": measurement["height"]
          }
        });
        print(response.data);
      }
    } on DioError catch (e) {
      logger.e(e);
      handleError(e);
    }
  }

  Future<PetRegistrationModel> getPetRegistrationDetails() async {
    try {
      if (debug) {
        return PetRegistrationModel(
          breed: "German",
          city: "Gaya",
          email: "ujjwal@gmail",
          gender: "Male",
          house: "106 B",
          mobile: "9636461534",
          petName: "Dancing Doggo",
          phone: "1234567890",
          pinCode: "823001",
          state: "Bihar",
          street: "road 2",
          userName: "Ujjwal Kumar",
          status: "Not Registered",
          registrationId: "123456",
          userImage:
              "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no",
          thumbnail: thumbnail,
        );
      }
      logger.d("Making GET Request to url/pets/registration");

      final response = await Dio().get(url + "/pets/registration");

      logger.i(response);
      return PetRegistrationModel.fromJson(response.data);
    } catch (e) {
      logger.e(e);
    }
  }

  Future<String> savePetRegistrationDetails(PetRegistrationModel data) async {
    FormData formData = new FormData.fromMap({
      "breed": data.breed,
      "city": data.city,
      "email": data.email,
      "gender": data.gender,
      "house": data.house,
      "mobile": data.mobile,
      "petName": data.petName,
      "phone": data.phone,
      "state": data.state,
      "pinCode": data.pinCode,
      "street": data.street,
      "userName": data.userName,
      "image": data.image,
    });
    try {
      logger.d("Sending POST request: url/pet/registration, data: $formData");

      final response = await Dio().post(
        url + "/pet/registration",
        data: formData,
      );
      logger.i(response);

      return (response.data);
    } on DioError catch (e) {
      logger.e(e);
      handleError(e);
    }
  }

  Future<Insight> getInsightsDetails() async {
    Insight res = Insight(
      title: "Insight Detail",
      imageUrl:
          "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no",
      thumbnail: thumbnail,
      info: [
        {
          "text2":
              "Labradors are a lively and inquisitive breed, \nespecially during their first three years so you need to keep dangerous household items out of their reach. \nYou might even need to keep your Lab away from entire areas of your home and garden where access to dangerous objects can’t be easily controlled",
        },
      ],
      moreInsights: [
        {
          "title": "more list 1",
          "thumbnail": thumbnail,
        }
      ],
    );
  }

  Future<List<Insight>> getInsightsListsPagination() async {
    List<Insight> listInsights = [
      Insight(
        info: [
          {
            "text1": "1.1 Making Safe Your Home and Garden for Arya",
            "text2":
                "Labradors are a lively and inquisitive breed, \nespecially during their first three years so you need to keep dangerous household items out of their reach. \nYou might even need to keep your Lab away from entire areas of your home and garden where access to dangerous objects can’t be easily controlled",
          },
          {
            "text1": "1.2 Making Safe Your Home and Garden for Arya",
            "text2":
                "Since Labradors grow to be large, it's important that puppies aren't fed too energy-rich food so that they don't grow too quickly. The consequences of an energy oversupply are a heavier weight than foreseen and the development of unstable bones. As a result, they will not be able to withstand the traction of the muscles and the pressure caused by an increase in weight, which can lead to misaligned limbs.",
          },
          {
            "text1": "1.3 Making Safe Your Home and Garden for Arya",
            "text2":
                "Labradors are a lively and inquisitive breed, \nespecially during their first three years so you need to keep dangerous household items out of their reach. \nYou might even need to keep your Lab away from entire areas of your home and garden where access to dangerous objects can’t be easily controlled",
          },
          {
            "text1": "1.4 Making Safe Your Home and Garden for Arya",
            "text2":
                "Labradors are a lively and inquisitive breed, \nespecially during their first three years so you need to keep dangerous household items out of their reach. \nYou might even need to keep your Lab away from entire areas of your home and garden where access to dangerous objects can’t be easily controlled",
          },
        ],
        description:
            "doggydoggydoggydoggydoggydoggydoggydoggy Uttar Pradesh 201301",
        title: "doggy",
        imageUrl:
            "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no",
        thumbnail: thumbnail,
      ),
      Insight(
          info: [
            {
              "text1": "2.1 Making Safe Your Home and Garden for Arya",
              "text2":
                  "Labradors are a lively and inquisitive breed, \nespecially during their first three years so you need to keep dangerous household items out of their reach. \nYou might even need to keep your Lab away from entire areas of your home and garden where access to dangerous objects can’t be easily controlled",
            },
            {
              "text1": "2.2 Making Safe Your Home and Garden for Arya",
              "text2":
                  "Labradors are a lively and inquisitive breed, \nespecially during their first three years so you need to keep dangerous household items out of their reach. \nYou might even need to keep your Lab away from entire areas of your home and garden where access to dangerous objects can’t be easily controlled",
            },
            {
              "text1": "2.3 Making Safe Your Home and Garden for Arya",
              "text2":
                  "Labradors are a lively and inquisitive breed, \nespecially during their first three years so you need to keep dangerous household items out of their reach. \nYou might even need to keep your Lab away from entire areas of your home and garden where access to dangerous objects can’t be easily controlled",
            },
            {
              "text1": "2.4 Making Safe Your Home and Garden for Arya",
              "text2":
                  "Labradors are a lively and inquisitive breed, \nespecially during their first three years so you need to keep dangerous household items out of their reach. \nYou might even need to keep your Lab away from entire areas of your home and garden where access to dangerous objects can’t be easily controlled",
            },
          ],
          description: "kittykittykittykittykittykitty Uttar Pradesh 201301",
          title: "kitty",
          thumbnail: thumbnail,
          imageUrl:
              "https://maps.gstatic.com/tactile/pane/default_geocode-1x.png"),
      Insight(
        info: [
          {
            "text1": "Making Safe Your Home and Garden for Arya",
            "text2":
                "Labradors are a lively and inquisitive breed, \nespecially during their first three years so you need to keep dangerous household items out of their reach. \nYou might even need to keep your Lab away from entire areas of your home and garden where access to dangerous objects can’t be easily controlled",
          },
          {
            "text1": "Making Safe Your Home and Garden for Arya",
            "text2":
                "Labradors are a lively and inquisitive breed, \nespecially during their first three years so you need to keep dangerous household items out of their reach. \nYou might even need to keep your Lab away from entire areas of your home and garden where access to dangerous objects can’t be easily controlled",
          },
          {
            "text1": "Making Safe Your Home and Garden for Arya",
            "text2":
                "Labradors are a lively and inquisitive breed, \nespecially during their first three years so you need to keep dangerous household items out of their reach. \nYou might even need to keep your Lab away from entire areas of your home and garden where access to dangerous objects can’t be easily controlled",
          },
          {
            "text1": "Making Safe Your Home and Garden for Arya",
            "text2":
                "Labradors are a lively and inquisitive breed, \nespecially during their first three years so you need to keep dangerous household items out of their reach. \nYou might even need to keep your Lab away from entire areas of your home and garden where access to dangerous objects can’t be easily controlled",
          },
        ],
        description:
            "D1, Amaltash Marg, Block D, Sector 12, Noida, Uttar Pradesh 201301",
        title: "GoDogee Dog Boarding & Gromming Services in Noida & NCR",
        imageUrl:
            "https://maps.gstatic.com/tactile/pane/default_geocode-1x.png",
        thumbnail: thumbnail,
      ),
      Insight(
        info: [
          {
            "text1": "Making Safe Your Home and Garden for Arya",
            "text2":
                "Labradors are a lively and inquisitive breed, \nespecially during their first three years so you need to keep dangerous household items out of their reach. \nYou might even need to keep your Lab away from entire areas of your home and garden where access to dangerous objects can’t be easily controlled",
          },
          {
            "text1": "Making Safe Your Home and Garden for Arya",
            "text2":
                "Labradors are a lively and inquisitive breed, \nespecially during their first three years so you need to keep dangerous household items out of their reach. \nYou might even need to keep your Lab away from entire areas of your home and garden where access to dangerous objects can’t be easily controlled",
          },
          {
            "text1": "Making Safe Your Home and Garden for Arya",
            "text2":
                "Labradors are a lively and inquisitive breed, \nespecially during their first three years so you need to keep dangerous household items out of their reach. \nYou might even need to keep your Lab away from entire areas of your home and garden where access to dangerous objects can’t be easily controlled",
          },
          {
            "text1": "Making Safe Your Home and Garden for Arya",
            "text2":
                "Labradors are a lively and inquisitive breed, \nespecially during their first three years so you need to keep dangerous household items out of their reach. \nYou might even need to keep your Lab away from entire areas of your home and garden where access to dangerous objects can’t be easily controlled",
          },
        ],
        description:
            "D1, Amaltash Marg, Block D, Sector 12, Noida, Uttar Pradesh 201301",
        title: "GoDogee Dog Boarding & Gromming Services in Noida & NCR",
        imageUrl:
            "https://maps.gstatic.com/tactile/pane/default_geocode-1x.png",
        thumbnail: thumbnail,
      ),
    ];
    return listInsights;
  }

  Future<Insights> getInsightsLists() async {
    try {
      if (debug) {
        List<Insight> listInsights = [
          Insight(
            info: [
              {
                // "text1": "1.1 Making Safe Your Home and Garden for Arya",
                "text2":
                    "Since Labradors grow to be large, it's important that puppies aren't fed too energy-rich food so that they don't grow too quickly. The consequences of an energy oversupply are a heavier weight than foreseen and the development of unstable bones. As a result, they will not be able to withstand the traction of the muscles and the pressure caused by an increase in weight, which can lead to misaligned limbs.",
              },
              {
                // "text1": "1.2 Making Safe Your Home and Garden for Arya",
                "text2":
                    "Labradors are a lively and inquisitive breed, \nespecially during their first three years so you need to keep dangerous household items out of their reach. \nYou might even need to keep your Lab away from entire areas of your home and garden where access to dangerous objects can’t be easily controlled",
              },
              {
                // "text1": "1.3 Making Safe Your Home and Garden for Arya",
                "text2":
                    "Labradors are a lively and inquisitive breed, \nespecially during their first three years so you need to keep dangerous household items out of their reach. \nYou might even need to keep your Lab away from entire areas of your home and garden where access to dangerous objects can’t be easily controlled",
              },
              {
                // "text1": "1.4 Making Safe Your Home and Garden for Arya",
                "text2":
                    "Labradors are a lively and inquisitive breed, \nespecially during their first three years so you need to keep dangerous household items out of their reach. \nYou might even need to keep your Lab away from entire areas of your home and garden where access to dangerous objects can’t be easily controlled",
              },
            ],
            description:
                "doggydoggydoggydoggydoggydoggydoggydoggy Uttar Pradesh 201301",
            title: "Making Safe Your Home and Garden for Arya",
            imageUrl:
                "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no",
            thumbnail: thumbnail,
          ),
          Insight(
              info: [
                {
                  // "text1": "2.1 Making Safe Your Home and Garden for Arya",
                  "text2":
                      "Labradors are a lively and inquisitive breed, \nespecially during their first three years so you need to keep dangerous household items out of their reach. \nYou might even need to keep your Lab away from entire areas of your home and garden where access to dangerous objects can’t be easily controlled",
                },
                {
                  // "text1": "2.2 Making Safe Your Home and Garden for Arya",
                  "text2":
                      "Labradors are a lively and inquisitive breed, \nespecially during their first three years so you need to keep dangerous household items out of their reach. \nYou might even need to keep your Lab away from entire areas of your home and garden where access to dangerous objects can’t be easily controlled",
                },
                {
                  // "text1": "2.3 Making Safe Your Home and Garden for Arya",
                  "text2":
                      "Labradors are a lively and inquisitive breed, \nespecially during their first three years so you need to keep dangerous household items out of their reach. \nYou might even need to keep your Lab away from entire areas of your home and garden where access to dangerous objects can’t be easily controlled",
                },
                {
                  // "text1": "2.4 Making Safe Your Home and Garden for Arya",
                  "text2":
                      "Labradors are a lively and inquisitive breed, \nespecially during their first three years so you need to keep dangerous household items out of their reach. \nYou might even need to keep your Lab away from entire areas of your home and garden where access to dangerous objects can’t be easily controlled",
                },
              ],
              description:
                  "kittykittykittykittykittykitty Uttar Pradesh 201301",
              title: "kitty",
              thumbnail: thumbnail,
              imageUrl:
                  "https://maps.gstatic.com/tactile/pane/default_geocode-1x.png"),
          Insight(
            info: [
              {
                "text1": "Making Safe Your Home and Garden for Arya",
                "text2":
                    "Labradors are a lively and inquisitive breed, \nespecially during their first three years so you need to keep dangerous household items out of their reach. \nYou might even need to keep your Lab away from entire areas of your home and garden where access to dangerous objects can’t be easily controlled",
              },
              {
                "text1": "Making Safe Your Home and Garden for Arya",
                "text2":
                    "Labradors are a lively and inquisitive breed, \nespecially during their first three years so you need to keep dangerous household items out of their reach. \nYou might even need to keep your Lab away from entire areas of your home and garden where access to dangerous objects can’t be easily controlled",
              },
              {
                "text1": "Making Safe Your Home and Garden for Arya",
                "text2":
                    "Labradors are a lively and inquisitive breed, \nespecially during their first three years so you need to keep dangerous household items out of their reach. \nYou might even need to keep your Lab away from entire areas of your home and garden where access to dangerous objects can’t be easily controlled",
              },
              {
                "text1": "Making Safe Your Home and Garden for Arya",
                "text2":
                    "Labradors are a lively and inquisitive breed, \nespecially during their first three years so you need to keep dangerous household items out of their reach. \nYou might even need to keep your Lab away from entire areas of your home and garden where access to dangerous objects can’t be easily controlled",
              },
            ],
            description:
                "D1, Amaltash Marg, Block D, Sector 12, Noida, Uttar Pradesh 201301",
            title: "GoDogee Dog Boarding & Gromming Services in Noida & NCR",
            imageUrl:
                "https://maps.gstatic.com/tactile/pane/default_geocode-1x.png",
            thumbnail: thumbnail,
          ),
          Insight(
            info: [
              {
                "text1": "Making Safe Your Home and Garden for Arya",
                "text2":
                    "Labradors are a lively and inquisitive breed, \nespecially during their first three years so you need to keep dangerous household items out of their reach. \nYou might even need to keep your Lab away from entire areas of your home and garden where access to dangerous objects can’t be easily controlled",
              },
              {
                "text1": "Making Safe Your Home and Garden for Arya",
                "text2":
                    "Labradors are a lively and inquisitive breed, \nespecially during their first three years so you need to keep dangerous household items out of their reach. \nYou might even need to keep your Lab away from entire areas of your home and garden where access to dangerous objects can’t be easily controlled",
              },
              {
                "text1": "Making Safe Your Home and Garden for Arya",
                "text2":
                    "Labradors are a lively and inquisitive breed, \nespecially during their first three years so you need to keep dangerous household items out of their reach. \nYou might even need to keep your Lab away from entire areas of your home and garden where access to dangerous objects can’t be easily controlled",
              },
              {
                "text1": "Making Safe Your Home and Garden for Arya",
                "text2":
                    "Labradors are a lively and inquisitive breed, \nespecially during their first three years so you need to keep dangerous household items out of their reach. \nYou might even need to keep your Lab away from entire areas of your home and garden where access to dangerous objects can’t be easily controlled",
              },
            ],
            description:
                "D1, Amaltash Marg, Block D, Sector 12, Noida, Uttar Pradesh 201301",
            title: "GoDogee Dog Boarding & Gromming Services in Noida & NCR",
            imageUrl:
                "https://maps.gstatic.com/tactile/pane/default_geocode-1x.png",
            thumbnail: thumbnail,
          ),
        ];

        return Insights(
            foodsInsights: listInsights,
            healthInsights: listInsights,
            lifestyleInsights: listInsights);
      }
      logger.d("Making GET Request to url/services");

      final response = await Dio().get(
        url + "/services",
      );
      logger.i(response);

      return Insights.fromJson(response.data);
    } on DioError catch (e) {
      logger.e(e);
      handleError(e);
    }
  }

  Future<ShopData> getShopItems() async {
    try {
      if (debug) {
        List<ShopItem> shopItems = [
          ShopItem(
            imageUrl:
                "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no",
            price: 222,
            quantity: 1,
            title: "Wild earth clean Protein",
            thumbnail: thumbnail,
          ),
          ShopItem(
            imageUrl:
                "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no",
            price: 1500,
            quantity: 1,
            title: "Royal Canon Maxi",
            thumbnail: thumbnail,
          ),
          ShopItem(
            imageUrl:
                "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no",
            price: 104,
            quantity: 1,
            title: "Biscuits",
            thumbnail: thumbnail,
          ),
          ShopItem(
            imageUrl:
                "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no",
            price: 200.12,
            quantity: 1,
            title: "Water",
            thumbnail: thumbnail,
          ),
        ];
        return ShopData(shopItems: shopItems);
      }
      logger.d("Making GET Request to url/store");

      final response = await Dio().get(url + "/store");
      logger.i(response);
      return ShopData.fromJson(response.data);
    } on DioError catch (e) {
      logger.e(e);
      handleError(e);
    }
  }

  Future addtoCart(int phoneNumber, int bundleId) async {
    try {
      logger.d(
          "Making PUT Request to url/put/store/$phoneNumber/cart/$bundleId with queryParams: action: add");
      final response = await Dio()
          .put(url + 'put/store/$phoneNumber/cart/$bundleId', queryParameters: {
        'action': 'add',
      });
      logger.i(response);

      print(response.data);
    } on DioError catch (e) {
      logger.e(e);
      handleError(e);
    }
  }

  Future removeFromCart(int phoneNumber, int bundleId) async {
    try {
      logger.d(
          "Making PUT Request to url/put/store/$phoneNumber/cart/$bundleId with queryParams: action: delete");
      final response = await Dio()
          .put(url + 'put/store/$phoneNumber/cart/$bundleId', queryParameters: {
        'action': 'delete',
      });
      logger.i(response);

      print(response.data);
    } on DioError catch (e) {
      logger.e(e);
      handleError(e);
    }
  }

  Future addToWishList(int phoneNumber, int bundleId) async {
    try {
      logger.d(
          "Making PUT Request to url/put/store/$phoneNumber/wishlist/$bundleId with queryParams: action: add");
      final response = await Dio().put(
          url + 'put/store/$phoneNumber/wishlist/$bundleId',
          queryParameters: {
            "action": "add",
          });
      logger.i(response);

      print(response.data);
    } on DioError catch (e) {
      logger.e(e);
      handleError(e);
    }
  }

  Future removeFromWishList(int phoneNumber, int bundleId) async {
    try {
      logger.d(
          "Making PUT Request to url/put/store/$phoneNumber/wishlist/$bundleId with queryParams: action: remove");
      final response = await Dio().put(
          url + 'put/store/$phoneNumber/wishlist/$bundleId',
          queryParameters: {
            "action": "remove",
          });
      logger.i(response);

      print(response.data);
    } on DioError catch (e) {
      logger.e(e);
      handleError(e);
    }
  }

  Future<ShopData> getCartItems() async {
    try {
      if (debug) {
        List<ShopItem> shopItems = [
          ShopItem(
            imageUrl:
                "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no",
            price: 222,
            quantity: 10,
            title: "Wild earth clean Protein",
            thumbnail: thumbnail,
          ),
          ShopItem(
            imageUrl:
                "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no",
            price: 1500,
            quantity: 10,
            title: "Royal Canon Maxi",
            thumbnail: thumbnail,
          ),
          ShopItem(
            imageUrl:
                "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no",
            price: 104,
            quantity: 10,
            title: "Biscuits",
            thumbnail: thumbnail,
          ),
          ShopItem(
            imageUrl:
                "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no",
            price: 200.12,
            quantity: 10,
            title: "Water",
            thumbnail: thumbnail,
          ),
        ];
        return ShopData(shopItems: shopItems);
      }
      logger.d("Making GET Request to url/shop");

      final response = await Dio().get(url + "/shop");
      logger.i(response);
      return ShopData.fromJson(response.data);
    } on DioError catch (e) {
      logger.e(e);
      handleError(e);
    }
  }

  //petProfileApi
  Future<PetProfileModel> getPetProfileApi(String phoneNumber) async {
    try {
      if (debug) {
        return PetProfileModel(
          name: "Arya or Ayan",
          type: "Cat or Dog",
          breed: "Indie Mau or GSD",
          birthday: "02/02/2019",
          gender: "Male",
          image: Picture(
            date: DateTime.now(),
            url:
                "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no",
            thumbnail: thumbnail,
          ),
          weight: "2.2",
          bloodGroup: "DAE 1.1",
          images: [
            Picture(
                date: DateTime.now(),
                url:
                    "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no"),
            Picture(
                date: DateTime.now(),
                url:
                    "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no"),
            Picture(
                date: DateTime.now(),
                url:
                    "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no")
          ],
          registrationId: "2DL45F",
          appearance: "Sexy",
          likings: "Salmon yummy",
          dislikings: "I dont like bathing",
          bodyMarks: "Mole on lower lip",
          friendliness: "Friendly with people but not other pets",
          enregyLevel: "High on Food",
          favoured: "Favoring Wool Balls",
          measurement: Measurement(height: 120, weight: 6),
          medicalHistory:
              "I was wounded many times in the battle Royal Street Fights.",
          hereditary: "No Disease has been diagnosed",
          training: "Little trained",
          height: "110",
          allergies: "No allergie figured out yet. Very adaptime..I am",
          documents: DocumentsModel(certifications: [
            Picture(
                date: DateTime.now(),
                url:
                    "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no"),
            Picture(
                date: DateTime.now(),
                url:
                    "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no"),
          ], medicalPrescriptions: [
            Picture(
                date: DateTime.now(),
                url:
                    "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no")
          ], registrationDocuments: [
            Picture(
                date: DateTime.now(),
                url:
                    "https://lh5.googleusercontent.com/p/AF1QipPrGxXpGzVO4w45udBuZjI9EzIma7ePz_1OlwrN=w426-h240-k-no"),
          ]),
        );
      }
      logger.d("Making GET Request to url/petProfile/$phoneNumber");
      final response = await Dio().get(
        url + "/petProfile/$phoneNumber",
      );
      logger.i(response);
      return PetProfileModel.fromJson(response.data);
    } on DioError catch (error) {
      logger.e(error.error);
      handleError(error);
    }
  }

  // // Check Email
  // Future<Message> checkEmail(String email) async {
  //   try {
  //     final response = await Dio().post(
  //       url + "/registration/emailCheck",
  //       queryParameters: {
  //         "email": email,
  //       },
  //     );
  //     print(response);

  //     return Message.fromJson(response.data);
  //   } on DioError catch (e) {
  //     handleError(e);
  //   }
  // }

  // // Email Registration
  // Future<Registration> emailRegistration(
  //   String email,
  //   String name,
  //   String password,
  // ) async {
  //   try {
  //     final response = await _dio.post(url + "/registration", queryParameters: {
  //       "email": email,
  //       "name": name,
  //       "password": password,
  //     });
  //     print(response);

  //     return Registration.fromJson(response.data);
  //   } on DioError catch (e) {
  //     handleError(e);
  //   }
  // }

  // Mobile Registration
  // Future<Registration> mobileRegistration(
  //   String mobile,
  //   String name,
  //   String password,
  //   String email,
  //   File image,
  //   bool useImageForProfile,
  // ) async {
  //   String fileName = image.path.split("/").last;
  //   FormData formData = new FormData.fromMap({
  //     "verificationImage": await MultipartFile.fromFile(
  //       image.path,
  //       filename: fileName,
  //     ),
  //   });

  //   try {
  //     final response = await Dio().post(
  //       url + "/registration",
  //       queryParameters: {
  //         "mobile": mobile,
  //         "name": name,
  //         "password": password,
  //         "email": email == null ? "" : email,
  //         "useImageForProfile": useImageForProfile,
  //       },
  //       data: formData,
  //     );
  //     print(response);

  //     return Registration.fromJson(response.data);
  //   } on DioError catch (e) {
  //     print(e.response.statusCode);
  //     handleError(e);
  //   }
  // }

  // // // Email Login
  // Future<Registration> emailLogin(
  //   String email,
  //   String password,
  // ) async {
  //   try {
  //     final response = await Dio().post(url + "/login", queryParameters: {
  //       "id": email,
  //       "password": password,
  //     });
  //     print(response);

  //     return Registration.fromJson(response.data);
  //   } on DioError catch (e) {
  //     handleError(e);
  //   }
  // }

  // // Mobile Login
  // Future<Registration> mobileLogin(
  //   String mobile,
  //   String password,
  // ) async {
  //   try {
  //     final response = await Dio().post(url + "/login", queryParameters: {
  //       "id": mobile,
  //       "password": password,
  //     });
  //     print(response);

  //     return Registration.fromJson(response.data);
  //   } on DioError catch (e) {
  //     handleError(e);
  //   }
  // }

  // // Logout access
  // Future<LogoutAccess> logoutAccess(String accessToken) async {
  //   try {
  //     final response = await _dio.post(url + "/logout/access",
  //         options:
  //             Options(headers: {"Authorization": accessToken}));
  //     print(response);

  //     return LogoutAccess.fromJson(response.data);
  //   } on DioError catch (e) {
  //     handleError(e);
  //   }
  // }

  // // Logout refresh token
  // Future<LogoutAccess> logoutRefreshAccess(String refreshToken) async {
  //   try {
  //     final response = await _dio.post(url + "/logout/refresh",
  //         options:
  //             Options(headers: {"Authorization": refreshToken}));
  //     print(response);

  //     return LogoutAccess.fromJson(response.data);
  //   } on DioError catch (e) {
  //     handleError(e);
  //   }
  // }

  // // get group categories
  // Future<List> getGroupCategories(String group, String accessToken) async {
  //   try {
  //     final response = await _dio.get(url + "/group/categories",
  //         options: Options(headers: {"Authorization": accessToken}),
  //         queryParameters: {
  //           "group": group,
  //         });
  //     print(response);

  //     return List.castFrom(response.data);
  //   } on DioError catch (e) {
  //     handleError(e);
  //   }
  // }

  // // get category tags
  // Future<List> getCategoryTags(
  //     String category, String group, String accessToken) async {
  //   try {
  //     final response = await Dio().get(url + "/category/tags",
  //         options: Options(headers: {"Authorization": accessToken}),
  //         queryParameters: {
  //           "category": category,
  //           "group": group,
  //         });
  //     print(response);

  //     return List.castFrom(response.data);
  //   } on DioError catch (e) {
  //     handleError(e);
  //   }
  // }

  // // add user category
  // Future<AddUserCategories> adduserCategory(
  //     String category, String group, String accessToken, Map tags) async {
  //   try {
  //     final response = await Dio().post(url + "/user/category/add",
  //         options: Options(
  //           headers: {"Authorization": accessToken},
  //         ),
  //         data: {
  //           "group": group,
  //           "category": category,
  //           "enabled": true,
  //           "visible": true,
  //           "mainCategory": true,
  //           "tags": tags,
  //         });
  //     print(response);

  //     return AddUserCategories.fromJson(response.data);
  //   } on DioError catch (e) {
  //     handleError(e);
  //   }
  // }

  // // get tag values
  // Future<List> getTagValue(String accessToken, String tag) async {
  //   try {
  //     final response = await Dio().get(
  //       url + "/tag/getValues",
  //       queryParameters: {
  //         "tag": tag,
  //       },
  //       options: Options(
  //         headers: {"Authorization": accessToken},
  //       ),
  //     );

  //     print(response);
  //     return List.castFrom(response.data);
  //   } on DioError catch (e) {
  //     handleError(e);
  //   }
  // }

  // // get user Data
  // Future<UserData> getUserData(String accessToken, String userId) async {
  //   try {
  //     final response = await Dio().get(
  //       url + "/user/data",
  //       queryParameters: {
  //         "userId": userId,
  //       },
  //       options: Options(
  //         headers: {"Authorization": accessToken},
  //       ),
  //     );

  //     print(response);
  //     return UserData.fromJson(response.data);
  //   } on DioError catch (e) {
  //     handleError(e);
  //   }
  // }

  // // edit user Data
  // Future<Message> editUserData(
  //   String accessToken,
  //   String name,
  //   String dob,
  //   String bio,
  //   String gender,
  //   String website,
  //   String mobile,
  //   String email,
  //   File image,
  // ) async {
  //   try {
  //     String fileName = "";
  //     if (image != null) fileName = image.path.split("/").last;
  //     FormData formData = new FormData.fromMap({
  //       "name": name,
  //       "dob": dob,
  //       "bio": bio,
  //       "gender": gender,
  //       "website": website,
  //       "mobile": mobile,
  //       "email": email,
  //       "profileImage": image == null
  //           ? null
  //           : await MultipartFile.fromFile(
  //               image.path,
  //               filename: fileName,
  //             ),
  //     });

  //     final response = await Dio().post(url + "/user/data/edit",
  //         options: Options(
  //           headers: {"Authorization": accessToken},
  //         ),
  //         data: formData);

  //     print(response);
  //     return Message.fromJson(response.data);
  //   } on DioError catch (e) {
  //     handleError(e);
  //   }
  // }

  // // get groups
  // Future<List> getGroups(String accessToken) async {
  //   try {
  //     final response = await Dio().get(
  //       url + "/groups",
  //       options: Options(
  //         headers: {"Authorization": accessToken},
  //       ),
  //     );

  //     print(response);
  //     return List.castFrom(response.data);
  //   } on DioError catch (e) {
  //     handleError(e);
  //   }
  // }

  // // get user Ratings
  // Future<UserRatings> getUserRatings(
  //   String accessToken,
  //   String userId,
  //   String bucket,
  //   String sortLogic,
  //   String sortOrder,
  // ) async {
  //   try {
  //     final response = await Dio().get(
  //       url + "/rating/view",
  //       queryParameters: {
  //         "userId": userId,
  //         "pageNumber": 1,
  //         "pageSize": 7,
  //         // "bucket": int.parse(bucket),
  //         "sortLogic": int.parse(sortLogic),
  //         "sortOrder": int.parse(sortOrder),
  //       },
  //       options: Options(
  //         headers: {"Authorization": accessToken},
  //       ),
  //     );

  //     print(response);
  //     return UserRatings.fromJson(response.data[0]);
  //   } on DioError catch (e) {
  //     handleError(e);
  //   }
  // }

  // // get user Ratings according to buckets
  // Future<UserRatings> getUserRatingsBuckets(
  //     String accessToken, String userId, String bucket) async {
  //   try {
  //     final response = await Dio().get(
  //       url + "/rating/view",
  //       queryParameters: {
  //         "userId": userId,
  //         "pageNumber": 1,
  //         "pageSize": 7,
  //         "bucket": int.parse(bucket),
  //         "sortLogic": 1,
  //         "sortOrder": 1,
  //       },
  //       options: Options(
  //         headers: {"Authorization": accessToken},
  //       ),
  //     );

  //     print(response);
  //     return UserRatings.fromJson(response.data[0]);
  //   } on DioError catch (e) {
  //     handleError(e);
  //   }
  // }

  // // get user Ratings according to buckets and category id
  // Future<UserRatings> getUserRatingsBucketsCategory(
  //   String accessToken,
  //   String userId,
  //   String bucket,
  //   String userCategoryId,
  // ) async {
  //   try {
  //     final response = await Dio().get(
  //       url + "/rating/view",
  //       queryParameters: {
  //         "userId": userId,
  //         "pageNumber": 1,
  //         "pageSize": 7,
  //         "bucket": int.parse(bucket),
  //         "sortLogic": 1,
  //         "sortOrder": 1,
  //         "userCategoryId": userCategoryId,
  //       },
  //       options: Options(
  //         headers: {"Authorization": accessToken},
  //       ),
  //     );

  //     print(response);
  //     return UserRatings.fromJson(response.data[0]);
  //   } on DioError catch (e) {
  //     handleError(e);
  //   }
  // }

  // // edit user category
  // Future<Message> edituserCategory(
  //   String category,
  //   String group,
  //   String accessToken,
  //   Map tags,
  //   String userCategoryId,
  // ) async {
  //   try {
  //     final response = await Dio().post(url + "/user/category/edit",
  //         options: Options(
  //           headers: {"Authorization": accessToken},
  //         ),
  //         data: {
  //           "id": userCategoryId,
  //           "group": group,
  //           "category": category,
  //           "enabled": true,
  //           "visible": true,
  //           // "mainCategory": true,
  //           "tags": tags,
  //         });
  //     print(response);
  //     return Message.fromJson(response.data);
  //   } on DioError catch (e) {
  //     handleError(e);
  //   }
  // }
}
