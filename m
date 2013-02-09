Return-Path: <ordex@autistici.org>
Date: Sat, 9 Feb 2013 22:20:26 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130209212026.GA11324@ritirata.org>
References: <1359916914-9798-1-git-send-email-ordex@autistici.org>
 <1359918139-12130-1-git-send-email-ordex@autistici.org>
 <201302091906.31026.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <201302091906.31026.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [FIXv2] batman-adv: fix master setting in rtnl
 interface
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
To: Marek Lindner <lindner_marek@yahoo.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 09, 2013 at 07:06:30PM +0800, Marek Lindner wrote:
> On Monday, February 04, 2013 03:02:19 Antonio Quartulli wrote:
> > To be merged with ("batman-adv: Allow to modify slaves of soft-interfac=
es
> > through rntl_link")
> >=20
> > Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> > ---
> >=20
> > v2:
> > - ndo_del_slave() also have to unset the master/upper_dev device
>=20
> Did you actually test the stuff you are proposing ??
> batctl if del <iface> results in a kernel crash ...

Well, since I do run batman-adv against net-next, I could not test the comp=
at
stuff and I left this exercise to you :-) The problem seems to be there....=
I'll
try to dig and see if I can how to fix it.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRFr2aAAoJEADl0hg6qKeOPWkP/1MUstaCcI7I3QS7U7IUi3lq
0jyjTCjKIUnInEKD5utRgYtoRMca7ySXXLwuzZgvo/iXmFehehWefFGSgYaYJSFn
Xqmf5VHuSlaLwAqbZr4lO5UVrG/A4HdCmbIvO2y5HK84hDRuxzDl+dXK/ZmWNdCW
Fsyp685AhZZ389NOThvNWZs6whqG6B6opBAK168jjx7Honzzng+vTA0H7h9nthU2
pmSAewMllvK8mfmJgjF40WT9bmsSXoyNIu6QQDNSG2QEnt5HcplnNPbWZOIlZJ/T
PSCLRsYdKWViv2orHADpCxE7U0rpcehYT0ct+Nc/EuxFH+Gp5evgVdvdF47Bjsah
+jMiTv3DH4OQjWlQSogaCEQZVKQOMy4bnRzPAxoXybA6tv9TjaK3WbEP8XiHIKXc
tKdtMyUJbBjxFqNk4Mj6r1Wf4qMDOr4G++SKdAj8tUZ3/CdpPV/Bp0kCWjSBlbuS
SDDaHmICWjh65FOzpHoPhcvwATvwCVDkFj1XPf/2pJ56g0l2tjrfrVaC8/69XA9I
Wjag21ixITjDR6eh5DnHJbvblGln/4DDS27fBjyvFdigvgGFGJQTz2kSrj76K18W
DnZlsFwWJLjwggzVq0TSCNLSmuUTRDjyhcgkDBW5ZF7Gw/zghd1hJcB/zRYBFYwS
jDfjhMykDc6IPAJJ/9Hk
=8rvn
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
