import Foundation 
import ObjectMapper 

class MeasurementsModel: Mappable { 

	var success: Bool? 
	var data: Data? 

	required init?(map: Map){ 
	} 

	func mapping(map: Map) {
		success <- map["success"] 
		data <- map["data"] 
	}
} 

class Data: Mappable { 

	var sizes: [Sizes]? 

	required init?(map: Map){ 
	} 

	func mapping(map: Map) {
		sizes <- map["sizes"] 
	}
} 

class Sizes: Mappable { 

	var name: String? 
	var size: String? 

	required init?(map: Map){ 
	} 

	func mapping(map: Map) {
		name <- map["name"] 
		size <- map["size"] 
	}
} 

//{
//  "data" : {
//    "sizes" : [
//      {
//        "size" : "27",
//        "name" : "Pants-27,28,29,30,31"
//      },
//      {
//        "size" : "S",
//        "name" : "Skirts-S,M,L,XL,XXL"
//      },
//      {
//        "size" : "S",
//        "name" : "Pants-XS,S,M,L,XL"
//      },
//      {
//        "size" : "Free size",
//        "name" : "Outer Wear-FREE"
//      }
//    ]
//  },
//  "success" : true
//}
//1s
