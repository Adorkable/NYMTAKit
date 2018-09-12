//
//  CalendarDate.swift
//  NYMTAKit
//
//  Created by Ian Grossberg on 9/12/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import GTFSKit

public extension CalendarDate {
    public func calendars(_ calendars: [GTFSKit.Calendar]) -> [GTFSKit.Calendar] {
        return calendars.filter({ (calendar) -> Bool in
            return calendar.serviceId == self.serviceId
        })
    }
}
