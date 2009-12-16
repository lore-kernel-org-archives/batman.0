Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Thu, 17 Dec 2009 00:25:02 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20091216232502.GA27802@pandem0nium>
References: <94CAE17FD1DB4640BF8FF28D61FDFA8A22BEF4@RESQNAOEX01.qnao.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <94CAE17FD1DB4640BF8FF28D61FDFA8A22BEF4@RESQNAOEX01.qnao.net>
Subject: Re: [B.A.T.M.A.N.] required network to run
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Eric,

the basic idea of meshing in general is: the destination nodes are=20
probably not in the coverage area of your radio, but you still want=20
to talk to these nodes. For example, imagine a city network where all=20
nodes are connected to each other: You wifi cards signal is only strong=20
enough for the next "neighbor", so you pass the traffic to the next=20
neighbor, which will foward it again until it has reached your destination.

This means you don't "see" all nodes in a network, and you need a=20
mesh routing program like batman to discover other nodes and find=20
correct routes to them via other nodes.

If you have all nodes in one little room, you don't need a routing daemon,
of course. :)

best regards,
	Simon

On Wed, Dec 16, 2009 at 04:30:51PM -0500, Conner, Eric wrote:
> I am new to ad-hoc mobile networking, and have a few questions.  I am
> just a little confused as to where batman fits in. Why do I need an
> active network to attach the batmand to?  If I'm in a network can't I
> see all the other nodes already?  What is batman buying for me if I have
> to create my own ad-hoc network?  If I don't have to create my own
> ad-hoc network, how do I set up my linux boxes so that they have an
> active network that will discover the nodes and allow the batmand to
> run?
>=20
> =20
>=20
> Thanks for your help
> Eric
>=20
> =20
>=20
> =20
>=20

> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n


--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkspbE4ACgkQrzg/fFk7axaf+wCfVTPYe29/5A/XcyAjwFLyfz3M
Xq8AoIzp/XSgsZw9mj6ZzXZ38QUjrEQI
=22oU
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
