//
//  Note.m
//  PokemonADay
//
//  Created by Cox, Christian on 8/28/16.
//  Copyright © 2016 Cox, Christian. All rights reserved.
//

#import "Note.h"

@implementation Note

@dynamic noteID, text, type;

//- (instancetype)initWithID:(NSInteger)ID text:(NSString *)text type:(NSString *)type
//{
//    self = [super init];
//    if (self)
//    {
//        self.ID = ID;
//        self.text = text;
//        self.type = [self noteTypeFromTypeString:type];
//    }
//    
//    return self;
//}

+ (NoteType)noteTypeFromTypeString:(NSString *)typeString
{
    NoteType type = TypeUnknown;
    
    if ([typeString isEqualToString:@"RememberWhen"])
    {
        type = RememberWhen;
    }
    else if ([typeString isEqualToString:@"WeShould"])
    {
        type = WeShould;
    }
    else if ([typeString isEqualToString:@"LoveReasons"])
    {
        type = LoveReasons;
    }
    else if ([typeString isEqualToString:@"QuotesAndLyrics"])
    {
        type = QuotesAndLyrics;
    }
    else if ([typeString isEqualToString:@"DirtyThings"])
    {
        type = DirtyThings;
    }
    else if ([typeString isEqualToString:@"AdjectiveAlphabet"])
    {
        type = AdjectiveAlphabet;
    }
    
    NSAssert(type != TypeUnknown, @"type was unknown");
    
    return type;
}

@end
