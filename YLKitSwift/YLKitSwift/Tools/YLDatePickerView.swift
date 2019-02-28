//
//  DatePickerView.swift
//  YLKitSwift
//
//  Created by Yeonluu on 2018/8/27.
//  Copyright © 2018年 Yeonluu. All rights reserved.
//

import UIKit

class YLDatePickerView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    /// 时间范围类型 默认为 年月日时分
    @objc enum DateRangeType: Int {
        case fullDateAndTime // 年月日时分
        case fullDate        // 年月日
        case dateAndTime     // 月日时分
        case date            // 月日
        case time            // 时分
    }
    
    /// 构造方法
    ///
    /// - Parameters:
    ///   - dateRangeType: 时间范围类型
    ///   - beginDate: 起始时间 传nil表示当前时间 （可以刚好选至该时间）
    ///   - endDate: 结束时间 传nil表示当前时间 （可以刚好选至该时间）
    ///   - hourRange: 小时范围 默认为0...23
    ///   - minuteInterval: 分钟间隔 默认为1分钟
    init(dateRangeType: DateRangeType, beginDate: Date?, endDate: Date?, hourRange: CountableClosedRange<Int> = 0...23, minuteInterval: Int = 1) {
        super.init(frame: CGRect.zero)
        self.dateRangeType = dateRangeType
        if let beginDate = beginDate {
            self.beginDate = beginDate
            self.isBeginNowDate = false
            self.isSetupDateSource = false
        }
        if let endDate = endDate {
            self.endDate = endDate
            self.isEndNowDate = false
            self.isSetupDateSource = false
        }
        self.hourRange = hourRange
        self.minuteInterval = minuteInterval
        setupDateSource()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 选择器视图
    public let pickerView = UIPickerView()
    
    /// 时间范围类型
    public var dateRangeType = DateRangeType.fullDateAndTime {
        didSet {
            isSetupDateSource = false
            componentOffset = 0
            setupDateSource()
            pickerView.reloadAllComponents()
        }
    }
    private var dateRange: CountableClosedRange<Int> = 0...0
    
    public func setup() {
        pickerView.showsSelectionIndicator = true
        pickerView.delegate = self
        pickerView.dataSource = self
        addSubview(pickerView)
        pickerView.frame = self.bounds
    }
    /// 范围起始时间 可以刚好选至该时间
    private var isBeginNowDate = true
    private var beginDate = Date() {
        didSet {
            self.isBeginNowDate = false
            self.isSetupDateSource = false
        }
    }
    /// 范围结束时间 可以刚好选至该时间
    private var isEndNowDate = true
    private var endDate = Date() {
        didSet {
            self.isEndNowDate = false
            self.isSetupDateSource = false
        }
    }
    
    /// 时间单位
    private var dateUnits = ["年", "月", "日", "", ""]
    /// 小时范围
    private var hourRange = 0...23
    /// 分钟间隔 默认为1
    private var minuteInterval = 1
    private func updateBeginMinute() {
        if minuteInterval > 1 {
            var minute = beginDateValues[minuteIndex]
            if minute%minuteInterval > 0 {
                minute += (minuteInterval - minute%minuteInterval)
                beginDateValues[minuteIndex] = minute
            }
        }
    }
    
    /// 起始时间值数组
    private lazy var beginDateValues = [beginDate.year, beginDate.month, beginDate.day, beginDate.hour, beginDate.minute]
    /// 结束时间值数组
    private lazy var endDateValues = [endDate.year, endDate.month, endDate.day, endDate.hour, endDate.minute]
    /// 各时间值序
    private let yearIndex = 0, monthIndex = 1, dayIndex = 2, hourIndex = 3, minuteIndex = 4
    /// 时间数据值数组
    private var dateValuesList = [[Int]]()
    /// 选中的索引数组
    private var selectedRows = [0, 0, 0, 0, 0]
    /// 选中的时间值行数数组
    private lazy var selectedValues = beginDateValues
    /// 当前时间值长度数组
    private var currentRowLengths = [0, 0, 0, 0, 0]
    /// 组的偏移量
    private var componentOffset = 0
    /// 字体大小
    private lazy var fontSize = CGFloat(22 - dateValuesList.count - (SCREEN_IS_NARROW ? 1 : 0))
    
    
    
    /// 初始化数据信息
    private var isSetupDateSource = false
    private func setupDateSource() {
        if isSetupDateSource {
            return
        }
        
        let firstList = [beginDate.year, 1, 1, hourRange.lowerBound, 0]
        let lastList = [endDate.year, 12, 31, hourRange.upperBound, 59]
        
        dateValuesList = [[Int]]()
        for (index, first) in firstList.enumerated() {
            dateValuesList.append(Array(sequence(state: first) { (value: inout Int) -> Int? in
                guard value <= lastList[index] else { return nil }
                
                defer {
                    if index == self.minuteIndex {
                        value += self.minuteInterval
                    }
                    else {
                        value += 1
                    }
                }
                return value
            }))
        }
        
        var subRange: CountableClosedRange<Int>?
        switch dateRangeType {
        case .fullDateAndTime:
            subRange = yearIndex...minuteIndex
        case .fullDate:
            subRange = yearIndex...dayIndex
        case .dateAndTime:
            subRange = monthIndex...minuteIndex
        case .date:
            subRange = monthIndex...dayIndex
        case .time:
            subRange = hourIndex...minuteIndex
        }
        
        if let subRange = subRange {
            dateValuesList = Array(dateValuesList[subRange])
            componentOffset = subRange.lowerBound
            dateRange = subRange
        }
        
        updateBeginMinute()
        
        isSetupDateSource = true
    }
}


