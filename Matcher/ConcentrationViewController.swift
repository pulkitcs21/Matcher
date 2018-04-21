

import UIKit

class ConcentrationViewController: UIViewController {
    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    @IBOutlet private var cardButtons: [UIButton]!{
        didSet{
            for index in cardButtons.indices{
                let button = visibleCardButtons[index]
                button.layer.cornerRadius = 3.0
            }
        }
    }
    
    private var visibleCardButtons: [UIButton]{
        return cardButtons.filter{!$0.superview!.isHidden}
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateViewFromModel()
    }
    @IBOutlet private weak var flipCountLabel: UILabel!{
        didSet{
            updateFlipCountLabel()
        }
    }
    var numberOfPairsOfCards: Int{
        return (visibleCardButtons.count + 1) / 2
    }
    private var emojichoices = "👻🤡👿😺👅😉😍🤓👻🤡👿😺👅😉😍🤓👻🤡👿😺👅😉😍🤓"

    
    private func updateFlipCountLabel(){
        let attributes: [NSAttributedStringKey:Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(game.flipcount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = visibleCardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateFlipCountLabel()
            updateViewFromModel()
        }else{
            print("Card chosen is not in the array")
        }
    }
    
    func updateViewFromModel(){
        if visibleCardButtons != nil{
            for index in visibleCardButtons.indices{
                let button = visibleCardButtons[index]
                let card = game.cards[index]
                if card.isFaceup{
                    button.setTitle(emoji(for: card), for: UIControlState.normal)
                    button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                }else{
                    button.setTitle("", for: UIControlState.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
                }
            }
        }
    }
    
    var theme: String? {
        didSet{
            emojichoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String{
        if emoji[card] == nil, emojichoices.count > 0{
            let randomStringIndex = emojichoices.index(emojichoices.startIndex, offsetBy: emojichoices.count.arc4Random)
            emoji[card] = String(emojichoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
}
extension Int{
    var arc4Random: Int{
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else {
            return 0
        }
    }
}
