Return-Path: <antonio@meshcoding.com>
Message-ID: <55911414.90404@meshcoding.com>
Date: Mon, 29 Jun 2015 11:47:00 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1434890572-3199-1-git-send-email-sven@narfation.org>
 <1434890572-3199-4-git-send-email-sven@narfation.org>
In-Reply-To: <1434890572-3199-4-git-send-email-sven@narfation.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cOxeC0HO3I4P0Xmm8s2XP99fhr05ACBep"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 4/4] batman-adv: Fix gw_bandwidth
 calculation on 32 bit systems
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
To: Sven Eckelmann <sven@narfation.org>, Marek Lindner <mareklindner@neomailbox.ch>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cOxeC0HO3I4P0Xmm8s2XP99fhr05ACBep
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 21/06/15 14:42, Sven Eckelmann wrote:
> The TVLV for the gw_bandwidth stores everything as u32. But the
> gw_bandwidth reads the signed long which limits the maximum value to
> (2 ** 31 - 1) on systems with 4 byte long. Also the input value is alwa=
ys
> converted from either Mibit/s or Kibit/s to 100Kibit/s. This reduces th=
e
> values even further when the user sets it via the default unit Kibit/s.=
 It
> may even cause an integer overflow and end up with a value the user nev=
er
> intended.
>=20
> Instead read the values as u64, check for possible overflows, do the un=
it
> adjustments and then reduce the size to u32.
>=20
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  * rebased on current master

shouldn't this patch be for maint as it is also fixing a potential
overflow issue?


--=20
Antonio Quartulli


--cOxeC0HO3I4P0Xmm8s2XP99fhr05ACBep
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVkRQYAAoJEOb/4TMchkvftIEQAIoU5aukNCFTRJHw3zcW3vt8
Bg6sklN43GiO6p4RCrSd7VsV4QJ1ejZbq3HGQOKeHRGxlpNDxuSweds8o1qBHPeD
/0Tunh62x99vQWsM27DOTDx/JKp29yNI5Wkk5ZUO5S7euhA36PqM2mjAOgmHCoyL
JA4DspWIkPdBou+lCttq3vKOmkgAVyTag195KMbTY8OxfxJOd5KgRFANdc1NhH5x
iJGxLuCT/k7yPY+5j8XSmv7448DjvNPcRGPWlJ43Q+DXMx4AGYDrOUJ0jE1RA6/G
Tkvx7s93xf/Klct4XJikhzKIXggYoxyJ7KH6MgagQKyNmB8RmL+/e6C9G3V/okJ/
JjKyaVSg/nJXkLEvtx/mZAKHMs11Ys0d3RiJC7EL8s3f9JVrKFzUpst3t6hpDeln
SNzMOskHhb9xggEaKlh8kQ++JilhLZfbTuROthw/NvoU+WQbvcHTjpCquD8PHwTA
oN/LPRLjn2rSP+/Bka+HJHnj9iyzBSEbePQeqw64rPm2sciKCtqvuLtFuk4wpLCG
84FXBAC6TLXBRNRWwXOr1AvQ/tffOBFpwhNqFkmXig5asfRULGRQd6af8eL/jrgW
RdveUK1rIMlEn3LB5mJxxcyZ7c9nCWM5wYJcnF3o5s6IXtJlybNgegtATYWdffHS
uQ+G7lMgjwgcgCQtVRhI
=uS2y
-----END PGP SIGNATURE-----

--cOxeC0HO3I4P0Xmm8s2XP99fhr05ACBep--
