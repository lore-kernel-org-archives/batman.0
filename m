Return-Path: <mpa@pengutronix.de>
Date: Tue, 2 Dec 2014 16:30:40 +0100
From: Markus Pargmann <mpa@pengutronix.de>
Message-ID: <20141202153040.GF24653@pengutronix.de>
References: <3895904.RefSiyY2EJ@sven-edge>
 <20141202135703.GC24653@pengutronix.de>
 <1869231.xPTQmY7LN2@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3Pql8miugIZX0722"
Content-Disposition: inline
In-Reply-To: <1869231.xPTQmY7LN2@sven-edge>
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


--3Pql8miugIZX0722
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2014 at 03:09:52PM +0100, Sven Eckelmann wrote:
> On Tuesday 02 December 2014 14:57:03 Markus Pargmann wrote:
> > On Tue, Dec 02, 2014 at 02:03:16PM +0100, Sven Eckelmann wrote:
> > > Hi,
> > >=20
> > > please explain how this file can now be used unmodified in userspace
> > > (batctl) and kernel. If it cannot be done without modifying the file =
then
> > > please provide patches to modify the daily checks which make sure that
> > > the files in both repos are the same. I think the batman-adv develope=
rs
> > > can give you the original scripts.
> >=20
> > I wasn't aware that this file is also used in batctl. Why is it needed
> > there?
> > Probably I should have a look into the batctl sources.
>=20
> It is used for things like the tcpdump, ping and traceroute. In the past =
(svn=20
> times) it was just a links from batctl to batman-adv. But after the switc=
h to=20
> git it was decided that both should be kept in sync manually but checked=
=20
> automatically.
>=20
> I would like to give you the mini-check script but I don't have it. And I=
=20
> don't have access to the servers anymore. But it is basically checkout of=
=20
> master, maint and next of batctl+batman-adv and some calls to cmp (or dif=
f?)=20
> to check if both files are the same. A mail is sent [1] to a mailing list=
=2E=20
> Someone has to merge the missing changes manually.

Thanks for the clarification. I will have a look at compile issues for
batctl. Until now I only worked with the batman tree imported into my
linux tree so all my kernel tools are still working.

Best regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--3Pql8miugIZX0722
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJUfdsgAAoJEEpcgKtcEGQQ21YQAIAWmlqn4qUrC2c1FPX/qNyT
MFHqgx52TpXTbDown3T6DTdD1548MZE9Vny1PTNNeZHVQ3pg/p3ok9TFfLvgmJ8N
n/70UjR8+hKD0/OcbI6P/dNk2qiG8YJw46icQ7spJRD1tYeZLqLwThIg39nkHi4h
J/8JS2MfqOwSZ59Ek9XTJJ1jDETYOB0TfdJD2JQOhRdOJb8aRpVTXTgbmrNMfKth
NaxxVDU/mR1cj/OPkkNjVy8+XlqXgLtjjvjntrP2evbfXAtP9RV6n8VDpVTUPwoN
cjKtePgcqHPSNBNaBpMe1mB/KWKz985GLbqWtUogb4J6yFiHjY2lwiW8yEhAKTcd
xJzWz6iAN0h2cVFqHoLzT0X2SMdv3zs0iYS+ETQpYMOt/gSFoEAn9p/B5VKYGkDS
9snaQowbbQwR4wcHsSBF4WY7IwC7mli8lqRmTaS6XFxOfXq5vnrtDOlyrCQIceFH
sTVVt4WYYeYlOQILe8rBflqZXGKVXGCD1+IZPV28sSm986T21PGhYOUB0fVrG/4I
3PR+SJfN/TEySAoh4+QgFsAF2o+4EeYSY199kvJmOJ7b78ty4uWuRoe/Jp754fNe
fOUlHs7pMhkJ97y6XzzlgJddyDs7UjRNgiH2VAbnsfXWL0I6uMwnHa+GL2JLoQTT
J25EvuTVrvzGyFlNFn3p
=rTfO
-----END PGP SIGNATURE-----

--3Pql8miugIZX0722--
