Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 12 Jan 2016 16:33:58 +0100
Message-ID: <55871661.0vibtzJOD8@sven-edge>
In-Reply-To: <1452609161-25243-1-git-send-email-a@unstable.cc>
References: <1452609161-25243-1-git-send-email-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1779920.FTGYXdggIs";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: remove whitespace from
	copyright line
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1779920.FTGYXdggIs
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 12 January 2016 22:32:41 Antonio Quartulli wrote:
> A whitespace has been accidentally added while updating the copyright
> years in the file headers. Remove it.
> 
> Fixes: ee0e93f52a34 ("batman-adv: update copyright years for 2016")
> Cc: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Antonio Quartulli <a@unstable.cc>

Nacked-by: Sven Eckelmann <sven@narfation.org>

This was on purpose to follow the the "How to Apply These Terms to Your New 
Programs" section of the GPL2 [1]. The example given there is following:

    <one line to give the program's name and a brief idea of what it does.>
    Copyright (C) <year>  <name of author>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

This way of separating the year and the copyright holder is also used in other 
parts of the kernel and other parts of the batman-adv related source code 
(e.g. batctl and alfred).

Kind regards,
	Sven

[1] https://www.gnu.org/licenses/gpl-2.0.txt
--nextPart1779920.FTGYXdggIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWlRzmAAoJEF2HCgfBJntGvKIP/30QF7HcOxwNhJtk/Zze3XMa
g6cu7oRzZO6pgwokDznLDPriPlSI0qLdvmT4s+vtEiMI8hFwJFfOhlT2nUxyR5tZ
eBm2X7RYpnaOSkv8YoPcJswVVVS3zIudmlz58r4mXmpye0MkVbnExvs52wXAbh81
uWSwrc8xU24BZb9f1AMBRl02739EZ7mjSOriCSkW2Fi8YD5B7Du6ZBGWGdGPHI0n
fawOZsDjbO8e8uFjyxVkCjB4LvzlZX88Vxz521DdFEzsVjGhMBjPVW9x/iDP1AbU
PPZj8QNMB9ZIOM6u52c5cdCKhK+ltjpgROleC0z/meb+vXNdBwZm5qdibJ/EWitG
vmTT4bkiF0ev3p1W8cFIGEbi24TfUmoZfY0HkAlaGJ3qBSFcgkHSF44rT2Nvsgto
Jn3gXiAPsyYvP7wHgPOaoAArTHEyjncjbjkI2u8b9XZw0uT4iHk9oXOSaUhq3wNX
Z/L2dm3pdaoPf0I7ozWdMKK+eZZSVqhkarTj6T/2aJ3gg/5yvQXah1g31UieXOaQ
Uv+r0oScc21nsITxghw1M2xJQw4f2h811C3jrr6Th8QEJIS/3+odZxRjAyffAoSP
3r9bxhdyZOBkalrwMQDT39XM/eXtefWWpbzqeRakbgP0a9gwjZz3WDlDmu/EWhD1
nCyvpnleVZj46aQoSpyh
=rfWG
-----END PGP SIGNATURE-----

--nextPart1779920.FTGYXdggIs--

