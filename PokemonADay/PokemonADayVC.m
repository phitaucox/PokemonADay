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

@interface PokemonADayVC ()

@property (nonatomic, strong) NoteView *noteView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation PokemonADayVC

- (void)viewDidLoad
{
    [super viewDidLoad];

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
    
    if ([self secondsUntilNextNote] < 1)
    {
        Note *note = [[PADNotesManager sharedManager] fetchRandomUnseenNote];
        NSString *headline = [Note headlineFromNoteType:note.type];
        [self.noteView fillNoteViewWithHeadline:headline body:note.text backgroundColor:[Note backgroundColorForNoteType:note.type] textColor:[Note textColorForNoteType:note.type]];
    }
    else
    {
        [self.noteView fillNoteViewWithHeadline:@"No cheating Carly..." body:[NSString stringWithFormat:@"You have %lu seconds until you can see another note from Bulbasaur.", [self secondsUntilNextNote]] backgroundColor:[UIColor lightGrayColor] textColor:[UIColor whiteColor]];
    }
    
    [self.view addSubview:self.noteView];
    
    POPSpringAnimation *springAnimation = [POPSpringAnimation animation];
    springAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    springAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(20, 60, 325, 325)];
    springAnimation.name = @"AnimateNoteOnScreen";
    springAnimation.delegate = self;
    springAnimation.springSpeed= 0.5f;
    
    [self.noteView pop_addAnimation:springAnimation forKey:@"AnimateNoteOnScreen"];
}

- (NSUInteger)secondsUntilNextNote
{
    NSUInteger secondsUntilNextNote = 0;
    
    return secondsUntilNextNote;
}

@end
