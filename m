Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 06 Nov 2015 14:22:37 +0100
Message-ID: <80380848.PJif3jmaAr@prime>
In-Reply-To: <004201d11893$53de6d00$fb9b4700$@itelsis.com>
References: <004201d11893$53de6d00$fb9b4700$@itelsis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8512856.HpqZpgTSbL";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
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

--nextPart8512856.HpqZpgTSbL
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Santiago,


On Friday 06 November 2015 14:02:01 Santiago =C1lvarez =C1lvarez wrote:=

> Hi everybody,
> I've been working for some time in testing batman-adv protocol with s=
everal
> network topologies, and different network communications.  Right now,=
 I'm
> trying to build a batman mesh network over 5GHz wireless modules. How=
ever,
> I'm getting errors when trying to configure the module to use one of =
the 5
> GHz channels.
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

yes, batman-adv on 5 GHz works for us.

There are regulatory limitations for the higher 5GHz channels, but chan=
nel=20
36-48 should have no restrictions for ad-hoc use - if your chip/driver=20=

supports it.

I would suggest to first look into getting Ad-Hoc mode working without =
batman-
adv before continuing any further. You might need other sticks, but the=
re are=20
definitely USB chips out there supporting Ad-Hoc (you may want to check=
 out=20
ath9k_htc based ones).

Cheers,
    Simon
--nextPart8512856.HpqZpgTSbL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlY8qZ0ACgkQrzg/fFk7axaQBACeP9BH7vsfnTPLHtrGGrCH4pvl
XqIAn1B/fKjLs0mtSv1/7sYKQ82ivLJM
=yRU7
-----END PGP SIGNATURE-----

--nextPart8512856.HpqZpgTSbL--

