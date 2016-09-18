//
//  NSDate+PADExtensions.m
//  PokemonADay
//
//  Created by Cox, Christian on 9/17/16.
//  Copyright © 2016 Cox, Christian. All rights reserved.
//

#import "NSDate+PADExtensions.h"

@implementation NSDate (PADExtensions)

- (NSInteger)numberOfSecondsUntil:(NSDate *)aDate
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitSecond fromDate:self toDate:aDate options:0];
    
    return [components second];
}

@end
