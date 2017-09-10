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
    
    c.autoregister(AppDependency.self, initializer: AppDependency.init)
    c.register(CircuitStore.self) { _ in LapTimeStore() }.inObjectScope(.container)
    
    c.autoregister(AppFactory.self, initializer: AppFactory.init)
    c.register(NewRaceViewModelFactory.self) { r in
        return { NewRaceViewModel(circuit: $0, dependencies: r ~> AppDependency.self) }
    }
    
    // Circuit list
    c.register(CircuitListViewModeling.self) { r in CircuitListViewModel(dependencies: r ~> AppDependency.self) }
    c.autoregister(CircuitListViewController.self, argument: CircuitListViewModeling.self, initializer: CircuitListViewController.init)
    
    // Circuit detail
    c.register(CircuitDetailViewModeling.self) { r, circuit in
        CircuitDetailViewModel(circuit: circuit, factories: r ~> AppFactory.self, dependencies: r ~> AppDependency.self)
    }
    c.autoregister(CircuitDetailViewController.self, argument: CircuitDetailViewModeling.self, initializer: CircuitDetailViewController.init)
    
    // New circuit
    c.register(NewCircuitViewModeling.self) { r in NewCircuitViewModel(dependencies: r ~> AppDependency.self) }
    c.autoregister(NewCircuitViewController.self, argument: NewCircuitViewModeling.self, initializer: NewCircuitViewController.init)
    
    return c
}()
