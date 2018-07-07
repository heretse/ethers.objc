//
//  LogInfo.m
//  ethers
//
//  Created by Winston Hsieh on 2018/5/17.
//  Copyright © 2018 Ethers. All rights reserved.
//

#import "LogInfo.h"

@implementation LogInfo


+ (instancetype)logInfoFromDictionary:(NSDictionary *)info {
    return [[LogInfo alloc] initWithDictionary:info];
}

- (instancetype)initWithDictionary: (NSDictionary*)info {
    self = [super init];
    
    if (self) {
        
        _address = [Address addressWithString:[info objectForKey:@"address"]];
        if (!_address) {
            NSLog(@"ERROR: Invalid Address");
            return nil;
        }
        
        NSMutableArray *mutableTopics = [[NSMutableArray alloc] init];
        
        NSArray *topicsArray = info[@"topics"];
        if (topicsArray.count > 0) {
            Hash *topic0 = [Hash hashWithHexString:[info[@"topics"] objectAtIndex:0]];
            if (!topic0) {
                [mutableTopics setObject:topic0 atIndexedSubscript:0];
            }
        }
        
        if (topicsArray.count > 1) {
            Hash *topic1 = [Hash hashWithHexString:[info[@"topics"] objectAtIndex:1]];
            if (!topic1) {
                [mutableTopics setObject:topic1 atIndexedSubscript:1];
            }
        }
        
        if (topicsArray.count > 2) {
            Hash *topic2 = [Hash hashWithHexString:[info[@"topics"] objectAtIndex:2]];
            if (!topic2) {
                [mutableTopics setObject:topic2 atIndexedSubscript:2];
            }
        }
        
        if (topicsArray.count > 3) {
            Hash *topic3 = [Hash hashWithHexString:[info[@"topics"] objectAtIndex:3]];
            if (!topic3) {
                [mutableTopics setObject:topic3 atIndexedSubscript:3];
            }
        }
        
        _topics = [NSArray arrayWithArray:mutableTopics];
        
        _blockNumber = [BigNumber bigNumberWithHexString:[info objectForKey:@"blockNumber"]];
        if (!_blockNumber) {
            _blockNumber = [BigNumber bigNumberWithInteger:-1];
        }
        
        NSString *timestamp = [info objectForKey:@"timeStamp"];
        if (timestamp) {
            if ([timestamp hasPrefix:@"0x"]) {
                _timestamp = [[NSNumber numberWithUnsignedInteger:[BigNumber bigNumberWithHexString:timestamp].unsignedIntegerValue] longLongValue];
            } else {
                _timestamp = [timestamp longLongValue];
            }
        } else {
            _timestamp = [[NSDate date] timeIntervalSince1970];
        }
        
        _gasPrice = [BigNumber bigNumberWithHexString:[info objectForKey:@"gasPrice"]];
        if (!_gasPrice) {
            NSLog(@"ERROR: Missing gasPrice");
            return nil;
        }
        
        _gasUsed = [BigNumber bigNumberWithHexString:[info objectForKey:@"gasUsed"]];
        if (!_gasUsed) {
            NSLog(@"ERROR: Missing gasUsed");
            return nil;
        }
        
        _transactionHash = [Hash hashWithHexString:[info objectForKey:@"transactionHash"]];
        if (!_transactionHash) {
            NSLog(@"ERROR: Missing transactionHash");
            return nil;
        }
    }
    
    return self;
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone {
    return self;
}

#pragma mark - NSObject

- (NSString*)description {
    return [NSString stringWithFormat:@"<LogInfo address=%@ blockNumber=%@ timestamp=%@ _gasPrice=%@ _gasUsed=%@ _transactionHash=%@ >",
            [_address checksumAddress], _topics, [_blockNumber decimalString], [NSDate dateWithTimeIntervalSince1970:_timestamp],
            [_gasPrice decimalString], [_gasUsed decimalString], [_transactionHash hexString]];
}

@end
