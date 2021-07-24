//
//  NSString+URLEncoding.m
//
//  Created by Jon Crosby on 10/19/07.
//  Copyright 2007 Kaboomerang LLC. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


#import "NSString+URLEncoding.h"


@implementation NSString (OAURLEncodingAdditions)

- (NSString *)URLEncodedString 
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (CFStringRef)self,
                                                                           NULL,
																		   CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                           kCFStringEncodingUTF8));

	return result;
}

- (NSString*)URLDecodedString
{
	NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
																						   (CFStringRef)self,
																						   CFSTR(""),
																						   kCFStringEncodingUTF8));

	return result;
}

+ (NSString *)serializeURL:(NSString *)baseURL params:(NSDictionary *)params
{
    NSURL* parsedURL = [NSURL URLWithString:baseURL];
    NSString* queryPrefix = parsedURL.query ? @"&" : @"?";

    NSMutableArray* pairs = [NSMutableArray array];
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id<NSObject> obj, BOOL *stop) {
        if (([obj isKindOfClass:[UIImage class]])
            ||([obj isKindOfClass:[NSData class]]))
        {
        } else {
            NSString *escaped_key = [key URLEncodedString];
            NSString *escaped_value = [obj.description URLEncodedString];
            [pairs addObject:[NSString stringWithFormat:@"%@=%@", escaped_key, escaped_value]];
        }
    }];
    NSString* query = [pairs componentsJoinedByString:@"&"];

    return [NSString stringWithFormat:@"%@%@%@", baseURL, queryPrefix, query];
}


@end
