Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 04 Nov 2016 08:16:22 +0100
Message-ID: <1751615.omgmT43EIh@bentobox>
In-Reply-To: <20161102171443.9491-1-sven@narfation.org>
References: <20161102171443.9491-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3354241.6QqCRhqIVE";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [maint] batman-adv: Revert "fix splat on
	disabling an interface"
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
Cc: julian@freifunk-rtk.de

--nextPart3354241.6QqCRhqIVE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Mittwoch, 2. November 2016 18:14:43 CET Sven Eckelmann wrote:
> The commit bac7733d06fa ("batman-adv: fix splat on disabling an interface=
")
> fixed a warning but at the same time broke the rtnl function add_slave for
> devices which were temporarily removed.
>=20
> batadv_softif_slave_add requires soft_iface of and hard_iface to be NULL
> before it is allowed to be enslaved. But this resetting of soft_iface to
> NULL in batadv_hardif_disable_interface was removed with the aforemention=
ed
> commit.
>=20
> Reported-by: Julian Labus <julian@freifunk-rtk.de>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Cc: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> Acked-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> ---
> This is a simple revert. Linus, feel free to propose a patch to remove the
> "|| hard_iface->soft_iface" when you think it is safe and you've tested
> that it works
>=20
> Bug report for it can be found at https://www.open-mesh.org/issues/307
> ---
>  net/batman-adv/hard-interface.c | 1 +
>  1 file changed, 1 insertion(+)

Applied in 89d0e31c2cc790743ee373b717c05ca85caf8384 [1].

Kind regards,
        Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/89d0e31c2cc790743ee373b=
717c05ca85caf8384
--nextPart3354241.6QqCRhqIVE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYHDXGAAoJEF2HCgfBJntGAW4QALgSWwYK8lvgLVYxo5Zy3U56
RSVBvxfBLbwDZi2X/lkKWQjvlHF8rVHfpABg/Vsi6d8WmP+2lTCDTFuRa7D9aPEI
nkHMCtrJOrNGySFGL/yBRLCeOWxKr2cdXyPVjPc1jlriIzBHb7PZ4QehVRutvcMY
iCXw4xGKZBZQh4z2CglGkz6yya6Dm/mNutyaw1w92GxJ8Trxgzc8diMw+ox7xBdQ
2CxMP+U463rhjkNiKuPyofHqg67GOSZarjLIHZK1gnXRudIHP/beaGgA1zWaVwLO
BNZvz8uQ2SPSYLyhfGIPbfWfO8yBvdohG6VYptomEEoWYb8Dpk5ORcSNx7GcUGgT
GYsF4I3UQTJ1OaNN3KT5aofUJnyGbrJW2dSW/E6jV6Z/bFB8henMd9W169x+BFPw
zlgIKQ5LXzXSC1LanoOeOZvlQPv7vFx17g89kyy9PP/1/xads7dd76PeBKS52IuB
GVSlcEGppzcCF6bE6ecA9QEwkuc1XTx9zIZsKxuH23BAMusvN6v8VrQPgqxI049l
Axh9hBUCFfAYsQjFKu+uHAaOqT8YKiCHc8vlodxGZTl9czOSV4p9BCpx5O74i9YV
boBG9wxFNXxuEVjYvG7Kqu86QxdOmmAy1P+/K4H+Qvry0pgKA/+dEN8wAPdieESP
Z0fKSdw3iMmCvCdeXfsS
=VwJH
-----END PGP SIGNATURE-----

--nextPart3354241.6QqCRhqIVE--

