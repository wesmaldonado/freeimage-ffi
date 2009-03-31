require 'test_helper'

FreeImage::Format::JPEG == FreeImage::FFI.FreeImage_GetFileType('data/test-jpg.jpg', 0)
FreeImage::Format::JPEG == FreeImage::FFI.FreeImage_GetFIFFromFilename('data/test-jpg.jpg')