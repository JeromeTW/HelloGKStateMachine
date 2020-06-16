//
//  UniversalVC.swift
//  HelloGKStateMachine
//
//  Created by JEROME on 2020/6/16.
//  Copyright © 2020 JEROME. All rights reserved.
//

import UIKit

/// 1
class UniversalVC : UIViewController {
  var articles: [Article]!
  var emptyView: UIView!
  var indicatorView: UIActivityIndicatorView!
  var tableView: UITableView!
  // view 載入完成後呼叫。
  // 呼叫 showEmptyState()。
  override func viewDidLoad() {}
  // 使用者按下空白狀態的載入按鈕時呼叫。
  // 移除 emptyView 並呼叫 loadArticles()。
  @objc func didPressButton(_ sender: UIButton) {}
  // 顯示 emptyView。
  func showEmptyState() {}
  // 顯示 indicatorView、進行網路呼叫並視結果成功與否來呼叫 showArticles(_:) 或 presentAlert(error:)。
  func loadArticles() {}
  // 將拿到的 articles 存到 self.articles 裡，並顯示 tableView。
  func showArticles(_ articles: [Article]) {}
  // 呈現警告來顯示錯誤訊息，並讓使用者選擇要重試或取消。
  // 依結果來呼叫 showEmptyState() 或 loadArticles()。
  func presentAlert(error: Error) {}
}
extension UniversalVC : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
}
extension UniversalVC : UITableViewDelegate {
  // 當刪除到 self.articles 變成空的時候，移除 tableView 並呼叫 showEmptyState()。
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    return nil
  }
}


/// 2
/* enum 優化:
 enum ViewControllerState {
     case empty, loading, error(Error), articles([Article])
 }
 
 // In View Controller.
 var state: ViewControllerState = .empty {  // didSet will be fat.
     didSet {
         switch oldValue {
         // 清理舊狀態...
         }
         switch state {
         // 顯示新狀態...
         }
     }
 }
 */

