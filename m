Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 20 Jun 2016 20:05:32 +0200
Message-ID: <4019482.FMBfOuWKPo@sven-edge>
In-Reply-To: <20160620175803.GB16638@otheros>
References: <1465939183-17868-1-git-send-email-linus.luessing@c0d3.blue>
 <5707464.HeWq3LKJdl@sven-edge> <20160620175803.GB16638@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3476812.HeOW5E8v7H";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: Introduce forward packet
	creation helper
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart3476812.HeOW5E8v7H
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday 20 June 2016 19:58:03 Linus L=FCssing wrote:
[...]
> > > @@ -478,20 +546,16 @@ int batadv_add_bcast_packet_to_list(struct =
batadv_priv *bat_priv,
[...]
> Regarding these two goto's, usually using a "return" directly instead=
 of a
> "goto out" is better, I agree. For these two cases I think I would
> prefer keeping it that way, because it's not a simple return but a
> return of a macro value. Having NETDEV_TX_OK and NETDEV_TX_BUSY
> each only once in a function makes it easier to spot the good or
> bad cases, I think?
>=20
> Or maybe I could rename "out" and "packet_free" to "err" and
> "err_packet_free" to make the error cases even more visible?

Hm, not sure if this is really required but I honestly like the
names "err" and "err_packet_free" right now :)

Kind regards,
=09Sven
--nextPart3476812.HeOW5E8v7H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXaDBsAAoJEF2HCgfBJntGH/AQAIxQTGHm/1Nd142dturtwLU1
v+aun0GZaWvIxLeaBhtPAwJN8XlWUxxu7ch3O1LTUYljInQY48COr3ucw72fbCVX
TYfWlk9prTXCd5hyzWCcJw3OfJpCNADpuqLjRpalbi94+oLsJcJAcEzLdyzMBvfV
XmE18WT9uJrN08iXDRLdShS7EZ5LCPPTpmowjqUNXTTT2pTNCjha79sI4yjHSdkg
m6mVnUA0iE83BfaYoGc4RytoHzFsCr7u9J1mJeIvRSna+UOIe5RuMQimGO/LncJ5
4/bTp35xaJFrcjx0W18F3cs+XPNPaGSCwMCLAWrvSYaA5crxG2ucIjehNdnN3ec+
LLpUaUhWyRrjVsx+UGylI+92tYphIpZEu+eAchm9ALzGDyEJxO0xaE7YohHW/bdH
QlOtxjAJ2l3mSTTo2Xw0/gPZZ6CpiVvVoCqU6ecCW1yS3Ahl0U23Qp0gKGiLEvBn
nqnxiex5+Z9Qb7ZF7v2PVevLpoCRxVcu7QMy6pya6kcvn6R3oaWAa00I8lZ6sOHV
lbYydDxIktke5/roUuepyIADt2d5U2OeuV/YaBKN4JlaWvX05MxdLO05BiNDEsVC
7mziWgTGtWU8SKVDcTugEjfUoGZyNi0bqRVHwjmQSaKsNX9HoZch0rbgVoilcUzk
6CSM5WJNkXbHB4HGzsx7
=Qzhm
-----END PGP SIGNATURE-----

--nextPart3476812.HeOW5E8v7H--

