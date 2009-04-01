require 'test_helper'

img = FreeImage::FFI.FreeImage_Load( FreeImage::Format::JPEG, '../test/data/test-jpg.jpg', FreeImage::Flags::JPEG_DEFAULT)

w = FreeImage::FFI.FreeImage_GetWidth(img)
h = FreeImage::FFI.FreeImage_GetHeight(img)