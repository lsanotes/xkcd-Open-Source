//
//  Comic.m
//  xkcd Open Source
//
//  Created by Mike on 5/14/15.
//  Copyright (c) 2015 Mike Amaral. All rights reserved.
//

#import "Comic.h"

@implementation Comic


#pragma mark - Initialization

+ (instancetype)comicFromDictionary:(NSDictionary *)dictionary {
    return [[[self class] alloc] initComicWithDictionary:dictionary];
}

- (instancetype)initComicWithDictionary:(NSDictionary *)dictionary {
    self = [super init];

    self.num = [dictionary[kNumKey] integerValue] ?: kDefaultComicNum;
    self.comicID = [dictionary[kNumKey] stringValue] ?: @"0";
    self.title = dictionary[kTitleKey] ?: @"";
    self.safeTitle = dictionary[kSafeTitleKey] ?: @"";
    self.alt = dictionary[kAltKey] ?: @"";
    self.transcript = dictionary[kTranscriptKey] ?: @"";
    self.imageURLString = dictionary[kImageURLStringKey] ?: @"";
    self.day = dictionary[kDayKey] ?: @"";
    self.month = dictionary[kMonthKey] ?: @"";
    self.year = dictionary[kYearKey] ?: @"";
    self.aspectRatio = dictionary[kAspectRatioKey] ? [dictionary[kAspectRatioKey] floatValue] : kDefaultAspectRatio;
    self.viewed = NO;
    self.favorite = NO;

    NSString *month = self.month.length > 0 ? [[[NSDateFormatter new] monthSymbols] objectAtIndex:([self.month integerValue] - 1)] : @"";
    self.formattedDateString = (month.length > 0 && self.day.length > 0 && self.year.length > 0) ? [NSString stringWithFormat:@"%@ %@, %@", month, self.day, self.year] : @"";

    return self;
}

+ (NSString *)primaryKey {
    return @"comicID";
}


#pragma mark - Sharing

- (NSURL *)generateShareURL {
    return [NSURL URLWithString:self.num > 0 ? [NSString stringWithFormat:@"%@/%ld", kShareURLBase, (long)self.num] : kShareURLBase];
}


#pragma mark - Test utilities

+ (NSDictionary *)comicDictForTestsWithID:(NSInteger)comicID {
    NSInteger rand = arc4random_uniform(5000);
    return @{
             kNumKey: @(comicID),
             kTitleKey: [NSString stringWithFormat:@"Title%ld", (long)rand],
             kSafeTitleKey: [NSString stringWithFormat:@"Safe Title%ld", (long)rand],
             kAltKey: [NSString stringWithFormat:@"Alt%ld", (long)rand],
             kTranscriptKey: [NSString stringWithFormat:@"Transcript%ld", (long)rand],
             kImageURLStringKey: [NSString stringWithFormat:@"www.xkcd.com/comics/%ld", (long)rand],
             kDayKey: [NSString stringWithFormat:@"%ld", (long)(arc4random_uniform(30) + 1)],
             kMonthKey: [NSString stringWithFormat:@"%ld", (long)(arc4random_uniform(11) + 1)],
             kYearKey: [NSString stringWithFormat:@"%ld", (long)(arc4random_uniform(1983) + 1)],
             kAspectRatioKey: @(rand)
             };
}

@end
