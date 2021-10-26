//
//  ViewModel.swift
//  MVVMMemo
//
//  Created by 國澤 on 2021/09/25.
//

import Foundation
import Combine

class MemoViewModel: ObservableObject {

    @Published private(set) var memos: [Memo] = Array(Memo.findAll())
    @Published var memoTextField = ""
    @Published var deleteMemo: Memo?
    @Published var isDeleteAllTapped = false
    @Published var objectkosu = ""
    @Published var updatekosu = ""
    @Published var updateMemo: Memo?
    var firsttext = ""
    var updatenum = ""
    

    private var addMemoTask: AnyCancellable?
    private var addkosuTask: AnyCancellable?
    private var deleteMemoTask: AnyCancellable?
    private var deleteAllMemoTask: AnyCancellable?
    private var updatekosuTask: AnyCancellable?
    private var updateMemoTask: AnyCancellable?

    init() {
        
        addMemoTask = self.$memoTextField
            .sink() {
                text in
                guard !text.isEmpty else {
                    return
                }
                self.firsttext = text
            }
        
        addkosuTask = self.$objectkosu
            .sink() {
                num in
                guard !num.isEmpty else {
                    return
                }
                let addmemo = Memo()
                addmemo.text = self.firsttext
                addmemo.kosu = num
                self.memos.append(addmemo)
                Memo.add(addmemo)
            }
        
        deleteMemoTask = self.$deleteMemo
            .sink() { memo in
                guard let memo = memo else {
                    return
                }
                if let index = self.memos.firstIndex(of: memo) {
                    self.memos.remove(at: index)
                    Memo.delete(memo)
                }
            }
        deleteAllMemoTask = self.$isDeleteAllTapped
            .sink() { isDeleteAllTapped in
                if (isDeleteAllTapped) {
                    Memo.delete(self.memos)
                    self.memos.removeAll()
                    self.isDeleteAllTapped = false
                }
            }
        updatekosuTask = self.$updatekosu
            .sink() {
                num in
                guard !num.isEmpty else {
                    return
                }
                self.updatenum = num
            }
        updateMemoTask = self.$updateMemo
            .sink() { memo in
                guard let memo = memo else {
                    return
                }
                if let index = self.memos.firstIndex(of: memo) {
                    Memo.update(memo,count: self.updatenum)
                }
            }
    }
}
