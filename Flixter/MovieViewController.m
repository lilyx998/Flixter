//
//  ViewController.m
//  Flixter
//
//  Created by Lily Yang on 6/15/22.
//

#import "MovieViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"

@interface MovieViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    
    [self fetchMovies];
    
    [self.activityIndicator stopAnimating];
    
    self.refreshControl = [[UIRefreshControl alloc] init]; // initializes refreshControl
    
    [self.activityIndicator startAnimating];
    
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
            if(error.code == NSURLErrorNotConnectedToInternet){
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@"Cannot Get Movies"
                                             message:@"The Internet connection appears to be offline."
                                             preferredStyle:UIAlertControllerStyleAlert];

                //Add Buttons

                UIAlertAction* yesButton = [UIAlertAction
                                            actionWithTitle:@"Try Again"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                                [self fetchMovies]; // ask Naveen?
                                            }];

                //Add your buttons to alert controller

                [alert addAction:yesButton];

                [self presentViewController:alert animated:YES completion:nil];
            }
            if (error != nil) {
                NSLog(@"%@", [error localizedDescription]);
            }
            else {
                NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers   error:nil];
//                NSLog(@"%@", dataDictionary);// log an object with the %@ formatter.
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    NSDictionary *dataToPass = self.movies[indexPath.row];
    DetailsViewController *detailsVC = [segue destinationViewController];
    detailsVC.data = dataToPass;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}




@end
