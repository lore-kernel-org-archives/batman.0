Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Sat, 03 Jun 2017 11:21:09 +0200
Message-ID: <6159566.YFa7EaokOW@prime>
In-Reply-To: <458fa88b-b6d9-d02a-8d5f-012f6c83edef@gmail.com>
References: <edc163f6-a49c-21f3-9cf1-74df6e262fdb@gmail.com>
 <CAJ-Vmo=RnRGCEOTs6VHzTVZeex0n7OnTEiJq8jZR2cDhbnTXwA@mail.gmail.com>
 <458fa88b-b6d9-d02a-8d5f-012f6c83edef@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1665812.oBcpM4xXnS";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [wpa_supplicant] Is there a way to limit peers
 (to about 12) for IBSS/adhoc?
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
Cc: Adrian Chadd <adrian@freebsd.org>, hostap@lists.infradead.org, Jason Toschlog <jason.toschlog@gmail.com>, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>

--nextPart1665812.oBcpM4xXnS
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi Xuebing,

are your devices all configured with on AP and one IBSS interface? Or even =
more=20
AP interfaces? What is the multicast rate you used?

One thing you need to consider is that in ath9k if you run AP and IBSS at t=
he=20
same time (at least with OpenWRT), the distributed IBSS beaconing is disabl=
ed=20
and each node will beacon the "normal" ~10 times per second. That means wit=
h=20
AP and IBSS and 40 nodes, you end up with ~800 beacons per second. That mig=
ht=20
be a problem (especially if all nodes are in the same spot).

To change this, you can try:

 * increase the multicast rate to e.g. 18 mbit/s (note, this may also chang=
e=20
the batman-adv neighbor range) and verify that the beacons are sent on high=
er=20
rates
 * disable some APs - you don't need so many anyway if they are all on the=
=20
same spot
 * increase the beacon interval on the APs- although some clients may not l=
ike=20
that.

=2E. anyway, that is all stuff you can try if you have the feeling the airt=
ime=20
is "polluted", so I would suggest to verify if this is the cause first befo=
re=20
taking counter measures.

Cheers,
     Simon
On Saturday, June 3, 2017 2:30:27 PM CEST Xuebing Wang wrote:
> Hi Adrian,
>=20
> =3D> Is it a gradual thing?  Ie, do you know when it starts to hang? Does
> it hang at 40? or gradually as you approach 40?
>=20
> We do not know. What we do know is, 20 peers / neighbors work well.
>=20
> Jason Toschlog in CC said that he observed similar issues with brcmfmac
> when peers reach 32 (16 peers work for him).
>=20
> I guess I will setup 32 or 40 nodes here and try limit the max number of
> peers (at wpa_supplicant) for IBSS/adhoc.
>=20
> Thanks again.
>=20
> Xuebing Wang
>=20
> On 2017=E5=B9=B406=E6=9C=8803=E6=97=A5 14:16, Adrian Chadd wrote:
> > Hi,
> >=20
> > Well, it sounds like something you need a 40 node test network for :)
> >=20
> > I was wondering whether it was some kind of MAC bug that was being
> > triggered because of so many units say, overflowing the keycache or
> > something. But if it's software encryption then maybe not. I wish I
> > could help more, but setting up a 40 node network to test is a big
> > challenge. :)
> >=20
> > Is it a gradual thing?  Ie, do you know when it starts to hang? Does
> > it hang at 40? or gradually as you approach 40?
> >=20
> > As for association limits - I thought there was a maximum station
> > parameter somewhere...
> >=20
> >=20
> > -adrian


--nextPart1665812.oBcpM4xXnS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlkyf4UACgkQoSvjmEKS
nqHN2Q/7Bqg9SUnIBY3E3NLjY7sE14FEKpitmnmihtymd3LeIdUoZTl+o4hHVI8n
WPmL/nGhz3A7qhtxK18ITT7f6fgg+bwyQJumukivNshSWxRAmHVB5eiOayCkKBPr
E1IpB5E4njPHu+MxiFCFSt033vBD2xpmcVSGBOlcP3gueM2km3sdguqkcR8+BTbv
81h74cUvne9zb/QcFkjt6a3NhjDhhcZ2/l9yZ1pWC1155p/csxps1d64Z87p7+KA
o4MhP32bmDZObPFwG3D0F6rN/jBk1SbUH6vKuwSd4gMpeRdRVjwfOhO257CWpDgT
j6S5yD75m0N0+ySpy8fBA91aooYyzr4MLAFbdm97+wkOH2AN2RAMovxmqRe/Rlqo
ztSGlYqw4LAYTHpNr5w55kpNfJoqMVHN7WKWs8+k+4luWofieba0wTSL0uhzrfes
2F8t1UEZ08tDeOGlWyjt0Y0k1gCBC7aq4fhiLZxqvYfFQM9qfSzLYFd4m35iGM6C
3NyEyiAZMZHqkYBzEdHZ5dSaLQg0DPbRDAWNTXgA6ZOsy6TtJkUojJhiApBtBXPR
+ja8s/SOsXC8VnPE8xblTprlhG744E7VM6sBlu77b+kkiXSp0xTjlwu61QSREs79
j2rd4tdDUma4cfO214QtKrWTOUpg+HPLdYclljYaaT1CffYJy+Y=
=oWc1
-----END PGP SIGNATURE-----

--nextPart1665812.oBcpM4xXnS--

