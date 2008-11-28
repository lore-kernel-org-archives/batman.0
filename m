Date: Fri, 28 Nov 2008 21:51:45 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] 0.3.1 rv1152 - some test results
Message-ID: <20081128205145.GB25072@pandem0nium>
References: <492DDC20.7090900@web.de>
	<200811280043.26990.lindner_marek@yahoo.de>
	<49302F8E.2040502@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline
In-Reply-To: <49302F8E.2040502@web.de>
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


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,=20

On Fri, Nov 28, 2008 at 07:51:10PM +0200, Chris W. wrote:
> It is, alltogether it's about 50 nodes. This vis is geopraphically more
> accurate: http://preveli.gr/mesh/bat-228-3.gif
>=20
> Now rv1161 is on, the reduced test area is
> http://preveli.gr/mesh/bat-228-3b.gif
>=20


> Yes, looks similar to Derek's.
> Not to mess with endian issues, I tested on broadcom only with no
> atheros connected. The tunnel builds up but isn't stable.
>=20
> Gateway client - gateway (10.4.2.2) says: IP (169.254.0.1) is invalid
> (maybe expired)
> Deleting default route via gate0 (table 68)
> Adding default route to 10.4.2.71 (gw_flags: 40, tq: 188, gw_product:
> 2747168)
> Gateway client - got IP (169.254.0.1) from gateway: 10.4.2.71
> Adding default route via gate0 (table 68)

The "invalid" messages probably is caused by the bad IPs (see below).=20
The gateway sends an "IP invalid"-message back if a not advertised IP=20
was used. The client then disconnects from the gateway.

We should probably change this policy. ;)


>=20
> The node itself can connect through the tunnel. Everything else which
> doesn't come from the nodes IP can't pass, the gateway logs:
>=20
> Nov 28 16:51:59 (none) kern.err batmand[18644]: Error - got packet from
> unknown client: 10.4.2.50 (virtual ip 10.2.50.99)
>=20
> Same error with olsr traffic which has dropped into the tunnel.

Only the advertised IPs are allowed. However you can build a NAT for
your gateway, this would ensure that only the advertised IP is used.
Something like=20

  iptables -t nat -A POSTROUTING -o gate0 -j MASQUERADE

should do the job. (maybe add something like "--source 192.168.100.0/24"
to further constrain the traffic).


> Thank you for the explanation. Is this module available for OpenWrt 0.9
> broadcom somewhere ?

I don't know of precompiled packages, maybe someone else does? :)

>=20
> Another point is that
> even if a gateway's internet connection is down, but announced, it is
> chosen as tunnel endpoint. Something similar to the olsrd-dyn-gw would
> be great.

Actually we have a mechanism to check for black hole gateways (on the
client).

>=20
> >
> >>-2- together with olsrd.
> >> From a gateway node running olsrd in parallel the route to an announced
> >>network drops out towards the internet, the node itself is reachable:
> >
> >Sorry, I don't understand this. Can you explain a bit more ?
> >
> The described effects may be due to routing problems and things like
> that on batman, olsr's routing is last so it takes all the rest. I'd
> better not describe this in detail as it may occur due to the following
> point.
> >
> >>-3- previously announced networks are not deleted (8.106), the routing
> >>table collects multiple entries for the same destination
> >
> >Thanks for the hint. Fixed in revision 1159.
> >
> Yes, no multiple entries anymore in 1161.
>=20
> The announced network of 2.72 gets lost after some minutes on all nodes.
> Logs show
> Nov 28 17:13:43 (none) kern.err batmand[18641]: Error - can't add route
> to 10.2.72.0/24 via 10.4.2.95 (table 65): File exists
> Nov 28 17:13:43 (none) kern.err batmand[18641]: Error - can't add route
> to 10.2.72.1/32 via 10.4.2.95 (table 65): File exists
> root@10.4.2.72:~# ip ro sh ta 65
> 10.2.50.0/24 via 10.4.2.50 dev eth1  proto static  src 10.4.2.72
>=20

Mhm, this is probably a regression in the new hna_buff_delete() function
=2E.. but i'm not sure. The "File exists" Error should not be visible in
any case.

Could you please (if possible) create a complete dump until the "File
exists" problems happen with debug level 4, and send this log to me and=20
Marek? We can have a more detailed view what's happening then.=20

(call batman with -cd4 for example)

best regards,
	Simon


--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFJMFnhrzg/fFk7axYRAp0aAJ9WMR34eyy0QO+Y+oqir0QI+SSrYwCggSJ6
fCiumsZXtpT4mJ4XWqoyEiE=
=phHS
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
