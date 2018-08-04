Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 04 Aug 2018 17:05:42 +0800
Message-ID: <42613698.Wqezz8BKG2@rousseau>
In-Reply-To: <20180521134657.GL7162@otheros>
References: <20180518014754.23644-1-mareklindner@neomailbox.ch>
 <20180518014754.23644-8-mareklindner@neomailbox.ch>
 <20180521134657.GL7162@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2550308.rCgSs0HbhC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 7/7] batman-adv: ELP - add throughput
 meter test duration attribute
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

--nextPart2550308.rCgSs0HbhC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday, 21 May 2018 21:46:57 HKT Linus L=FCssing wrote:
> On Fri, May 18, 2018 at 09:47:54AM +0800, Marek Lindner wrote:
> > When the ELP throughput meter fallback kicks in to trigger
> > a throughput meter measurement the test duration can be
> > configured via this attribute.
> >=20
> > Default tp test duration: 1000ms
>=20
> Would it make sense to note the adjusted default tp test duration
> in the commit message, too? It is adjusted from 10ms to 1000ms
> here, right?

I am having a hard time following your thoughts here. The default duration =
is=20
part of the commit message. The user space tp meter test is not affected by=
=20
this change. The tp meter ELP duration of 10ms default was introduced in th=
e=20
previous patch only.=20
Anyway, will change the previous patch to use 1000ms.


> I'm also wondering if it would make sense to make the test
> interval adjustable instead of the duration:
>=20
> With 1000ms on a 16MBit/s DSL line this would generate 864GB of
> traffic per month and would be an issue for several existing
> setups right now.

Assuming you are talking about the batman-adv-over-VPN-over-internet use-ca=
se:
Simply set the interface throughput to 16MBit/s to disable the ELP throughp=
ut=20
meter measuring altogether (see throughput_override).

ELP throughput measuring is not built to improve that use-case.


> Is there some minimum test duration at which the tp meter is
> supposed to not work realiably anymore, where an increased check
> period would be more suitable?

The ELP throughput meter test is designed to handle interface / neighbors w=
ith=20
fluctuating link throughput. For those setups, having up-to-date link=20
throughput information is what makes this worthwhile.

Static DSL uplinks don't fall into that category. Every regular throughput=
=20
check (no matter how rare) is worse than no test at all. To handle those ca=
se,=20
batman-adv already provides a knob.

Cheers,
Marek

--nextPart2550308.rCgSs0HbhC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAltlbGYACgkQU1VOj+62
HMAbXAf/e98oyCuSqpx6cteU8+IqFSvZ6EAcHp0qK7PRfD3uaEuIOSB5Sx3hJScQ
+SIWII9P8wEW/+iX0rI9nHdJZgFYP2M/4TNI5Hvz7U0LPi0PQbgVtCpt3uUp08f4
UTJdoMQZZ8/awXa6HrkQy66/lTKE0huxFdpfh0ZseJZg6R3k5uyySHdcEzKgVhJB
rScMGNvhXjtUMW1dyWdReYGFdNpn9bsiLRdcRXOKsECC9nGFh7e2Cp3IfDIVMSwu
F38XAkrdF0JfdB3nhl66CQllvnJIxXWeu9+bz9drbTQy+REGJdGqb5Yn/10u+BU4
AgUIc+9iowf2TxDa78ROzZZ+a8HLwQ==
=X2Df
-----END PGP SIGNATURE-----

--nextPart2550308.rCgSs0HbhC--



