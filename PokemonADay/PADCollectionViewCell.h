//
//  PADCollectionViewCell.h
//  PokemonADay
//
//  Created by Cox, Christian on 9/19/16.
//  Copyright © 2016 Cox, Christian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PADCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UIView *bodyView;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;


@end
