//
//  ViewController.m
//  Flixter
//
//  Created by Lily Yang on 6/15/22.
//

#import "ViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"

@interface ViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    
    [self fetchMovies];
    
    self.refreshControl = [[UIRefreshControl alloc] init]; // initializes refreshControl
    
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    // when refreshControl is triggered, will call fetchMovies
    
    [self.tableView addSubview:self.refreshControl]; // attached refreshControl to tableView; so when tableView is scrolled down, refreshControl will trigger
}

- (void) fetchMovies{
    // Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=16503f820f445513ebe949269c4a4684"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//               NSLog(@"%@", dataDictionary);// log an object with the %@ formatter.
               self.movies = dataDictionary[@"results"];
               // TODO: Get the array of movies
               // TODO: Store the movies in a property to use elsewhere
               // TODO: Reload your table view data
               [self.tableView reloadData];
           }
        [self.refreshControl endRefreshing];
    }];
    
    [task resume];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseMovieCell" forIndexPath:indexPath];
    NSDictionary *movie = self.movies[indexPath.row];
    
    // Title
    cell.titleLabel.text = movie[@"title"];
    
    // Synopsis
    cell.synopsisLabel.text = movie[@"overview"];
    
    // Image
    NSString *urlPrefix = @"https://image.tmdb.org/t/p/w500";
    NSString *urlSuffix = movie[@"poster_path"];
    NSString *urlString = [urlPrefix stringByAppendingString:urlSuffix];
    
    NSURL *url = [NSURL URLWithString:urlString];
    [cell.posterImage setImageWithURL:url];
    return cell;
}

//func refreshControl




@end
