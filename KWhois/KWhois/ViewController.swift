//
//  ViewController.swift
//  KWhois
//
//  Created by kiu on 2020/7/21.
//  Copyright © 2020 kiu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

    private var domainView : UITextView?

    private var socket : GCDAsyncSocket?

    private var curTag : Int = 0
    private var domainArray : NSArray = []
    private var resultArray : NSMutableArray?
    private var intervalTime : UInt32 = UInt32(0.5)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        title = "Whois查询"
        view.backgroundColor =  .white

        initView()
        initData()
    }

    func initView() {

        // 一键清除
        let clearButton = UIButton.init(type: .custom)
        clearButton.backgroundColor = .lightGray
        clearButton.layer.cornerRadius  = 6
        clearButton.layer.masksToBounds = true
        clearButton.setTitle("Clear", for: .normal)
        clearButton.setTitleColor(.white, for: .normal)
        clearButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        clearButton.addTarget(self, action: #selector(clearButtonClick), for: .touchUpInside)
        view.addSubview(clearButton)

        clearButton.snp.makeConstraints({ (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(40)
            make.bottom.equalTo(-50 - kTabbarSafeBottomMargin)
        })

        // KWhois查询
        let KWhoisButton = UIButton.init(type: .custom)
        KWhoisButton.backgroundColor = .red
        KWhoisButton.layer.cornerRadius  = 6
        KWhoisButton.layer.masksToBounds = true
        KWhoisButton.setTitle("Whois", for: .normal)
        KWhoisButton.setTitleColor(.white, for: .normal)
        KWhoisButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        KWhoisButton.addTarget(self, action: #selector(KWhoisButtonClick), for: .touchUpInside)
        view.addSubview(KWhoisButton)

        KWhoisButton.snp.makeConstraints({ (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(40)
            make.bottom.equalTo(clearButton.snp_topMargin).offset(-20)
        })

        domainView = UITextView.init()
        domainView?.textColor = .black
        domainView?.backgroundColor = .white
        domainView?.layer.borderWidth = 0.5
        domainView?.layer.cornerRadius  = 6
        domainView?.layer.masksToBounds = true
        domainView?.keyboardType = .URL
        domainView?.layer.borderColor = UIColor.lightGray.cgColor
        domainView?.font = UIFont.systemFont(ofSize: 13)
        domainView?.delegate = self
        view.addSubview(domainView!)

        domainView?.snp.makeConstraints({ (make) in
            make.top.equalTo(kStatusBarAndNavigationBarHeight + 20)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(KWhoisButton.snp_topMargin).offset(-50)
        })

    }

    func initData() {
        resultArray = NSMutableArray.init()
        setupClientSocket()
    }

    /// 清除内容
    @objc func clearButtonClick() {
        // 弹窗提示
        let alertView = UIAlertController.init(title: nil, message: "确定清理查询内容吗？", preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (UIAlertAction) in }

        let okAction = UIAlertAction(title: "确定", style: .default) { (UIAlertAction) in
            self.domainView?.text = ""
        }

        alertView.addAction(cancelAction)
        alertView.addAction(okAction)

        self.present(alertView, animated: true, completion: nil)
    }

    /// KWhois查询
    @objc func KWhoisButtonClick() {

        curTag = 0
        resultArray?.removeAllObjects()
        HUD.flash(.labeledProgress(title: nil, subtitle: "查询中..."))

        // 1、查询数据
        let resultStr = domainView?.text ?? ""
        domainArray = resultStr.split(separator: "\n") as NSArray

        connectSocket()

    }

    // 跳转结果页
    func gotoResultView() {
        HUD.hide()

        let resultView = KWhoisResultViewController()
        resultView.dataArray = resultArray as? [String]
        navigationController?.pushViewController(resultView, animated: true)
    }

    //MARK:- UITextViewDelegate
    func textViewDidChange(_ textView: UITextView) {
        // 获取文本内容
        let str = textView.text!
        // 通过富文本来设置行间距
        let paraph = NSMutableParagraphStyle()
        // 设置行间距
        paraph.lineSpacing = 5
        // 样式属性集合
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15),
                          NSAttributedString.Key.paragraphStyle: paraph]
        textView.attributedText = NSAttributedString(string: str, attributes: attributes)
    }

    //MARK:- 创建客户端Socket
    func setupClientSocket() {
        //在主队列中处理,  所有的回执都在主队列中执行。
        self.socket = GCDAsyncSocket(delegate: self, delegateQueue: DispatchQueue.main)
    }

    /// 连接KWhois服务器
    func connectSocket() {
        if self.socket == nil {
            setupClientSocket()
        }

        // 断开上次连接
        socket?.disconnect()
        do {
            if self.socket?.isConnected == false {
                try self.socket?.connect(toHost: "Whois.cnnic.cn", onPort: 43)
            }else {
                sendMsg()
            }
        }
        catch {
            HUD.flash(.labeledError(title: nil, subtitle: "连接KWhois服务器失败"))
            return
        }

    }

    /// 格式化数据并发送
    func sendMsg() {
        let domianStr = domainArray[curTag] as? String
        let sengMsg = "\(domianStr ?? "")\r\n"
        print("sengMsg -> \(sengMsg)")
        if let data = sengMsg.data(using: String.Encoding.utf8) {
            self.socket?.write(data, withTimeout: -1, tag: curTag)
        } else {
            HUD.flash(.labeledError(title: nil, subtitle: "\(domianStr ?? ""): 查询KWhois信息失败"))
        }
    }
}

extension ViewController : GCDAsyncSocketDelegate {
    // 连接成功
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        sendMsg()
        self.socket?.readData(withTimeout: -1, tag: curTag)
    }

    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        print("KWhois服务器断开连接")
    }

    // 接收到数据
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        let strMsg = String(bytes: data, encoding: String.Encoding.utf8)
        // 判断KWhois结果
        if strMsg?.contains("Queried interval is too short.") ?? false {
            // 查询间隔太短。
            sleep(intervalTime)
            connectSocket()

            return
        }

        if strMsg?.contains("Domain Name: ") ?? false {
            resultArray?.add(strMsg ?? "")
        }else {
            // 失败获取不存在，返回：domain+KWhois结果
            let domain = domainArray[curTag]
            resultArray?.add("\(domain) : \(strMsg ?? "")")
        }

        sock.readData(withTimeout: -1, tag: curTag)

        // 全部查询完，跳转结果页
        if resultArray?.count == domainArray.count {
            gotoResultView()
        }else {
            // 查询下一条
            curTag += 1
            connectSocket()
        }

    }
}
