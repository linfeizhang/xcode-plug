//
//  ViewController.m
//  Photograp
//
//  Created by zhanglf on 16/3/17.
//  Copyright © 2016年 zhanglf. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVKit/AVKit.h>
@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *photo;

- (IBAction)takePhoto:(id)sender;
- (IBAction)selectPhoto:(id)sender;
- (IBAction)movieBtn:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// 拍照
- (IBAction)takePhoto:(id)sender {
    if ([UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera]) {
        // 1. 创建对象
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        // 2. 设置对象的拾取源属性
        // 设置为拍照功能
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        // 3. 告诉picker使用照相机进行拍照操作
        picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        
        // 设置钱前或后置的摄像头
        // fron 为前置摄像头  rear 为后置摄像头
        picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        
        // 4. 设置代理
        picker.delegate = self;
        
        // 允许编辑
        picker.allowsEditing = YES;
        
        [self presentViewController:picker animated:YES completion:nil];
    }
}

// 选择照片
- (IBAction)selectPhoto:(id)sender {
    if ([UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }
    
}
// 录像
- (IBAction)movieBtn:(id)sender {
    // 1. 创建对象
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    
    // 2. 设置代理
    picker.delegate = self;
    
    // 3. 设置拾取源属性
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // 4. 设置多媒体类型
    //kUTTypeMovie 是有录像 还有声音
    //kUTTypeVideo 是有录像 没有声音
    picker.mediaTypes = @[(NSString *)kUTTypeMovie];
    
    // 设置摄像头
    picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    
    // 设置录像的质量
    picker.videoQuality = UIImagePickerControllerQualityTypeIFrame960x540;
    
    // 设置摄像头的捕获类型
    picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
    
    [self presentViewController:picker animated:YES completion:nil];
    
}
#pragma mark - /********** UIImagePickerController 代理方法 **********/
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    // 获取录像保存的url路径
    NSURL * url = info[UIImagePickerControllerMediaURL];
    NSLog(@"url = %@",url);
    // 把url路径转换为一个文件路径
    NSString * path = [url path];
    NSLog(@"path = %@",path);
    // 判断是否可以保存到本地相册中
    if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(path)) {
        // 保存录像，注意有一个方法回调:用来说明录像是否已经保存成功
        UISaveVideoAtPathToSavedPhotosAlbum(path, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
    }
    
    // 获得编辑后的照片
    UIImage * img = info[UIImagePickerControllerOriginalImage];
    self.photo.image = img;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
{
    if (error) {// 显示保存失败的错误信息
        NSLog(@"error = %@",error.localizedDescription);
    }else{
        NSLog(@"保存成功!");
        // 把本地文件路径转换成一个url
        NSURL * url = [NSURL fileURLWithPath:videoPath];
        // 创建播放视频的控制器
        
        MPMoviePlayerViewController * player = [[MPMoviePlayerViewController alloc]initWithContentURL:url];
        [self presentViewController:player animated:YES completion:nil];
        
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}



- (BOOL)prefersStatusBarHidden
{
    return YES;
}






@end
