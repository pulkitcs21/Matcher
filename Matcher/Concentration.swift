

import Foundation
class Concentration{
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int?{
        get{
            return cards.indices.filter{cards[$0].isFaceup}.oneAndOnly
        }
        set{
            for index in cards.indices{
                cards[index].isFaceup = (index == newValue)
            }
        }
    }
    
    private(set) var score = 0
    private(set) var flipcount = 0
    
    func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard at \(index) is not in array")
        if !cards[index].isMatched {
            flipcount += 1
            score -= 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    //cards match
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 1
                }
                cards[index].isFaceup = true
            } else{
                indexOfOneAndOnlyFaceUpCard=index
            }
        }
    }
    
    // Create cards everytime the concentration is called and store the card in array Cards
    //Shuffle the cards using
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "concentration.init NumberOfPairs of Cards can not be negative")
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card,card]
            
            //Shuffle the cards
            guard cards.count > 1 else {return}
        }
    }
}

extension Collection{
    var oneAndOnly: Element?{
        return count == 1 ? first : nil
    }
}

