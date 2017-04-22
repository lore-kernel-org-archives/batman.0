Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Sat, 22 Apr 2017 10:35:50 +0200
Message-ID: <1558277.kIpDkU8F5M@prime>
In-Reply-To: <e7d58eab-dfaf-bd5f-945e-1ebb1cac90af@gmail.com>
References: <9309484e-a9c2-0476-3ddf-a2d68a51c58e@gmail.com>
 <1626579.VOjpoqf3Fa@prime> <e7d58eab-dfaf-bd5f-945e-1ebb1cac90af@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4353936.vs3rkkuLsP";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [batman-adv] Does batman-adv works perfectly?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Xuebing Wang <xbing6@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart4353936.vs3rkkuLsP
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi Xuebing,

actually, ath9k is the most used hardware platform used with batman-adv, at=
=20
least as far as I'm aware. It is used commercially as well on some hundred=
=20
thousand devices. I would assume that it's very hard (or impossible) to fin=
d a=20
"perfect" running hardware platform and drivers. On other drivers, you will=
=20
have trouble to even get IBSS/11s mode running.

The question is, how do you handle faults - usually, there are workarounds=
=20
applied which happen automatically like the ones we have referenced in this=
=20
thread. They don't happen very often (i.e. less than once a day), and many =
of=20
them can be fixed quite fast (except for the deaf problem, which may take ~=
30=20
seconds to recover).

However, there are also some problems which happen more often in certain=20
environments or on certain hardware (maybe due to bad choices in RF design=
=20
=2E..). There also may be problems in certain driver versions (i.e.=20
regressions). And of course, there can be issues which have not yet been=20
addressed.

BTW, I've just seen that you use psk2-ccmp. There is a known problem with k=
ey=20
cache corruption. I'm not sure if it was already solved and merged in Chaos=
=20
Calmer [1]. You may want to try if the problem appears without encryption.

Cheers,
      Simon

[1] https://patchwork.kernel.org/patch/9381651/

On Saturday, April 22, 2017 3:12:54 PM CEST Xuebing Wang wrote:
> Hi Simon / Sven,
>=20
> Do you know any hardware platform on which batman-adv (or batmand) work
> perfectly and field-proven? Thanks.
>=20
> Xuebing Wang
>=20
> On 2017=E5=B9=B404=E6=9C=8806=E6=97=A5 15:04, Simon Wunderlich wrote:
> > Hello Xuebing,
> >=20
> > it sounds like you have WiFi driver issues. There are some effects like
> > key
> > cache corruption, deafness, and other effects known for the AR93xx seri=
es.
> > To confirm, you can try to use IPv6 link local ping (ping6
> > fe80:...%wlan0) to your neighbors. If you can ping but batman can't (e.=
g.
> > use batctl) it's a batman issue. If both pings don't get through, it's
> > most likely a WiFi driver issue. In this case, a master or something
> > doesn't help. :)
> >=20
> > Cheers,
> >=20
> >       Simon
> >=20
> > On Thursday, April 6, 2017 10:32:29 AM CEST Xuebing Wang wrote:
> >> Hi community,
> >>=20
> >> We have batman-adv working on OpenWRT Chaos Calmer.
> >> - Atheros ar9331 MIPS platform + built-in ath9k WiFi
> >> - batman-adv version 2016.1
> >> - routing_algos =3D BATMAN_IV
> >> - Wireless interface MTU =3D 1532, adhoc network encryption "psk2-ccmp"
> >> - bat0 interface MTU =3D 1500
> >>=20
> >> We have batman-adv running on 10+ sites. For each site, there are 10-20
> >> nodes in the mesh network.
> >>=20
> >> batman-adv runs almost perfectly (*almost*). Occasionally (occurrence
> >> rate is low), node drops off the batman-adv / adhoc mesh.
> >> - Sometimes, node can recover (re-joins the mesh network automatically=
),
> >> but not always.
> >>=20
> >> Any suggestions? Does batman-adv works perfectly in the field (i.e.
> >> running for 1 year with 100+ nodes without any issues)?
> >>=20
> >> What about I use one node as Master, and other nodes ping this Master
> >> every 10s (or 30 seconds) (to keep mesh from inactivity)? Does this he=
lp?
> >>=20
> >> Thanks.
> >> Xuebing Wang


--nextPart4353936.vs3rkkuLsP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlj7FeYACgkQoSvjmEKS
nqHdAxAA0wN2Lrkk9vXmgJXpbntSLQSCsHWVQnlsEw3RoiyO2YnBR9AT61GKJUr1
BJ+GfttL0yYZs4A480r+RzDzESEI3SUtt9e1dJMsx0k+Fc8XnIYtVLnSQFQh1umA
4KP2rt7Wb7SzCcU5vXnu7LKh+xpsVzFZqqmvKTTrzV5ubf/zi9vutW3LhJpKYoeB
JEGj8WtExduEd2q+W/nEt+jfJ70M9t7Ns5B8JAA6SnW221Yu4VNMho60xCUIKM8W
M21WdxoRmMpdYnl/kClVvyLNnJZ6mHJsNSuM5w+ryECNbWmmaj4waGg5vUvFT3sG
MDSpA+63YFX2sw2NoQDNbfz8Lq3WoMXskNLz/2qtIGMhMyH04LUJNnRPeCYZ2JFz
qmsYXhSCrXme1yGPFX+z/CnGlefpXgIzpqyNais7p08cPqilJ3YGOnndf4H22jGT
MeXfS1P/CZ1brTg6RXUqMk7p8n41SKoEFnHHOAKHceMYcuXZoBXDOZe25EOESXo+
ToLdUKvjcJddT039E9SOl56PLI/CpzYt5j0LHW2l6UsHc/qQLJ15AuIlqXEfcyZy
Zop5gBb4UbG023BYVL1ERSW/h6np3GnEHzi65V5cXnBghk7P4mxbyybfTrzpgsGx
gxwwsGbPfkfcVYRGh/myoDqFvdPO+stcTZIjtkLzt7bGwKT2fbE=
=xiy/
-----END PGP SIGNATURE-----

--nextPart4353936.vs3rkkuLsP--

