//
//  Calendar.swift
//  NYMTAKit
//
//  Created by Ian Grossberg on 9/12/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import GTFSKit

extension GTFSKit.Calendar {
    func calendarDates(_ calendarDates: [GTFSKit.CalendarDate]) -> [GTFSKit.CalendarDate] {
        return calendarDates.filter({ (calendarDate) -> Bool in
            return calendarDate.serviceId == self.serviceId
        })
    }
}
