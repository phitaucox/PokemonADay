//
//  NoteModalViewController.m
//  PokemonADay
//
//  Created by Cox, Christian on 9/21/16.
//  Copyright © 2016 Cox, Christian. All rights reserved.
//

#import "NoteModalViewController.h"

@interface NoteModalViewController ()

@end

@implementation NoteModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.layer.cornerRadius = 9.f;
}

- (IBAction)swipeUpRecognized:(UISwipeGestureRecognizer *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
