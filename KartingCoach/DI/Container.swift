//
//  Container.swift
//  KartingCoach
//
//  Created by Lukáš Hromadník on 10.09.17.
//

import Swinject
import SwinjectAutoregistration

let container: Container = {
    let c = Container()
    
//    c.autoregister(AppDependency.self, initializer: AppDependency.init)
//    c.autoregister(AppFactory.self, initializer: AppFactory.init)
    
    
    return c
}()
