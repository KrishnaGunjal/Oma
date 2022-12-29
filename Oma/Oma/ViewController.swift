//
//  ViewController.swift
//  Oma
//
//  Created by Krishna Gunjal on 28/12/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVSpeechSynthesizerDelegate {
    @IBOutlet weak var speakButton: UIButton!
    @IBOutlet weak var speakLabel: UILabel!
    
    var speechText = ["one two, three four!  five six.  $seven?"]
    var count = 0
    var speechSynthesizer = AVSpeechSynthesizer()
    
    @IBAction func speak(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            startThespeech()
        } else{
            pauseTheSpeech()
        }
    }
    
    func pauseTheSpeech() {
        speechSynthesizer.stopSpeaking(at: .immediate)
    }
    
    func startThespeech() {
        if speechSynthesizer.isSpeaking {
            speechSynthesizer.stopSpeaking(at: .immediate)
        }else {
            let speechUterence = AVSpeechUtterance(string: speechText[count])
            DispatchQueue.main.async {
                self.speechSynthesizer.speak(speechUterence)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        speechSynthesizer.delegate = self
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        speakLabel.text = utterance.speechString
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        speechSynthesizer.stopSpeaking(at: .word)
        
        count += 1
        if (count < speechText.count) {
            _ = AVSpeechUtterance(string: (speechText[count]))
        }else {
            count = 0
            speakButton.isSelected = false
        }
    }


}


