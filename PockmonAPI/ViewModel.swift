//
//  ViewModel.swift
//  PockmonAPI
//
//  Created by cho on 2023/11/15.
//

//import SwiftUI
//
//class ViewModel: ObservableObject {
//    @Published var pokemonImage: UIImage?
//    @Published var pokemonName: String = ""
//    @Published var pokemonTypes: [String] = []
//    @Published var randomID = Int.random(in: 1...151)
//    @Published var pokemonWeight: Int = 0
//    @Published var pokemonHeight: Int = 0
//    
//    @Published var resultMessage: String = ""
//    
//
//    func fetchRandomPokemon() {
//        
//        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(randomID)") else {
//            print("Invalid URL")
//            return
//        }
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let data = data {
//                do {
//                    let result = try JSONDecoder().decode(Pokemon.self, from: data)
//                    if let imageUrlString = result.sprites.front_default, let imageUrl = URL(string: imageUrlString), let imageData = try? Data(contentsOf: imageUrl) {
//                        DispatchQueue.main.async {
//                            self.pokemonImage = UIImage(data: imageData)
//                            self.pokemonName = result.name
//                            self.pokemonTypes = result.types.map { $0.type.name }
//                            self.pokemonHeight = result.height
//                            self.pokemonWeight = result.weight
//                        }
//                    }
//                } catch {
//                    print("Error decoding JSON: \(error)")
//                }
//            } else if let error = error {
//                print("Error fetching data: \(error)")
//            }
//        }.resume()
//    }
//    
//    func generateRandomID() {
//        randomID = Int.random(in: 1...151)
//    }
//    
//    func determineBattleResult(with selectedTypes: [String]) {
//        // 선택된 타입과 포켓몬의 타입을 비교하여 전투 결과를 결정하는 로직을 구현
//        guard let pokemonType = pokemonTypes.first else {
//            resultMessage = "다시 선택해주세요."
//            return
//        }
//        
//        switch pokemonType.lowercased() {
//        case "normal":
//            if selectedTypes.contains("격투") {
//                resultMessage = "이겼습니다!"
//            } else {
//                resultMessage = "다시 선택해주세요."
//            }
//        case "fire":
//            if selectedTypes.contains(where: { $0.lowercased() == "물" || $0.lowercased() == "바위" || $0.lowercased() == "불꽃" || $0.lowercased() == "드래곤" }) {
//                resultMessage = "이겼습니다!"
//            } else {
//                resultMessage = "다시 선택해주세요."
//            }
//        case "water":
//            if selectedTypes.contains(where: { $0.lowercased() == "전기" || $0.lowercased() == "풀" }) {
//                resultMessage = "이겼습니다!"
//            } else {
//                resultMessage = "다시 선택해주세요."
//            }
//        case "전기":
//            if selectedTypes.contains("땅") {
//                resultMessage = "이겼습니다!"
//            } else {
//                resultMessage = "다시 선택해주세요."
//            }
//        case "풀":
//            if selectedTypes.contains(where: { $0.lowercased() == "벌레" || $0.lowercased() == "독" || $0.lowercased() == "비행" || $0.lowercased() == "불꽃" || $0.lowercased() == "얼음" }) {
//                resultMessage = "이겼습니다!"
//            } else {
//                resultMessage = "다시 선택해주세요."
//            }
//        case "얼음":
//            if selectedTypes.contains(where: { $0.lowercased() == "격투" || $0.lowercased() == "독" || $0.lowercased() == "바위" || $0.lowercased() == "벌레" }) {
//                resultMessage = "이겼습니다!"
//            } else {
//                resultMessage = "다시 선택해주세요."
//            }
//        case "fighting":
//            if selectedTypes.contains(where: { $0.lowercased() == "비행" || $0.lowercased() == "에스퍼" || $0.lowercased() == "페어리" || $0.lowercased() == "벌레" || $0.lowercased() == "얼음" }) {
//                resultMessage = "이겼습니다!"
//            } else {
//                resultMessage = "다시 선택해주세요."
//            }
//        case "poison":
//            if selectedTypes.contains(where: { $0.lowercased() == "땅" || $0.lowercased() == "에스퍼" }) {
//                resultMessage = "이겼습니다!"
//            } else {
//                resultMessage = "다시 선택해주세요."
//            }
//        case "땅":
//            if selectedTypes.contains(where: { $0.lowercased() == "물" || $0.lowercased() == "풀" || $0.lowercased() == "얼음" }) {
//                resultMessage = "이겼습니다!"
//            } else {
//                resultMessage = "다시 선택해주세요."
//            }
//        case "flying":
//            if selectedTypes.contains(where: { $0.lowercased() == "전기" || $0.lowercased() == "바위" || $0.lowercased() == "강철" }) {
//                resultMessage = "이겼습니다!"
//            } else {
//                resultMessage = "다시 선택해주세요."
//            }
//        case "에스퍼":
//            if selectedTypes.contains(where: { $0.lowercased() == "벌레" || $0.lowercased() == "고스트" || $0.lowercased() == "악" }) {
//                resultMessage = "이겼습니다!"
//            } else {
//                resultMessage = "다시 선택해주세요."
//            }
//        case "벌레":
//            if selectedTypes.contains(where: { $0.lowercased() == "불꽃" || $0.lowercased() == "비행" || $0.lowercased() == "풀" || $0.lowercased() == "에스퍼" || $0.lowercased() == "페어리" }) {
//                resultMessage = "이겼습니다!"
//            } else {
//                resultMessage = "다시 선택해주세요."
//            }
//        case "rock":
//            if selectedTypes.contains(where: { $0.lowercased() == "물" || $0.lowercased() == "풀" || $0.lowercased() == "노멀" || $0.lowercased() == "불꽃" || $0.lowercased() == "비행" }) {
//                resultMessage = "이겼습니다!"
//            } else {
//                resultMessage = "다시 선택해주세요."
//            }
//        case "고스트":
//            if selectedTypes.contains(where: { $0.lowercased() == "노멀" || $0.lowercased() == "격투" || $0.lowercased() == "독" || $0.lowercased() == "벌레" || $0.lowercased() == "고스트" }) {
//                resultMessage = "이겼습니다!"
//            } else {
//                resultMessage = "다시 선택해주세요."
//            }
//        case "드래곤":
//            if selectedTypes.contains("드래곤") {
//                resultMessage = "이겼습니다!"
//            } else {
//                resultMessage = "다시 선택해주세요."
//            }
//        case "악":
//            if selectedTypes.contains(where: { $0.lowercased() == "에스퍼" || $0.lowercased() == "페어리" || $0.lowercased() == "고스트" }) {
//                resultMessage = "이겼습니다!"
//            } else {
//                resultMessage = "다시 선택해주세요."
//            }
//        case "강철":
//            if selectedTypes.contains(where: { $0.lowercased() == "불꽃" || $0.lowercased() == "물" || $0.lowercased() == "페어리" }) {
//                resultMessage = "이겼습니다!"
//            } else {
//                resultMessage = "다시 선택해주세요."
//            }
//        default:
//            resultMessage = "다시 선택해주세요."
//        }
//    }
//
//    
//    func resetSelection() {
//            resultMessage = ""
//        }
//}
//
