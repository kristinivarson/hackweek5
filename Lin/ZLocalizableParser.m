//
//  ZLocalizableParser.m
//  Lin
//
//  Created by Kristin Ivarson on 6/7/13.
//  Copyright (c) 2013 Kristin Ivarson. All rights reserved.
//

#import "ZLocalizableParser.h"

@implementation ZLocalizableParser

+ (NSString *)getLibraryNameFromStringsFilename:(NSString *)filename
{
    if ([filename rangeOfString:@"lib"].location == NSNotFound)
    {
        return @"Main";
    }
    
    NSArray* pathComponents = [filename componentsSeparatedByString:@"/"];
    if (pathComponents == nil || [pathComponents count] <= 4)
    {
        return @"Unknown";
    }

    return [pathComponents objectAtIndex:([pathComponents count] - 4)];
}

+ (NSString *)getLibraryNameFromSourceFilename:(NSString *)name
{
    if ([name rangeOfString:@"lib"].location == NSNotFound)
    {
        return @"Main";
    }
    NSArray* pathComponents = [name componentsSeparatedByString:@"/"];
    return [pathComponents objectAtIndex:([pathComponents count] - 3)];
}

+ (NSString *)getBestStringsFileForFile:(NSString *)fileName fromList:(NSArray *)stringFiles
{
    
    NSString *longestPrefix = nil;
    NSString *bestStringsMatch = nil;
    for(NSString *stringsFile in stringFiles)
    {
        if ([[ZLocalizableParser getLibraryNameFromSourceFilename:fileName]
            isEqualToString:[ZLocalizableParser getLibraryNameFromStringsFilename:stringsFile]])
        {
            return stringsFile;
        }
        
        NSString *commonPrefix = [fileName commonPrefixWithString:stringsFile options:0];
        if (longestPrefix == nil || longestPrefix.length < commonPrefix.length)
        {
            longestPrefix = commonPrefix;
            bestStringsMatch = stringsFile;
        }
    }
    return bestStringsMatch;
}

@end
