Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri, 12 Aug 2011 15:15:15 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20110812131515.GA24909@pandem0nium>
References: <201108030952.35467.lindner_marek@yahoo.de>
	<20110803083056.GE9901@lunn.ch>
	<201108031639.53966.lindner_marek@yahoo.de>
	<20110803165018.GF9901@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <20110803165018.GF9901@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] routing code re-organization / the road ahead
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, Aug 03, 2011 at 06:50:18PM +0200, Andrew Lunn wrote:
> On Wed, Aug 03, 2011 at 04:39:53PM +0200, Marek Lindner wrote:
> > Where is the interoperability coming from ? The protocols won't be comp=
atible.
>=20
> Interoperability has many meanings. I've seen it mean the protocol
> does not actively destroy the operation of another protocol. I've seen
> this in powerline networks. Company X proprietary powerline protocol
> is interoperable with HomePlug in that it will not destroy the
> HomePlug network if run in parallel with it. It won't talk to it
> either...
>=20
> By making it a runtime option, i don't need to recompile my kernel to
> swap from one to the other. I just need "batctl algo V" or "batctl
> algo IV". My kernel is interoperable, i just need to configure the
> mesh correctly for it to work.
>=20
> What might also be interesting is
> batctl algo IV bat0
> batctl algo V bat1
> brctl addif br0 bat0
> brctl addif br0 bat1
>=20
> It won't give optimal routes, but it at least gets the two meshs
> talking to each other.
>=20
mhm, I'm not sure if we need to let two different meshes talking (right now=
),
but a nice compromise might be to enable selecting the algorithm at module
load time as parameter - I would find it inconvenient to re-compile the mod=
ule=20
all the time. :)

This is hopefully not too hard, we could go with a struct of function point=
ers
as many other subsystems do. This could also be enhanced later to enable=20
"real" runtime selection, but there might be some challenges there, e.g.=20
changing the sysfs (for algorithm-dependent parameters) and other dependenc=
ies.

What do you think?

best regards,
	Simon

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk5FJ2MACgkQrzg/fFk7axaIHACeLUcnRBvWum0jDK1dj2sGP050
axUAoMozu8UoWS2pI7K4R2oejQFX94Fy
=VGm8
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
