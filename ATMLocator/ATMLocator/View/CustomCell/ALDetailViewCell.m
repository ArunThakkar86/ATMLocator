//
//  ALDetailViewCell.m
//  ATMLocator
//
//  Created by Zensar on 24/03/17.
//  Copyright © 2017 Zensar. All rights reserved.
//

#import "ALDetailViewCell.h"

@implementation ALDetailViewCell

@end

@implementation StoreBasicDetailCell
- (void)setStoreBasicDetailCellWithStoreData:(ALATMInfo *)storeLocatorObj{
    _lblStoreName.text = storeLocatorObj.name;
    _lblAddress.text = storeLocatorObj.address;
    _lblCity.text = storeLocatorObj.city;
    _lblStateZip.text = [NSString stringWithFormat:@"%@ - %@",storeLocatorObj.state,storeLocatorObj.zip];
}

@end

@implementation StoreContactCell
- (void)setStoreContactCellWithStoreData:(ALATMInfo *)storeLocatorObj{
    _lblContact.text = storeLocatorObj.phone;
}

@end

@implementation StoreBranchTimingCell
- (void)setStoreBranchTimingCellWithStoreData:(ALATMInfo *)storeLocatorObj {
    NSArray *arrayLobbyHrs = storeLocatorObj.lobbyHrs;
    if(arrayLobbyHrs.count >0 && arrayLobbyHrs.count ==7){
        _lblLobbyMon.text = arrayLobbyHrs[1];
        _lblLobbyTue.text = arrayLobbyHrs[2];
        _lblLobbyWed.text = arrayLobbyHrs[3];
        _lblLobbyThu.text = arrayLobbyHrs[4];
        _lblLobbyFri.text = arrayLobbyHrs[5];
        _lblLobbySat.text = arrayLobbyHrs[6];
    }
    
    NSArray *arrayDriveHrs = storeLocatorObj.driveUpHrs;
    if(arrayDriveHrs.count >0 && arrayDriveHrs.count ==7){
        _lblDriveMon.text = arrayDriveHrs[1];
        _lblDriveTue.text = arrayDriveHrs[2];
        _lblDriveWed.text = arrayDriveHrs[3];
        _lblDriveThu.text = arrayDriveHrs[4];
        _lblDriveFri.text = arrayDriveHrs[5];
        _lblDriveSat.text = arrayDriveHrs[6];
    }
    
}

@end

@implementation StoreServiceCell
- (void)setStoreServiceCellWithStoreData:(ALATMInfo *)storeLocatorObj {
    
    NSArray *arrayService = storeLocatorObj.services;
    NSString *services = @"";
    if(arrayService.count >0){
        
        
        for(int i = 0; i< arrayService.count; i++){
            services = [NSString stringWithFormat:@"%@\n %@\n",services,arrayService[i]];
        }
        NSLog(@"***** services : %@",services);
        _lblService.text = services;
    }
    
    
    
}

@end