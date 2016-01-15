//
//  Stopwatch.h
//  InstantInsanity
//
//  Created by Craig Milby on 1/13/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __STOPWATCH_H__
#define __STOPWATCH_H__

#import <Foundation/Foundation.h>

@interface Stopwatch : NSObject {
    NSTimer *m_timerUp;
    
    NSDate *m_pauseStart;
    NSDate *m_previousDireDate;
    
    int m_seconds;
    int m_minutes;
    int m_hours;
    
    bool m_isRunning;
}

- ( id ) init;

- ( void ) start;

- ( void ) pause;

- ( void ) resume;

- ( void ) stop;

- ( void ) reset;

- ( bool ) isRunning;

- ( NSString* ) getTimeString;

@end

#endif /* Stopwatch_h */
