Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 11 Dec 2013 16:31:21 +0800
Message-ID: <1804468.QD6oqgSnBX@diderot>
In-Reply-To: <1386411684-2448-4-git-send-email-antonio@meshcoding.com>
References: <1386411684-2448-1-git-send-email-antonio@meshcoding.com>
 <1386411684-2448-4-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2071125.jy8PD0UmIl";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/4] batman-adv: fix typ0s in
	batadv_tt_global_is_isolated()
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
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart2071125.jy8PD0UmIl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 07 December 2013 11:21:24 Antonio Quartulli wrote:
> Introduced by 6fa38a2c72cc79dd961a6d9ed00d32e1c308b448
> ("batman-adv: set the isolation mark in the skb if needed")
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  translation-table.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision 65f9fec.

Thanks,
Marek

--nextPart2071125.jy8PD0UmIl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSqCLZAAoJEFNVTo/uthzA71kH/jtviESM2TEJyPk1vdADt3HD
qR7EwEYuRd9doHECnSpsX6dZ53gYTwaS2FP/Dye2YOEm1WXkH+TyCDqsXgv+zOsE
oz1BgIGiGmVLztAzfVuYBZXEN/2xJOqxDE+JjmKf4W/kcPyBiuyFaYh7UsKG4xtz
JFnzpk5VYkV5B+UX70koZvn/dI26hfdOc/y4UXhcg2hzyLfDKzNyQcLCRsIr1vxj
hNGFzs/ka3KvRFbL9tABaDQ+rTUrcMCxQR1TofpZOTxpQnHPG2r9S61mcu9THaBZ
WS5qFvYPuFC9fyrlcTqSLflRUDRD1b9Kz3EoAJjPgrWXC9109RPh7b7YvHg81ug=
=h7aU
-----END PGP SIGNATURE-----

--nextPart2071125.jy8PD0UmIl--

