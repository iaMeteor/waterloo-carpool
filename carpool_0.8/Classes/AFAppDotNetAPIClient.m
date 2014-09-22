#import "AFAppDotNetAPIClient.h"

//static NSString * const AFAppDotNetAPIBaseURLString = @"http://carpool-waterloo.herokuapp.com/";
static NSString * const AFAppDotNetAPIBaseURLString = @"http://carpooltest1234.herokuapp.com/";
//static NSString * const AFAppDotNetAPIBaseURLString = @"http://pacific-reef-2211.herokuapp.com/";
//static NSString * const AFAppDotNetAPIBaseURLString = @"http://localhost:8080/Carpool_0.8/";





@implementation AFAppDotNetAPIClient

+ (instancetype)sharedClient {
    static AFAppDotNetAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    });
    
    return _sharedClient;
}

@end
