require 'test_helper'

jpg_image = FreeImage::FFI.FreeImage_Load( FreeImage::Format::JPEG, 'test/data/test-jpg.jpg', FreeImage::Flags::JPEG_DEFAULT) 

success_jpg = FreeImage::FFI.FreeImage_Save( FreeImage::Format::JPEG, jpg_image, 'test/data/test-jpg-2.jpg',FreeImage::Flags::JPEG_DEFAULT)

success_png = FreeImage::FFI.FreeImage_Save( FreeImage::Format::PNG,  jpg_image, 'test/data/test-png-2.png',FreeImage::Flags::PNG_DEFAULT)
