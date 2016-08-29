//
//  PADNotesManager.h
//  PokemonADay
//
//  Created by Cox, Christian on 8/28/16.
//  Copyright © 2016 Cox, Christian. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Note.h"

@interface PADNotesManager : NSObject

@property (nonatomic, strong, readonly) NSArray<Note *> *notes;

+ (instancetype)sharedManager;

- (Note *)fetchRandomUnseenNote;

@end
