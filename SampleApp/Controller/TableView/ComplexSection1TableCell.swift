//
//  ComplexSection1TableCell.swift
//  SampleApp
//
//  Created by Frank on 2020/4/9.
//  Copyright © 2020 Frank. All rights reserved.
//

import UIKit

class ComplexSection1TableCell: UITableViewCell {
    let colorArr: [UIColor] = [.red, .yellow, .blue, .green, .orange]
    let selectedColor: UIColor = UIColor(red: 100/255, green: 149/255, blue: 237/255, alpha: 1.0)
    var currentIndicatorIndex: Int = 0
    var buttonSet: [UIButton] = []
    lazy var scrollHeader: UIScrollView = UIScrollView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        scrollHeader.delegate = self
        scrollHeader.isUserInteractionEnabled = true
        scrollHeader.showsHorizontalScrollIndicator = false
        scrollHeader.isScrollEnabled = true
        scrollHeader.isPagingEnabled = true
        self.contentView.addSubview(scrollHeader)
        scrollHeader.snp.makeConstraints({ (make) in
            make.top.bottom.equalTo(0)
            make.height.equalTo(250)
            make.width.equalTo(SCREEN_WIDTH)
        })
        createView()
        createIndicator()
    }
    
    private func createView() {
        var marginLeft: CGFloat = 0.0
        for i in 0..<colorArr.count {
            marginLeft = SCREEN_WIDTH * CGFloat(i)
            let bannerView = UIView()
            bannerView.isUserInteractionEnabled = true
            bannerView.backgroundColor = colorArr[i]
            scrollHeader.addSubview(bannerView)
            bannerView.snp.makeConstraints({ (make) in
                make.width.equalTo(SCREEN_WIDTH)
                make.height.equalTo(scrollHeader.snp.height)
                make.top.equalTo(0)
                make.left.equalTo(marginLeft)
            })
        }
        scrollHeader.contentSize = CGSize.init(width: SCREEN_WIDTH * CGFloat(colorArr.count), height: 250.0)
    }
    
    private func createIndicator() {
        var marginLeft: CGFloat = 50.0
        let marginBetweenView: CGFloat = 20.0
        var containerWidth: CGFloat = 0.0
        let indicatorContainer: UIView = UIView()
        self.contentView.addSubview(indicatorContainer)
        for i in 0..<colorArr.count {
            marginLeft = CGFloat(20 * i) + marginBetweenView * CGFloat(i)
            let indicatorView = UIView()
            indicatorView.backgroundColor = i == currentIndicatorIndex ? selectedColor : .white
            indicatorView.layer.cornerRadius = 10
            indicatorContainer.addSubview(indicatorView)
            indicatorView.snp.makeConstraints({ (make) in
                make.width.height.equalTo(20)
                make.left.equalTo(marginLeft)
                make.top.equalTo(0)
            })
            let indicatorBtn = UIButton()
            indicatorBtn.tag = i
            indicatorView.addSubview(indicatorBtn)
            indicatorBtn.snp.makeConstraints({ (make) in
                make.width.height.equalToSuperview()
                make.top.equalTo(0)
                make.left.equalTo(0)
            })
            buttonSet.append(indicatorBtn)
            if i == colorArr.count - 1 {
                containerWidth += 20.0
            } else {
                containerWidth += 40.0
            }
            indicatorBtn.addTarget(self, action: #selector(selectBanner(sender:)), for: .touchUpInside)
        }
        indicatorContainer.snp.makeConstraints({ (make) in
            make.bottom.equalTo(-20)
            make.width.equalTo(containerWidth)
            make.height.equalTo(20)
            make.centerX.equalTo(SCREEN_WIDTH / 2)
        })
    }
    
    @objc private func selectBanner(sender: UIButton) {
        setView(sender.tag)
        currentIndicatorIndex = sender.tag
        sender.backgroundColor = selectedColor
        sender.layer.cornerRadius = 10
        setUnSelectedButton(currentIndicatorIndex)
    }
    
    private func setView(_ index: Int) {
        let offSetX = SCREEN_WIDTH * CGFloat(index)
        scrollHeader.setContentOffset(CGPoint(x: offSetX, y: 0), animated: true)
    }
    
    private func setUnSelectedButton(_ currentIndex: Int) {
        for btn in buttonSet where btn.tag != currentIndex {
            btn.backgroundColor = .white
            btn.layer.cornerRadius = 10
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension ComplexSection1TableCell: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let viewIndex = Int(scrollView.contentOffset.x / SCREEN_WIDTH)
        self.buttonSet[viewIndex].backgroundColor = selectedColor
        self.buttonSet[viewIndex].layer.cornerRadius = 10
        setUnSelectedButton(viewIndex)
    }
}
