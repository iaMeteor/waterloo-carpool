#import "PostTableViewCell.h"

#import "Post.h"

#import "UIImageView+AFNetworking.h"

@implementation PostTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    
    self.textLabel.adjustsFontSizeToFitWidth = YES;
    self.textLabel.textColor = [UIColor darkGrayColor];
    self.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];
    self.detailTextLabel.numberOfLines = 0;
    self.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return self;
}

- (void)setPost:(Post *)post {
    _post = post;

    if(_post.offering){
        [self.imageView setImage:[UIImage imageNamed:@"Offer.png"]];
    } else {
        [self.imageView setImage:[UIImage imageNamed:@"LF_2.png"]];
    }
    
    self.textLabel.text = [[_post.origin stringByAppendingString:@" → "] stringByAppendingString:_post.destination];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd 'at' HH:mm"];
    self.detailTextLabel.text = [@"Departure: " stringByAppendingString:[dateFormat stringFromDate:_post.date]];

    [self setNeedsLayout];
}

+ (CGFloat)heightForCellWithPost:(Post *)post {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CGSize sizeToFit = [post.tel sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(220.0f, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
#pragma clang diagnostic pop
    return fmaxf(70.0f, (float)sizeToFit.height + 45.0f);
}

#pragma mark - UIView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(0.0f, 0.0f, 70.0f, 69.0f);
    self.textLabel.frame = CGRectMake(80.0f, 10.0f, 230.0f, 20.0f);
    
    CGRect detailTextLabelFrame = CGRectOffset(self.textLabel.frame, 0.0f, 25.0f);
    detailTextLabelFrame.size.height = [[self class] heightForCellWithPost:self.post] - 45.0f;
    self.detailTextLabel.frame = detailTextLabelFrame;
}

@end
