//
//  AgendaController.swift
//  Ticker_Fase1
//
//  Created by Luis Fernando AG on 7/16/18.
//  Copyright © 2018 Fernando Alquicira. All rights reserved.
//

import UIKit
import JTAppleCalendar

class AgendaController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Global variables
    let cellAgendaId = "customCell"
    let formatter = DateFormatter()
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var customCalendar: JTAppleCalendarView!
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet weak var monthLabel: UILabel!
    
    
    
    var arrayOfEvents = [Event]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorColor = .clear
        self.tableView.rowHeight = 480
        setupCalendar()
        arrayOfEvents = [
            Event(name: "Dorian", photo: "dorian", date: "16/jun/18", price: "$450-1000", venue: "Palacio de los Deportes"),
            Event(name: "INTERPOL", photo: "interpol", date: "11/ago/2018", price: "$1450-5400", venue: "Teatro de la Ciudad Esperanza Iris")
        ]

        // Do any additional setup after loading the view.
        hideKeyboardWhenTappedAround()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    // TABLE VIEW DELEGATE
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfEvents.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell : AgendaTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellAgendaId, for: indexPath) as! AgendaTableViewCell
        let eventName = arrayOfEvents[indexPath.row].name
        let eventPhoto = arrayOfEvents[indexPath.row].photo
        let eventDate = arrayOfEvents[indexPath.row].date
        let eventVenue = arrayOfEvents[indexPath.row].venue
        let eventPrice = arrayOfEvents[indexPath.row].price
        
        cell.setUpCell(eventImage: eventPhoto, eventName: eventName, eventPrice: eventPrice, eventVenue: eventVenue, eventDate: eventDate)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
    
    
    
    
    
    
    
    // MARK -: LOGCIC IN FILTER BUTTONS
    
    @IBAction func popUpCalendar(_ sender: Any) {
        
        self.calendarView.isHidden = false
    }
    
    @IBAction func dismissCalendar(_ sender: Any) {
        
        self.calendarView.isHidden = true
    }
    
    
    
    
    
}

extension AgendaController: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource{
    
    func setupCalendar(){
        // Setup calendar view
        
        //Setup calendar spacing
        self.customCalendar.minimumLineSpacing = 0
        self.customCalendar.minimumInteritemSpacing = 0
        // Multiple selection ON-Default
        self.customCalendar.allowsMultipleSelection = true
        self.calendarView.isHidden = true
        
        // Sdetup labels
        customCalendar.visibleDates { (visibleDates) in
            self.setupViewsOfCalendar(from: visibleDates)
        }
        
    }
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo){
        let date = visibleDates.monthDates.first!.date
        
        self.formatter.dateFormat = "MMM"
        self.monthLabel.text = self.formatter.string(from: date)
        
    }
    
    func handleCellSelected(view: JTAppleCell, cellState: CellState){
        guard let validCell = view as? CalendarCustomCell else {return}

        if validCell.isSelected{
             validCell.selectedDateView.isHidden = false
        }else{
            
            validCell.selectedDateView.isHidden = true
        }
        
    }
    
    func handleCellTextColor(view: JTAppleCell, cellState: CellState){
        guard let validCell = view as? CalendarCustomCell else {return}
        
        if cellState.isSelected{
            validCell.dateLabel.textColor = UIColor().uicolorFromHexx(rgbValue: 0x333346, alpha: 1.0)
        }else{
            if cellState.dateBelongsTo == .thisMonth{
                validCell.dateLabel.textColor = UIColor().uicolorFromHexx(rgbValue: 0xfafafa, alpha: 1.0)
            }else{
                validCell.dateLabel.textColor = UIColor().uicolorFromHexx(rgbValue: 0xfafafa,
                                                                          alpha: 0.0)

            }
        }
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
    }
    
    
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "calendarCustomCell", for: indexPath) as! CalendarCustomCell
        cell.dateLabel.text = cellState.text
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        return cell
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2018 01 01")!
        let endDate = formatter.date(from: "2018 12 31")!
        
        
        
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalendar(from: visibleDates)
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell!, cellState: cellState)
        handleCellTextColor(view: cell!, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell!, cellState: cellState)
        handleCellTextColor(view: cell!, cellState: cellState)
    }
    
}
