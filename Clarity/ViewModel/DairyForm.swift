//
//  new2.swift
//  Clarity
//
//  Created by Nawaf Almutairi on 02/12/2021.
//

import Foundation


class DairyForm: ObservableObject {
    
    
    @Published var formTitle = [NSLocalizedString("Situation / Trigger", comment: ""),
                     NSLocalizedString("Automatic Thoughts", comment: ""),
                     NSLocalizedString("Mood/Emotion", comment: ""),
                     NSLocalizedString("Evidence for the Thought", comment: ""),
                     NSLocalizedString("Evidence Against the Thought", comment: ""),
                     NSLocalizedString("Alternative Thought", comment: ""),
                     NSLocalizedString("Outcome", comment: "")]
    
    @Published var explainedStep = [ NSLocalizedString("-Where where you? \n-What were you doing? \n-Who were you with?",comment: ""),
                          NSLocalizedString("-What thoughts were going through your mind? \n-What memories or images were in my mind?", comment: ""),
                          NSLocalizedString("-Emotions can be described with one word \n E.g angry,sad,scared \n rate 0-100%", comment: ""),
                          NSLocalizedString("-What facts support the truthfulness of this thought or image?",comment: ""),
                          NSLocalizedString("-What experiences indicate that this thought is not completely true all of the time? \n-If my best friend had this thought what would I tell them? \n-Are there any small experiences which contradict this thought?",comment: ""),
                          NSLocalizedString("-Write a new thought which takes into account the evidence for and against the original thoughts",comment: ""),
                          NSLocalizedString("-How do you feel about the situation now? \n Rate 0-100%",comment: "")]
    
    
}
