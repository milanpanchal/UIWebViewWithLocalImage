//
//  NSURLProtocolCustom.m
//  UIWebViewWithLocalImage
//
//  Created by Milan Panchal on 10/5/15.
//  Copyright (c) 2015 Pantech. All rights reserved.
//

#import "NSURLProtocolCustom.h"

@implementation NSURLProtocolCustom

+ (BOOL)canInitWithRequest:(NSURLRequest*)theRequest {
    
    if ([theRequest.URL.scheme caseInsensitiveCompare:@"testApp"] == NSOrderedSame) {
        return YES;
    }
    return NO;
}

+ (NSURLRequest*)canonicalRequestForRequest:(NSURLRequest*)theRequest {
    return theRequest;
}

- (void)startLoading {
    NSLog(@"%@", self.request.URL);
    
    NSString *urlString = [self.request.URL absoluteString];
    
    NSArray *splitArray = [urlString componentsSeparatedByString:@"://"];
    NSString *imageName;
    NSString *imageExtention = @"png";
    
    if (splitArray.count >= 2) {
        
        NSString *imageNameWithExtention = splitArray[1];
        NSRange range = [imageNameWithExtention rangeOfString:@"." options:NSBackwardsSearch];
        
        if (range.location != NSNotFound) {
            imageName = [imageNameWithExtention substringToIndex:range.location];
            imageExtention = [imageNameWithExtention substringFromIndex:range.location+1];
        }
        
    }
    
    NSString *mimeType = [NSString stringWithFormat:@"image/%@",splitArray[1]];
    
    NSURLResponse *response = [[NSURLResponse alloc] initWithURL:[self.request URL]
                                                        MIMEType:mimeType
                                           expectedContentLength:-1
                                                textEncodingName:nil];
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:imageExtention];
    NSData *data = [NSData dataWithContentsOfFile:imagePath];
    
    [[self client] URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    [[self client] URLProtocol:self didLoadData:data];
    [[self client] URLProtocolDidFinishLoading:self];
}

- (void)stopLoading {
    NSLog(@"something went wrong!");
}

@end
