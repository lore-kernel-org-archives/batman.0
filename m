Return-Path: <a@unstable.cc>
Date: Mon, 1 Feb 2016 10:46:50 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160201024650.GN22112@prodigo.lan>
References: <1454257280-19649-1-git-send-email-mareklindner@neomailbox.ch>
 <1454257280-19649-3-git-send-email-mareklindner@neomailbox.ch>
 <20160201004826.GL22112@prodigo.lan> <4194875.ui2pi6v3zm@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Sk71+Upln2BLuDmg"
Content-Disposition: inline
In-Reply-To: <4194875.ui2pi6v3zm@voltaire>
Subject: Re: [B.A.T.M.A.N.] [PATCH next 3/3] batman-adv: fix misleading
 default throughput warning
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--Sk71+Upln2BLuDmg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 01, 2016 at 09:44:39AM +0800, Marek Lindner wrote:
> On Monday, February 01, 2016 08:48:26 Antonio Quartulli wrote:
> > On Mon, Feb 01, 2016 at 12:21:20AM +0800, Marek Lindner wrote:
> > > The default throughput value represents Mbps and not kbps.
> >=20
> > Isn't this a bit confusing? The default throughput is expressed in mult=
iples
> > of 100kbps, not Mbps.
>=20
> Prior to my patch the debug message said:
> "[..] therefore defaulting to hardcoded throughput values of 1 kbit/s."
>=20
> With the patch it says:
> "[..] therefore defaulting to hardcoded throughput values of 1.0 Mbps."
>=20
> FYI, I changed the text to "Mbps" because that is what batman-adv prints =
in=20
> the neighbor table as well in the originator table.

The patch is fixing the way you interpret the BATADV_THROUGHPUT_DEFAULT_VAL=
UE
constant, therefore I expected that with "The default throughput value
represents Mbps" you were stating how to properly interpret such constant (=
and
this wouldn't be correct).


Cheers,



--=20
Antonio Quartulli

--Sk71+Upln2BLuDmg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWrscaAAoJENpFlCjNi1MRPLcP/2XRj7z1Jxnk9THTFqPkWJZZ
HOTqeUO8KcmrysqR4gMpX6Ygewa/O+mMhcpE/8GRp5TN52uPo8BwFUVH4Br93Wep
i74XJ+AGfUP3/qyZv0vj7i6rywbZl8OxjlIEAsgg5sGkk8a6Y8l5Wg5Tp4MoKujY
P//au4pKsKzUvwj9tPfoyLicxPhJpji9HqSj4MqLvw7cY07BUKq4RHl7kpfd43kc
LT/gsaLtOKmJS4kjXgsJYjHxM1XXRp5ir4Pmwo7h6t3OksIBgM9Ae72XUpxcOiRg
VjDMJAC8GfwbFNFG/XEO9k6WfsHWM3QhHKIpkjRxYjHqE+TLuKH8rhEgcIVGXK5I
jdIxVFtuyOK7JpvGjt6QyC99FgO9HlG7oi0aVXXLNdz29XJB4pIXjF8jvBjMEVKb
WZm70n2RFqsdPboYfw2xNVUfopqR1koFXNART20falPhy8tCERiPlNDmgMD0iIIi
xNkKAHhxn3r6Za1C+nxXt8DL4+HBSa/38MDDHwvbz5T5yERsIij/DOcADeo9wz+I
WL5XIkKBOf5lA3yzebcbr7TQB1UbNNRqQvF3PSUK7TSvyhigFKBRb2lBE5dgFVJW
QuNxzFqSq1lRBLwYzheTPbiRbP2pEdkAeBj3juxdv1qvEpCMLGdlCLNrWzGeZtQk
SaRWHiq2gXTNaTQMEGU3
=dpm3
-----END PGP SIGNATURE-----

--Sk71+Upln2BLuDmg--
