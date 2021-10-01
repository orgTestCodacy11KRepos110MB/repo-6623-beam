#include "../common.h"
#include "contract.h"
#include "../Math.h"

#define BEAMX_ALLOCATION_All(macro, macro_seed) \
    /* investors */ \
    macro(macro_seed( 0xa6,0xeb,0x40,0xb4,0x62,0x8f,0x26,0x1c,0xbd,0x01,0x00,0x31,0xf2,0xa2,0x79,0x5f,0x72,0x97,0x46,0xf4,0x0a,0x09,0x1f,0xd1,0x20,0x65,0x38,0xa7,0xd6,0x60,0x5a,0x0c,0x00 ),   142230,  0, 24) \
    macro(macro_seed( 0x91,0x47,0x77,0x61,0xe8,0x61,0xbe,0x69,0x7e,0xf3,0x7e,0x92,0x46,0x5d,0xa0,0xd0,0x80,0x13,0x74,0x26,0x19,0x7d,0x0b,0x2e,0x58,0x1e,0x9c,0xdc,0x44,0xaf,0xd7,0xad,0x00 ),   142230,  0, 24) \
    macro(macro_seed( 0xa7,0xd4,0xf2,0xdf,0x68,0xbc,0x4c,0xfb,0x37,0x3a,0x46,0x51,0x9b,0xc1,0x2a,0x18,0x21,0x1c,0x3c,0xc4,0x91,0x40,0x54,0x50,0x54,0x33,0x2d,0xd0,0xca,0x7c,0x64,0x45,0x00 ),   142230,  0, 24) \
    macro(macro_seed( 0xd1,0x52,0xcd,0xdb,0x5c,0xfe,0x3f,0x5e,0x5d,0xae,0xf0,0x2f,0xd5,0x6c,0xb1,0xcc,0x35,0x5b,0xbc,0xcb,0xf7,0x48,0xa4,0x6b,0xb5,0x21,0xad,0x68,0xb1,0xb7,0x51,0x87,0x00 ),   533170,  0, 24) /* also team member, (merged) */ \
    macro(macro_seed( 0xb9,0x77,0xc2,0x4d,0x0f,0x15,0xdf,0xf1,0x7b,0xe8,0x34,0x3b,0x85,0x67,0xe1,0xdf,0x09,0x52,0xbc,0x6c,0xa8,0x9f,0xe9,0xa9,0x59,0x35,0x5c,0xcc,0x2f,0xc4,0xfb,0xb6,0x00 ),   116590,  0, 24) \
    macro(macro_seed( 0xea,0x76,0xc8,0x87,0xce,0x8a,0x7e,0x73,0x00,0xfc,0x54,0x37,0x0d,0x87,0x6f,0xb4,0x08,0xc6,0x27,0x47,0x03,0x06,0x55,0x4c,0xad,0x5e,0xf7,0x14,0xa8,0x83,0xe8,0x55,0x01 ),   256610,  0, 24) \
    macro(macro_seed( 0xfb,0x51,0xb7,0x41,0x4b,0x3a,0x13,0x8d,0xa0,0x21,0xde,0xc3,0xcd,0xc1,0xdf,0x72,0x3f,0x11,0x1d,0x2c,0x33,0x83,0x82,0x0a,0x6b,0x41,0x43,0x21,0x8c,0xfa,0x50,0x05,0x00 ),  1855770,  0, 24) \
    macro(macro_seed( 0x53,0xb4,0xef,0x28,0x9a,0xfd,0x71,0xe1,0xc2,0xf7,0x52,0x95,0x78,0x11,0x48,0xd9,0x50,0x82,0x90,0x43,0x18,0xe3,0x7a,0xe4,0x51,0x69,0x9b,0x12,0x72,0xa7,0x8c,0x94,0x01 ),   233170,  0, 24) \
    macro(macro_seed( 0xcb,0x7d,0xd8,0x89,0x37,0xa6,0xfd,0x95,0x5f,0x4d,0xd7,0xb6,0x64,0x8f,0x2c,0x8a,0x57,0x83,0xf8,0x78,0x94,0x7e,0x28,0x04,0x53,0x40,0xec,0x33,0x3d,0xc7,0xfb,0xd5,0x01 ),   117790,  0, 24) \
    macro(macro_seed( 0xca,0x72,0x73,0x25,0xa3,0x56,0x28,0xb9,0xb4,0xf6,0x65,0xe0,0x8d,0x85,0xcb,0x44,0x1f,0xf0,0x78,0x75,0x14,0x34,0xaa,0x12,0xd1,0xe8,0x11,0x21,0x2a,0x4c,0x48,0x64,0x01 ),   925480,  0, 24) \
    macro(macro_seed( 0xd3,0x48,0x14,0x52,0x4e,0x68,0x49,0x3f,0xf4,0xf7,0xdc,0x13,0x4b,0xfd,0x84,0xed,0x8b,0xfd,0x83,0x41,0x89,0x5c,0x84,0x8a,0xcf,0x9f,0x8d,0x5f,0x2f,0x30,0xef,0x22,0x00 ),  1254810,  0, 24) \
    macro(macro_seed( 0xce,0x40,0x2e,0xe4,0xac,0xd8,0xa0,0x5a,0x29,0x22,0xa1,0x25,0x14,0x62,0x1d,0x80,0x6b,0x85,0x7c,0x14,0x67,0x25,0x7c,0x53,0x34,0xcd,0x73,0x86,0x65,0x73,0x4a,0xa3,0x01 ),   466350,  0, 24) \
    macro(macro_seed( 0x4c,0x27,0xed,0x83,0x38,0x32,0x35,0x53,0x92,0x26,0xed,0x85,0xe5,0x57,0x9d,0x3d,0x16,0x89,0x8f,0x68,0x61,0x0d,0xd1,0xe6,0xb3,0xcc,0x05,0x0c,0x4f,0x24,0xfe,0xeb,0x01 ),   233170,  0, 24) \
    macro(macro_seed( 0x7b,0x3c,0xd3,0xc3,0x6d,0x14,0xb4,0x14,0x97,0x07,0x34,0xff,0xd0,0xd2,0x71,0x4d,0x46,0xdd,0x91,0x46,0xbe,0x6e,0x4f,0x83,0xc0,0xb3,0xe3,0xe4,0xaf,0xc9,0x15,0x0d,0x01 ),   930290,  0, 24) \
    macro(macro_seed( 0xe2,0xa4,0xc7,0x3c,0x2e,0xc5,0xbf,0xbd,0x67,0x2a,0x71,0xca,0xd9,0xcd,0xc2,0xde,0xbb,0x0f,0xb6,0x9d,0x98,0xd4,0x4f,0xd3,0x39,0xe1,0xb2,0x7d,0x73,0x62,0x93,0x18,0x01 ),   117190, 12, 24) \
    macro(macro_seed( 0x8a,0x58,0x5e,0x9c,0x59,0x48,0x46,0x1f,0xea,0x28,0xbe,0x79,0x7e,0x1b,0x3d,0xa9,0x9e,0x97,0xae,0xa5,0xe9,0x74,0xa8,0x76,0x9a,0xac,0x48,0xc3,0xf0,0x3c,0xb9,0x4f,0x00 ),  1159860,  0, 24) \
    macro(macro_seed( 0x37,0x5c,0x00,0x44,0x6e,0x34,0x01,0x73,0x26,0xce,0x5e,0xd1,0x49,0xde,0xaf,0xe5,0x06,0x95,0x7f,0xc3,0xe5,0x73,0x8d,0xe7,0xba,0xde,0x41,0xee,0xec,0xe6,0xad,0xfb,0x00 ),   466350,  0, 24) \
    macro(macro_seed( 0xa3,0x3d,0x3d,0xf3,0xba,0x34,0x21,0x6b,0x56,0x84,0xe7,0x2c,0x1c,0xc3,0x7a,0xd2,0x76,0xef,0xc6,0x68,0x22,0x24,0x10,0x91,0x04,0x12,0x50,0x77,0x5f,0xbc,0xea,0x89,0x01 ),   463940,  0, 24) \
    macro(macro_seed( 0x78,0xd8,0x87,0x45,0x57,0x59,0x90,0x2a,0xb2,0x3d,0x14,0x5b,0xac,0x9b,0xb6,0xd1,0xb6,0x1c,0x1b,0xd1,0x4b,0x16,0x21,0x37,0xa1,0x21,0xab,0x3e,0x89,0x27,0x72,0x54,0x01 ),    69710,  0, 24) \
    macro(macro_seed( 0x60,0xba,0x8e,0xde,0x34,0x73,0xfa,0xfc,0xb1,0x8d,0x46,0xa4,0x9a,0xf1,0xf1,0x0d,0xbd,0xfd,0x44,0xb3,0x45,0xd4,0xde,0x36,0x35,0x6d,0xbf,0x12,0xd0,0x44,0x40,0x82,0x00 ),    46270,  0, 24) \
    /* ecosystem partners */ \
    macro(macro_seed( 0x2d,0xb2,0x4c,0x7c,0x29,0xeb,0xc6,0x33,0xb8,0x30,0x50,0x81,0xf9,0x5a,0x6f,0xe0,0xa3,0xd6,0xcb,0x14,0xed,0xc9,0x3a,0x8f,0xdc,0x48,0xbe,0x2a,0xcc,0x79,0x9c,0x8f,0x01 ),  4000000,  0, 24) \
    macro(macro_seed( 0x4d,0xa6,0xa2,0xc2,0xbf,0x33,0x58,0xbb,0xb7,0x0b,0x42,0x60,0xcc,0xea,0x9a,0x5f,0x00,0xf5,0x3f,0xed,0xf1,0x6c,0x7d,0x8f,0x4e,0xaa,0x13,0x78,0x40,0x91,0x44,0x56,0x01 ),    50000,  0,  6) \
    macro(macro_seed( 0x4d,0xe7,0x84,0x6a,0x7d,0x31,0xd8,0x42,0x6b,0xbe,0x63,0x6f,0xe2,0xad,0x67,0xf9,0x9a,0xba,0x1c,0x11,0xbc,0x4f,0xb7,0x39,0x4b,0x6a,0xea,0xa6,0x74,0xfb,0x33,0xf7,0x01 ),   420000,  0,  6) \
    /* eco system */ \
    macro(macro_seed( 0x05,0xa8,0xc5,0x03,0xec,0x42,0xcb,0xc1,0x95,0xae,0x1a,0x64,0x8d,0x9e,0xd3,0x05,0x63,0x5e,0x06,0xf0,0xed,0x9b,0x67,0x22,0x3f,0x59,0x47,0xf5,0xa3,0x91,0xf3,0xf7,0x00 ),  2530000,  0, 24) \
    /* team */ \
    macro(macro_seed( 0x7e,0x08,0x51,0x51,0xaf,0x65,0xda,0xdb,0x26,0x5f,0xd1,0x99,0x18,0xa8,0x9a,0x9c,0x9d,0xf3,0xa5,0xde,0x42,0xf7,0x75,0xcf,0x7d,0x3b,0x50,0x9a,0x15,0x61,0xac,0x38,0x00 ),  1000000,  0, 24) \
    macro(macro_seed( 0x7a,0x17,0x2a,0xa4,0x8d,0x3e,0x49,0x26,0x87,0x7e,0x93,0xc1,0x0d,0x3c,0x09,0xe2,0x7a,0x87,0x2f,0xab,0x35,0xb3,0xdf,0x74,0x07,0x60,0xbc,0xf7,0x18,0x48,0xde,0x11,0x01 ),  1000000,  0, 24) \
    macro(macro_seed( 0x59,0x44,0xb7,0x7a,0xe2,0x63,0x66,0x26,0xbc,0x10,0xa4,0x66,0x6f,0xfe,0x79,0x4e,0x2a,0x7c,0xd8,0x83,0xa3,0x8b,0xef,0xc4,0xef,0x76,0x2b,0xed,0x3a,0x2b,0x82,0xbd,0x01 ),  1500000,  0, 24) \
    macro(macro_seed( 0x63,0xaa,0x78,0xf4,0x66,0xd0,0x09,0x10,0x64,0x22,0x69,0x50,0xac,0x86,0x12,0x18,0xa0,0x6d,0xf6,0xb7,0x89,0xc1,0xfe,0x07,0x5a,0xc7,0xa6,0xaf,0x35,0x92,0x7f,0x05,0x00 ),  1500000,  0, 24) \
    macro(macro_seed( 0x86,0xda,0x74,0x06,0xd7,0x24,0xe3,0x71,0x69,0x22,0x27,0xd2,0x54,0x4b,0x2b,0x64,0x57,0x30,0xfd,0xe1,0x57,0x68,0xbb,0x79,0xb2,0xc2,0xd0,0x42,0x04,0x55,0x51,0x47,0x01 ),   750000,  0, 24) \
    macro(macro_seed( 0xcb,0xfa,0xe5,0x66,0x77,0xc3,0x2d,0xd8,0xb7,0x1a,0x29,0x87,0xb2,0x33,0x4f,0xba,0x0a,0xaf,0xdd,0x55,0x69,0xab,0x0c,0x67,0x88,0x55,0x7a,0x69,0x13,0xb6,0xca,0x25,0x01 ),   750000,  0, 24) \
    macro(macro_seed( 0x8b,0x87,0xa4,0x0c,0xcf,0xb8,0x56,0x9a,0xbf,0xb4,0x76,0xfb,0x39,0xcd,0xaf,0xa5,0xfe,0x63,0x59,0x38,0xe0,0x31,0xc2,0x7b,0xa8,0x6e,0x6d,0x4e,0xd5,0xc1,0x04,0x2f,0x01 ),  1000000,  0, 24) \
    macro(macro_seed( 0x05,0xc8,0xb9,0x69,0x33,0xce,0x07,0x48,0x99,0x46,0x1a,0x82,0x8a,0x74,0x1b,0x5a,0x3e,0x39,0x04,0xc2,0x72,0x44,0x2d,0x4c,0x70,0x12,0x52,0x63,0x9e,0x58,0xc1,0x4e,0x01 ),  1000000,  0, 24) \
    macro(macro_seed( 0x20,0xca,0xa6,0xcb,0x80,0xdc,0x5d,0x69,0xc1,0x9d,0x27,0x31,0x65,0xff,0xfd,0x2d,0x72,0x79,0x75,0x03,0xdf,0xdc,0x7c,0x11,0xd7,0x28,0x03,0x3d,0xdf,0xe7,0x9d,0xb6,0x01 ),  1000000,  0, 24) \
    macro(macro_seed( 0x59,0x64,0xbb,0xb4,0x5d,0x41,0x55,0xe1,0x3f,0x26,0x27,0xec,0x34,0x87,0x18,0x76,0x65,0xa0,0xf8,0x9b,0xcb,0xf1,0x65,0x9f,0x74,0x8e,0x12,0x80,0xe7,0x17,0x91,0xdc,0x00 ),   750000,  0, 24) \
    macro(macro_seed( 0x45,0x95,0xbf,0x0e,0xff,0xad,0x33,0x82,0x62,0xc1,0xd3,0xb5,0xb3,0x59,0x67,0x71,0x3b,0x36,0x1b,0x4e,0x44,0xbe,0xc3,0xdd,0xbc,0xc9,0x9a,0x1b,0x2d,0xd7,0x83,0x49,0x00 ),   750000,  0, 24) \
    macro(macro_seed( 0x8b,0xfb,0xac,0xb7,0x44,0x6d,0x73,0x77,0xe0,0xe6,0xc2,0xe7,0x9f,0x93,0x33,0x5a,0xb0,0xd1,0x6e,0x2a,0x6e,0xca,0x42,0x5b,0x78,0x9e,0x59,0x10,0xdc,0xcb,0x82,0xe4,0x01 ),   500000,  0, 24) \
    macro(macro_seed( 0x98,0x81,0xed,0xc5,0xa9,0x8b,0xd1,0xb8,0x86,0xa9,0x5a,0xc1,0xc0,0x2d,0x2d,0x39,0x98,0xa4,0xa4,0x85,0x90,0xdf,0x6a,0xcd,0x36,0x4b,0xce,0xbf,0xa1,0xa3,0xd9,0x96,0x00 ),   250000,  0, 24) \
    macro(macro_seed( 0x05,0x15,0x10,0x0c,0xcf,0x8b,0xff,0x91,0xc4,0xaa,0x7b,0x3b,0x82,0x7c,0x38,0x37,0x79,0x94,0x61,0x22,0x4d,0x75,0xc6,0x2d,0xfd,0x7a,0x87,0xd3,0x24,0x51,0x5c,0x69,0x00 ),   400000,  0, 24) \
    macro(macro_seed( 0x91,0xa5,0xdc,0xdb,0x9f,0xe0,0xf1,0xd8,0xa0,0x68,0xee,0x7f,0x1f,0x43,0xdd,0x2a,0x3b,0x84,0xd7,0xbf,0x77,0xb4,0x4f,0xa3,0xad,0xef,0x91,0xc2,0x01,0x22,0x73,0xa4,0x00 ),   750000,  0, 24) \
    macro(macro_seed( 0xd1,0x4e,0x49,0x0e,0x64,0x59,0x02,0xf7,0x46,0xf9,0x9a,0x9a,0xa4,0x19,0x44,0xe5,0xf5,0x03,0x4e,0xfa,0x2b,0x86,0xf6,0x3f,0xcf,0x12,0x86,0x37,0xba,0x01,0x97,0xba,0x01 ),   200000,  0, 24) \
    macro(macro_seed( 0x7c,0x0c,0x91,0xa8,0x75,0xd5,0xe5,0x38,0x9f,0x8d,0x3b,0x04,0x33,0x0a,0x9f,0x11,0x62,0x32,0xf5,0x26,0x68,0x9b,0x70,0x1c,0xb6,0x07,0xfc,0x1a,0x55,0xae,0x4a,0x98,0x00 ),   200000,  0, 24) \
    macro(macro_seed( 0x24,0xad,0x9f,0x3d,0x7d,0x3c,0x57,0x67,0xe2,0x61,0x7f,0xe0,0xeb,0x91,0xe9,0xbe,0x92,0xfb,0xce,0x87,0x56,0x08,0x24,0xa1,0x17,0x46,0xfc,0x6a,0x22,0x39,0x44,0x11,0x01 ),    80000,  0, 24) \
    macro(macro_seed( 0x74,0x05,0x37,0x33,0xce,0xf8,0x81,0xdc,0xab,0x36,0xda,0x26,0xf9,0xeb,0xf0,0xc9,0x84,0x8c,0xe9,0xe5,0xf3,0x5a,0xe7,0x49,0x3f,0x8b,0x8e,0x24,0x18,0x80,0x2d,0x30,0x01 ),    60000,  0, 24) \
    macro(macro_seed( 0x3c,0xfd,0x31,0x42,0xad,0x52,0x00,0x55,0xb6,0xcb,0x21,0x80,0x93,0xc1,0xc0,0xce,0xb6,0xee,0xf0,0x86,0x26,0x07,0xbe,0x2c,0xd4,0x4c,0x34,0x54,0xc0,0x3a,0x17,0x13,0x01 ),    40000,  0, 24) \
    macro(macro_seed( 0x25,0x05,0x48,0x17,0x4a,0xae,0xc4,0xf9,0xed,0x0e,0x91,0xf5,0xd2,0x58,0x8a,0xd8,0xd2,0x76,0x5f,0x6e,0x4c,0x35,0x0b,0x5e,0xfe,0x19,0xae,0xb6,0x33,0x05,0x2b,0x7a,0x01 ),     6000,  0, 24) \
    macro(macro_seed( 0xa8,0x92,0x2e,0x60,0x07,0x90,0x13,0xda,0x89,0x7f,0xca,0x50,0xee,0x31,0x76,0x23,0x0f,0xdd,0xc7,0xf5,0xfd,0xa9,0x2d,0x6c,0x2a,0x5f,0x6c,0x75,0x7f,0x6a,0xa3,0x89,0x01 ),     6000,  0, 24) \
    macro(macro_seed( 0x38,0xf7,0x5c,0x13,0xee,0x0c,0xf5,0xf7,0xf5,0x15,0x1b,0xda,0x7a,0x77,0xcf,0x0e,0x2d,0xb9,0x9f,0x44,0x25,0xdf,0x90,0xc3,0x2a,0xec,0x57,0x6e,0x3b,0x94,0x8e,0x76,0x00 ),     6000,  0, 24) \
    macro(macro_seed( 0xe2,0x62,0xe8,0x56,0xc1,0xc9,0x0a,0x67,0x2a,0x29,0x17,0x41,0x30,0xb7,0x4d,0xc9,0xa7,0xf4,0xa6,0xf5,0x77,0x3e,0x33,0x31,0x88,0xe8,0x60,0x86,0x4a,0xfb,0x8f,0x5d,0x00 ),     6000,  0, 24) \
    macro(macro_seed( 0x66,0x71,0x32,0xc8,0x2f,0xb1,0xc4,0x4d,0xec,0xa1,0x87,0xdf,0x19,0x3a,0x50,0xe1,0xc2,0xf3,0xef,0x3f,0x1a,0x45,0x51,0x94,0xbf,0xca,0x47,0xeb,0x70,0x51,0x08,0x06,0x01 ),   500000,  0, 24) \
    macro(macro_seed( 0x54,0xc2,0x67,0xb6,0x55,0xf1,0x61,0x48,0x17,0xac,0x96,0xda,0xb1,0x34,0x3d,0x3b,0x44,0x12,0x23,0x02,0x58,0x68,0x78,0x79,0x25,0x43,0x4e,0xcd,0x60,0xc6,0x21,0x6a,0x01 ),   200000,  0, 24) \
    macro(macro_seed( 0x4d,0xf9,0xa1,0xe7,0xb7,0x4d,0x38,0xe6,0x73,0x2b,0x10,0x15,0x50,0x9e,0x7c,0xed,0x1a,0xb6,0xdd,0xbb,0x8e,0x29,0xea,0xf5,0x50,0x9f,0x85,0xd4,0xeb,0xe2,0xdd,0x20,0x00 ),   100000,  0, 24) \
    macro(macro_seed( 0x92,0x5b,0xd5,0xf8,0xe6,0xac,0x83,0x6c,0x4a,0x46,0xcc,0x45,0xa2,0x2a,0xc1,0xa5,0xc2,0x27,0xae,0xcd,0x98,0x6d,0x2f,0x0a,0x4f,0x68,0x90,0xd7,0x76,0xcb,0xa9,0x91,0x01 ),   100000,  0, 24) \
    /* Foundation leftovers */ \
    macro(macro_seed( 0x62,0x38,0x99,0xe7,0x16,0x4d,0x04,0x74,0xfb,0x2a,0x3d,0xc3,0xd4,0xd8,0x98,0xd3,0xc9,0x5f,0xfa,0x13,0xef,0x14,0x52,0x08,0xf0,0xa5,0x8a,0x50,0x17,0xf1,0xdc,0xd9,0x00 ),  2296090,  0, 24) \
    /* next investment round */ \
    macro(macro_seed( 0x72,0xce,0x6d,0x4f,0x9d,0x02,0x2f,0xf2,0x4a,0xf2,0x38,0x14,0xf6,0x64,0x20,0x7d,0xe4,0x3a,0x10,0x93,0xef,0x28,0x16,0x47,0x48,0x00,0xa1,0x03,0x20,0xb6,0x57,0x79,0x01 ), 10626700,  0, 24)

