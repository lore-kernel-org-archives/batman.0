Date: Thu, 7 May 2009 12:08:17 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20090507100817.GA7137@pandem0nium>
References: <bad82a80905050708x1f0a75f0j27e78d72c81201bc@mail.gmail.com>
	<4A00856D.9080209@thewybles.com>
	<bad82a80905051153y14c528c7mc3461a1467824cc9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <bad82a80905051153y14c528c7mc3461a1467824cc9@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] batman-adv use in Manchester NH
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Arc,

On Tue, May 05, 2009 at 02:53:56PM -0400, Arc Riley wrote:
> > Excellent! Is there a website for your project?
>=20
>=20
> Not yet, in the next two weeks.
>=20
>=20
> Are you fully committed to Batman or still in the evaluation phases?
>=20
>=20
> There's room to be swayed, but batman-adv seems to be the best suited for
> our needs right now.  The primary concern is that the layer 2 branch isn't
> old enough to guarentee that it'll last - but it's free software so if it
> fizzles and is useful, someone will pick it up.
>=20
>=20
> OSPF perhaps? :)
>=20
>=20
> As I understand it, OSPF is designed for layer 3 networks.  There is no
> layer 3 routing going on within this network, to layer 3 protocols the
> entire mesh appears to be locally accessable.
>=20
> We really need something that directs users to use the gateway with the
> highest TQ.
>=20
> One method I just thought of; each gateway runs a DHCP server.  When a
> broadcast request is received, each gateway announces to the others their=
 TQ
> to the requesting node, and after a brief timeout, the gateway with the
> highest TQ responds to the requesting node.
>=20
> This raises a question however.  After reading the protocol document, I do
> not understand how the nodes on a network know which node to route frames
> which are destined for a MAC not belonging to a node, ie, a standard lapt=
op
> connected to the mesh.  The above scenario would require knowing which no=
de
> a non-node MAC is connected through.


Each node collects the local MAC-addresses by reading the source-MAC from=
=20
the Payload Ethernet Frames. These collected MAC addresses are then announc=
ed
over the mesh by attaching the list to the BATMAN packets (we call this HNA=
).=20

For example, a standard laptop would send frames to its AP A. A will have
a linux-bridge over the wifi interface and the mesh interface. The mesh int=
erface
reads the laptop MAC and knows that its local. This laptop MAC will then be
announced with the BATMAN packets. Another mesh node B will receive the=20
BATMAN packet and knows that frames for the laptop are to be passed to A.

Hope this explanation was clear enough, if not please ask. :)
>=20
>=20
> As a completely unrelated question, how does the batman-adv 0.1 kernel
> module currently handle multicast frame routing?

We have no special care for multicast currently, we just detect it and=20
broadcast it.

best regards,
	Simon

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoCsxEACgkQrzg/fFk7axZNUgCfd8AaWx3JeRLPXoHNtQvByHn6
h/UAoJbELuON0lN1IJg8duZxMDlD1/Qi
=vJ0w
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
