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

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation PokemonADayVC

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (IBAction)imageTapped:(UITapGestureRecognizer *)sender
{
    NoteView *noteView = [[NoteView alloc] initWithFrame:CGRectZero];
    noteView.center = self.view.center;
    
    Note *note = [[PADNotesManager sharedManager] fetchRandomUnseenNote];
    NSString *headline = [Note headlineFromNoteType:note.type];
    [noteView fillNoteViewWithHeadline:headline body:note.text backgroundColor:[Note backgroundColorForNoteType:note.type] textColor:[Note textColorForNoteType:note.type]];
    
    [self.view addSubview:noteView];
    
    POPSpringAnimation *springAnimation = [POPSpringAnimation animation];
    springAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    springAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(20, 60, 325, 325)];
    springAnimation.name = @"AnimateNoteOnScreen";
    springAnimation.delegate = self;
    springAnimation.springSpeed= 0.5f;
    
    [noteView pop_addAnimation:springAnimation forKey:@"AnimateNoteOnScreen"];
}

@end
