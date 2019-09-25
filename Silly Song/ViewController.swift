//
//  ViewController.swift
//  Silly Song
//
//  Created by Gessner, Clara on 24.09.19.
//  Copyright © 2019 Gessner, Clara. All rights reserved.
//

import UIKit

func shortNameFromName(name: String) -> String {
    var name = name
    var vowelCount: Int = 0
    name = name.lowercased()
    
    let vowelSet = CharacterSet(charactersIn: "aeiouäöüy")
    
    for char in name.unicodeScalars {
        if vowelSet.contains(char) {
            vowelCount += 1
        }
        
    }
    
    if vowelCount == 0 {
        return name
    }
    else {
        for char in name.unicodeScalars {
            if !vowelSet.contains(char) {
                name.remove(at: name.startIndex)
            }
            else {
                break
            }
        }
        return name
    }
}


func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    let lyrics = lyricsTemplate
    .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
    .replacingOccurrences(of: "<SHORT_NAME>", with: shortNameFromName(name: fullName))
    return lyrics
}

//lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: "Nate")

class ViewController: UIViewController {

    
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }
    
    
    @IBAction func displayLyrics(_ sender: Any) {
        let bananaFanaTemplate = [
        "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
        "Banana Fana Fo F<SHORT_NAME>",
        "Me My Mo M<SHORT_NAME>",
        "<FULL_NAME>"].joined(separator: "\n")
        
        if let name = nameField.text {
            let lyrics = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: name)
            lyricsView.text = lyrics
        }
        else {
            lyricsView.text = "Insert your name first!"
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
    }


}


// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
