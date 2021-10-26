//
//  Model.swift
//  MyApp
//
//  Created by 國澤 on 2021/09/27.
//

import Foundation
import RealmSwift

class Memo: Object, Identifiable {
    @objc dynamic var text = ""
    @objc dynamic var kosu = ""
    @objc dynamic var postedDate = Date()
}

extension Memo {
    private static var config = Realm.Configuration(schemaVersion: 1)
    private static var realm = try! Realm(configuration: config)

    static func findAll() -> Results<Memo> {
        realm.objects(self)
    }

    static func add(_ memo: Memo) {
        try! realm.write {
            realm.add(memo)
        }
    }

    static func delete(_ memo: Memo) {
        try! realm.write {
            realm.delete(memo)
        }
    }

    static func delete(_ memos: [Memo]) {
        try! realm.write {
            realm.delete(memos)
        }
    }
    
    static func update(_ memo: Memo, count: String) {
        try! realm.write{
            memo.kosu = count
        }
    }
}
