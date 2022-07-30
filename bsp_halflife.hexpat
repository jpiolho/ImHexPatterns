// Documentation: http://hlbsp.sourceforge.net/index.php?content=bspdef
#pragma pattern_limit 8388608
#pragma array_limit 1048576

struct Vector3 {
	float x;
	float y;
	float z;
};

struct Lump {
	s32 offset;
	s32 length;
};

struct Header {
	s32 version;
	
	Lump lumpEntities;
	Lump lumpPlanes;
	Lump lumpTextures;
	Lump lumpVertices;
	Lump lumpVisibility;
	Lump lumpNodes;
	Lump lumpTexInfo;
	Lump lumpFaces;
	Lump lumpLighting;
	Lump lumpClipNodes;
	Lump lumpLeaves;
	Lump lumpMarkSurfaces;
	Lump lumpEdges;
	Lump lumpSurfaceEdges;
	Lump lumpModels;
};

enum PlaneType : s32 {
	X = 0,
	Y = 1,
	Z = 2,
	AnyX = 3,
	AnyY = 4,
	AnyZ = 5
};

struct ColorRGB {
	u8 r [[color("FF0000")]];
	u8 g [[color("00FF00")]];
	u8 b [[color("0000FF")]];
};

struct Plane {
	Vector3 normal;
	float dist;
	PlaneType type;
};

struct Node {
	u32 plane;
	s16 children[2];
	s16 mins[3];
	s16 maxs[3];
	u16 firstFace, countFaces;
};

struct Texture {
	char name[];
	padding[16 - sizeof(name)];
	s32 width,height;
	s32 mipOffsets[4];
};

struct TextureInfo {
	Vector3 s;
	float sShift;
	Vector3 t;
	float tShift;
	u32 mipTex;
	u32 flags;
};

struct Face {
	u16 plane;
	u16 planeSide;
	u32 firstEdge;
	u16 edges;
	u16 textureInfo;
	u8 nStyles[4];
	u32 lightmapOffset;
};

struct ClipNode {
	s32 plane;
	s16 children[2];
};

struct Leaf {
	s32 contents;
	s32 visOffset;
	s16 mins[3];
	s16 maxs[3];
	u16 firstMarkSurface, markSurfaces;
	u8 ambientLevels[4];
};

struct Edge {
	u16 vertex[2];
};

struct Model {
	float mins[3];
	float maxs[3];
	Vector3 origin;
	s32 headNodes[4];
	s32 visLeafs;
	s32 firstFace, faces;
};

 
fn Texture_Base(u32 offset) {
	return addressof(parent.parent.count);
};

struct TextureOffset {
	Texture *textureInfo : u32 [[inline,pointer_base("Texture_Base")]];
};

struct LumpTexture {
	u32 count;
	TextureOffset textureInfos[count] [[inline]];
};

struct LumpEntities {
	char data[parent.header.lumpEntities.length];
};

struct LumpPlanes {
	Plane planes[parent.header.lumpPlanes.length / 0x14] [[inline]];
};

struct LumpVertices {
	Vector3 vertexes[parent.header.lumpVertices.length / (sizeof(float) * 3)] [[inline]];
};

struct LumpVisibility {
	u8 visibility[parent.header.lumpVisibility.length] [[inline]];
};

struct LumpNodes {
	Node nodes[parent.header.lumpNodes.length / 0x18] [[inline]];
};

struct LumpTexInfo {
	TextureInfo textureInfos[parent.header.lumpTexInfo.length / 0x28] [[inline]];
};

struct LumpFaces {
	Face faces[parent.header.lumpFaces.length / 0x14] [[inline]];
};

struct LumpLighting {
	ColorRGB colors[parent.header.lumpLighting.length / 0x3] [[inline]];
};

struct LumpClipNodes {
	ClipNode clipNodes[parent.header.lumpClipNodes.length / 0x8] [[inline]];
};

struct LumpLeaves {
	Leaf leaves[parent.header.lumpLeaves.length / 0x1C] [[inline]];
};

struct LumpMarkSurfaces {
	u16 markSurfaces[parent.header.lumpMarkSurfaces.length / sizeof(u16)] [[inline]];
};

struct LumpEdges {
	Edge edges[parent.header.lumpEdges.length / (sizeof(u16) * 2)] [[inline]];
};

struct LumpSurfaceEdges {
	u32 surfaceEdges[parent.header.lumpSurfaceEdges.length / sizeof(u32)] [[inline]];
};

struct LumpModels {
	Model models[parent.header.lumpModels.length / 0x40] [[inline]];
};

struct BSP {
	Header header;
	
	
};

Header header @ 0x00;

LumpEntities entities @ header.lumpEntities.offset;
LumpPlanes planes @ header.lumpPlanes.offset;
LumpTexture textures @ header.lumpTextures.offset;
LumpVertices vertices @ header.lumpVertices.offset;
LumpVisibility visibility @ header.lumpVisibility.offset;
LumpNodes nodes @ header.lumpNodes.offset;
LumpTexInfo textureInfos @ header.lumpTexInfo.offset;
LumpFaces faces @ header.lumpFaces.offset;
LumpLighting lighting @ header.lumpLighting.offset;
LumpClipNodes clipNodes @ header.lumpClipNodes.offset;
LumpLeaves leaves @ header.lumpLeaves.offset;
LumpMarkSurfaces markSurfaces @ header.lumpMarkSurfaces.offset;
LumpEdges edges @ header.lumpEdges.offset;
LumpSurfaceEdges surfaceEdges @ header.lumpSurfaceEdges.offset;
LumpModels models @ header.lumpModels.offset;




