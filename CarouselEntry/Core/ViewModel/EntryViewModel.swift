//
//  EntryViewModel.swift
//
//  Created by shishir on 06/10/18.
//  Copyright © 2018 Shishir R Amin. All rights reserved.
//

import Foundation

protocol DataSourceProtocol {
    func viewModel(numberOfItemsInSection:Int) -> Int
    func viewModel(modelAt indexPath:IndexPath) -> Any?
}
class EntryViewModel {
    
    var entries : DataSourceModel<DataViewModel>? = nil
    var keyPadValues : DataSourceModel<KeyPadDataViewModel>? = nil
    var viewType : ViewType
    var string = ""
    var selectedType : DataViewModel? = nil {
        didSet {
            string = selectedType?.vitalValue ?? ""
        }
    }
    
    init() {
        viewType = .keypad
        initEntryViewModels()
        initKeyPadValues()
    }
    
    func initEntryViewModels() {
        let a = DataViewModel(vital: Vitals(value: nil, type: .a))
        a.responseBlock = {
            [weak self](responder,error) in
              guard let weakSelf = self else { return }
            guard let value = responder as? String else { return }
            a.vital?.value = (value == "0" || value == "") ? nil : value
            weakSelf.selectData()
        }
        
        let b = DataViewModel(vital: Vitals(value: nil, type: .b))
        b.responseBlock = {
            [weak self](responder,error) in
            guard let weakSelf = self else { return }
            guard let value = responder as? String else { return }
            b.vital?.value = (value == "0" || value == "") ? nil : value
            weakSelf.selectData()
        }
        
        let c = DataViewModel(vital: Vitals(value: nil, type: .c))
        c.responseBlock = {
            [weak self](responder,error) in
            guard let weakSelf = self else { return }
            guard let value = responder as? String else { return }
            c.vital?.value = (value == "0" || value == "") ? nil : value
            weakSelf.selectData()
        }
        entries = DataSourceModel(result: [a,b,c])
        selectedType = a
    }
    
    func initKeyPadValues() {
        let one = KeyPadDataViewModel(keyPad: .one)
        let two = KeyPadDataViewModel(keyPad: .two)
        let three = KeyPadDataViewModel(keyPad: .three)
        let four = KeyPadDataViewModel(keyPad: .four)
        let five = KeyPadDataViewModel(keyPad: .five)
        let six = KeyPadDataViewModel(keyPad: .six)
        let seven = KeyPadDataViewModel(keyPad: .seven)
        let eight = KeyPadDataViewModel(keyPad: .eight)
        let nine = KeyPadDataViewModel(keyPad: .nine)
        let delete = KeyPadDataViewModel(keyPad: .delete)
        let zero = KeyPadDataViewModel(keyPad: .zero)
        let next = KeyPadDataViewModel(keyPad: .next)
        keyPadValues = DataSourceModel(result:[one,two,three,four,five,six,seven,eight,nine,delete,zero,next])
    }

    
    func getDataModelType(type:Type) -> [DataViewModel]? {
        let array = entries?.result?.filter({ (viewModel) -> Bool in
            return viewModel.vital?.type == type
        })
        return array
    }
    
    func getSelectedType() -> Int {
       let index = entries?.result?.index(where: ( { $0 === selectedType }))
        return index ?? 0
    }
    
    func selectData() {
        guard let theValue = selectedType else { return }
        if theValue.intValue > theValue.minIntValue, getSelectedType() < 2   {
            let index = getSelectedType()
            selectedType = entries?.viewModel(modelAt: IndexPath(row: index+1, section: 0)) as? DataViewModel
        }
    }
    
    func seclectDataForSection(section:Int) {
        let data = entries?.viewModel(modelAt: IndexPath(row: section, section: 0)) as? DataViewModel
        selectedType = data
    }
    
    func refresh(modelAt indexPath : IndexPath)  {
        let keyPadValue = keyPadValues?.viewModel(modelAt:indexPath) as? KeyPadDataViewModel
        guard let theValue = selectedType else { return }
        
        if theValue.isEmpty && keyPadValue?.keyPad.string == "0" {
            string = ""
            return
        }
        
        if keyPadValue?.keyPad == .delete {
            let temp = theValue.intValue/10
            string = temp == 0 ? "" : "\(temp)"
            selectedType?.responseBlock?(string,nil)
        } else {
            let temp = string + (keyPadValue?.keyPad.string ?? "")
            if (Int(temp) ?? 0) < theValue.maxIntValue {
                string = temp
                selectedType?.responseBlock?(string,nil)
            }
        }
    }
}

extension EntryViewModel : DataSourceProtocol {
    
    func viewModel(numberOfItemsInSection: Int) -> Int {
        if viewType == .entryView {
            return entries?.viewModel(numberOfItemsInSection:numberOfItemsInSection) ?? 0
        } else {
            return keyPadValues?.viewModel(numberOfItemsInSection:numberOfItemsInSection) ?? 0
        }
        
    }
    
    func viewModel(modelAt indexPath: IndexPath) -> Any? {
        if viewType == .entryView {
            return entries?.viewModel(modelAt:indexPath)
        } else {
            return keyPadValues?.viewModel(modelAt:indexPath)
        }
    }
    
    
}
