//
//  ViewControllerState.swift
//  HelloGKStateMachine
//
//  Created by JEROME on 2020/6/16.
//  Copyright © 2020 JEROME. All rights reserved.
//

import GameplayKit

class ViewControllerState: GKState {
  // 用 unowned let 來防止循環持有。
  unowned let viewController: GKStateMachineVC
  // 用來存取 viewController.view 的捷徑。
  var view: UIView {
    viewController.view
  }
  init(viewController: GKStateMachineVC) {
    self.viewController = viewController
  }
}
