Return-Path: <a@unstable.cc>
Date: Mon, 6 Jun 2016 23:44:02 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160606154402.GM13158@prodigo>
References: <1464439110-3113-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gsH/BiyznuOL98BK"
Content-Disposition: inline
In-Reply-To: <1464439110-3113-1-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/5] batman-adv: Clean up untagged vlan
 when destroying via rtnl-link
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


--gsH/BiyznuOL98BK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 28, 2016 at 02:38:26PM +0200, Sven Eckelmann wrote:
> The untagged vlan object is only destroyed when the interface is removed
> via the legacy sysfs interface. But it also has to be destroyed when the
> standard rtnl-link interface is used.
>=20
> Fixes: 952cebb57518 ("batman-adv: add per VLAN interface attribute framew=
ork")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Cc: Antonio Quartulli <a@unstable.cc>

Acked-by: Antonio Quartulli <a@unstable.cc>


--=20
Antonio Quartulli

--gsH/BiyznuOL98BK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXVZpCAAoJEJ4aZjxxc6bKzhEQALzOC4gL7tZXH5L/YeA19t+c
ebc0BhkIQgVKKGQ0qgAogJF5Z+LPWWUOPaluR5A9OWlQCDBcpP03u2G3gdp6CRYR
K0ZdIdLaBONA/VFoltG/3VDzhuVA1yQM8rttFubWMQLe5CsObf4WeyDA+jcvKmn8
o3JkKLzGYxpJY0uE8RS5fgqQWi++Xj+rbHq5sA2XsJtNxPeOYvZjNzAYNuWyiBGP
7qyKrw3ZJ+WuR7PPQE5ufudgVa2/JgwedukzrBvOeTL13bvDV9BYWBFr426/TuJw
KSnjpGmuTalpMKoAIZeIabNYiJhwibWqVIxEJtn+FSCzGL5RpLTfjvSs7R99nslR
S1A7W/jw/4LfeR6y2kmcf7RWHlqNo/OpoXH537dpCW2ocUJ88gvxShrM9k3XepX3
Dg9D562JdMzoehH7RKLKW1H3WOIJgfFgl3KcMkKu0tL+wQRhD5FhwrAX44foC/sC
XkIvomYIw04aMCkH8P/JKYS+Ura8x520PpoErsu4rVfOI38/745vbJnTEKbpa6OQ
uLXJtLffeSYAmb/W0QLYU+geRbdcwiaSll5v7kTcchHkaHcAfx5bCaUCSDuBPaCJ
mYYuiIBMeXt2zbhOJPI64c1ZOBZ0v9qv4TQpgm7DkfHVx+lzpEOO579ANkVVcaj4
s8apX3WuaGehCvBda66T
=wHjU
-----END PGP SIGNATURE-----

--gsH/BiyznuOL98BK--
