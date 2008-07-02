Date: Wed, 2 Jul 2008 15:01:16 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20080702130116.GA28427@hrz.tu-chemnitz.de>
References: <4864DD02.20209@csp.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <4864DD02.20209@csp.it>
Subject: [B.A.T.M.A.N.] Re: BATMAN ADVANCED KERNEL LAND LOOP
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


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

Just as an update for other people interested in batman-advanced: Paolo
and me were hunting the bug(s) in private, and these issues should be
resolved with rev1090.=20

Thank you again for reporting and testing, Paolo!
	Simon

On Fri, Jun 27, 2008 at 02:28:50PM +0200, cipollone wrote:
> Hi,
>=20
> I'm testing BATMAN Advanced Kernel Land and I've found a problem.
> I'm using BATMAN-adv over OpenWRT.
>=20
> My test is:
>=20
> 3 virtual machine
> 2 Ethernet card for each virtual machine
> 3 Vlan
>=20
> So we have a loop and I hoped that BATMAN solve this but...
>=20
> What's happen is that each virtual machine can send message to itself=20
> using the 2 interface.
> It passes because  the BATMAN  message are re-broadcasted and at a=20
> certain point 1 of machine start to communicate only with itself,=20
> disappearing from the network.
>=20
> I need helppp!!!
>=20
> Paolo Cipollone
>=20

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIa3wcrzg/fFk7axYRAskcAJ9f1LVGtrHSZBWE8uDwh0Lo9YyPfACfZzK/
JwRekcyyEMG8YNPAshngeEU=
=ynv8
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
