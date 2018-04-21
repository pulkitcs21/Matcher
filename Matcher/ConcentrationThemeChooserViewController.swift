

import UIKit

class ConcentrationThemesChooserViewController: UIViewController, UISplitViewControllerDelegate {
    
    let themes = [
        "Sports": "⚽️🏀🏈⚾️🎾🏐🏉🎱🏓⛷🎳⛳️",
        "Animals": "🐶🦆🐹🐸🐘🦍🐓🐩🐦🦋🐙🐏",
        "Faces": "😀😌😎🤓😠😤😭😰😱😳😜😇"
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        splitViewController?.delegate = self
    }
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentrationViewController{
            if let themename = (sender as? UIButton)?.currentTitle, let theme = themes[themename]{
                    cvc.theme = theme
                }
            } else if let cvc = lastSeguedToConcentrationViewController{
                if let themename = (sender as? UIButton)?.currentTitle, let theme = themes[themename]{
                    cvc.theme = theme
                }
            navigationController?.pushViewController(cvc, animated: true)
        }else{
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
        
    }
    
    private var lastSeguedToConcentrationViewController: ConcentrationViewController?
    
    private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme"{
            if let themename = (sender as? UIButton)?.currentTitle, let theme = themes[themename]{
                if let cvc = segue.destination as? ConcentrationViewController{
                    cvc.theme = theme
                }
            }
        }
    }
}


