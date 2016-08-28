//
//  PokemonADayVC.m
//  PokemonADay
//
//  Created by Cox, Christian on 7/30/16.
//  Copyright © 2016 Cox, Christian. All rights reserved.
//

#import "PokemonADayVC.h"
#import "NoteView.h"
#import <pop/POP.h>

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
    [noteView fillNoteViewWithHeadline:@"Headline" body:@"Body"];
    
    [self.view addSubview:noteView];
    
    POPSpringAnimation *springAnimation = [POPSpringAnimation animation];
    springAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    springAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(20, 60, 325, 325)];
    springAnimation.name = @"AnimateNoteOnScreen";
    springAnimation.delegate = self;
    springAnimation.springSpeed=.5f;     // value between 0-20 default at 4
    
    [noteView pop_addAnimation:springAnimation forKey:@"AnimateNoteOnScreen"];
}

@end
