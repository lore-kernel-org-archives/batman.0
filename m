Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 12 Jun 2018 21:46:49 +0200
Message-ID: <4572540.4P5GEOrqJY@sven-edge>
In-Reply-To: <20180606224624.10141-1-linus.luessing@c0d3.blue>
References: <20180606224624.10141-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2026155.HvfgsALnDt";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 1/2] batman-adv: Avoid storing
 non-TT-sync flags on singular entries too
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

--nextPart2026155.HvfgsALnDt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Donnerstag, 7. Juni 2018 00:46:23 CEST Linus L=FCssing wrote:
> Since commit 382d020fe3fa ("batman-adv: fix TT sync flag inconsistencies")
> TT sync flags and TT non-sync'd flags are supposed to be stored
> separately.
>=20
> The previous patch missed to apply this separation on a TT entry with
> only a single TT orig entry.
>=20
> This is a minor fix because with only a single TT orig entry the DDoS
> issue the former patch solves does not apply.
>=20
> Fixes: 382d020fe3fa ("batman-adv: fix TT sync flag inconsistencies")
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  net/batman-adv/translation-table.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Added as beb6246b2339 [1]

Thanks,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/beb6246b2339852b6a429ae=
9259a8eb30a685041
--nextPart2026155.HvfgsALnDt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlsgIykACgkQXYcKB8Em
e0bLgA/+PuoKvf2J8NTVXNdoJ6LnsfCZ83Z8Lz9RajXh2vtMwriipEiWzGoYERq2
NnBpQFt0bp7Aky9c7EhC3Tdh3DmaN2qEkIbFURJinre3A8uiV7CQ4VvLR6IAfEIf
4a3zXi7PZiILwcxzjcgG3gg95Q/k/3VJPEkGG8Dac1JvLM4Vn7nVivrI4mbZmHN4
XGbXuFZqAj90Uo7yumhq4MFwxxqgMRL/lCxMp4IhyqzbKQyHR1yBNlFstUJFHYAf
/477Qw+yQiIU0I4gD6gHB8tCBSZDG5CC49XxjXutXXeQijhuYCRSKRffILX8Bhfe
V74m9QXLrt61YkTiqAHhzQS/VBTtkzTaBZy248X4s6VbkvdIa8hL3C9sOB9lU0CF
aGjLs5IKC+mql1xLiiXneVn/8YncrdFBysUL10GG6BP2Q5/j/ukYj8cdkdRoZ85t
+qPsqCvoMy/oE5v/HnepOW2Q+Q/VTvFVPc+2/1MKcRiL6rWWwvdfknzo42KyMTSR
Wr/x4ttdTjJ0ADBijQ3jXHVc184gHhNUyBXFURsAkh2RQP1YC7GfdPEF7r+Olpb8
rEtq59XY5xFctt7oTJPo1AWMy1zoFJgljjkx4IxyWqmJ9gFpEoFsVNlQ3P3wReGW
wnOFqqwU8W/pBJtW8cY0jLZ0Z5DGRGOGyJeXyOs6k0lUD/3JVC8=
=MEJP
-----END PGP SIGNATURE-----

--nextPart2026155.HvfgsALnDt--



