Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 22 May 2010 17:01:19 +0200
References: <201005221616.46785.sven.eckelmann@gmx.de>
	<1274537833-2512-10-git-send-email-sven.eckelmann@gmx.de>
	<20100522143244.GA4070@suse.de>
In-Reply-To: <20100522143244.GA4070@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1593576.ntl9budENK";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201005221701.20751.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 10/10] Documentation: ABI: Add
	information about batman-adv sysfs entries
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
To: Greg KH <gregkh@suse.de>
Cc: Marek Lindner <lindner_marek@yahoo.de>, b.a.t.m.a.n@lists.open-mesh.net

--nextPart1593576.ntl9budENK
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Greg KH wrote:
> On Sat, May 22, 2010 at 04:17:13PM +0200, Sven Eckelmann wrote:
> > From: Marek Lindner <lindner_marek@yahoo.de>
> >=20
> > Add documents about new sysfs entries in
> >=20
> >  * /sys/class/net/<iface>/batman-adv/mesh_iface
> >  * /sys/class/net/<mesh_iface>/mesh/vis_mode
> >=20
> > Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> > Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
> > ---
> >=20
> >  .../ABI/testing/sysfs-class-net-batman-adv         |   14 ++++++++++
> >  Documentation/ABI/testing/sysfs-class-net-mesh     |   27
> >  ++++++++++++++++++++
>=20
> For now, can you keep this within the drivers/staging/batman/ directory,
> just so everything is nice and self-contained?  When it moves to the
> main part of the kernel tree, then it can move into the
> Documentation/ABI/testing/ directory, ok?
>=20
> > +What:           /sys/class/net/<mesh_iface>/mesh/vis_mode
> > +Date:           May 2010
> > +Contact:        Marek Lindner <lindner_marek@yahoo.de>
> > +Description:
> > +                Each batman node only maintains information about its
> > +                own local neighborhood, therefore generating graphs
> > +                showing the topology of the entire mesh is not easily
> > +                feasible without having a central instance to collect
> > +                the local topologies from all nodes. This file allows
> > +                to activate the collecting (server) mode. Once
> > +                activated the topology can be retrieved by reading
> > +                the vis_data file.
>=20
> Isn't the vis_data file in debugfs now?  If so, shouldn't this file move
> there as well?  Or at least don't point to a file that doesn't exist in
> sysfs :)

No, vis_data is the output. vis_mode says if a node is a client or a server=
=2E A=20
server can generate that output... but as vis_mode and vis_data are two=20
different things, I think that not both must be moved to debugfs. For examp=
le=20
a client should be able to move into client mode or read his current status=
=20
without having debugfs compiled inside his kernel - the client will never g=
et=20
the output vis_data, so it isn't important for him to have debugfs. But I w=
ill=20
remove that sentence.

Best regards,
	Sven



--nextPart1593576.ntl9budENK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL9/HAAAoJEF2HCgfBJntGRFoQAI+wPZ5L5glkFD4I7VNKOeDG
eDvVXE8zFNThuxvEZEZsARlsDNsOCI4gIC6mDWoFPC0fJ8KSNu6yNC0QxwtzM6hf
/ExWVlQhlnGMpqxrBgdFJk+okYSHZOEuZCVEWxSFxrGdiM66BTCwz0Aye2797eNp
ZwHqLRacMT6gZQDU/2NFuz4GaJo5q8Z9OPfsAoG1tF1Ec/SxdiViyilPxLJVv1ko
me4kwlkZjXj/zS7pp0jWPqnvhRxN8f2EYVm/i3RzPVt+ANFklHZjhDUCNkNwzqSn
75RVmyzHNmnWXDZS8XvA9SaJcfZGqgvFYBaqK3Luoidxr8RMKW2sSrVYHlWCHq+1
xm6JmV9S6hffJWtNIq2B+iJr+vhfy5AldoPvOIwfgS6U9jF3Bzcyo3Pz8oXjkXEg
Yy9KBzg/YSfvuIa6QTU/I6ZPBNhWFCHvpra7i9pB7M9BB7NgR2z3iNmtqOOZLfTj
wstVDtg/nO6BcnCkkVnTD4GzJaIETpK/Um5scQMs20OttzI3SfcdGBGbTtRDm95L
YwRkdMx9gertmQoYdAhnHfzTIZqVG6QMFFLnIfxBlFb77Omi//ijlMJ2s0NO+l5/
XcUuXocpUpRf6NbquFuRnH6Aa3VKtFaJRi1KF5cWZr70NSDqhyTXJ7H84B3RVTE/
1lEWzamVjr/lBunUzstH
=hKEu
-----END PGP SIGNATURE-----

--nextPart1593576.ntl9budENK--
