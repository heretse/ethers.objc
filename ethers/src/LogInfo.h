//
//  LogInfo.h
//  ethers
//
//  Created by Winston Hsieh on 2018/5/17.
//  Copyright © 2018 Ethers. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Address.h"
#import "BigNumber.h"
#import "Hash.h"

@interface LogInfo : NSObject <NSCopying>

+ (instancetype)logInfoFromDictionary:(NSDictionary*)info;

@property (nonatomic, strong, nonnull) Address *address;

@property (nonatomic, strong, nonnull) NSArray<Hash *> *topics;

@property (nonatomic, strong, nonnull) NSData *data;

@property (nonatomic, strong, nonnull) BigNumber *blockNumber;

@property (nonatomic, assign) NSTimeInterval timestamp;

@property (nonatomic, readonly) BigNumber *gasPrice;

@property (nonatomic, readonly) BigNumber *gasUsed;

@property (nonatomic, readonly) Hash *transactionHash;

@end
