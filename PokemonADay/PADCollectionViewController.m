//
//  PADCollectionViewController.m
//  PokemonADay
//
//  Created by Cox, Christian on 9/18/16.
//  Copyright © 2016 Cox, Christian. All rights reserved.
//

#import "PADCollectionViewController.h"

#import "Note.h"
#import "PADNotesManager.h"
#import "PADCollectionViewCell.h"

@interface PADCollectionViewController ()

@property (nonatomic, strong) NSArray <Note *> *seenNotes;

@end

@implementation PADCollectionViewController

static NSString * const reuseIdentifier = @"PADNoteCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[PADCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.seenNotes = [[PADNotesManager sharedManager] fetchSeenNotes];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.seenNotes count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PADCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    Note *note = self.seenNotes[indexPath.item];
    
    cell.noteLabel.text = note.text;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath 
{
    return YES;
}
*/

@end
