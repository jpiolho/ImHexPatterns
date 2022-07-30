#pragma pattern_limit 4194304

struct Color {
	u8 r [[color("FF0000")]];
	u8 g [[color("00FF00")]];
	u8 b [[color("0000FF")]];
};

struct FontInfo {
	u32 startOffset;
	u32 charWidth;
};

struct Texture {
	if(parent.type == 0x40 || parent.type == 0x43) {
		char name[];
		padding[16 - sizeof(name)];
	}
	
	u32 width;
	u32 height;
	
	if(parent.type == 0x46) {
		u32 rowCount;
		u32 rowHeight;
		FontInfo fontInfo[128];
	}
	
	if(parent.type == 0x40 || parent.type == 0x43) {
		u32 offsetTextureStart;
		u32 offsetMipmap1;
		u32 offsetMipmap2;
		u32 offsetMipmap3;
	}
	
	u32 imageData[width * height];
	
	if(parent.type == 0x40 || parent.type == 0x43) {
		u8 mipmap1[width * height / 4];
		u8 mipmap2[width * height / 8];
		u8 mipmap3[width * height / 16];
	}
	
	padding[2];
	
	if(parent.type == 0x42 || parent.type == 0x43) {
		Color colors[256];
	}
	
	padding[2];
};

struct LumpInfo {
	u32 offset;
	u32 compressedLength;
	u32 length;
	u8 type;
	u8 compression;
	padding[2];
	char name[];
	padding[16 - sizeof(name)];
	
	Texture texture @ offset;
};

struct LumpsList {
	LumpInfo lumps[parent.textureCount] [[inline]];
};

struct WAD {
	char signature[4];
	u32 textureCount;
	LumpsList* lumpsList : u32 [[inline]];
};

WAD wad @ 0x00;
