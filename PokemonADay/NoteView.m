//
//  NoteView.m
//  PokemonADay
//
//  Created by Cox, Christian on 8/3/16.
//  Copyright © 2016 Cox, Christian. All rights reserved.
//

#import "NoteView.h"

#import <QuartzCore/QuartzCore.h>

@implementation NoteView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self = [[[NSBundle mainBundle] loadNibNamed: NSStringFromClass([self class]) owner:self options: nil] firstObject];
        
        self.layer.cornerRadius = 9.f;
        self.layer.masksToBounds = YES;
        self.frame = frame;
    }
    
    return self;
}

- (void)fillNoteViewWithHeadline:(NSString *)headline body:(NSString *)body backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor
{
    self.headlineLabel.text = headline;
    self.bodyLabel.text = body;
    
    self.headlineView.backgroundColor = [backgroundColor colorWithAlphaComponent:0.75f];
    self.headlineLabel.textColor = textColor;
    
    self.bodyView.backgroundColor = backgroundColor;
    self.bodyLabel.textColor = textColor;
}

@end
