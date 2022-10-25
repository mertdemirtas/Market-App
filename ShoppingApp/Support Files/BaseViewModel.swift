//
//  BaseViewModel.swift
//  OMDB
//
//  Created by Mert Demirtaş on 22.09.2022.
//

import NetworkLayerPackage
import Combine

protocol BaseViewModelNetworkStateDelegate: AnyObject {
    func networkStateChanged(networkState: NetworkStates)
}

class BaseViewModel {
    public let networkManager = NetworkManager.shared
    weak var networkStateDelegate: BaseViewModelNetworkStateDelegate?
    
    init() {
        networkState()
    }
}

extension BaseViewModel {
    private func networkState() {
        networkManager.networkState = { [weak self] state in
            self?.networkStateDelegate?.networkStateChanged(networkState: state)
        }
    }
}
