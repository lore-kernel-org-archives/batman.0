Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 16 Nov 2014 13:49:56 +0800
Message-ID: <157347284.AYTAzmXrkZ@diderot>
In-Reply-To: <1405950125-13983-1-git-send-email-sw@simonwunderlich.de>
References: <1405950125-13983-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8331051.N3vusmHg4h";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] net: set name_assign_type in
	alloc_netdev()
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Simon Wunderlich <sw@simonwunderlich.de>


--nextPart8331051.N3vusmHg4h
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 21 July 2014 15:42:05 Simon Wunderlich wrote:
> From: Tom Gundersen <teg@jklm.no>
> 
> Extend alloc_netdev{,_mq{,s}}() to take name_assign_type as argument, and
> convert all users to pass NET_NAME_UNKNOWN.
> 
> Coccinelle patch:
> 
> @@
> expression sizeof_priv, name, setup, txqs, rxqs, count;
> @@
> 
> (
> -alloc_netdev_mqs(sizeof_priv, name, setup, txqs, rxqs)
> +alloc_netdev_mqs(sizeof_priv, name, NET_NAME_UNKNOWN, setup, txqs, rxqs)
> 
> -alloc_netdev_mq(sizeof_priv, name, setup, count)
> +alloc_netdev_mq(sizeof_priv, name, NET_NAME_UNKNOWN, setup, count)
> 
> -alloc_netdev(sizeof_priv, name, setup)
> +alloc_netdev(sizeof_priv, name, NET_NAME_UNKNOWN, setup)
> )
> 
> v9: move comments here from the wrong commit
> 
> Signed-off-by: Tom Gundersen <teg@jklm.no>
> Reviewed-by: David Herrmann <dh.herrmann@gmail.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> [sw: added compat code]
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
>  compat.h         | 14 ++++++++++++++
>  soft-interface.c |  2 +-
>  2 files changed, 15 insertions(+), 1 deletion(-)

Applied in revision df768d7.

Thanks,
Marek

--nextPart8331051.N3vusmHg4h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUaDsEAAoJEFNVTo/uthzAKjAH/0pitgRgblEbNo023lP6cnjz
WTrlh7xy6JQ7CUximUgLzDCTUicCsCNuCV3dsPe7/Yf38BVH8dIopxQajvW/8XwO
0OIMrII/QW9TrQ1bjdNorgN/Ap4rFeIWDCphIvTCF4clW7I+mHFTnGxR+ns96AST
W0PLb5SqKktJMe3ZdMenDY59Qh1TYrvXBeaoNtnxcV0FYvlT8WhguSz8nVgcI8BB
mw8a7LJ/GO1z6acHRQ5hPzjQw/2u+fn3pJGCsshDd9MuyoOKfPoOXZOJSNNbozCz
vJVFnsy4RPyfOO5J8C6P6Zyl+9C7pcYOeb4z7myYt1fiUSr4V5QlYoLuJl1OuKQ=
=D10W
-----END PGP SIGNATURE-----

--nextPart8331051.N3vusmHg4h--

