//
//  ALATMInfo.h
//  ATMLocator
//
//  Created by Zensar on 24/03/17.
//  Copyright © 2017 Zensar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALATMInfo : NSObject
@property(nonatomic,strong)NSString *state ;
@property(nonatomic,strong)NSString *locType ;
@property(nonatomic,strong)NSString *label ;
@property(nonatomic,strong)NSString *address ;
@property(nonatomic,strong)NSString *city ;
@property(nonatomic,strong)NSString *zip ;
@property(nonatomic,strong)NSString *name ;
@property(nonatomic,strong)NSString *lat ;
@property(nonatomic,strong)NSString *lng ;
@property(nonatomic,strong)NSString *bank ;
@property(nonatomic,strong)NSString *type ;
@property(nonatomic,strong)NSArray *lobbyHrs ;
@property(nonatomic,strong)NSArray *driveUpHrs ;
@property(nonatomic,strong)NSString *atms ;
@property(nonatomic,strong)NSArray *services ;
@property(nonatomic,strong)NSString *phone ;
@property(nonatomic,strong)NSString *distance;
@end
