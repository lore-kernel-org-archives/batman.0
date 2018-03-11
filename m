Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 11 Mar 2018 11:54:04 +0100
Message-ID: <2042233.hTAz9L1TrL@sven-edge>
In-Reply-To: <20180310235321.1324-1-linus.luessing@c0d3.blue>
References: <20180310235321.1324-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5115079.ehlsHt1hmO";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 0/2] batman-adv: netlink support for
 DAT and MCAST
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
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>, Antonio Quartulli <a@unstable.cc>

--nextPart5115079.ehlsHt1hmO
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sonntag, 11. M=E4rz 2018 00:53:19 CET Linus L=FCssing wrote:
> This patchset adds netlink support for dumping DAT cache and multicast
> flags tables.
>=20
> Changes in v2:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> - Added missing includes, "#include <linux/netlink.h>" and
>   "#include <uapi/linux/batman_adv.h>", to distributed-arp-table.c
> - Added missing forward declaration for "struct netlink_callback" to
>   distributed-arp-table.h
> - Changed nla_put_u32() to nla_put_in_addr() for BATADV_ATTR_DC_ADDRESS,
>   removed the then obsolete ntohl() conversion
> - Added missing include, "#include <linux/netlink.h>", to multicast.c
> - Changed nla_put_u8() to nla_put_u32() for BATADV_ATTR_MCAST_FLAGS and
>   BATADV_ATTR_MCAST_FLAGS_PRIV to enhance extensibility

Thanks for the doing the requested changes.

@Antonio: Can you please check whether you are ok with the new netlink name=
s=20
and types.

> +       [BATADV_ATTR_DC_ADDRESS]        =3D { .type =3D NLA_U32 },
> +       [BATADV_ATTR_DC_HWADDRESS]      =3D { .len =3D ETH_ALEN },
> +       [BATADV_ATTR_DC_VID]            =3D { .type =3D NLA_U16 },

Kind regards,
	Sven
--nextPart5115079.ehlsHt1hmO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlqlCswACgkQXYcKB8Em
e0Y1PhAApEoNdz1FWC/IHSV2tAIuLRUn+S3L/5DJMT94Jk/MlUiG71E0p3d78470
PsY5sY8dUtSAKCQ8hCFzS3wN9gSfIq51jPkdjoudKulXpxQ/X7cbraVhoVlFyJVn
XsIvhqb2FGoNc+bF0QY/z/5AU5EaE4hKUqo/2Zniy8SxeStqVHHgdKqXSFA1c6Nb
imBX//jzhd+x7JNudB05bqTLZjUkwkIxiGv+7vncid0K6at1saKj6OMap4/10NmV
5h3myeauSpOmV9byP82pzOHpRUrKQVHf7z9nmbqQ31htMAXVXbffbO05GxliK2Ht
jsnWwPSHaEPgNcrIXNZatrTAh4Xa3/GufrN07R+abHzA06Mb2LEEriEC7Abo/egy
LRrNQb9jrBltaD9aAQWCWQSr/aXlyBvqF+uRyCXRF+nRPEkxlpltf6zP6rIb8DdV
KZ++xhpufrTAAzVkm2Xf7SXqOn5A9K1Mcd5vLDeqeOfyD/IDGAnoSJ7Fcb9BQ/U6
Kth8ZnBRSvAXnafmRPp4rtp6x7COxALM7+RDKasy9RZhnnVFudkwx0Kx+hzg/9gu
F/QGD3w2czEI9AiyOskD0sewoe6ZKJgff1YaE/5Z8ztcFlI1ZQlQvy+jgBD/N0mi
iO+LQFHORYeK0mamDC3rUd+l5xEstAp7w1rhz/7wPFt5rdrS7bc=
=yDcB
-----END PGP SIGNATURE-----

--nextPart5115079.ehlsHt1hmO--

