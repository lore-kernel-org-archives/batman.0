Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
Date: Fri, 06 Nov 2015 14:24:48 +0100
Message-ID: <1907386.JoUJNV9Ls4@adelgunde>
In-Reply-To: <004201d11893$53de6d00$fb9b4700$@itelsis.com>
References: <004201d11893$53de6d00$fb9b4700$@itelsis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3134261.G1a8sWj9Nu";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] 5Ghz ad-hoc network for batman-adv
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


--nextPart3134261.G1a8sWj9Nu
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi,

On Friday, November 06, 2015 02:02:01 PM Santiago =C1lvarez =C1lvarez w=
rote:
> Hi everybody,=20
> I've been working for some time in testing batman-adv protocol with s=
everal
> network topologies, and different network communications.  Right now,=
 I'm
> trying to build a batman mesh network over 5GHz wireless modules. How=
ever,
> I'm getting errors when trying to configure the module to use one of =
the 5
> GHz channels.=20
>=20
> I'm using a module with Ralink RT5572N chipset. Searching in internet=
, I've
> read a few comments suggesting that it's not possible to configure a =
5ghz
> module in ad-hoc mode due to some kind of regulatory reasons.
>=20
> Any of you have managed to get batman-adv working over a 5 ghz wirele=
ss
> network?

This depends on the regulatory domain you are in or using. In general b=
atman on
5GHz works.

For example in Germany the lower 5GHz frequencies are free to use
indoors. And Ad-hoc works there perfectly fine (of course batman as wel=
l).
The upper channels require radar detection. This also means that the ch=
annel of
the ad hoc network has to be changed as soon as any radar was detected.=
 This is
more difficult. I am not sure if any implementation for this exists in =
Linux.

Best Regards,

Markus

=2D-=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |

--nextPart3134261.G1a8sWj9Nu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWPKomAAoJEEpcgKtcEGQQ148P/3o3gCC3zTd+sBHRuEiOZK5w
cbQPYe1lpvWZKpboO9QJZZuNC8VPEW2nbYr8+Jy5M6ChTlAyijzfNBYDj5VvKSeN
bHD6RMI2ZTetI++BvB2X3GsrCB24rJSItM4+M7cRdGpoI76XZyuRQb4A0ViK46Qv
TG2cPJJ/OQVbqbewJLtcBoEZ6auKMp/bNVN73Yvu6CirHPO8JJ+NBpbI6UqGoZfA
pQTkA00DhIBEyqDyZWg9lLjHf1d6DS23U5qIRS42jUJK/cBejAm/yNYB3dYo31Au
dory2m3sUHFVx7/q9h8kvZwAJvYyrXDB+AdvnyjRX06FVha7LTQA8Hl4EEJHW7Bd
8c529FT5vM4BJvY6dBn6EXaaq+NHDqB/aQbYxX028elMWkYSksp5tB+Tjp1BsZNo
0sIXLecTNeZ419A++LL+Mu2Q+OKm334ZQnFreUY9cFClcQU+YeyE8jWy3ykDZETf
dIqlllAo2Taq+4xiz36ERBLVwhFC3dHoNhEnRDk0TnT3jOgIYPU9pZV/WREkhaj7
ZSDI3EDx8hNnNyzNwvw97/v2w5k9x9ImOSeGrFTd1Rg6BfS2MeAMUZtgvqaSdzKV
a/mWyugS/Q1JdWNqEb0JJBABaWbppUieAuDhkn3ucGXO2FLsduPkkNO/4duQ81ax
uS4Bp0+EEzv9MTfepUTD
=5TLc
-----END PGP SIGNATURE-----

--nextPart3134261.G1a8sWj9Nu--

