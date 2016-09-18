//
//  NoteView.h
//  PokemonADay
//
//  Created by Cox, Christian on 8/3/16.
//  Copyright © 2016 Cox, Christian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteView : UIView

@property (weak, nonatomic) IBOutlet UIView *headlineView;
@property (weak, nonatomic) IBOutlet UIView *bodyView;
@property (weak, nonatomic) IBOutlet UILabel *headlineLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;

- (void)fillNoteViewWithHeadline:(NSString *)headline body:(NSString *)body backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor;

@end
