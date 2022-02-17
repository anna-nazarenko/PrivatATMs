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
//    private let dbManager = DatabaseManager.shared
    private let dbManager = RealmManager()
    private var viewController: DevicesViewControllerProtocol?
    var devices: [Device]?
    var preSavedDevices: [Device]?
    
    init(_ viewController: DevicesViewControllerProtocol) {
        networkManager.delegate = self
        self.viewController = viewController
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
            self.preSavedDevices = Array(self.dbManager.getDeviceObjects())
            return
        }
        
        didUpdateData(networkManager, data: preSavedDevices)
    }
    
    func cancelRequest() {
        viewController?.hideSpinner()
        networkManager.cancelRequest()
    }
}

//MARK: - Network Manager Delegate

extension DevicesPresenter: NetworkManagerDelegate {
    
    func didUpdateData(_ networkManager: NetworkManager, data: [Device]) {
        DispatchQueue.main.async {
            self.viewController?.hideSpinner()
            self.devices = data

            if self.dbManager.getDeviceObjects().isEmpty {
                self.dbManager.save(data)
            }
            
            self.viewController?.reloadData()
        }
    }

    func didFailWithError(message: String) {
        viewController?.hideSpinner()
        print(message)
    }
}
