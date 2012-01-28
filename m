Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sat, 28 Jan 2012 16:35:35 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20120128153535.GA15903@pandem0nium>
References: <1327677116-22645-1-git-send-email-lindner_marek@yahoo.de>
	<20120127151914.GB19664@lunn.ch>
	<201201272354.26055.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <201201272354.26055.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: encourage batman to take
 shorter routes by changing the default hop penalty
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


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 27, 2012 at 11:54:25PM +0800, Marek Lindner wrote:
>=20
> Hi Andrew,
>=20
> > Do you have any performance analysis to show this is really helpful
> > and not harmful?
> >=20
> > I've seen indoor results where i had to reduce the hop penalty,
> > otherwise BATMAN was taking a short path which worked badly. By
> > reducing the hop penalty, so encouraging it to take more hops, i got
> > usable routes.
> >=20
> > I see the danger here this could break working networks, so maybe it
> > needs justification?
>=20
> as a matter of fact I do believe it is helpful. In various networks (more=
 than=20
> a dozen) I have seen that batman would largely favor multi-hop routes, th=
us=20
> reducing the overall throughput. By setting it to a higher value I regain=
ed=20
> some of its performance. The networks are still up & running - I can show=
 them=20
> to you if you are interested.

I have seen similar results in my test setups. One simple scenario where I =
have
seen route flapping with hop penalty 10 in multiple setups is: If some node=
s are
at the same place (e.g. a few netbooks on the same table), they often don't=
 use
the direct route but change to a two-hop route to reach their destination -=
 even
if the direct link is nearly perfect. There don't even has to be payload tr=
affic
involved, the routes just flap because of the little tq oscillations from s=
ome
packets lost.

In these tests, I have also changed the hop penalty to 30 (or even 50, some=
times)
and these problems are gone.

The TQ metric has limited informative value in terms of available bandwidth=
/chosen
rate. The default wifi broadcast/multicast rate of 1 Mbit/s may lead to pre=
fering
low-rate 1 hop links over high-rate 2 hop links. However, this can be often=
 fixed
by increasing the mcast rate (mac80211 or madwifi support this). We should =
consider
including rate information in future metrics.

Anyway, for now and our current TQ metric I strongly agree in increasing th=
e hop
penalty too.

Cheers,
	Simon

>=20
> So, you had to reduce the default value of 10 to something even smaller ?=
 A=20
> hop penalty of 10 results in a penatly of 4% per hop. A rough equivalent =
of 2=20
> lost packets (62/64). Does not sound very much to me. Can you explain you=
r=20
> test setup a little more ?
>=20
> Nevertheless, this patch was intended to get a discussion going. The main=
=20
> problem I have been seeing in the last weeks is that OGM broadcasts have =
a=20
> hard time estimating the link quality / throughput on 11n devices. I'll a=
lso=20
> try to hack a proof of concept for an rssi influence on the routing and s=
ee if=20
> that has a better effect.

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk8kFccACgkQrzg/fFk7axbEjACg4DfVgJy92R2bt9qz5Nl0Ys8R
EFAAoJtm9esKYkGLc84tagoV09zVn8HO
=jhvf
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
