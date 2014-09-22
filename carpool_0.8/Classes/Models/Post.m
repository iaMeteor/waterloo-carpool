#import "Post.h"

#import "AFAppDotNetAPIClient.h"

@implementation Post

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) { // test whether [super init] works or not
        return nil;
    }
    
    //self.postID = (NSUInteger)[[attributes objectForKey:@"id"] integerValue];
    self.tel = [attributes objectForKey:@"tel"];
    if(self.tel == (id)[NSNull null] || self.tel.length == 0) {self.tel = @"";};
    
    self.origin = [attributes objectForKey:@"origin"];
    if(self.origin == (id)[NSNull null] || self.origin.length == 0) {self.origin = @"";};
    
    self.destination = [attributes objectForKey:@"destination"];
    if(self.destination == (id)[NSNull null] || self.destination.length == 0) {self.destination = @"";};
    
    self.offering = ([[attributes objectForKey:@"off_LF"] isEqualToNumber:@1]) ? TRUE:FALSE;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMddHHmm"];
    self.date = [dateFormat dateFromString:[attributes objectForKey:@"date_time"]];

    self.name = [attributes objectForKey:@"name"];
    if(self.name == (id)[NSNull null] || self.name.length == 0) {self.name = @"";};
    
    self.price = [attributes objectForKey:@"price"];
    if(self.price == (id)[NSNull null] ) {self.price = @0;};
    
    return self;
}

//#pragma mark - is used to tag the group of methods so you may easily find and detect methods from the Jump Bar. It may help you when your code files reach about 1000 lines and you want to find methods quickly through the category from Jump box.
#pragma mark -

+ (NSURLSessionDataTask *)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block {
    //the URL here will be connected to the end of the base URL
    return [[AFAppDotNetAPIClient sharedClient] GET:@"posts" parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        
             NSArray *postsFromResponse = JSON;
        
        NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];

        for (NSDictionary *attributes in postsFromResponse) {
            Post *post = [[Post alloc] initWithAttributes:attributes];
            [mutablePosts addObject:post];
        }
        
        mutablePosts = [NSMutableArray arrayWithArray:[[mutablePosts reverseObjectEnumerator] allObjects]];

        if (block) {
            block([NSArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
    
}


@end