extension DatePickerView {
    
    // MARK: PickerView delegate & dataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return dateValuesList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let index = component + componentOffset
        var count = dateValuesList[component].count
        if index == dayIndex { // 日
            var year = getDateValue(forComponent: yearIndex-componentOffset)
            var month = getDateValue(forComponent: monthIndex-componentOffset)
            if year == 0 { year = beginDateValues[yearIndex] }
            if month == 0 { month = beginDateValues[monthIndex] }
            count = Date.daysOfMonth(month: month, atYear: year)
        }
        
        if index > yearIndex { // 年 不需要动态计算
            
            var  flag = true
            // 判断是否选中结束时间
            for i in 0...index-1 {
                // 判断是否选中结束时间
                if selectedRows[i] != currentRowLengths[i]-1 {
                    flag = false
                }
            }
            
            if flag { // 若选中结束时间
                count = endDateValues[index]
                if index == minuteIndex {
                    count = count/minuteInterval + 1
                }
                else if index > dayIndex { // 月日是从1开始的
                    count += 1
                }
            }
            
            flag = true
            // 判断是否选中起始时间
            for i in 0...index-1 {
                if selectedRows[i] != 0 {
                    flag = false
                    break
                }
            }
            
            if flag && index == hourIndex { // 小时的情况要根据hourRange判断
                if beginDateValues[index] < hourRange.lowerBound {
                    flag = false
                }
                else if beginDateValues[index] > hourRange.upperBound {
                    count = 0
                    flag = false
                }
            }
            
            if flag { // 若选中起始时间
                if index == minuteIndex { // 分钟的情况要根据minuteInterval判断
                    count -= beginDateValues[index]/minuteInterval
                }
                else {
                    count -= beginDateValues[index]
                    if index <= dayIndex { // 月日是从1开始的
                        count += 1
                    }
                }
            }
        }
        // 无可用小时，亦无可用分钟
        if index == minuteIndex && currentRowLengths[hourIndex] == 0 {
            count = 0
        }
        currentRowLengths[index] = count
        return max(count, 1)
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return SCREEN_WIDTH / CGFloat(dateValuesList.count+1)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = view as? UILabel
        if label == nil {
            label = UILabel()
            label?.font = UIFont.systemFont(ofSize: fontSize)
            label?.textAlignment = .center
        }
        label?.text = getDateString(forRow: row, inComponent: component)
        return label!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let index = component + componentOffset
        selectedRows[index] = row
        selectedValues[index] = getDateValue(forRow: row, inComponent: component)
        
