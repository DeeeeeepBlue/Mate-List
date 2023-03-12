//
//  ScrapRepository.swift
//  Service
//
//  Created by 강민규 on 2023/03/12.
//  Copyright © 2023 com.ognam. All rights reserved.
//

import Firebase
import RxSwift

public class ScrapRepository {
    
    /// Post 데이터 베이스에서 post 가져오기
    func existScrap(docPath:String, _ escapingHandler : @escaping (Bool) -> ()){
        //TODO:        //TODO: [AppDelegate] Auth 고치기 11
        var result = false
        FireStoreService.db.collection("Post").document(docPath).getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                result = true
                escapingHandler(result)
            }else{
                print("Document does not exist")
                result = false
                escapingHandler(result)
            }
        }
    }
    
    /// User가 Scrap한 포스터들 가져오기
    func dataLoad() {
    //TODO:        //TODO: [AppDelegate] Auth 고치기 10
       FireStoreService.db.collection("User").document(Auth.auth().currentUser!.uid).collection("Scrap").getDocuments() { [self] (querySnapshot, err) in
                   if let err = err {
                       print("Error getting documents: \(err)")
                   } else {
                       for document in querySnapshot!.documents {
                          // print(document.data())
                           let value = document.data()
                           let pid = document.documentID
                           let uid = value["uid"] as? String ?? "글이 없습니다."
                           let author = value["user"] as? String ?? "글이 없습니다."
                           let title = value["title"] as? String ?? "글이 없습니다."
                           let contents = value["contents"] as? String ?? "글이 없습니다."
                           let date = value["date"] as? String ?? "글이 없습니다."
                           let isScrap = value["isScrap"] as? Bool ?? false
                           let findMate = value["findMate"] as? Bool ?? false

                           existScrap(docPath: document.documentID){ (result) in
                               if result{
                                   self.posts.append(Post(pid: pid, uid: uid, title: title, contents: contents, date: date, isScrap: isScrap, findMate: findMate ))
                                   print("잘 넣었음")
                                   self.reloadTableView()
                               } else{
                                   FireStoreService.db.collection("User").document(Auth.auth().currentUser!.uid).collection("Scrap").document(document.documentID).delete() { err in
                                       if let err = err {
                                           print("Error removing document: \(err)")
                                       } else {
                                           print("Document successfully removed!")
                                       }
                                   }
                               }
                           }
                       }
                   }
               }
       }

}
