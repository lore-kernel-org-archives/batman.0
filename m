Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 18 Apr 2012 14:25:31 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20120418122531.GA18292@pandem0nium>
References: <20120417092530.GA10402@pandem0nium>
	<4f8e5bfe.043c440a.68b1.4cde@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <4f8e5bfe.043c440a.68b1.4cde@mx.google.com>
Subject: Re: [B.A.T.M.A.N.] Problem with multi-radio,
 multi-channel in batman-adv
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


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Puyou,

On Wed, Apr 18, 2012 at 02:15:19PM +0800, puyou.lu wrote:
> Hi Simon,
> I have tried again, and I think the problem is caused by the same ESSID, =
as you said. I used the same ESSID on every wireless cards of every nodes.W=
hen I use different ESSIDs in different channel, the problem seems diappear=
ed.
>=20
> Another question, does the two wireless cards(wlan0 and wlan1) of one nod=
e have any differences in receiving and forwarding unicast and broadcast pa=
ckage? Can a gw_client node get IP address from a dhcp server from both wir=
eless cards?

Yes, you use the virtual bat0 interface. Whether the data is transported vi=
a wlan0 or wlan1 does not matter,
you will always receive the data on bat0.

There is no difference in the usage, and which interface is used is up to b=
atman-adv to decide. Please make
sure that you configure all your services like IP addresses, DHCP, etc on b=
at0 (or even on bridges above it),
not the wlanX interfaces.

http://www.open-mesh.org/wiki/batman-adv/Quick-start-guide

Cheers,
	Simon=20


>=20
> > -----Original Message-----
> > From: b.a.t.m.a.n-bounces@lists.open-mesh.org
> > [mailto:b.a.t.m.a.n-bounces@lists.open-mesh.org] On Behalf Of Simon
> > Wunderlich
> > Sent: Tuesday, April 17, 2012 5:26 PM
> > To: The list for a Better Approach To Mobile Ad-hoc Networking
> > Subject: Re: [B.A.T.M.A.N.] Problem with multi-radio, multi-channel in
> > batman-adv
> >=20
> > Hey Puyou,
> >=20
> > On Mon, Apr 16, 2012 at 06:35:04PM +0800, puyou.lu wrote:
> > > Hi guys.
> > > =E3=80=80=E3=80=80I=E2=80=99m trying to make a for nodes WMN using fo=
ur devices with two wireless
> > cards each. I would like to use three different channels to reduce the
> > interference, like this:
> > > =E3=80=80=E3=80=80[Node A]  <- channel 1 ->  [Node B]  <- channel 2 -=
>  [Node C]  <-
> > channel 3 ->  [Node D]
> > > =E3=80=80=E3=80=80First I configure eight wireless cards to the speci=
fic channel in ad-hoc
> > mode using =E2=80=9Ciw dev wlan0 ibss join =E2=80=A6=E2=80=9D.
> > > =E3=80=80=E3=80=80Then, I think I should add wlan0 and wlan1 to the s=
ame batman-adv
> > interface (that is bat0) in every device. So I need to configure four n=
odes
> > with the same commands like:
> > > =E3=80=80=E3=80=80              echo bat0 > /sys/class/net/wlan0/batm=
an_adv/mesh_iface
> > > =E3=80=80=E3=80=80              echo bat0 > /sys/class/net/wlan1/batm=
an_adv/mesh_iface
> > > =E3=80=80=E3=80=80Last configure an IP address to each bat0. (Node A-=
10.0.0.1, Node
> > B-10.0.0.2, Node C-10.0.0.3, Node D-10.0.0.4).
> > > =E3=80=80=E3=80=80But it seem Node A can reach Node B and Node C(usin=
g ping), but can=E2=80=99
> > t for Node D.
> > >
> > > =E3=80=80=E3=80=80Am I following the right procedure?
> > > =E3=80=80=E3=80=80Sorry for my poor English. Any help would be apprec=
iated.
> >=20
> > The procedure looks right in general. A few questions to debug:
> >=20
> >  * do you use different ESSIDs for the IBSS-networks? ad-hoc devices jo=
ining
> > may override the configured channel
> >    and select another IBSS-network instead when it has the same ESSID.
> >  * have you confirmed that the WiFi connection works without batman-adv=
? just
> > set up your WiFi, configure different
> >    IP addresses and ping for each hop to test.
> >  * does the output of "batctl originators" helps you? Are the other nod=
es
> > displayed on node 4?
> >=20
> > Cheers,
> > 	Simon
>=20
>=20

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk+OsrsACgkQrzg/fFk7axbDCwCeIE2Cre6pytQLy+imzDy8BJCR
LF8AoJUlRnJXcP2jem+R/dJ+kr/nBf25
=tI7S
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
