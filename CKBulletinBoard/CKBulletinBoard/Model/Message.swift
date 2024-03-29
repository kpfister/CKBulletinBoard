//
//  Message.swift
//  CKBulletinBoard
//
//  Created by Karl Pfister on 6/3/19.
//  Copyright © 2019 Karl Pfister. All rights reserved.
//

import Foundation
import CloudKit

// TypeKeys
struct Constants {
    static let recordKey = "Message"
    static let textKey = "text"
    static let timestampKey = "Timestamp"
}

class Message {
    
    var text: String
    var timestamp: Date
    var ckRecordID: CKRecord.ID
    
    init(text: String, timestamp: Date,ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.text = text
        self.timestamp = timestamp
        self.ckRecordID = ckRecordID
    }

    convenience init?(ckRecord: CKRecord) {
        guard let text = ckRecord[Constants.textKey] as? String, let timestamp = ckRecord[Constants.timestampKey] as? Date else { return nil}
        self.init(text: text, timestamp: timestamp, ckRecordID: ckRecord.recordID)
    }
}

extension CKRecord {
    convenience init(messge: Message) {
        self.init(recordType: Constants.recordKey, recordID: messge.ckRecordID)
        self.setValue(messge.text, forKey: Constants.textKey)
        self.setValue(messge.timestamp, forKey: Constants.timestampKey)
    }
}

extension Message: Equatable {
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.text == rhs.text && lhs.timestamp == rhs.timestamp
    }
}
