Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 3 Jun 2010 19:27:27 +0200
References: <1275509466.23599.43.camel@Joe-Laptop.home>
	<1275580393-8071-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1275580393-8071-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2263537.IgRxZiUCJI";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201006031927.34438.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH-trunk] batman-adv: Use
	(pr|netdev)_<level> macro helpers
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2263537.IgRxZiUCJI
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sven Eckelmann wrote:
> From: Joe Perches <joe@perches.com>
>=20
> Compile tested only
>=20
> Add #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> Remove "batman-adv:" from format strings
> Use pr_<level>
> Use netdev_<level>
>=20
> Signed-off-by: Joe Perches <joe@perches.com>
> [sven.eckelmann@gmx.de: Adapted for current batman-adv version]
> Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
> ---
>  This version is just for trunk because I haven't checked if it really
> works. (not on 2.6.34 nor on 2.6.21).

=46orgot to say that this patch is on top of Simon's "bonding and interface=
=20
alternating" patch and my version of the "Convert MAC_FMT to %pM" patch. So=
 it=20
is open for discussion which should enter first... but if you want to test =
it,=20
please first apply the other patches.

Best regards,
	Sven

--nextPart2263537.IgRxZiUCJI
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMB+X/AAoJEF2HCgfBJntG4PoQAI/MUORsb9+HSpSuSpZsYBnx
X7+kx580WJ6QlroJkpFR3HGCFpbImboXaL2lxz1zuWJXQ8cie0qPyk0QzYYQvuSG
W4fP5ud1km4/zeaz53c8rGu4xHSOSEgJN51bicAI7RYNPqZPn9DO4en84qPh1DAD
TEvZgyPXEiNXiVX5wiOJwG8oHizqnqQ3qWzqxnRQYdT3wbkYpXUS/InSQz0+2mYN
TRxeCOeAFIzJSwCNVli1NvQCZeHomFrZsIgq2IXeskfGeT03YiV7fymCc1Io+HAE
qq0fsTua/BtGMNNAYp7p1pieXLZ0uLXlv2MP1HsaenIQI/1ELpg1e35o5ptDRKTw
ugdUHoj7YtYwzuJGS7EleGynNw5sYet5HyQFpHsLeJtzNCdE/h2Lda0gZ6RleSqT
C1JYUg4n8x1BT7hjJEj8wuNFjalQVxDwFfQo4d/ouBd7EcjTn3PqsyDL3QYFqEom
Gj7NsViia7b+M6gUod6wWZ2qSK3yvGwF/bkdeRjJi0GGMC/78kRfyUqQqrpUroQD
OaKfmo8G3d98NEVyk/7C/yGZb8e+Ts/pkQsdY7fYzrqswF6bbRMdMzPBzqaIeYdU
wLnHwJ+vO/YRBwYFZ3yShu3OgqlIR1/Qe2LYnwmeU54D2d5uZJU+jEiijaIOnCvx
b0wF5sA7bRcPBcsMSISb
=cUEs
-----END PGP SIGNATURE-----

--nextPart2263537.IgRxZiUCJI--
