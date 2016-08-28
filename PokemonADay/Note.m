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

+ (NSString *)headlineFromNoteType:(NoteType)noteType
{
    NSString *headline = @"";
    
    if (noteType == RememberWhen)
    {
        headline = @"Remember when...";
    }
    else if (noteType == WeShould)
    {
        headline = @"We should...";
    }
    else if (noteType == LoveReasons)
    {
        headline = @"I love you, because...";
    }
    else if (noteType == QuotesAndLyrics)
    {
        headline = @"Lyrics and quotes...";
    }
    else if (noteType == DirtyThings)
    {
        headline = @"Dirty things...";
    }
    else if (noteType == AdjectiveAlphabet)
    {
        headline = @"An adjective to describe you...";
    }
    
    return headline;
}

@end
