// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tourism_web_app/model/place_model.dart';

class DestinationModel {
  final String name;
  List<Place> places;
  bool isExpanded = false;
  bool expandDisabled = false;

  DestinationModel({required this.name, required this.places});
}

class StateProvider with ChangeNotifier {
  final db = FirebaseFirestore.instance;

//   final rawData =
//     {

//    'name': "Bastar" ,
//    'description': 'Bastar, located in the southern part of the central Indian state of Chhattisgarh, is renowned for its rich cultural heritage, vibrant tribal communities, and stunning natural landscapes. This region, with Jagdalpur as its administrative headquarters, is celebrated for its unique blend of ancient traditions, tribal art forms, and lush forests.',

//    'facts' : {
//     "": "",

//     "": "",

//     "": "",

//     "": "",

//     "Naya Bastar": "As of my last update in January 2022, there isn't a widely recognized concept or entity referred to as New Bastar. However, if you're referring to any recent developments or initiatives in the Bastar region of Chhattisgarh, it would be helpful to provide more context or specify what aspect you're interested in. Whether it's about new infrastructure projects, economic developments, or any other recent changes, please let me know, and I'll do my best to provide relevant information.",

//     "Cleanliness and Ease of Living": "Efforts towards cleanliness in Bastar have seen improvements over time, with initiatives such as Swachh Bharat Abhiyan contributing to waste management, sanitation, and public hygiene. However, challenges like waste disposal, open defecation, and pollution remain in some areas, especially in rural parts of the region.",

//     "Rice Production": "Bastar cultivates various varieties of rice, including both traditional and modern high-yielding varieties. Some popular varieties grown in the region include Swarna, Mahsuri, Hybrid Rice, and Basmati.",
// },

//    'head_image': [""],

//    'media': {

//     'gallery' : ['', '', '', '', ''],
//     'videos' : [],

//     },

//    basedon:{} eg. {state:chhattisgarh}, {state:chhattisgarh, city:Bastar}
//    latitude:  19.07,
//    longitude: 82.03 ,
//    faq:[
//     {
//         "question": "What are the top attractions in Bastar?",
//         "answer": "Top attractions in Bastar Chitrakoot Waterfalls,Dokra Village,Gangrel Dam,Cherki Mahal,Bison Horn Maria Tribal Village,Danteshwari Temple,Anthropological Museum,Kanger Valley National Park"
//     },
//     {
//         "question": "What recreational activities are available in Bastar?",
//         "answer": "Bastar offers activities like Nature Walks and Hiking,Waterfall Visits,Wildlife Safaris,Cultural Immersion,Shopping,Photography and more."
//     },
//     {
//         "question": "What is the best time to visit Bastar?",
//         "answer": "The best time to visit Bastar is during the winter months, from October to February"
//     },
//     {
//         "question": "Is it safe to visit Bastar?",
//         "answer": "Yes, Bastar is generally considered safe for tourists. However, it's always recommended to follow standard travel safety precautions."
//     },
//     {
//         "question": "What is the local cuisine of Bastar?",
//         "answer": "Bastar offers a variety of cuisines and street food, reflecting its multicultural society."
//     },
//     {
//         "question": "What are the transportation options in Bastar?",
//         "answer": "Bastar is well-connected by road, rail, and air. The city has a good network of public transport including buses, auto-rickshaws, and taxis."
//     }
// ],

//    rating: 3,
//    sustainablity: 3.4,
//    optionalData: {average_temprature: March to June 25 to 40 and December to February 10 to 25, crime_rate:midium},
// },

// {
//    name: "Kawardha" ,
//    type: "City",
//    introduction:"Kawardha, a city in Chhattisgarh, India, exudes historical charm and natural beauty. Serving as the administrative headquarters of the Kawardha district, this quaint city is renowned for its royal palaces, verdant landscapes, and cultural heritage. Nestled amidst lush greenery and serene surroundings, Kawardha offers visitors a tranquil escape from the hustle and bustle of urban life. With its rich history, architectural marvels, and warm hospitality, Kawardha invites travelers to explore its timeless allure and experience the essence of rural India.",

//    whyTravel: {1 : "Kawardha is surrounded by lush greenery, forests, and scenic landscapes, making it an ideal destination for nature lovers and outdoor enthusiasts. ", 2: "You can either rent a car with a driver or opt for self-drive options if you're comfortable navigating the roads"}

//    Feature : Some features of this place. eg. {
//     "Cultural Heritage": "Kawardha is home to several indigenous tribes, including the Gonds, Baigas, and Korwas, each with its unique customs, traditions, and art forms. Visitors can immerse themselves in tribal culture by interacting with local communities, witnessing traditional rituals, and exploring tribal markets.",

//     "Industrial Hub": " Kawardha is not typically recognized as a major industrial hub. Instead, it is known more for its cultural heritage, natural beauty, and agricultural activities.",

//     "Recreational Activities": "Kawardha, known for its natural beauty and cultural richness, offers a variety of recreational activities for visitors to enjoy. Here are some popular recreational activities in Kawardha.",

//     "Educational Centers": "Kawardha, being a relatively small city, may not have as many educational institutions as larger urban centers. However, it likely has schools and colleges catering to the educational needs of the local population.",

//     "Naya Kawardha": "According to the 2011 census Kabirdham district has a population of 822,526 roughly equal to the nation of Comoros or the US state of South Dakota.This gives it a ranking of 479th in India (out of a total of 640).The district has a population density of 195 inhabitants per square kilometre (510/sq mi).Its population growth rate over the decade 2001-2011 was 40.66%.Kabirdham has a sex ratio of 997 females for every 1000 males, and a literacy rate of 61.95%. 10.63% of the population lives in urban areas. Scheduled Castes and Scheduled Tribes make up 14.56% and 20.31% of the population respectively.",

//     "Cleanliness and Ease of Living": "forts towards cleanliness in Kawardha may involve waste management, sanitation drives, and public awareness campaigns. Regular cleaning of public spaces, waste disposal systems, and initiatives like Swachh Bharat Abhiyan may contribute to maintaining cleanliness in the city.Kawardha's natural beauty calls for conservation efforts to preserve its ecological balance.",

//     "Rice Production": "Rice is a staple crop in Chhattisgarh, including Kawardha, and is typically cultivated using traditional methods such as flood irrigation and manual transplanting. However, modern agricultural practices, including the use of high-yielding varieties and mechanization, may also be adopted to enhance productivity."
// },

//    headImage: https://indiasinvitation.com/wp-content/uploads/2016/09/Temple-in-Kawardha.jpg,

//    gallery:{1:https://chhattisgarhtourism.co.in/destinations/chitrakote_waterfalls.jpg, 2: https://upload.wikimedia.org/wikipedia/commons/thumb/7/72/Chitrakot_watter_fall2.JPG/500px-Chitrakot_watter_fall2.JPG, 3: https://travelsetu.com/apps/uploads/new_destinations_photos/destination/2024/01/08/6ab141934e233cf3f95d13d1981eabc9_1000x1000.jpg, 4: https://www.chhattisgarhtourism.in/img1/bastar/002.jpg, 5: https://static2.tripoto.com/media/filter/tst/img/368560/TripDocument/1537792397_dsc00064_2.jpg, },

//    basedon:{} eg. {state:chhattisgarh}, {state:chhattisgarh, city:Bastar}
//    latitude:  19.07,
//    longitude: 82.03 ,
//    faq:[
//     {
//         "question": "What are the top attractions in Bastar?",
//         "answer": "Top attractions in Bastar Chitrakoot Waterfalls,Dokra Village,Gangrel Dam,Cherki Mahal,Bison Horn Maria Tribal Village,Danteshwari Temple,Anthropological Museum,Kanger Valley National Park"
//     },
//     {
//         "question": "What recreational activities are available in Bastar?",
//         "answer": "Bastar offers activities like Nature Walks and Hiking,Waterfall Visits,Wildlife Safaris,Cultural Immersion,Shopping,Photography and more."
//     },
//     {
//         "question": "What is the best time to visit Bastar?",
//         "answer": "The best time to visit Bastar is during the winter months, from October to February"
//     },
//     {
//         "question": "Is it safe to visit Bastar?",
//         "answer": "Yes, Bastar is generally considered safe for tourists. However, it's always recommended to follow standard travel safety precautions."
//     },
//     {
//         "question": "What is the local cuisine of Bastar?",
//         "answer": "Bastar offers a variety of cuisines and street food, reflecting its multicultural society."
//     },
//     {
//         "question": "What are the transportation options in Bastar?",
//         "answer": "Bastar is well-connected by road, rail, and air. The city has a good network of public transport including buses, auto-rickshaws, and taxis."
//     }
// ],

//    rating: 4.2,
//    sustainablity: 4.1,
//    optionalData: {average_temprature: March to June 25 to 40 and December to February 10 to 25, crime_rate:midium},
// },

// {
//    name: "Jagdalpur",
//    type: "City",
//    introduction: "Jagdalpur is a vibrant city located in the Bastar district of Chhattisgarh, India. It serves as the administrative headquarters of Bastar and is renowned for its rich cultural heritage, natural beauty, and historical significance. ",

//    whyTravel: {1 : "agdalpur and the Bastar region are known for their rich tribal culture, with numerous indigenous communities residing in the area.", 2: "agdalpur is surrounded by breathtaking natural beauty, including lush forests, rolling hills, and cascading waterfalls"}
//    Feature : Some features of this place. eg. {
//     "Cultural Heritage": "Jagdalpur is home to numerous indigenous tribal communities, including the Gond, Maria, Muria, and Bison Horn Maria tribes, among others. These tribes have preserved their unique cultural identity, customs, and way of life for generations, contributing to the rich tapestry of cultural heritage in the region.",

//     "Industrial Hub": "It's worth noting that Chhattisgarh, the state to which Jagdalpur belongs, has been actively working to attract industrial investment and develop industrial infrastructure.",

//     "Recreational Activities": "Jagdalpur and its surrounding areas boast lush forests, rolling hills, and scenic landscapes, perfect for nature enthusiasts. Travelers can enjoy leisurely nature walks or embark on trekking expeditions to explore the region's biodiversity and natural beauty.",

//     "Educational Centers": "IGNOU operates a study center in Jagdalpur, providing distance education programs and courses in various disciplines, including arts, science, commerce, and management.",

//     "Cleanliness and Ease of Living": "Jagdalpur maintains a relatively clean environment, with efforts from the local government and community initiatives to ensure cleanliness in public areas such as parks, streets, and markets.",

//     "Rice Production": "Jagdalpur, being located in the Bastar region of Chhattisgarh, contributes to the overall rice production of the state. However, specific data solely focusing on Jagdalpur's rice production might not be readily available."
// },

//    headImage: https://assets-news.housing.com/news/wp-content/uploads/2022/09/21065018/JAGDALPUR-FEATURE-compressed.jpg,

//    gallery:{1:https://media-cdn.tripadvisor.com/media/photo-c/1280x250/0e/7d/c9/a9/chitrakote-waterfall.jpg, 2: https://assets-news.housing.com/news/wp-content/uploads/2022/09/21065018/JAGDALPUR-FEATURE-compressed.jpg, 3: https://www.nativeplanet.com/img/2019/11/coverjagdalpur-1574426063.jpg, },

//    basedon:{state:chhattisgarh}, {state:chhattisgarh, city:Jagdalpur}
//    latitude: 19.08200000,
//    longitude: 82.02240000,

//    faq:[
//     {
//         "question": "What are the top attractions in Jagdalpur?",
//         "answer": "Top attractions in Jagdalpur  Tirathgarh Waterfall, Danteshwari Temple, Kanger Valley National Park, and Dalpat Sagar Lake."
//     },
//     {
//         "question": "What recreational activities are available in Jagdalpur?",
//         "answer": "Jagdalpur offers activities like shopping, jeep safari, visiting historic sites, and more."
//     },
//     {
//         "question": "What is the best time to visit Jagdalpur?",
//         "answer": "The best time to visit Jagdalpur is during the winter months, from October to February, when the weather is pleasant and conducive to outdoor activities and sightseeing."
//     },
//     {
//         "question": "Is it safe to visit Jagdalpur?",
//         "answer": "Before planning your trip to Jagdalpur, it's advisable to check for any travel advisories issued by your country's government or relevant authorities."
//     },
//     {
//         "question": "What is the local cuisine of Jagdalpur?",
//         "answer": "The local cuisine of Jagdalpur, influenced by the tribal communities and agricultural abundance of the Bastar region, offers a unique blend of flavors, ingredients, and culinary traditions."
//     },
//     {
//         "question": "What are the transportation options in Jagdalpur?",
//         "answer": "Jagdalpur, located in the Bastar region of Chhattisgarh, India, offers various transportation options for travelers to explore the city and its surrounding areas."
//     }
// ],

//    rating: 4.5 ,
//    sustainablity: 3.4 ,
//    optionalData: {average_temprature: 29, crime_rate:midium},
// };

