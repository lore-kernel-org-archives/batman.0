Return-Path: <ordex@autistici.org>
Date: Mon, 11 Feb 2013 21:14:28 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130211201428.GB16760@ritirata.org>
References: <201302111710.04911.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline
In-Reply-To: <201302111710.04911.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] create batman-adv interfaces with netlink v3
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Sven Eckelmann <sven@narfation.org>


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2013 at 05:10:04 +0800, Marek Lindner wrote:
>=20
> Hi,
>=20
> here the third patch series to get the netlink interface creation into sh=
ape.
> Changes since v2:
>  * Reference counting bugfix in batadv_add_slave() & batadv_del_slave()
>  * Master settings & compat support
>=20
> Kudos to Antonio for providing the compat support and debugging the inter=
face=20
> to the bitter end!

But..has the patchset been rebased on top of the latest master? Git am is
complaining and cannot apply the patches.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRGVEkAAoJEADl0hg6qKeO6MQQAJx8xun9DkaqesHl8KcRCopu
TsFhdfvyWbTbWtkIr/0d9kAM+XGrP/c1n9lOMOU0XiVEbD03Y5B8ImH4XF1I/CBD
/xD7JA95P99sexh//FfWxnrAecl2Y2flIwxHObIcjkOUXAmQbP2Edt0KLZH/QS2H
h4YbXvIXMCi9X0fF6jEWCWHVkTv7bHO8gaUEl/hsFUL9X38k2XcGjAsxI30KDBha
OIK3V3OLVIOjAoLb3gWlVLGo8iRd9lPrIqLB5/E37Z1fS14DVC0rm8xdGfHCxtGA
LERKG3TKndSwnaZF+JzfSkdEaXD2qdkBCslciSv19Tfx5i4KyvHwwRBIwWXGigvq
pXb61LYaaO0DMPcJeWlBKUPICL2ZV3ClsZMZZoSCcWM+QmMRrEb6pbtxu7QIm88j
TXUuDIqdgL067mME0kdiNm2fmybry7iHTXq2WYLQPGDlJnzOk/KNhwhXTI8mnmR7
3moUECUIXOtgSpr5UhUOAb1dm8Y5lpdlD2dALUJWSyFuxE3sly0rpMVQA5kZNf2D
Yu7m3C8eE3KCmNM10+TiinwmCbSf+Fwpm7HNHposET0Uh5WcxielwzGO9dgjv4BW
QiCQ/9aeE3uLqVTFljWkZYPNTv5lADw3URSC2tZopQx4TkDGJmEerSSeNEL7wFM/
sLV0evuUNA6lPxbX5cea
=CCg/
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
