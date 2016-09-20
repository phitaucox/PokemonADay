//
//  Note.h
//  PokemonADay
//
//  Created by Cox, Christian on 8/28/16.
//  Copyright © 2016 Cox, Christian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(int16_t, NoteType)
{
    RememberWhen = 0,
    WeShould,
    LoveReasons,
    QuotesAndLyrics,
    DirtyThings,
    AdjectiveAlphabet,
    WeShouldDoDirtyThings,
    TypeUnknown
};

@interface Note : NSManagedObject

@property (nonatomic, strong) NSString *noteID;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) NoteType type;
@property (nonatomic, assign) BOOL hasBeenSeen;

+ (NoteType)noteTypeFromTypeString:(NSString *)typeString;

+ (NSString *)headlineFromNoteType:(NoteType)noteType;

+ (UIColor *)backgroundColorForNoteType:(NoteType)noteType;

+ (UIColor *)textColorForNoteType:(NoteType)noteType;

+ (NSString *)endingStringOnNoteForNoteType:(NoteType)noteType;

@end
