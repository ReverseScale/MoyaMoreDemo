//
//  ViewController.swift
//  MoyaMoreDemo
//
//  Created by WhatsXie on 2018/4/12.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func uploadAction(_ sender: Any) {
        upload()
    }
    @IBAction func uploadFileNameAction(_ sender: Any) {
        uploadFileName()
    }
    @IBAction func uploadMultipleAction(_ sender: Any) {
        uploadMultiple()
    }
    @IBAction func uploadMultipleFileNameAction(_ sender: Any) {
        uploadMultipleFileName()
    }
    @IBAction func downloadAction(_ sender: Any) {
        download()
    }
    @IBAction func downloadSaveNameAction(_ sender: Any) {
        downloadSaveName()
    }
    @IBAction func downloadAssetLoaderAction(_ sender: Any) {
        downloadAssetLoader()
    }
    
    // Upload a single document
    func upload() {
        //需要上传的文件
        let fileURL = Bundle.main.url(forResource: "hangge", withExtension: "zip")!
        //通过Moya提交数据
        ServiceProvider.request(.upload(fileURL: fileURL), progress:{
            progress in
            //实时打印出上传进度
            print("当前进度: \(progress.progress)")
        }) {
            result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapString()
                print(data ?? "")
            }
        }
    }
    
    func uploadFileName() {
        //需要上传的文件
        let fileURL = Bundle.main.url(forResource: "hangge", withExtension: "zip")!
        //通过Moya提交数据
        ServiceProvider.request(.uploadFileName(fileURL: fileURL, fileName: "test.zip")) {
            result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapString()
                print(data ?? "")
            }
        }
    }
    
    func uploadMultiple() {
        //需要上传的文件
        let file1URL = Bundle.main.url(forResource: "hangge", withExtension: "png")!
        let file1Data = try! Data(contentsOf: file1URL)
        let file2URL = Bundle.main.url(forResource: "other", withExtension: "png")!
        //通过Moya提交数据
        ServiceProvider.request(
            .uploadMultiple(value1: "hangge", value2: 10, file1Data: file1Data, file2URL: file2URL),
            progress:{
                progress in
                //实时答打印出上传进度
                print("当前进度: \(progress.progress)")
        }) {
            result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapString()
                print(data ?? "")
            }
        }
    }
    
    func uploadMultipleFileName() {
        //需要上传的文件
        let file1URL = Bundle.main.url(forResource: "hangge", withExtension: "png")!
        let file1Data = try! Data(contentsOf: file1URL)
        let file2URL = Bundle.main.url(forResource: "other", withExtension: "png")!
        //通过Moya提交数据
        ServiceProvider.request(
            .uploadMultipleFileName(value1: "hangge", value2: 10, file1Data: file1Data, file2URL: file2URL),
            progress:{
                progress in
                //实时答打印出上传进度
                print("当前进度: \(progress.progress)")
        }) {
            result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapString()
                print(data ?? "")
            }
        }
    }
    
    func download() {
        //要下载的图片名称
        let assetName = "logo.png"
        //通过Moya进行下载
        ServiceProvider.request(.downloadAsset(assetName: assetName), progress:{
            progress in
            //实时打印出下载进度
            print("当前进度: \(progress.progress)")
        }) { result in
            switch result {
            case .success:
                let localLocation: URL = DefaultDownloadDir.appendingPathComponent(assetName)
                let image = UIImage(contentsOfFile: localLocation.path)
                print("下载完毕！保存地址：\(localLocation)")
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func downloadSaveName() {
        //要下载的图片名称
        let assetName = "logo.png"
        //保存的名称
        let timeInterval:TimeInterval = Date().timeIntervalSince1970
        let saveName = "\(Int(timeInterval)).png"
        //通过Moya进行下载
        ServiceProvider.request(.downloadAssetSaveName(assetName: assetName, saveName: saveName)) {
            result in
            switch result {
            case .success:
                let localLocation: URL = DefaultDownloadDir.appendingPathComponent(saveName)
                let image = UIImage(contentsOfFile: localLocation.path)
                print("下载完毕！保存地址：\(localLocation)")
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func downloadAssetLoader() {
        let loader = AssetLoader()
        loader.load(asset: .logo) { result in
            switch result {
            case let .success(localLocation):
                print("下载完毕！保存地址：\(localLocation)")
            case let .failure(error):
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

