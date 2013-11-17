Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 17 Nov 2013 11:31:10 +0800
Message-ID: <7436464.faCUh8GSl0@diderot>
In-Reply-To: <1384599832-3959-3-git-send-email-antonio@meshcoding.com>
References: <1384599832-3959-1-git-send-email-antonio@meshcoding.com>
 <1384599832-3959-3-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1758378.uBXFg7m05n";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 2/6] batman-adv: mark a local client as
	isolated when needed
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@open-mesh.com>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart1758378.uBXFg7m05n
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 16 November 2013 12:03:48 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> A client sending packets which mark matches the value
> configured via sysfs has to be identified as isolated using
> the TT_CLIENT_ISOLA flag.
> 
> The match is mask based, meaning that only bits set in the
> mask are compared with those in the mark value.
> 
> If the configured mask is equal to 0 no operation is
> performed.
> 
> Such flag is then advertised within the classic client
> announcement mechanism.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  main.h              |  2 ++
>  packet.h            |  1 +
>  soft-interface.c    |  7 ++++---
>  translation-table.c | 16 +++++++++++++++-
>  translation-table.h |  2 +-
>  5 files changed, 23 insertions(+), 5 deletions(-)

Applied in revision a8c0e75.

Thanks,
Marek

--nextPart1758378.uBXFg7m05n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSiDh+AAoJEFNVTo/uthzAtPcH/3Dk7IPHjyzdaAhhm6d7wmkz
PsqTHuXTsIZWbps5hKS3i1HbL2mJfIsZ7LLFaFi9ds+Qz72WmsEwRkMv9pkoI95n
hCx90GBSVeUdFjcZbLw/jSJpwXTsPIo5q+eP1sc9Av43OPrDkZGp5UqizijROrsA
Ntjx644cm09Fn3QO/Mw8ZpcluYkPKqxOlQDbhn/Z75yKRIp302fVwxcOC5H0u4nS
SUgAFfcf54Ldz/RoB42dpnbaOf2iP3xBitE1QPChSPRVOp2jxHtH/2gH/wyokUe+
l2mlVFOs4rqK+1hzCsRCztxBJ72/MXmQCyHLpF/clQ+5/dCmz3QRk/Elk/ACZns=
=KDlS
-----END PGP SIGNATURE-----

--nextPart1758378.uBXFg7m05n--

