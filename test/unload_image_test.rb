require 'test_helper'

image = FreeImage::FFI.FreeImage_Load( FreeImage::Format::JPEG, '../test/data/test-jpg.jpg', FreeImage::Flags::JPEG_DEFAULT)

FreeImage::FFI.FreeImage_Unload(image)
