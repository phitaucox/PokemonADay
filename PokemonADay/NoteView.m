//
//  NoteView.m
//  PokemonADay
//
//  Created by Cox, Christian on 8/3/16.
//  Copyright © 2016 Cox, Christian. All rights reserved.
//

#import "NoteView.h"

@implementation NoteView

- (instancetype)initWithFrame:(CGRect)frame
{
    NoteView *noteView = [[[NSBundle mainBundle] loadNibNamed: NSStringFromClass([self class]) owner:self options: nil] firstObject];
    
    noteView.frame = frame;
    
    return noteView;
}

- (void)fillNoteViewWithHeadline:(NSString *)headline body:(NSString *)body
{
    self.headlineLabel.text = headline;
    self.bodyLabel.text = body;
}

@end
