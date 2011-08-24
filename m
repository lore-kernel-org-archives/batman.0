Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Thu, 25 Aug 2011 00:23:19 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20110824222319.GA28951@pandem0nium>
References: <CAPjQAd9-g6ugSci1Y_5t1BOqZ-Pa2k=hGhyauV-09d1unq=ecA@mail.gmail.com>
	<30568448.oAQcoQ5y1R@sven-laptop.home.narfation.org>
	<CAPjQAd_kJT72R28f+0+xjLBp7gT-64U8xKKnVKQg2wbNvYiRkA@mail.gmail.com>
	<20110824071841.GA7895@lunn.ch>
	<CAPjQAd9nSQhRtfbfDsN-raqK2mo5NhuDWPxmt_FCvAS8ZYkf9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <CAPjQAd9nSQhRtfbfDsN-raqK2mo5NhuDWPxmt_FCvAS8ZYkf9w@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] A case for batman-11s
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Javier,

On Wed, Aug 24, 2011 at 11:30:01AM -0700, Javier Cardona wrote:
> > I actually think IEEE 802.11s needs to first evolve and become part of
> > IEEE802.1. The problem is, mesh !=3D wireless, so having it part of
> > 802.11 limits its application way too much.
>=20
> 802.11s is designed to fit within the IEEE 802 family of protocols (it
> was approved by the IEEE 802 Executive Committee in July).  You are
> correct in that 11s does restrict the mesh to be a wireless mesh.  But
> it is designed to connect to external networks via 802.1D bridges.
> 802.1D bridges have been around for ages and are good at
> interconnecting diverse MAC types without routing loops.  I read here
> (http://www.open-mesh.org/wiki/batman-adv/Bridge-loop-avoidance) that
> batman implements its own loop-avoidance protocol which, from my
> limited perspective, seems redundant.
>=20

The bridge loop avoidance is a little bit different from (R)STP. It also
avoids loops, but at the same time tries to offer the wireless clients
coming from the mesh the best way into the wired backhaul (i.e. select
the best router for this task). At this point, (R)STP could be also used,
but it usually just randomly kill of links, not neccesarily based on=20
transmit quality. :)

> > I've been to a few of the wireless battlemesh events and gained some
> > experience with real mesh network. One thing which is very clear to me
> > is, they are multi-technology. They mix 802.11, 802.3, cable modems,
> > VPN, and in theory, there is no reason why avian carriers could not be
> > used.
> >
> > If you look at the mesh routing protocols represented in battlemesh,
> > static routes, babel, olsr, BMX, and batman{-adv} all are multi
> > technology and have no problem building one mesh over a heterogeneous
> > network.
>=20
> I can appreciate the benefits of supporting a diversity of link
> technologies.  I'd have to understand better how a single metric
> definition can be used to quantify the quality of all link types, from
> 802.11 to homing pigeon.  But I guess it's being done successfully.
>=20
batman-adv usually sees non-wireless links as "perfect" links, as there
is no packet loss. There is no "special" support (it may be interesting
to further qualify bandwidth or latency), but it just blends in
transparently. That's the beauty. ;)

> > (...)
> >
> > You also said 802.11s contains device authentication, encryption,
> > etc. This also seems to me to be the wrong layering. These should be
> > generic services which any 802.11 "mode" above can use.
> > Can these services be used in adhoc mode or managed mode?
>=20
> In 802.11 infrastructure mode you have only one authenticator (the AP)
> and many supplicants.  You cannot use the same security model in a
> mesh, when there are no such role divisions.  Does batman-adv provide
> a security layer above the link layer security (and below IP)?  If so,
> where can I read more about that?
>=20

Have a look WPA-NONE. It is not well documented, but it basically works
with a single shared key and CCMP/AES encryption. No peer-to-peer=20
session keys or stuff like that though, afaik.

> > My personal opinion is that taking the multi-technology batman-adv
> > protocol and shoehorning it into the single technology 802.11s is the
> > wrong way to go. What might however be interesting is taking a closer
> > look at 802.11s and see what can be generalized and moved up into
> > babel, olsr, BMX, and batman{-adv}, or merged into plain old managed
> > mode and adhoc mode 802.11 and offered as services to layers above.
>=20
> When I wrote my first e-mail to your list I was under the impression
> was that batman-adv's routing algorithm was more advanced than HWMP,
> mainly because it had incorporated improvements gathered from many
> deployments (... and mesh battles :).  But it seems like batman's main
> strength is its ability to establish routes over heterogeneous links,
> not necessarily minimizing the spectrum utilization.

Mhm, heterogenous network support is definitly one strength of batman.
However, with its general design we have a broad bandwidth where
we can optimize and experiment, for example:

 * multiple interfaces support in general (does 802.11s allow to span=20
   meshes over multiple radios?), and with this:
   * interface alternating (receive on wlan0, send on wlan1) [1]
   * bonding (send on wlan0 and wlan1 in a round robin fashion) [1]
   * full duplex (not implemented, but might be someday ;)
 * network coding (we have some recent research on this) [2]
 * optimized multicast transfer [3]
 * further support for some protocols, like ARP [4]
   (through distributed hash tables, a current GSoC project)
 * the "core" routing too, of course :)
 ...

Regarding the battlemesh - we have seen some interesting effects in
the battlemeshes, but personally I see these events as an excellent
way to meet people, discuss experiences and ideas and primarily have=20
a lot of fun. ;) It is one of the rare occasions that most of the
batman developers meet. You should come next time if you can. :)

The "real" tests and live experience is gathered inside real mesh networks,=
 e.g.=20
community networks or commercial networks with routers which include=20
batman-adv as their mesh network software (using *WRT or commercial firmwar=
es).=20
Many features which were developed (e.g. Gateway support [5], Bridge Loop
Avoidance [6], Multicast Support [3], ...) came directly from=20
"real world requirements".

Thanks for your input!

best regards,
	Simon

[1] http://www.open-mesh.org/wiki/batman-adv/Bonding-alternating
[2] http://www.open-mesh.org/wiki/open-mesh/2011-08-18-network-coding-first=
-steps
[3] http://downloads.open-mesh.org/batman/misc/wbmv4-multicast.avi
[4] http://www.open-mesh.org/wiki/batman-adv/DAT
[5] http://www.open-mesh.org/wiki/batman-adv/Gateways
[6] http://www.open-mesh.org/wiki/batman-adv/Bridge-loop-avoidance

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk5VedcACgkQrzg/fFk7axZKZACg9VJhPmNtJeTtfeelhS5ekf18
ZuQAn2KULqw3yAdX/Bak1kztIWoQwh5H
=kDRr
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
