Date: Fri, 24 Oct 2008 00:47:57 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] Re: batman in atheros
Message-ID: <20081023224757.GA2098@pandem0nium>
References: <bccbc6690810230341j340091cbs50b15d7680d7cf5e@mail.gmail.com>
	<20081023120531.GE5979@tesla>
	<bccbc6690810231225r6411dc49p9b90126649d5cbcc@mail.gmail.com>
	<20081023123502.GH5979@tesla>
	<bccbc6690810231252u59e56c16u4f7e82b25ee13f49@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <bccbc6690810231252u59e56c16u4f7e82b25ee13f49@mail.gmail.com>
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
Cc: "Luis R. Rodriguez" <lrodriguez@atheros.com>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=utf8
Content-Disposition: attachment
Content-Transfer-Encoding: quoted-printable

Hello Max,

BATMAN is a routing daemon, a userspace program modifying the routing
table on each node to build up the mesh network. It sends UDP packets
to exchange information. This is very different from 802.11s, which is=20
building the mesh on the Link Layer. In 802.11s, routing information
is exchanged via WiFi management frames, and it is implemented in the=20
wifi driver.

Depending on your view, BATMAN is also a routing algorithm. It could
also be implemented directly on the Link Layer. We have implemented the
algorithm in batman-advanced on the Ethernet, to use Ethernet Frames=20
to exchange information and route (or better switch) Frames on our own.=20
You get a virtual interface, and can use the mesh network like a big switch.

Still, this has little to do with 802.11s. I guess its possible to
implement the BATMAN algorithm into the 802.11s framework as well.
If you want to do so, i recommend to go with Luis suggestion and
contribute some code to mac80211. You should know that this would require=
=20
serious efforts for you, it is not done with "providing Luis some=20
information".

However, it is not even needed to implement BATMAN in the wifi driver. It c=
an
run very well ON TOP of the otus wifi driver, as it runs on any other wifi
driver. The only requirement is that the driver supports AdHoc Mode, and=20
according to the announcement that is the case.

best regards,
	Simon

On Thu, Oct 23, 2008 at 09:52:06PM +0200, M. Peterson wrote:
> Hello Batmans,
> can you provide info to Luiz, to integrate Batman into the Atheros Linux
> Wlan driver as a a default package?
> Thx Max
>=20
> http://thread.gmane.org/gmane.linux.kernel/747372
> http://www.golem.de/0810/63121.html
>=20
> On Thu, Oct 23, 2008 at 2:35 PM, Luis R. Rodriguez
> <lrodriguez@atheros.com>wrote:
>=20
> > On Thu, Oct 23, 2008 at 12:25:28PM -0700, M. Peterson wrote:
> > > can you integrate batman ? so that atheros drivers provide it?
> >
> > I tried to read the FAQ and Documentaion and nothing explained what the
> > difference is between 11s. What is it?
> >
> > If batman !=3D 11s, then your best bet is to contribute code to mac80211
> > to enable batman as an option.
> >
> >  Luis
> >

> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFJAP8drzg/fFk7axYRAlNkAKCrFd3iZx1zJzSDjkneKnIWcNsFxgCgwWDg
WTyROyEcDorl13OK9LWZ5DE=
=wot5
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