void AllocateAll(const DaoCore::State& s)
{
    // Ensure totals agree.
#define MACRO_NOP(...)
#define THE_MACRO(seed, valBeams, start, end) valBeams+
    // should be inlined
    constexpr Amount nPreallocatedAssigned = g_Beam2Groth * (BEAMX_ALLOCATION_All(THE_MACRO, MACRO_NOP) 0);
#undef THE_MACRO

    static_assert(nPreallocatedAssigned + DaoCore::Preallocated::s_Unassigned == DaoCore::Preallocated::s_Emission);

    // Ensure vesting periods are well-defined (order, won't overflow)
    constexpr uint32_t nBlockPerMonth = 1440 * 365 / 12;

#define THE_MACRO(seed, valBeams, start, end) \
    static_assert(start < end); \
    static_assert(((uint32_t) (start * nBlockPerMonth)) / nBlockPerMonth == start); \
    static_assert(((uint32_t) (end * nBlockPerMonth)) / nBlockPerMonth == end);

    BEAMX_ALLOCATION_All(THE_MACRO, MACRO_NOP)
#undef THE_MACRO
#undef MACRO_NOP


    // Allocate everything
    Env::Halt_if(!Env::AssetEmit(s.m_Aid, DaoCore::Preallocated::s_Emission + DaoCore::Farming::State::s_Emission, 1));

    // Assign preallocated
#pragma pack (push, 1)
    struct Entry {
        Opaque<33> m_Pk;
        uint32_t m_ValueBeams;
        uint8_t m_Month_0;
        uint8_t m_Month_Delta;
    };
#pragma pack (pop)

#define THE_MACRO(seed, valBeams, month_start, month_end) { { seed }, valBeams, month_start, month_end - month_start },
#define THE_MACRO_SEED(...) { __VA_ARGS__ }

    static const Entry s_pE[] = {
        BEAMX_ALLOCATION_All(THE_MACRO, THE_MACRO_SEED)
    };
#undef THE_MACRO
#undef THE_MACRO_SEED


    Height h = Env::get_Height();

    DaoCore::Preallocated::User::Key puk;
    DaoCore::Preallocated::User pu;
    pu.m_Received = 0;

    for (uint32_t i = 0; i < _countof(s_pE); i++)
    {
        const auto& e = s_pE[i];
        _POD_(puk.m_Pk) = e.m_Pk;

        pu.m_Total = g_Beam2Groth * (Amount) e.m_ValueBeams;

        pu.m_Vesting_h0 = h + nBlockPerMonth * e.m_Month_0;
        pu.m_Vesting_dh = nBlockPerMonth * e.m_Month_Delta;

        Env::Halt_if(Env::SaveVar_T(puk, pu)); // would fail if key is duplicated
    }
}

