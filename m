Return-Path: <antonio@meshcoding.com>
Message-ID: <55792240.7040301@meshcoding.com>
Date: Thu, 11 Jun 2015 07:53:04 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1433989533-30587-1-git-send-email-xerofoify@gmail.com>
In-Reply-To: <1433989533-30587-1-git-send-email-xerofoify@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9gTnF6mtLX9dRp5O2QxwJwliO85mJSd85"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv:Make the function
	batadv_is_my_mac bool
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
To: Nicholas Krause <xerofoify@gmail.com>
Cc: mareklindner@neomailbox.ch, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, davem@davemloft.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9gTnF6mtLX9dRp5O2QxwJwliO85mJSd85
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Nicholas,

On 11/06/15 04:25, Nicholas Krause wrote:
> This makes the function batadv_is_my_mac bool now due
> to this particular function only returning either one
> or zero as its return value.
>=20
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>

NAK.

we already have ("batman-adv: main, Convert is_my_mac() to bool") in
net-next that does exactly the same. I guess you did not pull the latest
changes before writing this patch?

Cheers,


--=20
Antonio Quartulli


--9gTnF6mtLX9dRp5O2QxwJwliO85mJSd85
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVeSJEAAoJEOb/4TMchkvfmqUP/183aLW7L69kngRDMdeXoR+O
kIghnYAnakndcpKLtABMDtscmvKcRMmc2XHqgUeooKMYmoGO4YBwKtb6RhXL2KM1
cClVc4TFXaEktD8yQZsfYwiRrdHAuc6cpNtrsFKiEx+3NokZe8OArQg/UGTaqmQf
8wI0J+4BXzCeX2ayHzEZhBJajKz9cBZb4724uT8trNgI76ThlSnXNpCbBifoUTIk
SqM6uf6FasXjaK/ocPzYqHm6bbEebaL2PsNXvdnC7oyTEGS1EiYcjJvfnRhcK/Kr
0I9fcSqoM0jhPwHZNLxbrQlkcMMTXy8aa4kS9A7Biwn8CVyKyHIuPPiEtEj/7Z2N
s8h0/yBTMknnGoAq0yqS5lvlNfoZ5FoNNyNNVTdbTQtNu3qp8LnadPwGRF2Ok1/U
ynYoKwpSqKK8Hoyu/tjct15+6ij0RpAZmq8tXvDIHpNpXnPU2duHfmx0bRvxg+eX
L19KNtifRlfKX5M/YO/H5HxENw3o48TMGQC4DB3mCi1695qM41B5cQl1a1NYNRHu
VDp1/fH8AzaLhe5DXfOghL8L9JwHFKjjVU3fjuajp/EBjler5Q5H/B3uNxNuYfAz
PBENuFaQG0TycNR2++v+2GofhAtriyMZRStBG6Ucb+cpwNK6oMPp0wU74hz+1v/K
TmtEZZ/hNkm3BYXvO3Wq
=sBDq
-----END PGP SIGNATURE-----

--9gTnF6mtLX9dRp5O2QxwJwliO85mJSd85--
