//
//  AutomaticBowlingScorer.swift
//  Bowling
//
//  Created by Apurva Kochar on 8/5/18.
//  Copyright © 2018 Emirates. All rights reserved.
//

import Foundation


class AutomaticBowlerScorer {
    let highestScore = 10
    private var frameScore = [FrameScore]()
    private var cumulativeScore = [Int](){
        didSet{
            self.reloadViewClosure?()
        }
    }
    
    var reloadViewClosure: (()->())?
    init() {
        
    }
    
    func frameNumber() -> Int{
       return frameScore.count
    }
    
    func scoreSoFar() -> Int{
        return cumulativeScore.reduce(0, +)
    }
    
    func gameIsOver() -> Bool {
        return frameScore.count == 10
    }
    
    func roll(_ pins : Int) -> [Int]{
        setCurrentScore(pins)
        updatePreviousScore()
        return cumulativeScore
    }
    
    func isFirstRoll() -> Bool {
        return frameScore.count == 0 || frameScore.last?.secondRoll == nil || frameScore.last?.firstRoll == highestScore
    }
    
    func scoreForTheFrame(at index: IndexPath) -> Int{
        return cumulativeScore[index.row]
    }
    
    func updatePreviousScore() {
        if(frameNumber() > 1){
            let previousIndex = frameNumber() - 2
            let previousScore = frameScore[previousIndex]
            let currentFrame = frameScore.last!
            
            if((isFirstRoll() && previousScore.bonus == "Spare") || previousScore.bonus == "Strike"){
                cumulativeScore[previousIndex] = highestScore + currentFrame.firstRoll
        }
        }
    }
    
    func setCurrentScore(_ pins: Int) {
        var score : FrameScore?
        if(isFirstRoll()){
            if(pins == highestScore){
                score = FrameScore(firstRoll: pins, secondRoll: 0, bonus: "Strike")
            }
            else{
                score = FrameScore(firstRoll: pins, secondRoll: 0, bonus: "Miss")
            }
            cumulativeScore.append(pins)
            frameScore.append(score!)
        }
        else{
            print(frameNumber())
            print(cumulativeScore.count)
            let firstScore = frameScore.last?.firstRoll
            if((firstScore! + pins) == highestScore){
                score = FrameScore(firstRoll: pins, secondRoll: 0, bonus: "Spare")
            }
            else{
                score = FrameScore(firstRoll: pins, secondRoll: 0, bonus: "Miss")
            }
            cumulativeScore[frameNumber() - 1] = firstScore! + pins
            frameScore[frameNumber() - 1] = score!
        }
    }
    

}

struct FrameScore{
    var firstRoll: Int
    var secondRoll: Int?
    var bonus: String
}


