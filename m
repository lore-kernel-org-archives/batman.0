Return-Path: <mpa@pengutronix.de>
Date: Tue, 2 Dec 2014 14:57:03 +0100
From: Markus Pargmann <mpa@pengutronix.de>
Message-ID: <20141202135703.GC24653@pengutronix.de>
References: <3895904.RefSiyY2EJ@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
In-Reply-To: <3895904.RefSiyY2EJ@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH 30/31] batman-adv: packet.h,
 add some missing includes
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2014 at 02:03:16PM +0100, Sven Eckelmann wrote:
> Hi,
>=20
> please explain how this file can now be used unmodified in userspace (bat=
ctl)=20
> and kernel. If it cannot be done without modifying the file then please=
=20
> provide patches to modify the daily checks which make sure that the files=
 in=20
> both repos are the same. I think the batman-adv developers can give you t=
he=20
> original scripts.

I wasn't aware that this file is also used in batctl. Why is it needed
there?
Probably I should have a look into the batctl sources.

Thanks,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJUfcUuAAoJEEpcgKtcEGQQ5ZMP/iQhQOKG/18cvtHl7KNFjcnn
JyucSibiegHcpuDMuOEnb+IU1FHvkzoazOeb9TenVTrMiuq3u0lBykTRAQ2yfB67
LcoOUI4ORL0OxSxaIQnMOx4k4hqhHAmFe7FwWxcqoPTxd8KliHnHh8uMEdGp7AMR
MJnIHYQ8YjTRzd9BecAbNhngcmzZ4Ad0eyN3moE4l1esLyYgVdXHdNHPwzVYIB6W
SX3F7L3MhsMZa9kztI+pgsgcjbb9p/2aomr6wDQNufIz1Ymoi7tDM+HienbHiVjo
pHxsAuowOymN9pL319zJx3tfcOe44D4Jz8SAuxu8SboBxbFenBKCy/7DGDetDXp3
ZpFW18vsKwnMcGDHkw6IHykGpOuHAAR4IK6pwCZbz7f5YY+YBitu9MoRA3/noP1S
/fVSLqQJ51Kp2szC8PdsNA6yk4wJNUZ1xZYvNvg9qnbuBLrKVwPGQBFFwV8x6f9e
CXyl03+ube4WCqo5q0yU4pa9tizB9n3q+lYesnVgSWE8QFKMN3QnWt9ofFdDIA2M
Qe1v6Gd/K5EhKYi6hNg6ogohu0nLWQZ/7WjfPtRhLtye8xY/E9UkPX7jkShZxr/f
/EIG8pBwuOYZkizK/pODgHmogXB+k4apyi23XlGYkAg6VyritzWLdIDMBylj6B82
ZoQ9E5qh4czCwlENXkbs
=Jeut
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
