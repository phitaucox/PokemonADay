//
//  PADNotesManager.m
//  PokemonADay
//
//  Created by Cox, Christian on 8/28/16.
//  Copyright © 2016 Cox, Christian. All rights reserved.
//

#import <CoreData/CoreData.h>

#import "PADNotesManager.h"
#import "PADDataController.h"

@interface PADNotesManager()

@property (nonatomic, strong, readwrite) NSArray<Note *> *notes;

@end

@implementation PADNotesManager

+ (instancetype)sharedManager
{
    static PADNotesManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    
    return sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self loadNotes];
        self.notes = [self fetchNotes];
    }
    
    return self;
}

- (NSArray *)notesArrayFromJSONFilePath:(NSString *)jsonFilePath
{
    NSError *error = nil;
    NSInputStream *inputStream = [[NSInputStream alloc] initWithFileAtPath:jsonFilePath];
    [inputStream open];
    id json = [NSJSONSerialization JSONObjectWithStream:inputStream options:kNilOptions error:&error];
    [inputStream close];
    
    NSAssert(!error, @"json file read failed");
    
    return json[@"notes"];
}

- (void)loadNotes
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // grab json file path
        NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:@"carlyapp" ofType:@"json"];
        
        NSAssert(jsonFilePath, @"json file path is empty");
        
        // remove any existing data in db
        [self clearNotes];
        
        // build notes array from json file path
        NSArray *notes = [self notesArrayFromJSONFilePath:jsonFilePath];
        
        NSAssert([notes count] > 0, @"notes array is empty");
        
        NSUInteger count = 1;
        
        for (NSDictionary *note in notes) {
            Note *noteManagedObj = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:[PADDataController sharedInstance].managedObjectContext];
            noteManagedObj.noteID = [NSString stringWithFormat:@"%lu", count];
            noteManagedObj.text = note[@"text"];
            noteManagedObj.type = [Note noteTypeFromTypeString:note[@"type"]];
            noteManagedObj.hasBeenSeen = NO;
            
            NSError *error = nil;
            
            BOOL saved = [[PADDataController sharedInstance].managedObjectContext save:&error];
            
            count++;
            
            NSAssert(saved, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
        }
    }
}

- (NSArray *)fetchNotes
{
    return [self fetchNotesWithPredicate:nil];
}

- (void)clearNotes
{
    NSArray *notes = [self fetchNotes];
    
    for (Note *note in notes)
    {
        [[PADDataController sharedInstance].managedObjectContext deleteObject:note];
    }
}

- (Note *)fetchRandomUnseenNote
{
    NSPredicate *unSeenPredicate = [NSPredicate predicateWithFormat:@"hasBeenSeen == NO"];
    NSArray *unseenNotes = [self fetchNotesWithPredicate:unSeenPredicate];
    NSUInteger r = arc4random_uniform((uint32_t)[unseenNotes count]) + 1;
    NSPredicate *randomPredicate = [NSPredicate predicateWithFormat:@"noteID == %lu", r];
    NSArray *fetchedNotes = [self fetchNotesWithPredicate:randomPredicate];
    Note *note = [fetchedNotes firstObject];
    if (note)
    {
        note.hasBeenSeen = YES;
        [[[PADDataController sharedInstance] managedObjectContext] refreshObject:note mergeChanges:YES];
    }
    
    return note;
}

- (NSArray <Note *> *)fetchSeenNotes
{
    NSPredicate *seenPredicate = [NSPredicate predicateWithFormat:@"hasBeenSeen == YES"];
    
    return [self fetchNotesWithPredicate:seenPredicate];
}

- (NSArray *)fetchNotesWithPredicate:(NSPredicate *)predicate
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Note"];
    if (predicate)
    {
        [fetchRequest setPredicate:predicate];
    }
    
    NSError *fetchError = nil;
    
    NSAssert(!fetchError, @"Note fetch failed!");
    
    return [[PADDataController sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
}

@end
