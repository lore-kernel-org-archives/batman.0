Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 19 Feb 2013 22:43:40 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130219214340.GA29174@pandem0nium>
References: <1361112184-9927-1-git-send-email-ordex@autistici.org>
 <20130218234904.GA24241@pandem0nium>
 <201302190908.44891.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <201302190908.44891.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: add compat support for the
 new netlink ops
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2013 at 09:08:44AM +0800, Marek Lindner wrote:
>=20
> Hi Simon,
>=20
> > I've tested this (just test, no code review) in my 2.6.32 qemu (Debian
> > squeeze, iproute from wheezy). It generally loads and batctl if add/del
> > seems to work, but there is something weird going on with bridge
> > interaction. After calling the following 3 commands:
> >=20
> > brctl addbr br0
> > batctl if add eth0
> > ip link set dev eth0 master br0
> >=20
> > I would expect that eth0 moved from bat0 to br0 (or some error is
> > reported).=20
>=20
> I feel some confusion here. It could very well be that 2.6.32 did not yet=
=20
> support this kind of "interface transfer". You could repeat your test wit=
hout=20
> any of the later patches (just go back to the last stable release) to see=
 what=20
> happens. It is very likely that our patches have nothing to do with that.

you are right - I've checked 2013.0.0, same behaviour - and now that you me=
ntion
it, this is all completely independent from batman-adv/netlink. Sorry for r=
eporting
stuff like that ... :)

Also it seems that batctl (2010.0.0, from debian stable) reports all device=
s, even
if they are not added to batman-adv. It reports them as "not in use". This =
confused
me, haven't seen that on other systems (unused devices are just skipped ...=
). After
upding to the wheezy version of batctl (2012.1.0), this effect was gone.

Anyway, I've tested a little more and still I see some issues:

>=20
> These are the tests we should do in order to confirm the compat patch in=
=20
> question:
>=20
> * batctl if add $iface && some OGMS here && batctl if del $iface

This works fine, I see OGMs, and the interface is removed cleanly.

> * ip link add dev bat0 type batadv

This works fine.

> ip link set dev $iface master bat0

This doesn't work. eth0 is not added to batman. To further test, I've added
it via batctl.

> some OGMS here=20

yes (bat0 created with ip, eth0 added using batctl)

>ip link set dev $iface nomaster

has no effect

> ip link del dev bat0

works.
>=20
> Even more interesting are combinations of those:
> * batctl if add $iface && some OGMS here && ip link set dev $iface nomast=
er &&=20
> ip link del dev bat0
> * ip link add dev bat0 type batadv && ip link set dev $iface master bat0 =
&&=20
> some OGMS here && batctl if del $iface

Some of these combinations are tested above, but I'd suggest we should fix =
the
general case first. :)

Cheers,
	Simon

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlEj8gwACgkQrzg/fFk7axa0GgCdE5y1kOnMspoPHpP2wcWuu5Lh
U9MAoOFpYEBI0Cwd2pogVZ67lKuCrILv
=8ROT
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
