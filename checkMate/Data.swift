//
//  Data.swift
//  checkMate
//
//  Created by 한상윤 on 2022/02/03.
//

import Foundation


struct contents {
    
    let author: String
    let tittle: String
    let contents: String
//    let lifePattern?
//    let dueTime: String
//    let howManyPeople: int

}

struct replys {
    
    let author: String
    let contents: String
    
}

var findMateData: [contents] = [
    
    contents(author: "상윤", tittle: "조용한 룸메 구합니다!", contents: "경상대 전자공학과 한상윤입니다. \n인생은 회전목마 \n우린 매일 달려가 \n언제쯤 끝나 난 잘 몰라"),
    contents(author: "가은", tittle: "잘 안들어오는 룸메 구합니다", contents: "체크메이트 팀장 김가은입니다. \n내가 슬플 때마다 \n이 노래가 찾아와 \n세상이 둥근 것처럼 우리"),
    contents(author: "민규", tittle: "저랑 룸메하실 분~~", contents: "엘리트 강민규입니다. \n빙빙 돌아가는 회전목마처럼 \n영원히 계속될 것처럼 \n빙빙 돌아온 우리의 시간처럼 \n인생은 회전목마 ayy")
    
]

var replySection: [Int]!
var replyRow: [Int]!

var replyData: Array<Array<replys>> = [
    
    [replys(author: "1", contents: "1"),
    replys(author: "1", contents: "2"),
    replys(author: "1", contents: "3"),
    replys(author: "1", contents: "4")],
    
    [replys(author: "2", contents: "1"),
    replys(author: "2", contents: "2"),
    replys(author: "2", contents: "3"),
    replys(author: "2", contents: "4")],
    
    [replys(author: "3", contents: "1"),
    replys(author: "3", contents: "2"),
    replys(author: "3", contents: "3"),
    replys(author: "3", contents: "4")],
    
    [replys(author: "4", contents: "1"),
    replys(author: "4", contents: "2"),
    replys(author: "4", contents: "3"),
    replys(author: "4", contents: "4")],
    

]

var testData: Array<Array<replys>> = [
    
    [replys(author: "용감한 폰", contents: "안녕하세요!"),
    replys(author: "든든한 나이트", contents: "혹시 룸메 구하셨나용?"),
    replys(author: "직진하는 룩", contents: "저랑 같이 살아요"),
    replys(author: "뛰어난 비숍", contents: "저랑 mbti 같으시네요")],

    [replys(author: "용감한 폰", contents: "안녕하세요!"),
    replys(author: "든든한 나이트", contents: "혹시 룸메 구하셨나용?"),
    replys(author: "직진하는 룩", contents: "저랑 같이 살아요"),
    replys(author: "뛰어난 비숍", contents: "저랑 mbti 같으시네요")],
    
    [replys(author: "용감한 폰", contents: "안녕하세요!"),
    replys(author: "든든한 나이트", contents: "혹시 룸메 구하셨나용?"),
    replys(author: "직진하는 룩", contents: "저랑 같이 살아요"),
    replys(author: "뛰어난 비숍", contents: "저랑 mbti 같으시네요")]

]


//var checkMark: String = "checkmark.circle"

var habitCheck: [String] = [
    "흡연",
    "게임",
    "코골이",
    "이갈이",
    "방에서 통화",
    "방에서 음식섭취",
    "귀가 시간(11시 이후)",
    "취침 시간(12시 이후)",
]

var habitSelect: [String] = [
    "청소주기",
    "샤워시간",
    "mbti"
]

var cleanSelect : String = ""
var smokingSelect : Bool = false
var gameSelect : Bool = false
var snoringSelect : Bool = false
var griding_teethSelect : Bool = false
var callSelect : Bool = false
var eatSelect : Bool = false
var curfewSelect : Bool = false
var bedtimeSelect : Bool = false
var mbtiSelect : String = ""

//let scrapFilter = findMateData.filter { item in
//    for i in 1...(findMateData.count-1) {
//        findMateData[i].author == "상윤"
//    }
//    return true
//}

