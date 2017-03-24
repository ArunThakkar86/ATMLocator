//
//  ALDetailViewCell.h
//  ATMLocator
//
//  Created by Zensar on 24/03/17.
//  Copyright © 2017 Zensar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALATMInfo.h"

@interface ALDetailViewCell : UITableViewCell

@end

@interface StoreBasicDetailCell: UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblStoreName;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblCity;
@property (weak, nonatomic) IBOutlet UILabel *lblStateZip;

- (void)setStoreBasicDetailCellWithStoreData:(ALATMInfo *)storeLocatorObj;

@end

@interface StoreContactCell: UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnContact;
@property (weak, nonatomic) IBOutlet UILabel *lblContact;

- (void)setStoreContactCellWithStoreData:(ALATMInfo *)storeLocatorObj;

@end

@interface StoreBranchTimingCell: UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblLobbyMon;
@property (weak, nonatomic) IBOutlet UILabel *lblLobbyTue;
@property (weak, nonatomic) IBOutlet UILabel *lblLobbyWed;
@property (weak, nonatomic) IBOutlet UILabel *lblLobbyThu;
@property (weak, nonatomic) IBOutlet UILabel *lblLobbyFri;
@property (weak, nonatomic) IBOutlet UILabel *lblLobbySat;

@property (weak, nonatomic) IBOutlet UILabel *lblDriveMon;
@property (weak, nonatomic) IBOutlet UILabel *lblDriveTue;
@property (weak, nonatomic) IBOutlet UILabel *lblDriveWed;
@property (weak, nonatomic) IBOutlet UILabel *lblDriveThu;
@property (weak, nonatomic) IBOutlet UILabel *lblDriveFri;
@property (weak, nonatomic) IBOutlet UILabel *lblDriveSat;

- (void)setStoreBranchTimingCellWithStoreData:(ALATMInfo *)storeLocatorObj;

@end

@interface StoreServiceCell: UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblService;

- (void)setStoreServiceCellWithStoreData:(ALATMInfo *)storeLocatorObj;

@end
