//
//  NoteModalViewController.m
//  PokemonADay
//
//  Created by Cox, Christian on 9/21/16.
//  Copyright © 2016 Cox, Christian. All rights reserved.
//

#import "NoteModalViewController.h"

#import "NoteView.h"

@interface NoteModalViewController ()

@end

@implementation NoteModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.layer.cornerRadius = 9.f;
    
    if (self.note)
    {
        [self buildNoteView];
    }
}

- (IBAction)swipeUpRecognized:(UISwipeGestureRecognizer *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)buildNoteView
{
    NoteView *noteView = [[NoteView alloc] initWithFrame:CGRectMake(0, 0, 275.f, 357.f)];
    
    NSString *headline = [Note headlineFromNoteType:self.note.type];
    NSString *noteText = [NSString stringWithFormat:@"%@%@", self.note.text, [Note endingStringOnNoteForNoteType:self.note.type]];
    
    [noteView fillNoteViewWithHeadline:headline body:noteText backgroundColor:[Note backgroundColorForNoteType:self.note.type] textColor:[Note textColorForNoteType:self.note.type]];
    
    [self.view addSubview:noteView];
}

@end
