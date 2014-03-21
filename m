Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 21 Mar 2014 16:29:39 +0800
Message-ID: <4207604.yrUcTBJjN3@diderot>
In-Reply-To: <1395251747-27289-2-git-send-email-antonio@meshcoding.com>
References: <1395251747-27289-1-git-send-email-antonio@meshcoding.com>
 <1395251747-27289-2-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2342892.digcU2lRAY";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 next 02/11] batman-adv: don't mess up
	with the netdev refcounting if not needed
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart2342892.digcU2lRAY
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday 19 March 2014 18:55:38 Antonio Quartulli wrote:
> Looking for an interface and increasing its refcounter only
> to check if it really exists is not really useful and makes
> the code look more complex without a real gain.
>=20
> Change batadv_mcast_has_bridge() accordingly and avoid to
> use the pointer to the interface outside of the
> rcu_read_lock/unlock context.
>=20
> Introduced by e368857f66620b8483166e8e6556d9c87f9b3e71
> ("batman-adv: Multicast Listener Announcements via Translation Table"=
)
>=20
> Cc: Linus L=FCssing <linus.luessing@web.de>
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  compat.h    | 19 ++++---------------
>  multicast.c | 33 ++++-----------------------------
>  2 files changed, 8 insertions(+), 44 deletions(-)

Applied in revision 9ef7aad.

Thanks,
Marek

--nextPart2342892.digcU2lRAY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTK/hzAAoJEFNVTo/uthzADJAH/R/YQx0tpJjAJ4tEwdBI9VWi
Zjh43Iv2kIWKTcluQ0nNtBkedIXriKL6ZzTUoNywCYZin960105yESpeB2/ePz4T
cztNzNQEFOZ5KR0jgNYmfPGkbCRnfyvMOSe1/LQI5YrEI8T7DSBL5HSP+toDbjoB
A2SqsH6dVIYMMjfwz+hE3UH8ZGJfDYVN+61TQKes1GrM8SiZj2qtxJlTTXqWfqsP
hC99J37rCy7+T3gU3O+MXD0BxkDHNWdZ5MmHhNAcALxdSmyiq3P1R7NOO6OtWnAx
EGhnnrUKWotdlDACZHvcy2cOEcKWiTLy1Zo8yqJrDGq5w7UP8zjaZTACy6BxN5w=
=z+XE
-----END PGP SIGNATURE-----

--nextPart2342892.digcU2lRAY--

