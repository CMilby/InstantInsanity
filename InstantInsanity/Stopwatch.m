//
//  Stopwatch.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/13/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "Stopwatch.h"

@implementation Stopwatch {
    
}

- ( id ) init {
    if ( self = [ super init ] ) {
        m_isRunning = false;
    }
    return self;
}

- ( void ) start {
    if ( m_isRunning ) {
        return;
    }
    
    m_startDate = [ NSDate date ];
    m_stopDate = m_startDate;
    if ( m_clockTimer == nil ) {
        m_clockTimer = [ NSTimer timerWithTimeInterval: 1.0f / 100.0f target: self selector: @selector( handleTimerTick ) userInfo: nil repeats: true ];
    }
    
    m_isRunning = true;
}

- ( void ) stop {
    if ( !m_isRunning ) {
        return;
    }
    
    m_isRunning = false;
    [ m_clockTimer invalidate ];
    m_clockTimer = nil;
    m_stopDate = [ NSDate date ];
}

- ( void ) reset {
    [ m_clockTimer invalidate ];
    m_clockTimer = nil;
    m_isRunning = false;
    
    m_startDate = nil;
    m_stopDate = nil;
}

- ( bool ) isRunning {
    return m_isRunning;
}

- ( NSString* ) getTimeString {
    if ( m_startDate == nil ) {
        return @"00:00.00";
    }
    
    NSDate *currentDate;
    NSTimeInterval timeInterval;
    if ( m_isRunning ) {
        currentDate = [ NSDate date ];
    } else {
        currentDate = m_stopDate;
    }
    
    timeInterval = [ currentDate timeIntervalSinceDate: m_startDate ];
    NSDate *timerDate = [ NSDate dateWithTimeIntervalSince1970: timeInterval ];
    NSDateFormatter *dataFormatter = [ [ NSDateFormatter alloc ] init ];
    [ dataFormatter setDateFormat: @"mm:ss.SS" ];
    [ dataFormatter setTimeZone: [ NSTimeZone timeZoneForSecondsFromGMT: 0.0 ] ];
    return [ dataFormatter stringFromDate: timerDate ];
}

- ( void ) handleTimerTick {
    
}

@end