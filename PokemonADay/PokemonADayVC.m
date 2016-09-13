//
//  PokemonADayVC.m
//  PokemonADay
//
//  Created by Cox, Christian on 7/30/16.
//  Copyright © 2016 Cox, Christian. All rights reserved.
//

#import <pop/POP.h>

#import "PokemonADayVC.h"

//#import "NoteView.h"

#import "PADNotesManager.h"
#import "Note.h"

#import "NoteVC.h"

#import "PresentingAnimationController.h"
#import "DismissingAnimationController.h"

@interface PokemonADayVC ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation PokemonADayVC

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];

}

#pragma mark - Actions

- (IBAction)imageTapped:(UITapGestureRecognizer *)sender
{
    if ([self hasBeenOneDay])
    {
        Note *note = [[PADNotesManager sharedManager] fetchRandomUnseenNote];
        if (note)
        {
            POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
            scaleAnimation.springBounciness = 10;
            scaleAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.2, 1.4)];

            [self.imageView.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];

            NoteVC *noteViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"noteModal"];

            noteViewController.transitioningDelegate = self;

            noteViewController.modalPresentationStyle = UIModalPresentationCustom;
            
            NSString *headline = [Note headlineFromNoteType:note.type];
//            [noteViewController fillNoteViewWithHeadline:headline body:note.text backgroundColor:[Note backgroundColorForNoteType:note.type] textColor:[Note textColorForNoteType:note.type]];
            noteViewController.headlineLabel.text = headline;
            [self presentViewController:noteViewController animated:YES completion:nil];
        }
    }
}

#pragma mark - Utilities

- (BOOL)hasBeenOneDay
{
    BOOL hasBeenOneDay = YES;
    
//    NSString *lastSeenDateString = [[NSUserDefaults standardUserDefaults] stringForKey:@"LastNoteSeenDateString"];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
//    NSDate *lastSeenDate = [dateFormatter dateFromString:lastSeenDateString];
//    NSDate *currentDate = [dateFormatter defaultDate];
    
//    NSDate *oneDayAgo = [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay value:-1 toDate:[NSDate date] options:0];
    
    return hasBeenOneDay;
}

#pragma mark - UIViewControllerTransitionDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[PresentingAnimationController alloc] init];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[DismissingAnimationController alloc] init];
}

@end
