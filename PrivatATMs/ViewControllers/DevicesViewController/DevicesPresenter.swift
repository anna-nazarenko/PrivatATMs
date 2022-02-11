//
//  DevicesPresenter.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 07.02.2022.
//

import Foundation

protocol DevicesPresenterProtocol: AnyObject {
    var devices: [Device]? { get set }
    var preSavedDevices: [Device]? { get set }
    func getDevices()
    func getDevices(byCity: String)
    func updateTableViewWithPreSavedDevices()
    func cancelRequest()
}

class DevicesPresenter {
    
//MARK: - Properties
    
    private let networkManager = NetworkManager.shared
    private var viewController: DevicesViewControllerProtocol?
    var devices: [Device]?
    var preSavedDevices: [Device]?
    
    init() {
        networkManager.delegate = self
    }
    
    func setDevicesViewController(_ viewController: DevicesViewControllerProtocol) {
        self.viewController = viewController
    }
}

//MARK: - Device Presenter Protocol

extension DevicesPresenter: DevicesPresenterProtocol {
    func getDevices() {
        viewController?.showSpinner()
        networkManager.fetchCashMachines()
    }
    
    func getDevices(byCity: String) {
        viewController?.showSpinner()
        networkManager.fetchCashMachine(cityName: byCity)
    }
    
    func updateTableViewWithPreSavedDevices() {
        guard let preSavedDevices = preSavedDevices else {
            getDevices()
            return
        }
        didUpdateData(networkManager, data: preSavedDevices)
    }
    
    func cancelRequest() {
        networkManager.cancelRequest()
    }
}

//MARK: - Network Manager Delegate

extension DevicesPresenter: NetworkManagerDelegate {
    
    func didUpdateData(_ networkManager: NetworkManager, data: [Device]) {
        DispatchQueue.main.async {
            self.viewController?.hideSpinner()
            self.devices = data
            if self.preSavedDevices == nil { self.preSavedDevices = data }
            self.viewController?.reloadData()
        }
    }

    func didFailWithError(message: String) {
        viewController?.hideSpinner()
        print(message)
    }
}