BEAM_EXPORT void Ctor(const void*)
{
    if (Env::get_CallDepth() > 1)
    {
        DaoCore::State s;

        static const char szMeta[] = "STD:SCH_VER=1;N=BeamX Token;SN=BeamX;UN=BEAMX;NTHUN=GROTHX";
        s.m_Aid = Env::AssetCreate(szMeta, sizeof(szMeta) - 1);
        Env::Halt_if(!s.m_Aid);

        AllocateAll(s);

        Env::SaveVar_T((uint8_t) s.s_Key, s);
    }
}

BEAM_EXPORT void Dtor(void*)
{
}

BEAM_EXPORT void Method_2(void*)
{
    // called on upgrade. N/A
    Env::Halt();
}

BEAM_EXPORT void Method_3(const DaoCore::GetPreallocated& r)
{
    DaoCore::Preallocated::User::Key puk;
    _POD_(puk.m_Pk) = r.m_Pk;

    DaoCore::Preallocated::User pu;
    Env::Halt_if(!Env::LoadVar_T(puk, pu));

    Strict::Add(pu.m_Received, r.m_Amount);

    Height dh = Env::get_Height();
    Strict::Sub(dh, pu.m_Vesting_h0);
    dh = std::min(dh, pu.m_Vesting_dh);

    Env::Halt_if(
        MultiPrecision::From(pu.m_Received) * MultiPrecision::From(pu.m_Vesting_dh) >
        MultiPrecision::From(pu.m_Total) * MultiPrecision::From(dh));

    // ok
    if (pu.m_Received < pu.m_Total)
        Env::SaveVar_T(puk, pu);
    else
        Env::DelVar_T(puk);

    DaoCore::State s;
    Env::LoadVar_T((uint8_t) s.s_Key, s);
    Env::FundsUnlock(s.m_Aid, r.m_Amount);

    Env::AddSig(r.m_Pk);
}

