//
//  Alert.swift
//  TicTacToe
//
//  Created by Utsav Shah on 09/09/23.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertContext {
    let humanWin = AlertItem(title: Text("You Win Congrats"), message: Text("You are so smart. You beat computer"), buttonTitle: Text("Yeah"))
    let computerWin = AlertItem(title: Text("You lost"), message: Text("Better luck next time"), buttonTitle: Text("Rematch"))
    let draw = AlertItem(title: Text("Draw"), message: Text("What a battle of wits we have here...  "), buttonTitle: Text("Try Again"))
}
