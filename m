Return-Path: <a@unstable.cc>
Date: Tue, 24 May 2016 18:00:18 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160524100018.GB21783@prodigo.lan>
References: <1464042677-7787-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <1464042677-7787-1-git-send-email-linus.luessing@c0d3.blue>
Subject: Re: [B.A.T.M.A.N.] [PATCH] RFC: batman-adv: Remove unused
 primary_if variable
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


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 24, 2016 at 12:31:17AM +0200, Linus L=FCssing wrote:
> Fixes: 29b9256e6631 ("batman-adv: consider outgoing interface in OGM send=
ing")
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>=20
> Note sure whether the "forw_packet->if_incoming !=3D primary_if" check va=
nished
> on purpose or by accident in the mentioned commit. Or whether it got
> substituted by some other check. Therefore sending the patch as RFC.

I think Simon can better comment on this, but my understanding is that such
check has been moved to batadv_iv_ogm_schedule(), thus primary_if is useles=
s in
this function.

Simon, comments ?

Cheers,

--=20
Antonio Quartulli

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXRCYyAAoJEJ4aZjxxc6bKbcAP/2Eq5Yr+xtTatCJCC5XpCal3
3FWKQlW1PdDVj2QOEUio6jpJJQcCPRhgjBsv0pL1m0qbp/j/AbnYD2c4I39fU0/r
774G3sKtZRAzAixdcCU2UOULgLJY1pXF3BKDhQ46tXWcBWzsnk9k0W6pZXQjLsQC
ugSo6n5Wk3KNcqYj8IGRpW/2yr9ZWGTLNR8AaCktotjVR7v3/6lKEUHI5fQo4d94
An6pZ2+u6l37kXB087/zuIFVTOYcSiWrfdW0QHhto/HqtUmazk3+w/m+ZVhAKLfy
ukJLCBNWc66p6Laz6iBx6SFfacCBCe9Ktz8WuoGZqK+mznciKwlyzYWg4xjHfAlb
OH46uNxY1bb9jObCTNRsQBA+u2yPZ6ib5q1ztG/hNbGg1R6IkxfZ0vW4bBMFjB8+
94/kUNyzQB8TcXZ8Hy2y5ONq4CHgCBCKqgEYlFNSl9Rv1tbsBAqbUO/HmZtyVVw6
mXUBm7CPuF0xQsENe8kv0qxnuETvyvLtCI7VoD2mLrnw5dAVa4EURcnViyKrOc2V
Gr3zUmKmBhAVaKrtF6gK1RNCh0bIqZdCZHpy052SKhp+3VkjxeK3RyHYWQcnmkfi
J4y1W7ZDl7/TNGYKdAq4YYNxXOmjH6f84dgLWnlE/VTwa1iRsQ/ILeUp7ktKUK71
ZzR69/eZOXHJpA/wgb3k
=GJZS
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
