Date: Sat, 2 Aug 2008 17:47:57 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] BATMAN Advanced Kernel: how much time to find a
	new route?
Message-ID: <20080802154757.GB32217@pandem0nium>
References: <E9DE65F5-50B7-494C-8C69-E0A028F2AF0B@gmail.com>
	<20080725111751.GA27127@hrz.tu-chemnitz.de>
	<48908444.3040805@csp.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline
In-Reply-To: <48908444.3040805@csp.it>
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
To: cipollone@csp.it, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

BATMAN IV in batman-advanced uses TQ_GLOBAL_WINDOW_SIZE of 10.=20
When a packet is received, the TQ value transmitted in the packet will
be weighted and stored. The sliding window of neighbours who did not=20
forward an OGM with this sequence number will have this entry set to zero.
The old neighbours' sliding window will be filled with zeros, while
the new neighbours' sliding window will gain more and more (weighted)=20
TQ values. Once the Average of the sliding window is higher than the
old one, the route will switch.

So it should change after maximum of 10 seconds. The new neighbour will
start off with bad tq values for the TQ: Neighbours have not answered a
lot of OGMs, so the asymetric penalty reduces the stored TQ value a lot.=20
This is probably the reason why it does not switch in 5 seconds, but
takes a bit longer.

If you want to read in the source code, look into isBidirectionalNeigh()
and update_orig(). This is the theory, i don't guarantee for bugs. ;)

regards,
	Simon



On Wed, Jul 30, 2008 at 05:09:56PM +0200, cipollone wrote:
> Hi,
>=20
> I'm studying how BATMAN Advanced-Kernel work.
> I'm interesting in knowing what is the behavior of BATMAN and the=20
> reaction time of the protocol if a node exit from a range node and=20
> entered in another range node. I have discovered that (in a simulation=20
> with 3 hosts with a mobile node and 2 static node) BATMAN find a new=20
> route losing more or less 8 seconds, passing from one to the other node.=
=20
> But the OGMs time is 1 s and the sliding window is 64, so why it can=20
> lost 64 seconds to find another route (or 32)?
>=20
> So there is a equation to define a the time lost to find a new route?
>=20
> I have an originator interval of 1 seconds (set by default).
>=20
> Thank you
>=20
> Paolo
>=20
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>=20

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIlIGtrzg/fFk7axYRAhLKAJ9bESztiSBIw52RDvfpdqiHNhKxBQCeLghc
XVhTnQuoSxOth01jBtyADCc=
=b16Q
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
