Date: Sat, 15 Sep 2007 14:34:27 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] WRT54G Wireless Mode setup questions.
Message-ID: <20070915123426.GA10893@hrz.tu-chemnitz.de>
References: <20070914172207.lemavxar4o8kkog8@172.20.2.230>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <20070914172207.lemavxar4o8kkog8@172.20.2.230>
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


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Karl,

On Fri, Sep 14, 2007 at 05:22:07PM -0400, karl@skytecmail.com wrote:
> Hello everyone!,
>=20
> I have a couple of question, and excuse me if they has been previously =
=20
> answered, but I can't find any straight answer.
Sure, no problem ;)

> If I run "batmand" on a WRT54G, either running OpenWRT, Tomato, DD-WRT =
=20
> or similar firmware, what is the correct mode to set up the router?
> That is, do I leave it in AP mode, Repeater mode (as in the case of =20
> DD-WRT) or what mode?
You need Ad-Hoc Mode, so anyone can talk to anyone.=20

>=20
> I still don't have clear how the routers talk/find each other.
> And then, how do you set up DHCP server on them? On one gateway?, =20
> meaning that it will supply addresses to all clients, or on each =20
> gateway? I assume there has to be a single DHCP server on the mesh =20
> (obviously!), but where?
For batman, you need to give everyone static IPs. The Problem of an
DHCP-server is that it only reaches clients within it's range and is not
very reliable in a mesh network. (There are solutions to this, but the
easiest way is to stick with static IPs for now)

> Please point me to some references as to how to set up on an existing=20
> WRT54G.

Have a look at openwrt or the freifunk firmware
(http://freifunk.net/wiki/FreifunkFirmwareEnglish).

> I have already installed "batmand" on a WRT54G (v6) running DD-WRT =20
> (micro) and it runs!, but my setup will be on one master router =20
> WRT54GS V1, currently running Tomato VPN build that has tun driver) =20
> that will be my Internet gateway, and two WRT's running DD-WRT micro =20
> as satellites for the mesh.
> I'm confused, so I need a little guidance here :)
> Also, if I can use anything else other than DD-WRT firmware on the =20
> WRT54G V6's I have, please let me know.
> What I have available on hand is (1) WRT54G V1 and (2) WRT54G V6, so =20
> that's what I have to work with.

I'm not really familar with the OpenWRT models, but I guess every Model
which runs batman somehow is fine. ;) By the way, if a router announces
that its a gateway you should use the -g flag, and the satellites should
use -r to find/use the gateway.

Regards,
	Simon

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG69FSrzg/fFk7axYRAhrjAJ9NY0f6Vl5PfdbHZQSZcGrApUC/2ACgr98S
ujbBYcmxdhKeYueqmEg4LPU=
=sRsf
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
