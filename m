Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 25 Oct 2016 11:45:19 +0200
Message-ID: <2155840.zTA8OrSqiX@bentobox>
In-Reply-To: <580F251E.7060400@yahoo.com>
References: <580F251E.7060400@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart36036084.aATUndUyhP";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Whether Batman-adv need suitable wifi network
	card (support interface modes ( mesh point ) ) .
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: johnzeng <johnzeng2013@yahoo.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart36036084.aATUndUyhP
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 25. Oktober 2016 17:25:50 CEST johnzeng wrote:
>=20
> Hello Dear Sir :
>=20
> Whether Batman-adv need suitable wifi network card (support interface
> modes ( mesh point ) ) .

"mesh point" is for 802.11s. You can use 802.11s (mesh point) interfaces
for batman-adv when you set mesh_fwding to 0. But most people use IBSS
(adhoc) at the moment for batman-adv. It doesn't really care that much
about the underlying interface. It just has to be ethernet compatible
and support some basic features like broadcast.

So you could even run infrastructure mode (AP+Sta) with batman-adv. But
it doesn't make a lot of sense in most situations :)

The B.A.T.M.A.N. V algorithm implementation has some extra requirements.
It must be able to get the expected throughput towards a different device
from=20cfg80211. You can check if the driver supports this by checking
`iw dev wlan0 station dump` and searching for "expected throughput:".
The Mpbs value should represent the reality (and not be complete bogus).

The biggest problems here are driver/hw bugs. Even the ath9k hardware
(which works quite well) has its fair share of problems.

> there are two wifi network card , and i thought Rt2070 will support
> Batman-adv .
>=20
> Because Rt2070 will support interface modes ( mesh point ) , and
> RTL8188CUS can't support interface modes based mesh point .

Both advertise support for IBSS. So you can (in theory) use adhoc on
both devices and run batman-adv on top of these adhoc interfaces. But
you may end up with driver problems (at least I already had problems
with Realtek and Ralink hardware). Maybe someone else here already
tested these two chips and tell us more about them.

Kind regards,
	Sven
--nextPart36036084.aATUndUyhP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYDymvAAoJEF2HCgfBJntGgJQQAMEwd8wIzucMx6OFaEbgSXDN
nZeA9/Tlu+CXvWgG4XHzZzn4SYymBMJLG6RrF4dxSLXWt83XEyaRlXuEtLD5v9LP
ESHOt8OO5jviL5QUn93CSwFeoADaoLSORuHHUNzPygDX3p4v+sOVyEaQ5ZEi5UHA
zBgwT0JeZZbI13bF9fs9o1f8pmp5nMtWN5NOuedBHoPt8wtNEKvB19dPavCiW1xn
CCuCeAqMPNBK+zNK3MMJHFgTODMmhnyPDyKHhtdXfefSDHHF3D7hvhUr5V1kJMyp
64uyHjh8Aavq1+FryMWtF0Wk2Ti4zpmBv0rhJzLAXC825L4U8finDM75pFDBYX3B
ixBpsl/1UV639sTHXj0/aaFtjij713qTb6lqugFtbRfGka4MZmDWahsQZaKTjjBD
p0/S4GJATW23MPIrD93Srkgk9qg2JfeS12DMq/u8OGRx//0fkfd+E8jGskZxQGVg
sKpeyd9tpDSckoIsvXVs+8xIaFBNPa+RcQTDOKpxR5MyeGoaIz0OV8LqPwQg5oXA
QUpc7wkHxG4ZXYNBoqLOIbSL8M/bAuGScys7pRH4IXIVL6jDMt4QM91vPQzzRMlw
Q6voI1qT52mksyQh5P8JxZHhS2pwC682WEVzG1pm/OYpOEmQqcDXzP+w8hPKoaSs
pFmvPcwtf7812rt9BGec
=LcJa
-----END PGP SIGNATURE-----

--nextPart36036084.aATUndUyhP--

