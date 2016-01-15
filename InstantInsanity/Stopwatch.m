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
        m_seconds = m_minutes = m_hours;
        m_isRunning = false;
    }
    return self;
}

- ( void ) start {
    m_timerUp = [ NSTimer scheduledTimerWithTimeInterval: 1.0 target: self selector: @selector( handleUp ) userInfo: nil repeats: true ];
    m_isRunning = true;
}

- ( void ) pause {
    m_pauseStart = [ NSDate dateWithTimeIntervalSinceNow: 0 ];
    m_previousDireDate = [ m_timerUp fireDate ];
    [ m_timerUp setFireDate: [ NSDate distantFuture ] ];
}

- ( void ) resume {
    float pauseTime = -1 * [ m_pauseStart timeIntervalSinceNow ];
    [ m_timerUp setFireDate: [ NSDate dateWithTimeInterval: pauseTime sinceDate:m_previousDireDate ] ];
    m_pauseStart = nil;
    m_previousDireDate = nil;
}

- ( void ) stop {
    m_isRunning = false;
}

- ( void ) reset {
    m_isRunning = false;
    
    [ m_timerUp invalidate ];
    m_timerUp = nil;
    
    m_seconds = m_hours = m_minutes = 0;
}

- ( bool ) isRunning {
    return m_isRunning;
}

- ( NSString* ) getTimeString {
    NSString *returnString = [ NSString stringWithFormat: @"%02i:%02i.%02i", m_hours, m_minutes, m_seconds ];
    
    return returnString;
}

- ( void ) handleUp {
    m_seconds += 1;
    if ( m_seconds == 60 ) {
        m_seconds = 0;
        m_minutes += 1;
        if ( m_minutes == 60 ) {
            m_minutes = 0;
            m_hours += 1;
        }
    }
}

@end










