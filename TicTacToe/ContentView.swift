//
//  ContentView.swift
//  TicTacToe
//
//  Created by Utsav Shah on 20/08/23.
//

import SwiftUI

enum Player {
    case human, computer
}

struct Move {
    let player: Player
    let boardIndex: Int
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}

struct ContentView: View {
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    @State var isGameBoardDisable = false
    @State var moves: [Move?] = Array(repeating: nil, count: 9)
    @State var isHuman: Bool = true
    @State var alertItem: AlertItem?
    
    var body: some View {
        VStack {
            
            circleView
            
            Button("New Game") {
                print(columns)
                resetGame()
            }
            
            Spacer()
        }
    }
    
    var circleView: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                LazyVGrid(columns: columns ,spacing: 8) {
                    
                    ForEach(0..<9) { i in
                        ZStack {
                            Circle()
                                .foregroundColor(.red)
                                .frame(width: geometry.size.width/3 - 15, height: geometry.size.width/3 - 15)
                            Image(systemName: moves[i]?.indicator ?? "")
                                .resizable()
                                .frame(width: 35, height: 35, alignment: .center)
                        }
                        .onTapGesture {
                            if isOccupied(moves: moves, index: i) { return }
                            moves[i] = Move(player: .human, boardIndex: i)
                            isGameBoardDisable = true
                            
                            if checkWinCondition(for: .human, in: moves) {
                                print("Human Win")
                                return
                            }
                            
                            if checkForDraw(in: moves) {
                                print("Draw")
                                return
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                let compPotition = isComputerMove(in: moves)
                                moves[compPotition] = Move(player: .computer, boardIndex: compPotition)
                                isGameBoardDisable = false
                                if checkWinCondition(for: .computer, in: moves) {
                                    print("Computer Win ")
                                    return
                                }
                            }
                            
                            
                        }
                    }
                }
                Spacer()
            }
            .disabled(isGameBoardDisable)
            .padding()
//            .alert(item: alertItem?.message, content: { item in
//                Alert(title: item.title, dismissButton: .default(item.buttonTitle, action: {
//                    resetGame()
//                }))
//            })
//            .alert(item: alertItem?.message, content: { item in
//                AlertItem(title: item.title, message: item, buttonTitle: <#T##Text#>)
 
//            })
        }
    }
    
        func isOccupied(moves: [Move?], index: Int) -> Bool {
            return moves.contains(where: {
                $0?.boardIndex == index
            })
        }
        
        func isComputerMove(in move: [Move?]) -> Int {
            var movePotition = Int.random(in: 0..<9)
            
            while isOccupied(moves: moves, index: movePotition) {
                movePotition = Int.random(in: 0..<9)
            }
            
            return movePotition
        }
        
        func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
            let winPattern: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8],[0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
            
            let playerMoves = moves.compactMap { $0 }.filter { $0.player == player }
            
            let playerPositions = Set(playerMoves.map { $0.boardIndex })
            
            for pattern in winPattern where pattern.isSubset(of: playerPositions) {
                return true
            }
            
            // Return true if none of the win patterns match
            return false
        }
        
        func checkForDraw(in moves: [Move?]) -> Bool {
            return moves.compactMap({$0}).count == 9
        }
        
        func resetGame() {
            moves = Array(repeating: nil, count: 9)
            isHuman = true
            isGameBoardDisable = false
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
