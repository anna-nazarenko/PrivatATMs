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
    private let dbManager = DatabaseManager.shared
    private var viewController: DevicesViewControllerProtocol?
    var devices: [Device]?
    var preSavedDevices: [Device]?
    
    init(_ viewController: DevicesViewControllerProtocol) {
        self.networkManager.delegate = self
        self.viewController = viewController
    }
    
    func setDevicesViewController(_ viewController: DevicesViewControllerProtocol) {
        self.viewController = viewController
    }
}

//MARK: - Device Presenter Protocol

extension DevicesPresenter: DevicesPresenterProtocol {
    func getDevices() {
        self.viewController?.showSpinner()
        self.networkManager.fetchCashMachines()
    }
    
    func getDevices(byCity: String) {
        self.viewController?.showSpinner()
        self.networkManager.fetchCashMachine(cityName: byCity)
    }
    
    func updateTableViewWithPreSavedDevices() {
        guard let preSavedDevices = preSavedDevices else {
            self.preSavedDevices = Array(self.dbManager.getDeviceObjects())
            return
        }
        
        didUpdateData(data: preSavedDevices, isInitiaRequest: false)
    }
    
    func cancelRequest() {
        self.viewController?.hideSpinner()
        self.networkManager.cancelRequest()
    }
}

//MARK: - Network Manager Delegate

extension DevicesPresenter: NetworkManagerDelegate {
    
    func didUpdateData(data: [Device], isInitiaRequest: Bool) {
        self.viewController?.hideSpinner()
        self.devices = data

        if isInitiaRequest {
            self.dbManager.deleteAll()
            self.dbManager.save(data)
        }
        
        self.viewController?.reloadData()
    }

    func didFailWithError(message: String) {
        self.viewController?.hideSpinner()
        print(message)
    }
}
