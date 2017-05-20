//
//  AddViewController.swift
//  HotUrl
//
//  Created by Marco Agovino on 11.05.17.
//  Copyright © 2017 Marco Agovino. All rights reserved.
//

import UIKit
import Speech

class AddViewController: UIViewController {
    
    // Hilfsvariablen
    private let audioEngine = AVAudioEngine()
    // Aktuelle Einstellung - Sprache
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.current)!
    // Anfrage
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    
    private var recognitionTask: SFSpeechRecognitionTask?
    
    @IBOutlet weak var nameAudioBtn: UIButton!
    @IBOutlet weak var urlAudioBtn: UIButton!
    @IBOutlet weak var commentAudioBtn: UIButton!
    
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var urlInput: UITextField!
    @IBOutlet weak var commentInput: UITextField!
    
    @IBAction func nameBtnTapped(_ sender: Any) {
        speechInput(forFild: nameInput, andButton: nameAudioBtn)
    }
    
    @IBAction func urlBtnTapped(_ sender: Any) {
        speechInput(forFild: urlInput, andButton: urlAudioBtn)

    }
    
    @IBAction func commentBtnTapped(_ sender: Any) {
        speechInput(forFild: commentInput, andButton: commentAudioBtn)

    }
    
    @IBAction func safeTapped(_ sender: Any) {
        
    }
    
    // Speech Input
    private func speechInput(forFild: UITextField, andButton: UIButton) {
        // wenn AudioEngine schon läuft -> stoppen
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio() // auch beenden
        } else {
            do {
                try getTranscription {
                    (transcript) in
                forFild.text = transcript // was transcripiert wurde wird im Feld gespeichert
            }
            } catch let error as NSError {
                // TODO
                print(error.localizedDescription)
            }
        }
    }
    
    // Complishen Handler
    private func getTranscription(withHandler: @escaping (_ transcript: String) -> () ) throws {
        // alter Task beenden
        if let recognitionTask = recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }
        // Audio aufnehmen vorbereitung
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSessionCategoryRecord)
        try audioSession.setMode(AVAudioSessionModeMeasurement)
        try audioSession.setActive(true, with: .notifyOthersOnDeactivation) // jetzt aktivieren
        
        // 1. request
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let inputNode = audioEngine.inputNode else {
            print("Kein Input-Node gefunden")
            // TODO
            return
        }
        // 2. request nicht null
        guard let recognitionRequest = recognitionRequest else {
            print("Request nicht erstellbar")
            return
        }
        
        // Audio-Aufnahme
        recognitionRequest.shouldReportPartialResults = false // kein Diktiergerät
        
        // Mikrophone Zugriff
        let format = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: format) { (buffer:AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
            // TODO: Umwandeln von Aufnahme nach TEXT

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
