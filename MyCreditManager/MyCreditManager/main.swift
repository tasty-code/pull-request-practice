//
//  main.swift
//  MyCreditManager
//
//  Created by 김준성 on 2023/09/05.
//

import Foundation

CreditModel.shared.read()
CreditManageView().run()
CreditModel.shared.write()

