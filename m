Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 11 Jan 2016 17:05:21 +0100
Message-ID: <4025424.ueLjcNil9i@sven-edge>
In-Reply-To: <5693D141.5080900@unstable.cc>
References: <1451992006-13191-1-git-send-email-sven@narfation.org>
 <1451992006-13191-11-git-send-email-sven@narfation.org>
 <5693D141.5080900@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart18623958.TjNyXKJhZP";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 11/31] batman-adv: Drop reference to
	netdevice on last reference
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart18623958.TjNyXKJhZP
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday 11 January 2016 23:58:57 Antonio Quartulli wrote:
> what is wrong in releasing the releasing the reference to net_dev ins=
ide
> the RCU callback (except for introducing some delay) ?

To quote my may to Linus about the same patch:

On Tuesday 05 January 2016 10:18:13 Sven Eckelmann wrote:
> On Tuesday 05 January 2016 06:02:08 Linus L=FCssing wrote:
> > PS: Just to clarify, patch 10 is only a style patch, right?
>=20
> Yes, it is more a style patch to make everything more consistent.

Kind regards,
=09Sven
--nextPart18623958.TjNyXKJhZP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWk9LBAAoJEF2HCgfBJntGTfIP/jq6cBOop6h8FYmUo7t204El
IA5lCgXx97qEcwRRWcfI7sdVV0HoMsU+xO/yZW3sMl1KD4v9qvl3A5wXljwVCTw+
eueWtLR08/sprhf7sgZZahPN7hKuben7s9wKjLC2zDpwTbHpo2FPlyKEBrjjlnTV
OL5PGxSQ6kfm5GXDMbtF3XgTGM/u4Uc3leDqku4p6OTh6BXDgS97aE0MFrdje+Lc
BMjDcYtvzTlsXOMqaDU4aI6zSg/vrSe+BQ01doe8I6adMESw+tJf2bIgIzHunjBa
FZnAvS6EPW3wyu25VPHnOOEVHLkqfyYQQbdrzFOGeA3LaoJ25fxvEaBab0HKz5pB
mGJl6BKl0iJjspAWkWr6eNz1sHcGm1QYvIcO7S51oQdGAT9bJquCelGXhnqIhHOZ
doQ7+ZGkUGjzXFJoqgdomoztOvgMKj0Jw+Vpnuq/o4rQ8qbDDoBqaZ8uETZ4i3Ti
bYKqjDVDQQIjBnhBMgsWRE58UKg0hgCkAffe0+VEQKTnpsVKG+0OIejR93ukyN02
Fi5uywliHwSlb3uYPBFfaguZvlJAE+Uvbfm7anSa+QcIhXADxKL/90BD75g10mkV
dMDF3vxXzjsAbMG3GkkkEkidHbNiWACM9xk/U9o6C6XFSerdwoEbjhjet2ojkCdN
Puk2AffHSiDKFREXUQXg
=QAqO
-----END PGP SIGNATURE-----

--nextPart18623958.TjNyXKJhZP--