BEAM_EXPORT void Method_4(const DaoCore::UpdPosFarming& r)
{
    Height h = Env::get_Height();

    DaoCore::Farming::State fs;
    if (Env::LoadVar_T((uint8_t) DaoCore::Farming::s_Key, fs))
        fs.Update(h);
    else
        _POD_(fs).SetZero();
    fs.m_hLast = h;

    DaoCore::Farming::UserPos up;
    DaoCore::Farming::UserPos::Key uk;
    _POD_(uk.m_Pk) = r.m_Pk;

    if (Env::LoadVar_T(uk, up))
    {
        Amount newBeamX = fs.RemoveFraction(up);
        Strict::Add(up.m_BeamX, newBeamX);
    }
    else
        _POD_(up).SetZero();

    up.m_SigmaLast = fs.m_Sigma;

    if (r.m_WithdrawBeamX)
    {
        Strict::Sub(up.m_BeamX, r.m_WithdrawBeamX);

        DaoCore::State s;
        Env::LoadVar_T((uint8_t) s.s_Key, s);

        Env::FundsUnlock(s.m_Aid, r.m_WithdrawBeamX);
    }

    if (r.m_Beam)
    {
        if (r.m_BeamLock)
        {
            Strict::Add(up.m_Beam, r.m_Beam);
            Env::FundsLock(0, r.m_Beam);
        }
        else
        {
            Strict::Sub(up.m_Beam, r.m_Beam);
            Env::FundsUnlock(0, r.m_Beam);
        }
    }

    fs.m_WeightTotal += DaoCore::Farming::Weight::Calculate(up.m_Beam);

    // fin
    Env::SaveVar_T((uint8_t) DaoCore::Farming::s_Key, fs);

    if (up.m_Beam || up.m_BeamX)
        Env::SaveVar_T(uk, up);
    else
        Env::DelVar_T(uk);

    Env::AddSig(r.m_Pk);

}
