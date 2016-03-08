//
//  AvatarImagePicker.m
//  VKApplication
//
//  Created by Vasyl Vasylchenko on 19.02.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "AvatarImagePicker.h"
#import "VKClient.h"
#import "AvatarImageProvider.h"

@interface AvatarImagePicker () <UIImagePickerControllerDelegate>

@property VKClient *vkClient;
@property UIImage *imageFromCameraRoll;
@property AvatarImageProvider *avatarImageProvider;

@end

@implementation AvatarImagePicker

- (instancetype)initWithViewController:(UIViewController *)vc{
    self = [super init];
    if (self){
        self.vkClient = [VKClient new];
        [self configureImagePickerOnVC:vc];
    }
    return self;
}

- (void)configureImagePickerOnVC:(UIViewController *)vc{
    self.delegate = self;
    self.allowsEditing = YES;
    self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [vc presentViewController:self animated:YES completion:nil];
        
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [self.vkClient getServerForUpLoadPictWithResponse:^(NSDictionary *responseObject) {
            PhotoUploadServerModel *upLoadServer = [MTLJSONAdapterWithoutNil modelOfClass:[PhotoUploadServerModel class] fromJSONDictionary:responseObject error:nil];
            self.avatarImageProvider = [[AvatarImageProvider alloc] initWithImage:image andServerPath:upLoadServer.serverPath];
        }];
    }];
    
}

@end
