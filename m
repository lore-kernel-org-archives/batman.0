Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 30 Jul 2012 12:31:17 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20120730103117.GA28562@pandem0nium>
References: <CAHD-aqKaF4tfsMBQLnyrn4wkqDHQpPjsfCDjhXPzrCbkzM7tsg@mail.gmail.com>
 <20120708100956.GA10210@pandem0nium>
 <CAHD-aq+wSvBc56KGJ6RFDMgnP_sir5TXx83EYPw_WWh8=Geqag@mail.gmail.com>
 <20120725203425.GB11999@pandem0nium>
 <CAHD-aqK68-74CHsL4FUhAXdxJcbJjvdJcGEh6z9XQt5zXvvFGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <CAHD-aqK68-74CHsL4FUhAXdxJcbJjvdJcGEh6z9XQt5zXvvFGw@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] 2012.2 OGMs over ethernet issue?
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


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Guido,

On Sat, Jul 28, 2012 at 03:34:29PM -0300, Gui Iribarren wrote:
> On Wed, Jul 25, 2012 at 5:34 PM, Simon Wunderlich
> >
> > OK, so you say that it doesn't work when you simply add eth0 batctl, bu=
t it works
> > with the bridge?
> Exactly.
> With a caveat: turns out adding plain eth0 (no vlans involved) works
> fine as expected, the problem arises when using vlans.
>=20
> > What is the minimal setup which is not working, two routers
> > and one cable?
> I just reproduced it minimally: two routers, one cable, no adhoc, no
> bla2, no gw_mode, identical setup in both routers.
> enabling bla2 makes no difference.
>=20
> http://pastebin.com/y1JwMaDM
>=20
> A=3Df8:d1:11:54:50:f9
> B=3Df8:d1:11:3b:78:df
>=20
> "A" batctl td shows incoming OGMs from neighbour "B",
> but batctl ll doesn't react.
>=20
> viceversa for "B".
>=20
> ping6 works fine over eth0.2 between A and B
>=20
> adding a simple "option type 'bridge'" on both routers solves the OGM
> issue, like so:
>=20
> config interface 'eth0_2'
> 	option type 'bridge'
> 	option ifname 'eth0.2'
> 	option proto 'none'
> 	option mtu '1528'
>=20
> with this, eth0.2 is included in br-eth0_2, and bat0 manages
> br-eth0_2... OGMs do come through correctly, and "batctl o" shows
> neighbour on both sides.
>=20
> all in all, workaround is not complicated (in fact a one-liner) but i
> find it curious that without the bridge thingy, batctl td catches the
> OGMs, yet batman doesn't recognize them.
> I haven't tinkered with vlans before, so i might be misunderstanding
> how they should work.
>=20

Thanks for working that out. I've just tried out VLANs on Ethernet with
BATMAN myself, and it worked well here - so I can't reproduce it by simply
using VLANs.

Another cause of the fault may be the VLAN stuff in OpenWRT, as this is not
a "real" VLAN but just a way to address the ports on your box. I have not
much experience with that, but I've heard funny things about it. ;) Have you
tried changing the VLAN config? E.g. changing ports '0t 2t' for eth0.2 to
'0t 2' (to remove tagging)?=20

Do you have the same problem on other types of devices? (Maybe the internal
switch is acting weird)

Maybe some else has more experience on Switch/VLAN-config than me and can
have a look at that config. :) http://pastebin.com/y1JwMaDM

As I said, Ethernet/VLANs work fine for me, and I know other people running
batman over Ethernet-VLANs as well ...

Cheers
	Simon

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlAWYnUACgkQrzg/fFk7axZkeQCdGYC0ZHoeht0kktiXKe5IRmfr
glwAoKSl9nuXAiMffQeOXF4yqa0UMSj4
=y/gM
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
