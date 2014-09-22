#import <Foundation/Foundation.h>

@interface Post : NSObject

//@property (nonatomic, assign) NSUInteger postID;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSString *origin;
@property (nonatomic, strong) NSString *destination;
@property (nonatomic)         Boolean offering;
@property (nonatomic, strong) NSDate   *date;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *price;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (NSURLSessionDataTask *)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block;

@end
