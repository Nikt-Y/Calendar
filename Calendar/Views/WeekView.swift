//
//  WeekView.swift
//  Calendar
//
//  Created by Nik Y on 26.05.2023.
//

import UIKit

// Представление недели
class WeekView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(daysScrollView)
        daysScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            daysScrollView.topAnchor.constraint(equalTo: topAnchor),
            daysScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            daysScrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            daysScrollView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let daysScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private var dayViews: [DayView] = []
    
    func configure(with week: Week) {
        dayViews.forEach { $0.removeFromSuperview() }
        dayViews = week.days.map { day in
            let dayView = DayView()
            dayView.configure(with: day)
            return dayView
        }
        
        let stackView = UIStackView(arrangedSubviews: dayViews)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 100
        
        daysScrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: daysScrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: daysScrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: daysScrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: daysScrollView.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalTo: daysScrollView.heightAnchor)
        ])
    }
}
