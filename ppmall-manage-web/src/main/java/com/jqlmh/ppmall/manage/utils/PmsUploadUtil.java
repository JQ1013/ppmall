package com.jqlmh.ppmall.manage.utils;

import org.csource.fastdfs.ClientGlobal;
import org.csource.fastdfs.StorageClient;
import org.csource.fastdfs.TrackerClient;
import org.csource.fastdfs.TrackerServer;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

/**
 * @author LMH
 * @create 2020-04-10 21:49
 */
public class PmsUploadUtil {

	public static String uploadImage(MultipartFile multipartFile) {

		StringBuilder imgUrl = new StringBuilder("http://192.168.184.130");

		// 上传图片到服务器
		// 配置fdfs的全局链接地址
		String path = PmsUploadUtil.class.getResource("/tracker.conf").getPath(); // 获得配置文件的路径
		try {
			//初始化Fastdfs客户端,放入配置文件
			ClientGlobal.init(path);
		} catch (Exception e) {
			e.printStackTrace();
		}

		// 获得一个trackerClient的实例
		TrackerClient trackerClient = new TrackerClient();

		//获取一个trackerServer的实例
		TrackerServer trackerServer = null;
		try {
			trackerServer = trackerClient.getTrackerServer();
		} catch (IOException e) {
			e.printStackTrace();
		}

		// 通过trackerServer获得一个Storage链接客户端
		StorageClient storageClient = new StorageClient(trackerServer);

		try {
			byte[] bytes = multipartFile.getBytes(); // 获得上传的二进制对象

			//获得文件后缀名
			String originalFilename = multipartFile.getOriginalFilename(); //获取文件名 a.jpg
			int index = originalFilename.lastIndexOf("."); //文件名分隔符"."所在的索引
			String suffixName = originalFilename.substring(index + 1); //后缀名

			String[] uploadFileInfos = storageClient.upload_file(bytes, suffixName, null);

			//拼串获得的图片的url
			for (String uploadFileInfo : uploadFileInfos) {
				imgUrl.append("/").append(uploadFileInfo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return imgUrl.toString();
	}
}
