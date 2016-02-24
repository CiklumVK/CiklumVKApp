//
//  AvatarImageProvider.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 21.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "AvatarImageProvider.h"
#import "VKClient.h"
#import "PhotoSaveModel.h"

@interface AvatarImageProvider ()

@property VKClient *vkClient;


@end

@implementation AvatarImageProvider

-(instancetype)initWithImage:(UIImage *)image andServerPath:(NSString *)serverPath{
    self = [super init];
    if (self){
        self.vkClient = [VKClient new];
        [self changeAvatarByImage:image andServerPath:serverPath];
    }
    return self;
}

- (void)changeAvatarByImage:(UIImage *)image andServerPath:(NSString *)serverPath{
    [self.vkClient changeAvatarByServer:serverPath withImage:image withResponse:^(NSDictionary *responseObject) {
        NSArray <PhotoSaveModel *> *photoSaveModelArray = [MTLJSONAdapterWithoutNil modelOfClass:[PhotoSaveModel class] fromJSONDictionary:responseObject error:nil];
        PhotoSaveModel *photo = photoSaveModelArray;
        [self.vkClient savePhotoByServer:photo.serverNumber withPhotoHash:photo.photoHash withPhotoDescription:photo.photoDescription withResponse:^(NSArray *responseObject) {
            
            NSLog(@"%@", responseObject);
        }];
//        NSLog(@"%@", photoSaveModelArray);
    }];
}

@end
