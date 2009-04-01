require 'rubygems'
require 'ffi'

class FreeImage
  
  # FreeImage.h LOAD/SAVE TYPES
  module Flags
    # Load / Save flag constants -----------------------------------------------

    BMP_DEFAULT =        0
    BMP_SAVE_RLE=        1
    CUT_DEFAULT =        0
    DDS_DEFAULT=			0
    EXR_DEFAULT=			0		# save data as half with piz-based wavelet compression
    EXR_FLOAT	=		0x0001	# save data as float instead of as half (not recommended)
    EXR_NONE=			0x0002	# save with no compression
    EXR_ZIP=				0x0004	# save with zlib compression, in blocks of 16 scan lines
    EXR_PIZ		=		0x0008	# save with piz-based wavelet compression
    EXR_PXR24=			0x0010	# save with lossy 24-bit float compression
    EXR_B44	=			0x0020	# save with lossy 44% float compression - goes to 22% when combined with EXR_LC
    EXR_LC=				0x0040	# save images with one luminance and two chroma channels, rather than as RGB (lossy compression)
    FAXG3_DEFAULT=		0
    GIF_DEFAULT	=		0
    GIF_LOAD256=			1		# Load the image as a 256 color image with ununsed palette entries, if it's 16 or 2 color
    GIF_PLAYBACK	=	2		# 'Play' the GIF to generate each frame (as 32bpp) instead of returning raw frame data when loading
    HDR_DEFAULT	=		0
    ICO_DEFAULT  =       0
    ICO_MAKEALPHA	=	1		# convert to 32bpp and create an alpha channel from the AND-mask when loading
    IFF_DEFAULT   =      0
    J2K_DEFAULT	=		0		# save with a 16:1 rate
    JP2_DEFAULT	=		0		# save with a 16:1 rate
    JPEG_DEFAULT =       0		# loading (see JPEG_FAST); saving (see JPEG_QUALITYGOOD|JPEG_SUBSAMPLING_420)
    JPEG_FAST   =        0x0001	# load the file as fast as possible, sacrificing some quality
    JPEG_ACCURATE =      0x0002	# load the file with the best quality, sacrificing some speed
    JPEG_CMYK	=		0x0004	# load separated CMYK "as is" (use | to combine with other load flags)
    JPEG_QUALITYSUPERB =  0x80	# save with superb quality (100:1)
    JPEG_QUALITYGOOD  =  0x0100	# save with good quality (75:1)
    JPEG_QUALITYNORMAL = 0x0200	# save with normal quality (50:1)
    JPEG_QUALITYAVERAGE = 0x0400	# save with average quality (25:1)
    JPEG_QUALITYBAD =    0x0800	# save with bad quality (10:1)
    JPEG_PROGRESSIVE =	0x2000	# save as a progressive-JPEG (use | to combine with other save flags)
    JPEG_SUBSAMPLING_411 = 0x1000		# save with high 4x1 chroma subsampling (4:1:1) 
    JPEG_SUBSAMPLING_420 = 0x4000		# save with medium 2x2 medium chroma subsampling (4:2:0) - default value
    JPEG_SUBSAMPLING_422 = 0x8000		# save with low 2x1 chroma subsampling (4:2:2) 
    JPEG_SUBSAMPLING_444 = 0x10000	# save with no chroma subsampling (4:4:4)
    KOALA_DEFAULT =      0
    LBM_DEFAULT   =      0
    MNG_DEFAULT   =      0
    PCD_DEFAULT   =      0
    PCD_BASE      =      1		# load the bitmap sized 768 x 512
    PCD_BASEDIV4  =      2		# load the bitmap sized 384 x 256
    PCD_BASEDIV16  =     3		# load the bitmap sized 192 x 128
    PCX_DEFAULT   =      0
    PNG_DEFAULT   =      0
    PNG_IGNOREGAMMA	=	1		# loading: avoid gamma correction
    PNG_Z_BEST_SPEED	=		0x0001	# save using ZLib level 1 compression flag (default value is 6)
    PNG_Z_DEFAULT_COMPRESSION =	0x0006	# save using ZLib level 6 compression flag (default recommended value)
    PNG_Z_BEST_COMPRESSION	=	0x0009	# save using ZLib level 9 compression flag (default value is 6)
    PNG_Z_NO_COMPRESSION =		0x0100	# save without ZLib compression
    PNG_INTERLACED	=		0x0200	# save using Adam7 interlacing (use | to combine with other save flags)
    PNM_DEFAULT   =    0
    PNM_SAVE_RAW  =      0       # If set the writer saves in RAW format (i.e. P4, P5 or P6)
    PNM_SAVE_ASCII =     1       # If set the writer saves in ASCII format (i.e. P1, P2 or P3)
    PSD_DEFAULT   =    0
    RAS_DEFAULT    =     0
    SGI_DEFAULT		=	0
    TARGA_DEFAULT =      0
    TARGA_LOAD_RGB888 =  1       # If set the loader converts RGB555 and ARGB8888 -> RGB888.
    TIFF_DEFAULT  =      0
    TIFF_CMYK	=		0x0001	# reads/stores tags for separated CMYK (use | to combine with compression flags)
    TIFF_PACKBITS =      0x0100  # save using PACKBITS compression
    TIFF_DEFLATE  =      0x0200  # save using DEFLATE compression (a.k.a. ZLIB compression)
    TIFF_ADOBE_DEFLATE  = 0x0400  # save using ADOBE DEFLATE compression
    TIFF_NONE     =      0x0800  # save without any compression
    TIFF_CCITTFAX3	=	0x1000  # save using CCITT Group 3 fax encoding
    TIFF_CCITTFAX4 =		0x2000  # save using CCITT Group 4 fax encoding
    TIFF_LZW	=		0x4000	# save using LZW compression
    TIFF_JPEG	=		0x8000	# save using JPEG compression
    WBMP_DEFAULT  =      0
    XBM_DEFAULT	=		0
    XPM_DEFAULT	=		0
  end
  
  # From FreeImage.h FI_ENUM(FREE_IMAGE_FORMAT)
  module Format
  	UNKNOWN = -1
  	BMP		= 0
  	ICO		= 1
  	JPEG	= 2
  	JNG		= 3
  	KOALA	= 4
  	LBM		= 5
  	IFF = LBM
  	MNG		= 6
  	PBM		= 7
  	PBMRAW	= 8
  	PCD		= 9
  	PCX		= 10
  	PGM		= 11
  	PGMRAW	= 12
  	PNG		= 13
  	PPM		= 14
  	PPMRAW	= 15
  	RAS		= 16
  	TARGA	= 17
  	TIFF	= 18
  	WBMP	= 19
  	PSD		= 20
  	CUT		= 21
  	XBM		= 22
  	XPM		= 23
  	DDS		= 24
  	GIF     = 25
  	HDR		= 26
  	FAXG3	= 27
  	SGI		= 28
  	EXR		= 29
  	J2K		= 30
  	JP2		= 31
  end
  
  module FFI
    extend ::FFI::Library
    ffi_lib 'freeimage.3'


    # Takes file_path and bytes to read, returns FreeImage::Format
    attach_function :FreeImage_GetFileType, [:string, :int], :int
    attach_function :FreeImage_GetFIFFromFilename, [:string], :int

    # Takes Free Image Format, returns 0/1 for boolean
    attach_function :FreeImage_FIFSupportsReading, [:int], :int
    attach_function :FreeImage_FIFSupportsWriting, [:int], :int
    
    
    # DLL_API FIBITMAP *DLL_CALLCONV FreeImage_Load(FREE_IMAGE_FORMAT fif, const char *filename, int flags FI_DEFAULT(0));
    attach_function :FreeImage_Load, [:int, :string, :int], :pointer
    
    #DLL_API void DLL_CALLCONV FreeImage_Unload(FIBITMAP *dib);
    attach_function :FreeImage_Unload, [:pointer], :void

    # DLL_API BOOL DLL_CALLCONV FreeImage_Save(FREE_IMAGE_FORMAT fif, FIBITMAP *dib, const char *filename, int flags FI_DEFAULT(0));    
    attach_function :FreeImage_Save, [:int, :pointer, :string, :int], :int

    #DLL_API BOOL DLL_CALLCONV FreeImage_FIFSupportsICCProfiles(FREE_IMAGE_FORMAT fif);
    attach_function :FreeImage_FIFSupportsICCProfiles, [:int], :int
    
    # FI_STRUCT (FIICCPROFILE) { 
    #       WORD    flags;  // info flag
    #       DWORD size; // profile's size measured in bytes
    #       void   *data; // points to a block of contiguous memory containing the profile
    #     };
    class ICCProfile < ::FFI::ManagedStruct
      layout :flags,  :uint16,
             :size,  :uint32,
             :data, :pointer

      def self.release(ptr)
        FreeImage::FFI.free_object(ptr)
      end
    end
    # DLL_API FIICCPROFILE *DLL_CALLCONV FreeImage_GetICCProfile(FIBITMAP *dib);
    attach_function :FreeImage_GetICCProfile, [:pointer], :pointer
    
    # DLL_API FIICCPROFILE *DLL_CALLCONV FreeImage_CreateICCProfile(FIBITMAP *dib, void *data, long size);
    # See "copy_icc_profile" from image_science
    attach_function :FreeImage_CreateICCProfile, [:pointer, :pointer, :long], :pointer
    # void copy_icc_profile(VALUE self, FIBITMAP *from, FIBITMAP *to) {
    #   FREE_IMAGE_FORMAT fif = FIX2INT(rb_iv_get(self, "@file_type"));
    #   if (fif != FIF_PNG && FreeImage_FIFSupportsICCProfiles(fif)) {
    #     FIICCPROFILE *profile = FreeImage_GetICCProfile(from);
    #     if (profile && profile->data) { 
    #       FreeImage_CreateICCProfile(to, profile->data, profile->size); 
    #     }
    #   }
    # }
    
    # DLL_API void DLL_CALLCONV FreeImage_DestroyICCProfile(FIBITMAP *dib);
    attach_function :FreeImage_DestroyICCProfile, [:pointer], :void
    
    # DLL_API FIICCPROFILE *DLL_CALLCONV FreeImage_CreateICCProfile(FIBITMAP *dib, void *data, long size);
    attach_function :FreeImage_CreateICCProfile, [:pointer, :pointer, :long], :pointer

    #DLL_API FIBITMAP *DLL_CALLCONV FreeImage_Copy(FIBITMAP *dib, int left, int top, int right, int bottom);
    # Basically this is a way to crop an image... copy it from the source into a new image of these dimensions.
    attach_function :FreeImage_Copy, [:pointer, :int, :int, :int, :int], :pointer
    # TODO: FreeImage_Page
    #DLL_API BOOL DLL_CALLCONV FreeImage_Paste(FIBITMAP *dst, FIBITMAP *src, int left, int top, int alpha);
    attach_function :FreeImage_Paste, [:pointer, :pointer, :int, :int, :int], :int
    
    # DLL_API unsigned DLL_CALLCONV FreeImage_GetWidth(FIBITMAP *dib);
    attach_function :FreeImage_GetWidth, [:pointer], :uint
    # DLL_API unsigned DLL_CALLCONV FreeImage_GetHeight(FIBITMAP *dib);
    attach_function :FreeImage_GetHeight, [:pointer], :uint
    
    module Filter
      #/** Upsampling / downsampling filters. 
      #Constants used in FreeImage_Rescale.
      # */
    	BOX		     = 0  	# Box, pulse, Fourier window, 1st order (constant) b-spline
    	BICUBIC	   = 1	# Mitchell & Netravali's two-param cubic filter
    	BILINEAR   = 2	# Bilinear filter
    	BSPLINE	   = 3	# 4th order (cubic) b-spline
    	CATMULLROM = 4	# Catmull-Rom spline, Overhauser spline
    	LANCZOS3	 = 5 # Lanczos3 filter
    end
    # TODO: FreeImage_Rescale
    # DLL_API FIBITMAP *DLL_CALLCONV FreeImage_Rescale(FIBITMAP *dib, int dst_width, int dst_height, FREE_IMAGE_FILTER filter);
    attach_function :FreeImage_Rescale, [:pointer, :int, :int, :int], :pointer
    
    #DLL_API FIBITMAP *DLL_CALLCONV FreeImage_MakeThumbnail(FIBITMAP *dib, int max_pixel_size, BOOL convert FI_DEFAULT(TRUE));
    attach_function :FreeImage_MakeThumbnail, [:pointer, :int, :int], :pointer
    

    # To see how to use this look here: http://kenai.com/projects/ruby-ffi/pages/Examples
    # Generally
    #
    # YourModule::OutputMessageCallback = Proc.new do |format, message|
    #  puts "Format #{format} said #{message}"
    # end
    # FreeImage::FFI.FreeImage_SetOutputMessage(YourModule::OutputMessageCallback)
    
    # typedef void (*FreeImage_OutputMessageFunction)(FREE_IMAGE_FORMAT fif, const char *msg);
    callback :FreeImage_OutputMessageFunction, [:int, :string], :void
    
    # typedef void (DLL_CALLCONV *FreeImage_OutputMessageFunctionStdCall)(FREE_IMAGE_FORMAT fif, const char *msg); 
    callback :FreeImage_OutputMessageFunctionStdCall, [:int, :string], :void
    
    # DLL_API void DLL_CALLCONV FreeImage_SetOutputMessageStdCall(FreeImage_OutputMessageFunctionStdCall omf); 
    attach_function :FreeImage_SetOutputMessageStdCall, [:FreeImage_OutputMessageFunctionStdCall], :void

    # DLL_API void DLL_CALLCONV FreeImage_SetOutputMessage(FreeImage_OutputMessageFunction omf);
    attach_function :FreeImage_SetOutputMessage, [:FreeImage_OutputMessageFunction], :void
        
    # DLL_API void DLL_CALLCONV FreeImage_OutputMessageProc(int fif, const char *fmt, ...);
    attach_function :FreeImage_OutputMessageProc, [:int, :string], :void
  end
end
