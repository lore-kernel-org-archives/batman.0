Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 14 Oct 2013 22:37:21 +0800
Message-ID: <2488579.ibi0SMlka2@diderot>
In-Reply-To: <1381625420-4062-5-git-send-email-antonio@meshcoding.com>
References: <1381625420-4062-1-git-send-email-antonio@meshcoding.com>
 <1381625420-4062-5-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7766101.SHv2neAicl";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 4/4] batman-adv: include the
	synch-flags when compute the global/local table CRC
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


--nextPart7766101.SHv2neAicl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 13 October 2013 02:50:20 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> Flags covered by TT_SYNCH_MASK are kept in sync among the
> nodes in the network and therefore they have to be
> considered while computing the global/local table CRC.
> 
> In this way a generic originator is able to understand if
> its table contains the correct flags or not.
> 
> Bits from 4 to 7 in the TT flags fields are now reserved for
> "synchronized" flags only.
> 
> This allows future developers to add more flags of this type
> without breaking compatibility.
> 
> It's important to note that not all the remote TT flags are
> synchronised. This comes from the fact that some flags are
> used to inject an information once only.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  packet.h            | 11 +++++++++--
>  translation-table.c | 19 +++++++++++++++++++
>  2 files changed, 28 insertions(+), 2 deletions(-)

Applied in revision 05d4de2.

Thanks,
Marek

--nextPart7766101.SHv2neAicl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSXAGkAAoJEFNVTo/uthzAd+wH/0Ogxy6UcrK+IZKy5/z6om6S
gyF48WyxzasmMGZ2Hir+aV2po4WyYwvUvmLzxlhPMkSXOLEiL6lblfAqjkSkKdlb
/Le7j+q8o2YUhXKRBHEnPHKDTLjvr6QVFqGOpMGkBpxN7a0M+2RkOw5H4Fad16oW
kt3ILmQE/zQwJ9Oa0CY2MmXKww16VE0Z7NPwA399Hx2TaH/TTCIdSMKYlVtx74YV
JlGS+9LjJtxiMr3uh+tLVKOD938DycZSYYOh3BhBa3t+2OOMUW9FZQkxYHNfvoxA
Ka/uxB46t0xqyxdunftGx5WF0eD5+XIcpqlEPrmNG+4PDeNSex9jXTq0MUPm1zo=
=F2ll
-----END PGP SIGNATURE-----

--nextPart7766101.SHv2neAicl--

