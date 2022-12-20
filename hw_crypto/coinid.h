// Copyright 2018 The Beam Team
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#pragma once
#include "ecc_decl.h"

typedef uint64_t Amount;
typedef uint32_t AssetID;

#pragma pack (push, 1)
typedef struct
{
	uint64_t m_Idx;
	uint32_t m_Type;
	uint32_t m_SubIdx;

	Amount  m_Amount;
	AssetID m_AssetID;

	// only trailing padding skipped (4 bytes)
	// normally this struct is aligned, the problem could be only with arrays

} CoinID;
#pragma pack (pop)

#define c_CoinID_Scheme_V0 0
#define c_CoinID_Scheme_V1 1
#define c_CoinID_Scheme_BB21 2 // worakround for BB.2.1

int CoinID_getSchemeAndSubkey(const CoinID*, uint8_t* pScheme, uint32_t* pSubkey); // returns 1 iff subkey is required
void CoinID_getHash(const CoinID*, UintBig*);
