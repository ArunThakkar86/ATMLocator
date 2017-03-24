//
//  ALDetailViewController.m
//  ATMLocator
//
//  Created by Zensar on 24/03/17.
//  Copyright © 2017 Zensar. All rights reserved.
//

#import "ALDetailViewController.h"
#import "ALAppUtility.h"
#import "ALDetailViewCell.h"

typedef enum : NSUInteger {
    StoreBasicDetailSec,
    StoreContactSec,
    StoreBranchTimingSec,
    StoreServiceSec
    
} StoreTableSection;

@interface ALDetailViewController () <UITableViewDataSource, UITableViewDelegate> {
    
}
@property (weak, nonatomic) IBOutlet UITableView *tblStore;

@end

@implementation ALDetailViewController

- (void)viewDidLoad{
    [super viewDidLoad];
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self getSelectedObject];
    
}

- (void)getSelectedObject{
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", _selectedMarker.title];
        NSArray *results = [_atmList filteredArrayUsingPredicate:predicate];
        if(results.count > 0){
            dispatch_async( dispatch_get_main_queue(), ^{
                _selectedATM = [results objectAtIndex:0];
                [ALAppUtility dismissProgressView];
                [_tblStore reloadData];
            });

        }
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(_selectedATM)
        return 4;
    else
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = nil;
    // Configure the cell...
    if (indexPath.section == StoreBasicDetailSec) {
        CellIdentifier = @"StoreBasicDetailCell";
        StoreBasicDetailCell *cell = (StoreBasicDetailCell *)[ALAppUtility tableView:tableView
                                                                   cellWithIdentifier:CellIdentifier
                                                                            indexPath:indexPath];
        [cell setStoreBasicDetailCellWithStoreData:self.selectedATM];
        return cell;
    } else if (indexPath.section == StoreContactSec) {
        CellIdentifier = @"StoreContactCell";
        StoreContactCell *cell = (StoreContactCell *)[ALAppUtility tableView:tableView
                                                           cellWithIdentifier:CellIdentifier
                                                                    indexPath:indexPath];
        [cell setStoreContactCellWithStoreData:self.selectedATM];
        return cell;
    } else if (indexPath.section == StoreBranchTimingSec){
        CellIdentifier = @"StoreBranchTimingCell";
        StoreBranchTimingCell *cell = (StoreBranchTimingCell *)[ALAppUtility tableView:tableView
                                                                     cellWithIdentifier:CellIdentifier
                                                                              indexPath:indexPath];
        [cell setStoreBranchTimingCellWithStoreData:self.selectedATM];
        return cell;
    } else if (indexPath.section == StoreServiceSec){
        CellIdentifier = @"StoreServiceCell";
        StoreServiceCell *cell = (StoreServiceCell *)[ALAppUtility tableView:tableView
                                                           cellWithIdentifier:CellIdentifier
                                                                    indexPath:indexPath];
        [cell setStoreServiceCellWithStoreData:self.selectedATM];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == StoreBasicDetailSec) {
        return 120.0f;
    } else if (indexPath.section == StoreContactSec) {
        return 60.0f;
    } else if (indexPath.section == StoreBranchTimingSec) {
        return 180.0f; //110.0f;
    } else if (indexPath.section == StoreServiceSec) {
        return 170.0f; // amenities + header
    }
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    //    if (section == StoreAmenitiesSec)
    //        return 0.01f;
    return 2.0f;
}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == StoreContactSec) {
        if (indexPath.row == 0){
            [self phoneAction];
        }
    }
}
//#pragma mark - store contact -
//
- (void)phoneAction {
    UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"ATM Locator"  message:@"Please click one number to make a call"  preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSArray *phoneNums = [self.selectedATM.phone componentsSeparatedByString:@","];
    
    for (NSString *phoneNum in phoneNums) {
        [alertController addAction:[UIAlertAction actionWithTitle:phoneNum style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self dismissViewControllerAnimated:YES completion:nil];
            [ALAppUtility callTo:action.title];
        }]];
    }
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