        if index+1 <= dateRange.upperBound {
            for i in index+1...dateRange.upperBound {
                pickerView.reloadComponent(i-componentOffset)
                selectLastDateValue(inComponent: i-componentOffset)
            }
        }
    }
}

extension DatePickerView {
    
    // MARK: Helper
    
    /// 自动选中上次选中的时间值
    private func selectLastDateValue(inComponent component: Int) {
        
        let index = component + componentOffset
        let lastValue = selectedValues[index]
        let currentVaule = getDateValue(forComponent: component)
        if lastValue == currentVaule {
            return
        }
        
        let firstVlaue = getDateValue(forRow: 0, inComponent: component)
        var row = lastValue - firstVlaue
        if index == minuteIndex {
            row = row/minuteInterval
        }
        if row < 0 {
            row = 0
        }
        else if row >= pickerView.numberOfRows(inComponent: component) {
            row = pickerView.numberOfRows(inComponent: component) - 1
        }
        
        pickerView.selectRow(row, inComponent: component, animated: false)
        selectedRows[index] = row
        selectedValues[index] = getDateValue(forComponent: component)
    }
    
    ///  获取当前时间值
    private func getDateValue(forComponent component: Int) -> Int {
        guard component >= 0 else {
            return 0
        }
        let row = pickerView.selectedRow(inComponent: component)
        return getDateValue(forRow: row, inComponent: component)
    }
    
    /// 获取时间值
    private func getDateValue(forRow row: Int, inComponent component: Int) -> Int {
        guard component < dateValuesList.count else {
            return 0
        }
        let index = component + componentOffset
        var row = row
        
        if index >= 1 {
            var isStart = true
            for i in 0...index-1 {
                if selectedRows[i] != 0 {
                    isStart = false
                    break
                }
            }
            
            if isStart && index == hourIndex {
                if beginDateValues[index] < hourRange.lowerBound {
                    isStart = false
                }
                else if beginDateValues[index] > hourRange.upperBound {
                    isStart = false
                    return -1
                }
            }
            
            if isStart && !(index == hourIndex && beginDateValues[index] < hourRange.lowerBound) {
                
                if index == minuteIndex {
                    row += beginDateValues[index]/minuteInterval
                }
                else {
                    row += beginDateValues[index]
                    if index <= 2 { // 月日是从1开始的
                        row -= 1
                    }
                }
            }
        }
        row = min(row, dateValuesList[component].count - 1)
        return dateValuesList[component][row]
    }
    
    /// 获取时间字符串
    private func getDateString(forRow row: Int, inComponent component: Int) -> String {
        let index = component + componentOffset
        let value = getDateValue(forRow: row, inComponent: component)
        
        if currentRowLengths[index] == 0 {
            return "—"
        }
        
        if index >= hourIndex {
            return String(format: "%02d", value) + dateUnits[index]
        }
        return "\(value)" + dateUnits[index]
    }
    
    // MARK: public
    /// 更新当前时间
    public func updateNowDate() {
        
        if !isBeginNowDate && !isEndNowDate {
            return
        }
        
        let now = Date()
        let values = [now.year, now.month, now.day, now.hour, now.minute]
        if isBeginNowDate {
            beginDate = now
            beginDateValues = values
        }
        if isEndNowDate {
            endDate = now
            endDateValues = values
        }
        setupDateSource()
    }
    
    /// 选中时间
    public func setSelectedDate(_ date: Date?) {
        if let date = date {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.25) { [weak self] in
                guard let self = self else { return }
                self.selectedValues = [date.year, date.month, date.day, date.hour, date.minute]
                for i in self.dateRange {
                    self.pickerView.reloadComponent(i)
                    self.selectLastDateValue(inComponent: i)
                }
            }
        }
    }
    
    /// 获取选中的时间
    public func getSelectedDate() -> Date {
        return Date(year: selectedValues[yearIndex], month: selectedValues[monthIndex], day: selectedValues[dayIndex], hour: selectedValues[hourIndex], minute: selectedValues[minuteIndex], second: 0)
    }
}


