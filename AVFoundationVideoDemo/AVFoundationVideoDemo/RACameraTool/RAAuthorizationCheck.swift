//
//  AuthorizationCheck.swift
//  AVFoundationVideoDemo
//
//  Created by ZCBL on 16/8/10.
//  Copyright © 2016年 RA. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

enum mediaType:Int {
    case video = 0
    case audio = 1
}

class RAAuthorizationCheck: NSObject {

  
}

// MARK: - 权限检查
extension RAAuthorizationCheck {

    /// 检测是否有摄像头使用权限
    ///
    /// - parameter Type: 类型，默认为视频 可选audio
    ///
    /// - returns: true / false
    class internal func checkCameraAuthorization(Type:mediaType = .video) -> Bool {
        
        var authorizationStatus:AVAuthorizationStatus
        
        if Type == .video {
            
            authorizationStatus = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
            
        }else{
            
            authorizationStatus = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeAudio)
            
        }
        
        if authorizationStatus == .Authorized{
            
            return true
            
        }else{
            
            return false
        }

    }
    
    /// 是否拥有相册使用权限(如没没有权限，或未请求权限会弹出权限请求，8.0以上可用该方法)
    ///
    /// - returns: true/false
    @available(iOS 8.0, *)
    class internal func checkPhotoAlbumAuthorization() -> Bool{
        
        let authorization = PHPhotoLibrary.authorizationStatus()
        
        if authorization != .Authorized{
            
            PHPhotoLibrary.requestAuthorization({ (PHAuthorizationStatus) in
                
                print(PHAuthorizationStatus)
            })
        }
        
        if PHPhotoLibrary.authorizationStatus() == .Authorized {
            
            return true
            
        }else{
            
            return false
        }
        
    }
}

// MARK: - 设备可用性检查
extension RAAuthorizationCheck {

    /// 检查相机硬件是否存在
    ///
    /// - returns: true / false
    class internal func checkCameraDeviceAvilable() -> Bool {
        
        return UIImagePickerController.isSourceTypeAvailable(.Camera)
    }
    
    /// 检查是否支持图库
    ///
    /// - returns: true / false
    class internal func checkPhotoLibraryAvilable() -> Bool{
    
        return UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary)
    }
    
    /// 检测是否支持相册
    ///
    /// - returns: true / false
    class internal func checkPhotoAlbum() -> Bool {
        
        return UIImagePickerController.isSourceTypeAvailable(.SavedPhotosAlbum)
    }
    
    /// 检测是否有闪光灯硬件
    ///
    /// - returns: true / false
    class internal func checkHasFlash() -> Bool {
        
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeMuxed)
        
        return captureDevice.hasFlash
    }
    
    /// 检测是否支持手电筒
    ///
    /// - returns:true / false
    class internal func checkHasTorch() -> Bool {
        
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeMuxed)
        
        return captureDevice.hasTorch
    }
}