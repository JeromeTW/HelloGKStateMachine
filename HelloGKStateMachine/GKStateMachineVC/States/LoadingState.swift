//
//  LoadingState.swift
//  HelloGKStateMachine
//
//  Created by JEROME on 2020/6/16.
//  Copyright © 2020 JEROME. All rights reserved.
//

import GameplayKit
import UIKit

class LoadingState: ViewControllerState {
  // 網路呼叫的錯誤。
  enum Error: Swift.Error {
    case noData
  }
  // 創造一個 UIActivityIndicatorView。
  private var indicatorView: UIActivityIndicatorView = {
    let indicatorView = UIActivityIndicatorView(style: .gray)
    indicatorView.translatesAutoresizingMaskIntoConstraints = false
    return indicatorView
  }()
  override func didEnter(from previousState: GKState?) {
    // 把 indicatorView 顯示出來。
    view.addSubview(indicatorView)
    NSLayoutConstraint.activate([
      indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    ])
    indicatorView.startAnimating()
    // 進行網路呼叫。
    // 請自行加上 API key。
    let url = URL(string: "http://newsapi.org/v2/everything?q=bitcoin&from=2020-05-16&sortBy=publishedAt&apiKey=f5269ed61d8c4cc793d650e99bc3183e")!
    let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
      DispatchQueue.main.sync {
        do {
          if let error = error { throw error }
          guard let data = data else { throw Error.noData }
          let response = try JSONDecoder().decode(Articles.self, from: data)
          // 成功拿到 articles 的話就交給 ArticlesState 並切換過去。
          self?.stateMachine?.state(forClass: ArticlesState.self)?.articles = response.articles
          self?.stateMachine?.enter(ArticlesState.self)
        } catch {
          // 出錯的話就把 error 交給 ErrorState 去顯示。
          self?.stateMachine?.state(forClass: ErrorState.self)?.error = error
          self?.stateMachine?.enter(ErrorState.self)
        }
      }
    }
    task.resume()
  }
  // 清理狀態。
  override func willExit(to nextState: GKState) {
    indicatorView.stopAnimating()
    indicatorView.removeFromSuperview()
  }
  
  override func isValidNextState(_ stateClass: AnyClass) -> Bool {
    return stateClass == ArticlesState.self || stateClass == ErrorState.self
  }
}
