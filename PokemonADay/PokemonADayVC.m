//
//  PokemonADayVC.m
//  PokemonADay
//
//  Created by Cox, Christian on 7/30/16.
//  Copyright © 2016 Cox, Christian. All rights reserved.
//

#import <pop/POP.h>

#import "PokemonADayVC.h"
#import "NoteView.h"
#import "PADNotesManager.h"
#import "Note.h"
#import "NSDate+PADExtensions.h"

@interface PokemonADayVC ()

@property (nonatomic, strong) NoteView *noteView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) PADNotesManager *notesManager;

@end

@implementation PokemonADayVC

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.notesManager = [PADNotesManager sharedManager];
    }
    
    return self;
}

- (PADNotesManager *)notesManager
{
    if (!_notesManager)
    {
        _notesManager = [PADNotesManager sharedManager];
    }
    
    return _notesManager;
}

- (IBAction)imageTapped:(UITapGestureRecognizer *)sender
{
    if (self.noteView)
    {
        [self.noteView removeFromSuperview];
        self.noteView = nil;
    }
    
    self.noteView = [[NoteView alloc] initWithFrame:CGRectZero];
    self.noteView.center = self.view.center;
    
    NSInteger hoursUntilNextNote = [self hoursUntilNextNote];
    hoursUntilNextNote = 0;
    if (hoursUntilNextNote < 1)
    {
        Note *note = [self.notesManager fetchRandomUnseenNote];
        if (!note)
        {
            if ([[self.notesManager fetchSeenNotes] count] >= 365)
            {
                [self.noteView fillNoteViewWithHeadline:@"All done..." body:@"Bulbasaur doesn't have any more Notes for you. Be sure to check out the History any time you want though. Hope you enjoyed reading all these." backgroundColor:[UIColor blueColor] textColor:[UIColor darkTextColor]];
            }
            else
            {
                [self.noteView fillNoteViewWithHeadline:@"Bulbas..." body:@"Your fav Pokémon Bulbasur accidentally couldn't find what your note for whatever reason. Give it another shot." backgroundColor:[UIColor greenColor] textColor:[UIColor darkTextColor]];
            }
        }
        else
        {
            NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
            dayComponent.day = 1;
            
            NSDate *nextDate = [[NSCalendar currentCalendar] dateByAddingComponents:dayComponent toDate:[NSDate date] options:0];
            
            [[NSUserDefaults standardUserDefaults] setObject:nextDate forKey:@"NoteFetchedDate"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            NSString *headline = [Note headlineFromNoteType:note.type];
            NSString *noteText = [NSString stringWithFormat:@"%@%@", note.text, [Note endingStringOnNoteForNoteType:note.type]];
            
            [self.noteView fillNoteViewWithHeadline:headline body:noteText backgroundColor:[Note backgroundColorForNoteType:note.type] textColor:[Note textColorForNoteType:note.type]];
        }
    }
    else
    {
        [self.noteView fillNoteViewWithHeadline:@"No cheating Carly..." body:[NSString stringWithFormat:@"You have %lu hours until you can see another note from Bulbasaur", hoursUntilNextNote] backgroundColor:[UIColor lightGrayColor] textColor:[UIColor darkTextColor]];
    }
    
    [self.view addSubview:self.noteView];
    
    POPSpringAnimation *springAnimation = [POPSpringAnimation animation];
    springAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    springAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(20, 70, 325, 325)];
    springAnimation.name = @"AnimateNoteOnScreen";
    springAnimation.delegate = self;
    
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.springBounciness = 5;
    scaleAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.1, 1.2)];
    
    [self.noteView pop_addAnimation:springAnimation forKey:@"AnimateNoteOnScreen"];
    [self.imageView.layer pop_addAnimation:scaleAnimation forKey:@"ScaleBulbasaur"];
}

- (NSInteger)hoursUntilNextNote
{
    NSInteger hoursUntilNextNote = 0;
    
    NSDate *noteFetchedDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"NoteFetchedDate"];
    
    NSInteger secondsUntilNextNote = [[NSDate date] numberOfSecondsUntil:noteFetchedDate];
    hoursUntilNextNote = secondsUntilNextNote / 60 / 60;
    
    return hoursUntilNextNote;
}

@end
