//
//  SoundPlayer.swift
//  MyMusic
//
//  Created by Swift-Beginners on 2020/12/31.
//

import UIKit
import AVFoundation

class SoundPlayer: NSObject {
    // シンバルの音源データを読み込み
    let cymbalData = NSDataAsset(name: "cymbalSound")!.data
    
    // シンバル用​プレイヤーの変数
    var cymbalPlayer: AVAudioPlayer!
    
    // ギターの音源データを読み込み
    let guitarData = NSDataAsset(name: "guitarSound")!.data
    
    // ギター用プレイヤーの変数
    var guitarPlayer: AVAudioPlayer!
    
    // シンバルの音を鳴らすメソッド
    func cymbalPlay() {
        do {
            // シンバル用のプレイヤーに、音源データを指定
            cymbalPlayer = try AVAudioPlayer(data: cymbalData)
        
            //シンバルの音源再生
            cymbalPlayer.play()
        } catch {
            print("シンバルで、エラーが発生しました！")
        }
    }  // cymbalPlay ここまで
    
    // ギターの音を鳴らすメソッド
    func guitarPlay() {
        do {
            // ギター用のプレイヤーに、音源ファイル名を指定
            guitarPlayer = try AVAudioPlayer(data: guitarData)
            
            //ギターの音源再生
            guitarPlayer.play()
        } catch {
            print("ギターで、エラーが発生しました！")
        }
    }  // guitarPlay ここまで
}
