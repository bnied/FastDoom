/**************************************************************************
 *                                                                        *
 * Copyright(C) 1998-2011 Simon Howard, Andreas Dehmel                    *
 *                                                                        *
 * This program is free software; you can redistribute it and/or modify   *
 * it under the terms of the GNU General Public License as published by   *
 * the Free Software Foundation; either version 2 of the License, or      *
 * (at your option) any later version.                                    *
 *                                                                        *
 * This program is distributed in the hope that it will be useful,        *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of         *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          *
 * GNU General Public License for more details.                           *
 *                                                                        *
 * You should have received a copy of the GNU General Public License      *
 * along with this program; if not, write to the Free Software            *
 * Foundation, Inc, 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA *
 *                                                                        *
 *                     The WADPTR Project: PALETTE.C                      *
 *                                                                        *
 *  Compresses WAD files by merging identical lumps in a WAD file and     *
 *  sharing them between multiple wad directory entries.                  *
 *                                                                        *
 **************************************************************************/

#include "wadmerge.h"
#include "wadptr.h"
#include "palette.h"

#define VGA_PALETTE_SIZE 768

void pal_compress(FILE *fp)
{
	char *lumppal = "PLAYPAL";

	int entrynum;
	unsigned char *working;
	unsigned int i,j;
	unsigned int posold = 0;
	unsigned int posnew = 0;
	unsigned char newpalette[12 * VGA_PALETTE_SIZE];
	entry_t newplaypal;

	entrynum = entry_exist(convert_string8_lumpname(lumppal));
	working = cachelump(entrynum);

	for (i = 0; i < 14; i++)
	{
		if ((i == 1) || (i == 9))
		{
			posold += VGA_PALETTE_SIZE;
			continue;
		}
			
		memcpy(newpalette + posnew, working + posold, VGA_PALETTE_SIZE);
		posnew += VGA_PALETTE_SIZE;
		posold += VGA_PALETTE_SIZE;
	}

	wadentry[entrynum].length = 12 * VGA_PALETTE_SIZE;
	wadentry[entrynum].offset = ftell(fp);

	fwrite(newpalette, 1, 12 * VGA_PALETTE_SIZE, fp);
}
