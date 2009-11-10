Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 10 Nov 2009 23:16:58 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20091110221658.GA10514@pandem0nium>
References: <20091109190206.GA2642@Linus-Debian>
	<200911101834.41970.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <200911101834.41970.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] BATMAN-Adv and MTU handling
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


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Tue, Nov 10, 2009 at 06:34:41PM +0800, Marek Lindner wrote:
> > The motivation of using a higher MTU of 1524 at the beginning was
> > the rumour, that there might be some client devices (which we
> > would get into the network by bridging bat0 wifi wlan0 for
> > instance) not able to handle any MTU smaller than 1500. But in
> > fact it turned out, that in our days basically all devices are
> > able to do both IPv4 and IPv6 PMTU discovery on layer 3. So tests
> > showed, that if all BATMAN nodes are using an MTU of 1476 on bat0
> > (or the overlaying bridge) everything seems to work fine.
>=20
> Sorry, I can't follow you here. If the whole network is a switch environm=
ent=20
> how could the clients perform a working PMTU ? Sure, all clients are able=
 to=20
> do PMTU (I don't think somebody doubted that) but it won't work.  :)
> Client sends 1500 bytes -> router receives the frame (no IP!) and drops t=
he=20
> packet. Where should the "fragmentation needed" packet come from ? That o=
nly=20
> works if you route packets instead of switching them.
>=20

Maybe most clients support that, but consider the way back. E.g. in TU-Chem=
nitz
and many other corporate or university network firewalls, ICMP messages=20
including PMTU packets are blocked. This means Wifi client A may send corre=
ctly=20
the smaller packets to server B, but B might send a big packet back as
the PMTU messages are blocked at the firwall and then get dropped in the=20
mesh network.

This might be considered as problem of the servers network firewall, but=20
unfortunately things like these exist. There are also misconfigured desktop=
=20
firewalls which block ICMP packets. Its more a question of configuration th=
an
support.

regards,
	Simon

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkr55loACgkQrzg/fFk7axZWWQCgiy3XfFBN+8yVz65RAet5ENA6
JWkAn2trX87I5XHUtycF23HGdfc/ioF7
=sq1w
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
