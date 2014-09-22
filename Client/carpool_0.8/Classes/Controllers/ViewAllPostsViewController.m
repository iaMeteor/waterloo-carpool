#import "ViewAllPostsViewController.h"

#import "Post.h"

#import "PostTableViewCell.h"

#import "UIRefreshControl+AFNetworking.h"
#import "UIAlertView+AFNetworking.h"
#import "DetailViewController.h"

//#import "AFHTTPSessionManager.h"

@interface ViewAllPostsViewController ()
@property (readwrite, nonatomic, strong) NSArray *posts;
@property (readwrite, nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation ViewAllPostsViewController

- (void)reload:(__unused id)sender {
    NSURLSessionTask *task = [Post globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        if (!error) {
            self.posts = posts;
            [self.tableView reloadData];

        }
    }];
    
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
    
    [self.refreshControl setRefreshingWithStateOfTask:task];
   
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    
    self.title = NSLocalizedString(@"Carpool", nil);

    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, 100.0f)];
    [self.refreshControl addTarget:self action:@selector(reload:) forControlEvents:UIControlEventValueChanged];
    [self.tableView.tableHeaderView addSubview:self.refreshControl];

    self.tableView.rowHeight = 70.0f;
    
/*    AFHTTPSessionManager * Manager = [AFHTTPSessionManager manager];
    //NSURL *url = [NSURL URLWithString:@"http://carpool-waterloo.herokuapp.com/"];
    // NSURL *url = [NSURL URLWithString:@"http://carpooltest1234.herokuapp.com/"];
    //NSURL *url = [NSURL URLWithString:@"http://pacific-reef-2211.herokuapp.com/"];
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/Carpool_0.8/"];
    
    
    Manager.responseSerializer = [AFJSONResponseSerializer serializer];
    Manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [Manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"admin" password:@"nimda"];
    
*/
    
    
    [self reload:nil];
}

#pragma mark - UITableViewDataSource
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self reload:nil];
}

//Tells the data source to return the number of rows in a given section of a table view. (required)
- (NSInteger)tableView:(__unused UITableView *)tableView
 numberOfRowsInSection:(__unused NSInteger)section
{
    return (NSInteger)[self.posts count];
}

//Asks the data source for a cell to insert in a particular location of the table view. (required)
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[PostTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.post = [self.posts objectAtIndex:(NSUInteger)indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(__unused UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [PostTableViewCell heightForCellWithPost:[self.posts objectAtIndex:(NSUInteger)indexPath.row]];
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //Perform a segue.
    [self performSegueWithIdentifier:@"Detailed View"
                              sender:[self.posts objectAtIndex:indexPath.row]];
    
     
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Detailed View"]) {
        if ([segue.destinationViewController isKindOfClass:[DetailViewController class]]) {
            DetailViewController* dvc = (DetailViewController *)segue.destinationViewController;
            dvc.post = sender;
        }
    }
}

@end
