Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 11 Oct 2010 09:54:09 +0200
References: <1286712994-30845-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1286712994-30845-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart32997507.oQchfy92BI";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201010110954.10005.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: decrease refcount of
	hard-interface when it gets removed
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>

--nextPart32997507.oQchfy92BI
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Marek Lindner wrote:
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> ---
>  batman-adv/hard-interface.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
> index ec16dc9..afc2c3d 100644
> --- a/batman-adv/hard-interface.c
> +++ b/batman-adv/hard-interface.c
> @@ -44,6 +44,7 @@ static void hardif_free_rcu(struct rcu_head *rcu)
>=20
>  	batman_if =3D container_of(rcu, struct batman_if, rcu);
>  	sysfs_del_hardif(&batman_if->hardif_obj);
> +	dev_put(batman_if->net_dev);
>  	kref_put(&batman_if->refcount, hardif_free_ref);
>  }

Uh....

Acked-by: Sven Eckelmann <sven.eckelmann@gmx.de>

--nextPart32997507.oQchfy92BI
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMssKhAAoJEF2HCgfBJntGf2QQANEM1bACjlxEOLmjtXOX0pYv
2z4G1xPHPWJSGKsoW5MczRopxjHqpsr0CE2oR14dQIH9I2+l7FAFMAB42N0eE9Zg
/uk0L0rub++feUUc5brA17OdRKhIv8LZEOa6MAYStGJ587QIECHncBWy7Gvt2yD/
UjaMNCaz6L0o7cbXz8m1voy5GlllsAPb8w+muPGQtPUyuw0fseM+xTa8r0qxL06s
Kuyh3moS9w6arqKZVndcIK2GhXuGd2LfiJLLgz9Zf2nRnH0q2FfZB/q4D7qs7v0m
aqhDrix5+WfiNdlr2f740L8Qf3u7yxxgrAGkPMavuYRZcyejabpOM0u8UYPJe1Mr
cLpFsX3XBo5hjOG0vqNEWT9PJUNg+OA2e1vVBcXZP4Q8JwYDmI25NIKxWRnM2SjR
g4yUSrayG6UHg9GDykmRlEkyF0DYoONbqGs5kkGkLwwh3WhNrAfs7R/Z9CMa4K/c
xUgfVy50xyeDicojN4LUL/Q+TLkJg+4Jx/1gRRTivRB3OE1kjFM4d0K6CM76BIqp
NHtbAK5MiyIPCB/hsAS9CWjr+BDp8JRiOgmifmKu1tmIkozNouAB/jdwK8BW7Lvu
YIZEIjnILqAU7UAKR998FFvqPe+MJa89AmyguPWBl4ODdK154kIYYdwZzCc5pzS4
VaT5E2kcjqezooa72Np3
=AAZ+
-----END PGP SIGNATURE-----

--nextPart32997507.oQchfy92BI--
