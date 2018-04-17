# MoyaMoreDemo
Demo moya upload and download usage examples

只是一个基于 Moya 官方的上传、下载演示 Demo，通过 ServiceProvider 实现如下常用功能：

* 上传单个文件（带参数）
* 上传多个文件（带参数）
* 下载方法（带有赋值参数）
* 下载方法封装

上传文件使用示例代码：
```Swift
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
```

封装下载 AssetLoader 使用示例代码：
```Swift
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
```
