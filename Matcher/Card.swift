

import Foundation

struct Card: Hashable{
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    var hashValue: Int {return identifier}
    
    var isFaceup = false
    var isMatched = false
    private var identifier:Int
    
    private static var identifierFactory = 0
    
    private static func uniqueIdentiferFactory() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    init(){
        self.identifier = Card.uniqueIdentiferFactory()
    }
}

