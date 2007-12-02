Date: Sat, 1 Dec 2007 22:32:16 -0600
From: Jan Hetges <tran@ms20.net>
Subject: Re: [B.A.T.M.A.N.] two-way-tunnel quirks
Message-ID: <20071202043216.GB3923@apoderado.ometepe.net>
References: <20071130232852.GC3934@apoderado.ometepe.net>
	<200712011834.54327.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline
In-Reply-To: <200712011834.54327.lindner_marek@yahoo.de>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 01, 2007 at 06:34:54PM +0100, Marek Lindner wrote:
>=20
> > now i found an issue which i didn't relate with batman
> > first. I got several reports of users, hotmail/msn/live.com
> > not being accessible anymore...
> > Yesterday i found out theres also problems with some pop server
> > not beeing accessible, but everything works fine directly at the
> > upstream gw, without any batmand involved.
>=20
> Unfortunately, it is too few information to do anything about it. Could y=
ou=20
> describe your experiences in more detail. Here some questions on the way:
>=20
> - When did you notice the problem for the first time ?
user reports for about 3 weeks
> - Which revision was used ?
probably rv777, i'm running batmand-exp only since then
> - What exactely is your problem ?
web-browsers say something like "hotmail/msn/live.com dropped the
connection"
> - Can you describe it in way that i can reproduce it ?

  A---B---C

A: your computer

B: bmxd_rv804  client node      }
                                 }running 2-way-tunnel
C: bmxd_rv804    gw node        }

and now try to browse www.hotmail.com, but i'm not sure if
you can reproduce it, because the high latency (>640ms) of
our sat-uplink might be also involved=20

cheers

  --Jan

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHUjVQlTtvZdk47D4RAiiOAJ9HWtddx2ygsyTks9D41OoY1YQSkQCgg9Qj
MtBsSlAIyw6S/HBPsRk/cSI=
=63P8
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
