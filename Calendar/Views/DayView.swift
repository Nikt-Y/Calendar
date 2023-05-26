//
//  DayView.swift
//  Calendar
//
//  Created by Nik Y on 26.05.2023.
//

import UIKit

// Представление дня
class DayView: UIView {
    private let dayOfMonthLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let monthLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let dayOfWeekLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    // Создаем вертикальный stackView, который содержит месяц, дату и день недели
    override init(frame: CGRect) {
        super.init(frame: frame)
        let stackView = UIStackView(arrangedSubviews: [dayOfMonthLabel, monthLabel, dayOfWeekLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            stackView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with day: Day) {
        dayOfMonthLabel.text = "\(day.dayOfMonth)"
        monthLabel.text = "\(day.month)"
        dayOfWeekLabel.text = "\(day.day)"
    }
}
