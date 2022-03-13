import Foundation

struct ConcentrationGame {
    
    private(set) var cards = [Card]()
    
    // Индекс одной перевернутой карточки
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
            
//            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
            
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    } else {
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    // Либо задаем значение переменной выше, либо nil
    
    mutating func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchingIndex = indexOfOneAndOnlyFaceUpCard, matchingIndex != index {
                if cards[matchingIndex] == cards[index] {
                    cards[matchingIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                } else {
                    indexOfOneAndOnlyFaceUpCard = index
                }
            }
    }
    
    /* func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchingIndex = indexOfOneAndOnlyFaceUpCard, matchingIndex != index {
                if cards[matchingIndex].identifier == cards[index].identifier {
                    cards[matchingIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
        } else {
            for flipDown in cards.indices {
                cards[flipDown].isFaceUp = false
            }
            cards[index].isFaceUp = true
            indexOfOneAndOnlyFaceUpCard = index
        }
            
        }
    } */
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "ConcentrationGame.init(\(numberOfPairsOfCards)): must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            /*cards.append(card)
            cards.append(card)*/
            cards += [card,card]
        }
        // TODO: Shuffle the cards
        cards.shuffle()
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}

extension Array {
    // тасование элементов 'self' "по месту"
    mutating func shuffle() {
        // пустая коллекция и с одним элементом не тасуются
        if count < 2 { return }
        
        for i in indices.dropLast() {
            let diff = distance(from: i, to: endIndex)
            let j = index(i, offsetBy: diff.arc4RandomExtension)
            swapAt(i, j)
        }
    }
}
