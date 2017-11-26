//
//  AssetPicker.swift
//  SecurityKeeper
//
//  Created by 李玲 on 11/25/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit
import TLPhotoPicker

class AssetPicker {
    
    static var shared = AssetPicker()
    private var picker:TLPhotosPickerViewController
    
    private init(){
        picker = TLPhotosPickerViewController()
        picker.delegate = self
    }
    
    func showImagePicker(){
        guard let top = UIHelper.topVC else{
            UIHelper.throwAn(error: "Unknow Error")
            return
        }
        top.present(picker, animated: true, completion: nil)
    }
    
    private func convertAssetToDataModel(_ asset:TLPHAsset){
        if asset.type == .photo || asset.type == .livePhoto{
            let data = UIImagePNGRepresentation(asset.fullResolutionImage!)
            let model = DataModel()
            model.data = data
            model.title = asset.originalFileName!
            PersistentManager.shared.save(asset: model)
        }else{
            print(asset.videoSize(completion: { (size) in
                print(size)
            }))
            asset.fetchVideoData(completion: { (data) in
                let model = DataModel()
                model.data = data
                model.title = asset.originalFileName!
                PersistentManager.shared.save(asset: model)
            })
        }
    }
}

extension AssetPicker:TLPhotosPickerViewControllerDelegate{
    func dismissPhotoPicker(withTLPHAssets: [TLPHAsset]) {
        //self.selectedAssets = withTLPHAssets
        for asset in withTLPHAssets {
            convertAssetToDataModel(asset)
        }
    }
    
    func photoPickerDidCancel() {
        
    }
    
    func dismissComplete() {
        
    }
    func didExceedMaximumNumberOfSelection(picker: TLPhotosPickerViewController) {
       
    }
}
