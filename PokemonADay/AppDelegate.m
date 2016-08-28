//
//  AppDelegate.m
//  PokemonADay
//
//  Created by Cox, Christian on 7/30/16.
//  Copyright © 2016 Cox, Christian. All rights reserved.
//

#import "AppDelegate.h"

#import "Note.h"
#import "PADDataController.h"

@interface AppDelegate ()

@property (nonatomic, strong) PADDataController *dataController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    self.dataController = [[PADDataController alloc] init];
    
    [self loadData];
    
    NSArray *notes = [self fetchNotes];
    
    for (Note *note in notes) {
        NSLog(@"id: %@", note.noteID);
        NSLog(@"text: %@", note.text);
        NSLog(@"type: %lu", (unsigned long)note.type);
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    [self.dataController saveContext];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [self.dataController saveContext];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self.dataController saveContext];
}

#pragma mark - Finagling Data
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

- (void)loadData
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
    {
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // grab json file path
        NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:@"carlyapp" ofType:@"json"];
        
        NSAssert(jsonFilePath, @"json file path is empty");
        
        // remove any existing data in db
        [self clearData];
        
        // build notes array from json file path
        NSArray *notes = [self notesArrayFromJSONFilePath:jsonFilePath];
        
        NSAssert([notes count] > 0, @"notes array is empty");
        
        for (NSDictionary *note in notes) {
            Note *noteManagedObj = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:[self.dataController managedObjectContext]];
            noteManagedObj.noteID = note[@"id"];
            noteManagedObj.text = note[@"text"];
            noteManagedObj.type = [Note noteTypeFromTypeString:note[@"type"]];
            
            NSError *error = nil;
            
            BOOL saved = [[self.dataController managedObjectContext] save:&error];

            NSAssert(saved, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
        }
    }
}

- (NSArray *)fetchNotes
{
    NSArray *notes = @[];
    
    NSFetchRequest *noteFetch = [[NSFetchRequest alloc] initWithEntityName:@"Note"];
    
    NSError *fetchError = nil;
    
    notes = [[self.dataController managedObjectContext] executeFetchRequest:noteFetch error:&fetchError];
    
    NSAssert(!fetchError, @"note fetch in clearData failed");
    
    return notes;
}

- (void)clearData
{
    NSArray *notes = [self fetchNotes];
    
    for (Note *note in notes)
    {
        [[self.dataController managedObjectContext] deleteObject:note];
    }
}

@end
