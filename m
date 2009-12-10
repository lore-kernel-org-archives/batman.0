Return-Path: <bittorf@bluebottle.com>
Date: Thu, 10 Dec 2009 09:58:46 +0100
From: Bastian Bittorf <bittorf@bluebottle.com>
Message-ID: <20091210085845.GT22743@alix.l28.local>
References: <391345.99048.qm@web111612.mail.gq1.yahoo.com>
	<20091209063411.GJ29768@lunn.ch>
	<618743.16485.qm@web111609.mail.gq1.yahoo.com>
	<200912092142.07700.onelektra@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2DJuma0xDHN2clgl"
Content-Disposition: inline
In-Reply-To: <200912092142.07700.onelektra@gmx.net>
Subject: Re: [B.A.T.M.A.N.] general theory question RE: dhcp on a peer
	only	mesh
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


--2DJuma0xDHN2clgl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* elektra <onelektra@gmx.net> [09.12.2009 21:40]:
> >=20
> > Out of curiousity, what does the freifunk network use for assigning IPs=
 ?
>=20
> At Freifunk Berlin users register with a user name and a valid e-mail add=
ress.=20
> Then you can register IPs in the data base.

At Freifunk Weimar each new flashed router assigns a
random IP-Adress out of a reserved IP-Range for 100 Nodes.

Each 15mins the node tries to register an offical IP
with his SSH-PUBKEY on a central server and reassigns
the new IP. (which includes IP's for WAN/LAN/WIFI/HNA4/lan+wifi-DHCP)

So we have a strict mapping SSHPUBKEY <--> IP. We need
zero user-interaction for settings up a new node. The
SSH-PUB-KEY normally never changes in the live of a node.

bye, Bastian

PS: we have about 600 registered routers/nodes (but not all are active)

--2DJuma0xDHN2clgl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksguEUACgkQDonSpHhHLlzt9gCfe3GYTi5TNOuACQp8U9IsrDkb
XlMAnj6wg48ycQnmmVRz3u7lI3Rw2Eup
=2Mmn
-----END PGP SIGNATURE-----

--2DJuma0xDHN2clgl--
