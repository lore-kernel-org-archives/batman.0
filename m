Date: Wed, 21 Mar 2007 14:56:16 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] b.a.t.m.a.n & OLPC
Message-ID: <20070321135616.GA13922@hrz.tu-chemnitz.de>
References: <26c774550703210540j66d663ccr2c5b56b6f13c3919@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <26c774550703210540j66d663ccr2c5b56b6f13c3919@mail.gmail.com>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Diego,

the Documentation so far can be found in the wiki:

https://www.open-mesh.net/batman/documentation

and our code subversion repository might help too:

svn co https://dev.open-mesh.net/svn/batman/

We have a new branch there called "batman-advanced" which is highly
experimental and tries to pull the batman protocol on layer2, which
makes ipv6, ipv4 or your own ip-discovering protocol possible. But it
might not work yet, be warned. :)
I'm going to write some Docs about this branch soon.

Some question about the chip/processor there:

1.  is it possible to compile code (gcc) for that?

2.  do we have an OS? b.a.t.m.a.n. only works on Linux so far, so you
    might need to (re)write libc/kernel-things yourself if you want to port.
	I'd recommend porting right now as b.a.t.m.a.n. (even the stable
	branch) is still in development, protocol things might change.
=09
3.  How much RAM do we have available? b.a.t.m.a.n. is storing
    quite a few things about its neighbours.

If you're familiar with irc you're also welcome to join our channel
(#batman on irc.freenode.org).

Regards
	Simon


On Wed, Mar 21, 2007 at 12:40:53PM +0000, Diego Paez wrote:
> Hi!
>=20
> i wonder if there are some chances to test b.a.t.m.a.n protocol over a
> olpc...I want to test it, but i know that we have some things to consider,
> like the ability for the protocol to run into the arm9e processor (the
> processor of the  marvell libertas, some specifications here
> http://arm.com/products/CPUs/ARM946E-S.html ).
>=20
> Im gonna need some code and/or some documentation...anything :D...
>=20
> However my english isn't that good...Sorry!
>=20
> Thanks!
>=20
> Diego
> Facultad de Informatica
> UNLP

> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGATmArzg/fFk7axYRAnpsAJ0XcT4pEx/lV0C5iba/4eMseU5VKwCgqmi0
UfbIteUQd1D/J6nIoyP8v7g=
=SFLR
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
