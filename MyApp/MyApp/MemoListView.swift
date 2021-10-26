//
//  MemoListView.swift
//  MyApp
//
//  Created by 國澤 on 2021/09/27.
//

import SwiftUI

// MARK: MemoListView
struct MemoListView: View {
    @ObservedObject var viewModel = MemoViewModel()

    @State private var isNameTextFieldPresented = false
    @State private var isDeleteAllAlertPresented = false
    @State private var nameTextField = ""
    @State private var kosu = 0

    var body: some View {
        NavigationView {
            VStack {
                if (isNameTextFieldPresented) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("名前")
                        
                            TextField("Input name", text: $nameTextField)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 200, height: 30)
                        }
                    
                        VStack(alignment: .leading) {
                            Text("個数")
                            
                        Picker(selection: $kosu, label: Text("個数選択")) {
                            ForEach(0 ..< 50) { num in
                                Text("\(num)")
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 80, height: 30)
                        .clipped()
                    }
                }
                    .padding()
                                    
                }
                
                List {
                    ForEach(viewModel.memos.sorted {
                        $0.postedDate > $1.postedDate
                    }) { memo in
                        
                        HStack {
                            
                            MemoRowView(memo: memo)
                            
                            Spacer()
                            // Buttonにすると行全体にタップ判定がついてしまったので、Text.onTapGestureを代わりに使っている
                            Image(systemName : "trash").onTapGesture {
                                viewModel.deleteMemo = memo
                            }
                            .padding()
                            .foregroundColor(.red)
                            .background(Color.white)
                        }
                        
                    }
                }
            }
            .navigationTitle("リスト")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                if !(isNameTextFieldPresented){
                                    Button("全削除") {
                                        isDeleteAllAlertPresented.toggle()
                                    }
                                    .disabled(viewModel.memos.isEmpty)
                                }else{
                                    Button("キャンセル") {
                                        isNameTextFieldPresented.toggle()
                                        nameTextField = ""
                                        kosu = 0
                                    }
                                }
                            }
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(action :{
                                    if (isNameTextFieldPresented) {
                                        viewModel.memoTextField = nameTextField
                                        nameTextField = ""
                                        viewModel.objectkosu = String(kosu)
                                        kosu = 0
                                    }
                                    isNameTextFieldPresented.toggle()
                                }) {
                                    Image(systemName: "plus")
                                }.disabled(isNameTextFieldPresented && nameTextField.isEmpty)
                            }
                        }
            .alert(isPresented: $isDeleteAllAlertPresented) {
                Alert(title: Text("警告"),
                      message: Text("全てのリストを削除します。\nよろしいですか？"),
                      primaryButton: .cancel(Text("いいえ")),
                      secondaryButton: .destructive(Text("はい")) {
                        viewModel.isDeleteAllTapped = true
                      }
                )
            }
        }
    }
}

// MARK: MemoRowView
struct MemoRowView: View {
    @ObservedObject var viewModel = MemoViewModel()
    
    var memo: Memo
    @State private var kosu: Int = 0
    var sikiiti: Int {
        -1 * Int(memo.kosu)!
    }
    
    var body: some View {
        
        HStack {
            Text(memo.text)
                .font(.body)
            Spacer()
            
            Stepper(value: $kosu, in: sikiiti ... 100, onEditingChanged: { Bool in
                
                if !Bool {
                
                    viewModel.updatekosu = String(kosu + Int(memo.kosu)!)
                
                    viewModel.updateMemo = memo
                    kosu = 0
                    print(memo)
                }
            }){
                Text("個数: \(memo.kosu)" )
            }
            .frame(width:180)
            
        }
    }

    func formatDate(_ date : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.string(from: date)
    }
    
}


struct MemoListView_Previews: PreviewProvider {
    static var previews: some View {
        MemoListView()
        //MemoRowView()
    }
}
