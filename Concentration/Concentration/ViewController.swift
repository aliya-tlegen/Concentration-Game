import UIKit

class ViewController: UIViewController {
    
    private lazy var game = ConcentrationGame(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (buttonCollection.count + 1) / 2
    }

    // переменная с наблюдателем
    private(set) var touches = 0 {
        didSet {
            touchLabel.text = "Touches: \(touches)"
        }
    }
    
    // переворачивание карточки
    
    // массив с эмоджи
    private var emojiCollection = ["🦍", "🦏", "🦧", "🐋", "🦩", "🐓", "🦌", "🐊", "🐪", "🐘", "🦒", "🦘"]
    
    private var emojiDictionary = [Int: String]()
    
    private func emojiIdentifier(for card: Card) -> String {
        /*if emojiDictionary[card.identifier] != nil {
            return emojiDictionary[card.identifier]!
        } else {
            return "?"
        }*/
        if emojiDictionary[card.identifier] == nil {
            emojiDictionary[card.identifier] = emojiCollection.remove(at: emojiCollection.count.arc4RandomExtension)
        }
        return emojiDictionary[card.identifier] ?? "?"
    }
    
    private func updateViewFromModel() {
        for index in buttonCollection.indices {
            let button = buttonCollection[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emojiIdentifier(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.3753465674, green: 0.659653185, blue: 0.89, alpha: 0) : #colorLiteral(red: 0.3753465674, green: 0.659653185, blue: 0.89, alpha: 1)
            }
        }
    }
    
    @IBOutlet private var buttonCollection: [UIButton]!
    @IBOutlet private weak var touchLabel: UILabel!
    
    // функция, которая применяется к коллекции кнопок
    @IBAction private func buttonAction(_ sender: UIButton) {
        touches += 1
        
        // optional binding
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            game.chooseCard(at: buttonIndex)
            updateViewFromModel()
        }
    }
    
}

extension Int {
    var arc4RandomExtension: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
