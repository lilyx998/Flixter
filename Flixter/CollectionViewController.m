//
//  CollectionViewController.m
//  Flixter
//
//  Created by Lily Yang on 6/17/22.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"

@interface CollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *movies;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self; 
    [self fetchMovies]; 
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
                [self.collectionView reloadData];
            }
    }];
    [task resume];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    
    NSDictionary *movie = self.movies[indexPath.item];
    
    NSString *urlPrefix = @"https://image.tmdb.org/t/p/w500";
    NSString *urlSuffix = movie[@"poster_path"];
    NSString *urlString = [urlPrefix stringByAppendingString:urlSuffix];
    
    NSURL *url = [NSURL URLWithString:urlString];
    [cell.posterImage setImageWithURL:url];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movies.count;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath *indexPath = [self.collectionView indexPathsForSelectedItems][0];
    
    NSDictionary *dataToPass = self.movies[indexPath.row];
    DetailsViewController *detailsVC = [segue destinationViewController];
    detailsVC.data = dataToPass;
}

@end