  void getdata() async {
    // final database = FirebaseFirestore.instance;

    // final state = await database.collection('state').get();

    // print('state --> ${state.docs[0].data()}');

    // await database.collection("state").get().then((event) {
    //   for (var doc in event.docs) {
    //     print("${doc.id} => ${doc.data()['name']}");
    //   }
    // });
  }

  final List<DestinationModel> _viewList = [
    DestinationModel(name: 'Popular Destination', places: []),
    DestinationModel(name: 'Featured Destination', places: []),
  ];

  List<DestinationModel> get viewList {
    return [..._viewList];
  }

  // Place document to Place Object
  Place docToPlace(String id, Map<String, dynamic> rawData) {
    final Map<String, Map<String, dynamic>> sustainability = {};
    final Map<String, dynamic> location = {};
    final Map<String, List<String>> media = {};
    final Map<String, String> facts = {};
    final List<String> headImage = [];

    (rawData['sustainability'] as Map<String, dynamic>).forEach((key, value) {
      if (value is Map) {
        sustainability[key] = Map<String, dynamic>.from(value);
      }
    });
    // print('sustainability --> $sustainability');

    (rawData['location'] as Map<String, dynamic>).forEach((key, value) {
      if (value is Map) {
        location[key] = Map<String, dynamic>.from(value);
      } else {
        location[key] = value;
      }
    });
    // print('location --> $location');

    (rawData['media'] as Map<String, dynamic>).forEach((key, value) {
      if (value is List) {
        media[key] = List<String>.from(value);
      }
    });
    // print('media --> $media');

    headImage.addAll(List<String>.from(rawData['head_image']));
    // print('headImage --> $headImage');
    facts.addAll(Map<String, String>.from(rawData['facts']));
    // print('facts --> $facts');

    String? stateName;
    DocumentReference<Map<String, dynamic>>? stateReference;

    if (location.containsKey('state')) {
      // print('entered');
      stateName = location['state']['name'];
      stateReference = location['state']['reference'];
      // stateReference = null;
      // print('stateName: $stateName');
      // print('stateRef: ${stateReference}');
    }

    return Place(
      id: id,
      name: rawData['name'],
      continent: location['continent'],
      country: location['country'],
      stateName: stateName,
      stateReference: stateReference,
      rating: rawData['rating'],
      sustainability: sustainability,
      media: media,
      // location: location,
      headImage: headImage,
      facts: facts,
    );
  }

  void changeExpandState(DestinationModel item) {
    _viewList.forEach((element) {
      if (element.name == item.name) {
        element.isExpanded = !item.isExpanded;
      } else {
        element.expandDisabled = !element.expandDisabled;
      }
    });

    notifyListeners();
  }

  Future<List<DestinationModel>> fetchPlaceByHighRating() async {
    List<Place> highRatePlaces = [];
    final cities = await db
        .collection('state')
        .doc('q577bVOeSzgZBN35JwRp')
        .collection('cities')
        .get();

    cities.docs.forEach((doc) {
      print(doc.get('name'));
      highRatePlaces.add(docToPlace(doc.id, doc.data()));

      // print('data --> ${doc.data()}');
    });

    print('highRatePlaces --> $highRatePlaces');

    _viewList.forEach((model) {
      model.places = highRatePlaces;
    });

    return _viewList;
  }
}
