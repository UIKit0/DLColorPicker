//
//  DLCPRendering.m
//  DLColorPicker
//
//  Created by Vincent Esche on 10/28/13.
//  Copyright (c) 2013 Definite Loop. All rights reserved.
//

#import "DLCPRendering.h"

#import "DLCPHSBSupport.h"

UIImage *DLCPRenderHueImage(CGFloat saturation, CGFloat brightness) {
	return DLCPRenderHueImageWithWidth(saturation, brightness, 256);
}

UIImage *DLCPRenderHueImageWithWidth(CGFloat saturation, CGFloat brightness, NSUInteger width) {
	return DLCPRenderImageWithSize(width, 1, ^(CGFloat *red, CGFloat *green, CGFloat *blue, CGFloat *alpha, CGFloat xNormalized, CGFloat yNormalized) {
		CGFloat hue = xNormalized;
		DLConvert_HSV_to_RGB(hue * 360, saturation, brightness, red, green, blue);
	});
}

UIImage *DLCPRenderBrightnessImage(CGFloat hue, CGFloat saturation) {
	return DLCPRenderBrightnessImageWithWidth(hue, saturation, 256);
}

UIImage *DLCPRenderBrightnessImageWithWidth(CGFloat hue, CGFloat saturation, NSUInteger width) {
	return DLCPRenderImageWithSize(width, 1, ^(CGFloat *red, CGFloat *green, CGFloat *blue, CGFloat *alpha, CGFloat xNormalized, CGFloat yNormalized) {
		CGFloat brightness = xNormalized;
		DLConvert_HSV_to_RGB(hue * 360, saturation, brightness, red, green, blue);
	});
}

UIImage *DLCPRenderSaturationBrightnessImage(CGFloat hue) {
	return DLCPRenderSaturationBrightnessImageWithSize(hue, 256, 256);
}

UIImage *DLCPRenderSaturationBrightnessImageWithSize(CGFloat hue, NSUInteger width, NSUInteger height) {
	return DLCPRenderImageWithSize(width, height, ^(CGFloat *red, CGFloat *green, CGFloat *blue, CGFloat *alpha, CGFloat xNormalized, CGFloat yNormalized) {
		CGFloat saturation = xNormalized;
		CGFloat brightness = 1.0 - yNormalized;
		DLConvert_HSV_to_RGB(hue * 360, saturation, brightness, red, green, blue);
	});
}

UIImage *DLCPRenderHueSaturationImage(CGFloat brightness) {
	return DLCPRenderHueSaturationImageWithSize(brightness, 256, 256);
}

UIImage *DLCPRenderHueSaturationImageWithSize(CGFloat brightness, NSUInteger width, NSUInteger height) {
	return DLCPRenderImageWithSize(width, height, ^(CGFloat *red, CGFloat *green, CGFloat *blue, CGFloat *alpha, CGFloat xNormalized, CGFloat yNormalized) {
		CGFloat saturation = 1.0 - yNormalized;
		CGFloat hue = xNormalized;
		DLConvert_HSV_to_RGB(hue * 360, saturation, brightness, red, green, blue);
	});
}

UIImage *DLCPRenderAlphaImageWithWidth(CGFloat checkerDarkBrightness, CGFloat checkerLightBrightness, CGFloat foregroundBrightness, NSUInteger width) {
	return DLCPRenderAlphaImageWithSize(checkerDarkBrightness, checkerLightBrightness, foregroundBrightness, width, 1);
}

UIImage *DLCPRenderAlphaImageWithSize(CGFloat checkerDarkBrightness, CGFloat checkerLightBrightness, CGFloat foregroundBrightness, NSUInteger width, NSUInteger height) {
	return DLCPRenderImageWithSize(width, height, ^(CGFloat *red, CGFloat *green, CGFloat *blue, CGFloat *alpha, CGFloat xNormalized, CGFloat yNormalized) {
		NSUInteger tileSize = 10;
		NSUInteger x = (xNormalized * width) / tileSize;
		NSUInteger y = (yNormalized * height) / tileSize;
		CGFloat brightness = (((x + y) & 0x1) == 0) ? checkerDarkBrightness : checkerLightBrightness;
		brightness = (brightness * (1.0 - xNormalized)) + (xNormalized * foregroundBrightness);
		*red = *green = *blue = brightness;
		*alpha = 1.0;
	});
}

UIImage *DLCPRenderImageWithSize(NSUInteger width, NSUInteger height, DLCPPixelRenderBlock pixelBlock) {
	NSCAssert(pixelBlock, @"Method argument 'pixelBlock' must not be nil");
	UIImage *image = nil;

	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, width * 4, colorSpace, (kCGBitmapByteOrder32Little|kCGImageAlphaNoneSkipFirst));
	
	CGColorSpaceRelease(colorSpace);
	
	size_t bytesPerPixel = CGBitmapContextGetBitsPerPixel(context) / 8;
	size_t bytesPerRow = CGBitmapContextGetBytesPerRow(context);
	uint8_t *dataPtr = CGBitmapContextGetData(context);
	
	for (NSUInteger y = 0; y < height; y++) {
		uint8_t *pixelPtr = dataPtr + (y * bytesPerRow);
		CGFloat yNormalized = (CGFloat)y / height;
		for (NSUInteger x = 0; x < width; x++) {
			CGFloat xNormalized = (CGFloat)x / width;
			CGFloat rgba[4] = {1.0, 1.0, 1.0, 1.0};
			pixelBlock(rgba + 0, rgba + 1, rgba + 2, rgba + 3, xNormalized, yNormalized);
			// BGRA little endian!
			pixelPtr[0] = MIN(MAX(rgba[2], 0.0), 1.0) * 255;
			pixelPtr[1] = MIN(MAX(rgba[1], 0.0), 1.0) * 255;
			pixelPtr[2] = MIN(MAX(rgba[0], 0.0), 1.0) * 255;
			pixelPtr[3] = MIN(MAX(rgba[3], 0.0), 1.0) * 255;
			pixelPtr += bytesPerPixel;
		}
	}
	
	CGImageRef imageRef = CGBitmapContextCreateImage(context);
	CGContextRelease(context);
	image = [UIImage imageWithCGImage:imageRef];
	CGImageRelease(imageRef);
	return image;
}
