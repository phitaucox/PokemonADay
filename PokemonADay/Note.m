//
//  Note.m
//  PokemonADay
//
//  Created by Cox, Christian on 8/28/16.
//  Copyright © 2016 Cox, Christian. All rights reserved.
//

#import "Note.h"

@implementation Note

@dynamic noteID, text, type, hasBeenSeen;

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
    else if ([typeString isEqualToString:@"WeShouldDoDirtyThings"])
    {
        type = WeShouldDoDirtyThings;
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
    else if (noteType == WeShouldDoDirtyThings)
    {
        headline = @"Dirty things we should do...";
    }
    
    return headline;
}

+ (UIColor *)backgroundColorForNoteType:(NoteType)noteType
{
    UIColor *backgroundColor = [UIColor clearColor];
    
    if (noteType == RememberWhen)
    {
        backgroundColor = [UIColor colorWithRed:0.49 green:0.35 blue:0.71 alpha:1.0];
    }
    else if (noteType == WeShould)
    {
        backgroundColor = [UIColor colorWithRed:0.11 green:0.91 blue:1.00 alpha:1.0];
    }
    else if (noteType == LoveReasons)
    {
        backgroundColor = [UIColor colorWithRed:0.89 green:1.00 blue:0.10 alpha:1.0];
    }
    else if (noteType == QuotesAndLyrics)
    {
        backgroundColor = [UIColor colorWithRed:0.99 green:0.39 blue:0.44 alpha:1.0];
    }
    else if (noteType == DirtyThings)
    {
        backgroundColor = [UIColor colorWithRed:0.95 green:0.65 blue:0.07 alpha:1.0];
    }
    else if (noteType == AdjectiveAlphabet)
    {
        backgroundColor = [UIColor colorWithRed:0.16 green:0.20 blue:0.36 alpha:1.0];
    }
    else if (noteType == WeShouldDoDirtyThings)
    {
        backgroundColor = [UIColor colorWithRed:0.33 green:0.84 blue:0.75 alpha:1.0];
    }
    
    return backgroundColor;
}

+ (UIColor *)textColorForNoteType:(NoteType)noteType
{
    UIColor *textColor = [UIColor darkTextColor];
    
    if (noteType == AdjectiveAlphabet || noteType == RememberWhen)
    {
        textColor = [UIColor whiteColor];
    }
    
    return textColor;
}

+ (NSString *)endingStringOnNoteForNoteType:(NoteType)noteType
{
    NSString *endingString = @"";
    
    if (noteType == RememberWhen)
    {
        endingString = @" 😀";
    }
    else if (noteType == WeShould)
    {
        endingString = @" 👍";
    }
    else if (noteType == LoveReasons)
    {
        endingString = @" ❤️";
    }
    else if (noteType == QuotesAndLyrics)
    {
        endingString = @" 🎧";
    }
    else if (noteType == DirtyThings)
    {
        endingString = @" ☺️";
    }
    else if (noteType == AdjectiveAlphabet)
    {
        endingString = @" 😘";
    }
    else if (noteType == WeShouldDoDirtyThings)
    {
        endingString = @" 🤗";
    }
    
    return endingString;
}

@end
