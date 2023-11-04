#pragma author JPiolho
#pragma description Quake 1 - Lit v1 file

#include <type/magic.pat>
#include <std/mem.pat>

struct LitFile {
    type::Magic<"QLIT"> signature;
    s32 version;
    u8 data[while(!std::mem::eof())];
};

LitFile Lit @ 0x00;
