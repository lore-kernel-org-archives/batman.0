Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 30 Mar 2011 21:49:05 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20110330194905.GA30406@pandem0nium>
References: <E76519770B30484E96B403F9721C148B2FB0C1DD@afsexc102.aurora.aero>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <E76519770B30484E96B403F9721C148B2FB0C1DD@afsexc102.aurora.aero>
Subject: Re: [B.A.T.M.A.N.] UDP multicast
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
To: "Toupet, Olivier" <otoupet@aurora.aero>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Olivier,

yes, batman advanced (note, not the layer 3 BATMAN) supports multicast. It
behaves like a (rather lossy) Ethernet interface and transports multicast
traffic just like broadcast. For broadcast, we use a "classic flooding"
approach, which means that every message is rebroadcasted by every node
once when heard first. This "works" also for UDP multicast traffic,=20
but is not designed for high bandwidth multicast/broadcast data.

Linus and me are working on an optimization for multicast which is currently
in an experimental stage, which may also be better suited for your applicat=
ion.
However, I don't know whether LCM works on lossy networks and which bandwid=
th
requirements it has. Also note that the optimization is not "deployment rea=
dy"
yet. ;)

A few pointers to get started:
Quick Start Guide: http://www.open-mesh.org/wiki/batman-adv/Quick-start-gui=
de
First Announcement of Multicast Optimization (Specification attached):
https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2010-December/003858.html


best regards,
	Simon

On Thu, Mar 24, 2011 at 07:42:21PM +0000, Toupet, Olivier wrote:
> Hello,
>=20
> I am considering using the Lightweight Communications and Marshalling (LC=
M) library recently developed at MIT: http://code.google.com/p/lcm/ . Howev=
er, that library relies on UDP multicast and I need it to work for mesh net=
works. I have only used simple UDP in the past with B.A.T.M.A.N. and I was =
wondering if my applications would still work with B.A.T.M.A.N. if I went w=
ith UDP multicast. Doing a little bit of research on the web seems to indic=
ate that the UDP packets would be treated like broadcast packets and would =
then be flooded in the network, which doesn't seem efficient bandwidth-wise=
=2E Is that really the case? Would B.A.T.M.A.N. work with LCM (i.e. UDP mul=
ticast)? Is there documentation that explains how to set up B.A.T.M.A.N. fo=
r UDP multicast?
>=20
> Thanks in advance for your reply.
>=20
> Best regards,
>=20
> Olivier

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2TiTEACgkQrzg/fFk7axaDKACg8VLnHmaF3VuNGahc4joDUd3J
39YAniharStpNXCxym+c8Xp7PzcEzi1C
=uEbz
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
