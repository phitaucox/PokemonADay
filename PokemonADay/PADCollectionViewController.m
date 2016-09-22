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
#import "PresentingAnimationController.h"
#import "DismissingAnimationController.h"
#import "NoteModalViewController.h"

@interface PADCollectionViewController ()

@property (nonatomic, strong) NSArray <Note *> *seenNotes;

@end

@implementation PADCollectionViewController

static NSString * const reuseIdentifier = @"PADCollectionViewCell";

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumLineSpacing = 5;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 25, 20, 25);
        flowLayout.itemSize = CGSizeMake(160.f, 160.f);
        
        // Set up the collection view
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.backgroundColor = [UIColor colorWithRed:0.67 green:0.99 blue:0.85 alpha:1.0];
        
        [self.collectionView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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

    cell.layer.borderWidth = 1.f;
    cell.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    cell.headerView.backgroundColor = [[Note backgroundColorForNoteType:note.type] colorWithAlphaComponent:0.75f];
    cell.headerLabel.text = [Note headlineFromNoteType:note.type];
    cell.headerLabel.textColor = [Note textColorForNoteType:note.type];
    
    cell.bodyView.backgroundColor = [Note backgroundColorForNoteType:note.type];
    cell.bodyLabel.text = note.text;
    cell.bodyLabel.textColor = [Note textColorForNoteType:note.type];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Note *note = self.seenNotes[indexPath.item];
    
    NoteModalViewController *modalVC = [self.storyboard instantiateViewControllerWithIdentifier:@"noteModal"];
    
    modalVC.note = note;
    
    modalVC.transitioningDelegate = self;
    
    modalVC.modalPresentationStyle = UIModalPresentationCustom;
    
    [self.navigationController presentViewController:modalVC animated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitionDelegate -

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[PresentingAnimationController alloc] init];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[DismissingAnimationController alloc] init];
}

@end
