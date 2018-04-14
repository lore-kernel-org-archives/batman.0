Return-Path: <a@unstable.cc>
References: <20180413181618.24144-1-sven@narfation.org>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <cf2ad8e6-202a-f8f0-29a5-e9dee517167d@unstable.cc>
Date: Sat, 14 Apr 2018 17:36:11 +0800
MIME-Version: 1.0
In-Reply-To: <20180413181618.24144-1-sven@narfation.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qXD2yUkDY9m3Sxn8mrV9AWiqPtdM58eKZ"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Validate translated mac addresses
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>
Cc: Andre Kasper <Andre.Kasper@gmx.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qXD2yUkDY9m3Sxn8mrV9AWiqPtdM58eKZ
Content-Type: multipart/mixed; boundary="7VvzBhytUCKuyqCowh9GwbI04hD6YTTG2";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>
Cc: Andre Kasper <Andre.Kasper@gmx.de>
Message-ID: <cf2ad8e6-202a-f8f0-29a5-e9dee517167d@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Validate translated mac addresses
References: <20180413181618.24144-1-sven@narfation.org>
In-Reply-To: <20180413181618.24144-1-sven@narfation.org>

--7VvzBhytUCKuyqCowh9GwbI04hD6YTTG2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 14/04/18 02:16, Sven Eckelmann wrote:
> The IP translation layer is using the neighbor table of the kernel to g=
et
> the unicast link layer (mac) address for IP(v4|v6) addresses. The kerne=
l
> can not only return unicast mac addresses to such an RTM_GETNEIGH reque=
st
> but also zero mac address. Such an address must be considered invalid
> because the global translation table may not only contain a unique clie=
nt
> mac address entry for it. The translation from client mac to originator=

> will therefore most likely return an unexpected originator.
>=20
> Dropping these kind of (bogus) results avoids confusions while using th=
ings
> like batctl's ping or traceroute.
>=20
> Reported-by: Andre Kasper <Andre.Kasper@gmx.de>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Acked-by: Antonio Quartulli <a@unstable.cc>



--=20
Antonio Quartulli


--7VvzBhytUCKuyqCowh9GwbI04hD6YTTG2--

--qXD2yUkDY9m3Sxn8mrV9AWiqPtdM58eKZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlrRy4wACgkQB6U8WA7y
zXR54xAAtVZub1eMXD5AhRX4PH5eKjScnFbz0E5xiiomvKRYmmKXFuIuWmhHGkNl
6ozAX5WrXMDw7LzZyP8xZoVAS1STADh+WgAqe40XEMeApR1WFl5tYBDZv2cSOOdo
0WnqlwPIA6Ujxi7CFvY58g/vRg3Yfx7i9HyPqE0AojputjZ/F0HdsYuOHqQnI8h8
eVVT7hhZjyN9JcY0XZMTCSclnFg1Xrkcxeck/fI4YwZDL+2uoWkoN2rYgXP8xiXr
MD+wwePuqlXxSJ9RsTKZnSWNTvvu9hggzQnlNoUNuxUs+4YBO0nN3EdX18ze9bCa
fx7kAJ0yQoN/gqDwY3sfbxyR1sv7Rhytmp83tKlkHWhBvDloQaiPOxuO3jha5tCH
k6/2kYFuK2pZrdlipauko0rgIautdgg8xqS1n2NlXMp8cQtYubHOy81U9ME4NFmi
COC/6HhtbS8xkZ4JOEl6lkEDXYtQnAFYPu0he8fTH1Sd6p4c/U+pp+AZv3ZDTBCA
Kz41VZTK6hPsjKNpraH8oHgzgkoFEpCa8ERzGs7k7MmzbrlNeerWMl4xwaktg52p
PSkRleZU6fG3S0q+Sm2BZPpet3ZIzNFkst78gfOprN9TIaSzTb9JNKLSHtfsmPWZ
ROCUeGNrOD3cQo00h5e4ADn6NxF9CBoN+YKA0GJH1dyYpMommnU=
=F9TK
-----END PGP SIGNATURE-----

--qXD2yUkDY9m3Sxn8mrV9AWiqPtdM58eKZ--
