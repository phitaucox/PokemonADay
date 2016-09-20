//
//  PADCollectionViewCell.m
//  PokemonADay
//
//  Created by Cox, Christian on 9/19/16.
//  Copyright © 2016 Cox, Christian. All rights reserved.
//

#import "PADCollectionViewCell.h"

@implementation PADCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.cornerRadius = 9.f;
    self.layer.masksToBounds = YES;
}

@end
