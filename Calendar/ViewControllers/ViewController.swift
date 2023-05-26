//
//  ViewController.swift
//  Calendar
//
//  Created by Nik Y on 26.05.2023.
//

import UIKit

class CalendarViewController: UIViewController {
    private var weeks: [Week] = [] // Массив с неделями, которые мы будем отображать
    private let weeksTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(WeekViewCell.self, forCellReuseIdentifier: WeekViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Заполняем массив с неделями
        initializeWeeks()
        
        view.addSubview(weeksTableView)
        weeksTableView.delegate = self
        weeksTableView.dataSource = self
        
        weeksTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weeksTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            weeksTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            weeksTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            weeksTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        weeksTableView.reloadData()
    }
    
    // Метод, заполняющий массив с неделями для трех лет
    func initializeWeeks() {
        let currentYear = Calendar.current.component(.year, from: Date())
        self.weeks = createWeeks(for: currentYear - 1)
        self.weeks.append(contentsOf: createWeeks(for: currentYear))
        self.weeks.append(contentsOf: createWeeks(for: currentYear + 1))
    }
    
    // Создаем недели для одного года
    func createWeeks(for year: Int) -> [Week] {
        var weeks: [Week] = []
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        for weekOfYear in 1...53 {
            if let date = dateFormatter.date(from: "\(year)/01/01") {
                let weekStart = calendar.date(byAdding: .weekOfYear, value: weekOfYear - 1, to: date)
                var days: [Day] = []
                
                for dayOffset in 0...6 {
                    if let dayDate = calendar.date(byAdding: .day, value: dayOffset, to: weekStart!) {
                        days.append(Day(date: dayDate))
                    }
                }
                
                weeks.append(Week(days: days, year: year, weekOfYear: weekOfYear))
            }
        }
        
        return weeks
    }
}

// Настройка tableView
extension CalendarViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weeks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeekViewCell.identifier, for: indexPath) as! WeekViewCell
        cell.configure(with: weeks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

// Строка таблицы
class WeekViewCell: UITableViewCell {
    static let identifier = "WeekViewCell"
    
    private let weekView: WeekView = {
        let view = WeekView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(headerLabel)
        contentView.addSubview(weekView)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            headerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            weekView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 8),
            weekView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            weekView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            weekView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            weekView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with week: Week) {
        headerLabel.text = "Год: \(week.year), Неделя: \(week.weekOfYear)"
        weekView.configure(with: week)
    }
}

