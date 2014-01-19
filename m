Return-Path: <antonio@meshcoding.com>
Message-ID: <52DBFA49.1090102@meshcoding.com>
Date: Sun, 19 Jan 2014 17:16:09 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <d48019225b19f19f5ac724d3b1a247cdf921f92b.1390143639.git.mschiffer@universe-factory.net>
In-Reply-To: <d48019225b19f19f5ac724d3b1a247cdf921f92b.1390143639.git.mschiffer@universe-factory.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rpBXGa8TRHCat7aasLQdl18PbxRuVpSOC"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batadv-vis: don't leak socket fd in
	get_if_mac()
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
To: mschiffer@universe-factory.net
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rpBXGa8TRHCat7aasLQdl18PbxRuVpSOC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 19/01/14 16:01, Matthias Schiffer wrote:
> Leaking an fd every time get_if_mac() is called causes a batadv-vis ser=
ver
> process to hit the open file limit in a matter of hours when it is as l=
ow as
> 1024 (which it is on OpenWRT).
>=20
> Reported-by: Jan-Philipp Litza <janphilipp@litza.de>
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>

Matthias,

what repository is this patch against?

> ---
>  vis/vis.c | 8 ++++++--

I am puzzled because your commit subject says "batadv-vis" but the patch
does not seem to be against batman-adv/batctl. Can you clarify please?

Cheers,



--=20
Antonio Quartulli


--rpBXGa8TRHCat7aasLQdl18PbxRuVpSOC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS2/pNAAoJEEKTMo6mOh1Vv5UP/AwDlpEE2U5AKT3A397nc4p9
hS9nY82+ncJwjF0sVS16tgwWTPT/HeOiumvLQSzdvLD+VDpXiEcc0Hxtu5bRIOhJ
OuB2RfZ88yLaVRp19ghK4FXfRq5zYSR2b/oRQBSkJIDCoOcGl8MG7MC04j12+wIN
kneu76MhbDzsbsUBsLpo5uCpe4z7UEfAHkePLNAT5md8ZxkWCfXXOj9gbwF1gQ0R
543t22sSqY3ucXFWZTZg5XHRrX84jXkNYp0JNvQ7bihDuymi+yhGYVk7kF7FKQcr
lp/1pwkmc/RfKU0JylMnLRTPq++xowEKv114r+QxF3RhnGM/PkfgmhXmpqwUVZ7F
7xe2flCC7qvpwpg8QuZtBwGJeVe0XmccfFdGtuvJZ3H2o7OqQ3pQLsvfUDJPZa1Y
FLemDjIprzmfBagWUMTHKnjBkSTEn+uT1DFueiTV1g13jbY2zsSDsBPNEDnvUMXd
jDRvzo1CkIxQW6vyH/IThzNGo5BFqRhXpn1Yp3ikQOl/7GFR7eqRpDBGsa3Cn5pw
13fcbcbaQYm5p3d6MfUJIMFOHJXPyVq34hdjGuEhXh+2k5HXfC8jFESJiPx9RX3B
8002X2oi+T8Vvmf6M62VXxQISRdgIe/8JJUj43At7n3ZE2kNieZxOcTA73Y0IxU0
CA+FeBPdTaG7GRY6DSOI
=iEgm
-----END PGP SIGNATURE-----

--rpBXGa8TRHCat7aasLQdl18PbxRuVpSOC--
