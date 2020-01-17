Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re:
Date: Fri, 17 Jan 2020 08:44:49 +0100
Message-ID: <2587871.AsJD0l72uE@prime>
In-Reply-To: <mailman.6.1579205674.8101.b.a.t.m.a.n@lists.open-mesh.org>
References: <mailman.6.1579205674.8101.b.a.t.m.a.n@lists.open-mesh.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10894538.rmToC6h1BE";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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
Cc: "Martin,
 Jeremy J CIV USARMY CCDC C5ISR (USA)" <jeremy.j.martin33.civ@mail.mil>

--nextPart10894538.rmToC6h1BE
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Jeremy,

On Thursday, January 16, 2020 9:06:50 PM CET Martin, Jeremy J CIV USARMY CCDC 
C5ISR (USA) via B.A.T.M.A.N wrote:
> My/My Teams intent is to have 4 radios in total, 2 on one pc and two on
> another. Our plan is to have Batman take care of the switching between
> which radio to use in order to transmit data between these two PC's. One
> radio is high frequency radio (60 Ghz) and the other would be a lower
> frequency radio and the idea is to have batman switch between these radios
> once the higher frequency radio is dropping between a certain TQ.

BATMAN will switch by default when one link has a better TQ (towards the final 
destination) than the other link, so I believe this should happen by default.

> My
> primary questions regarding this scenario would be, 1) Are there specific
> standards the radio chipsets would need to support in order for them to
> work in this scenario?. 

Normally you would want IBSS mode or 802.11s mode work. BATMAN can also work 
in AP/Sta mode, although the packet loss counting may be biased since 
broadcast handling works a bit different than in IBSS/11s. But for point-to-
point links it might just work.

> 2) Would Batman-adv be adequate enough to be able
> to handle a 1Gb/s data transmission and be able to swap accordingly to the
> lower frequency radio?

If your radio and CPU are powerful enough, batman-adv is able to handle it, 
yes.

Cheers,
      Simon
--nextPart10894538.rmToC6h1BE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAl4hZfEACgkQoSvjmEKS
nqFv/hAApCEYdfxWJkmq0KhfaDHOvKNRpc0OsdowiIZHKQfu/JSnFMv5UOj0rpAK
T289oxyhGrAGg1UG8EsnjN1emPlacEo50c7uf7CRN3RJW5pHdK4ueKQske9gs0Jx
0lnxHDHLfRynFjtDqIk1/FkMh7i9vbLq+9b/yNYE3FbbfChTn0qyxfN98AF636mt
YVPnKWL9HGdZK7O1knTR1wAFWp10KPL+U8wcu27pGs6JjZK3IW1G5Pnk7pu2lopQ
J78BjPS/YJqRpf9sqkN4RVUfB78JW7ooC+LIo4QJgymfDsNEKtjnOwyyMin1HXo+
79QG7H5kkGwyW6yEDziROvQ1D4+yDjluLF+WHUhzLaisxGwIK82QJy/ZnY2DB8TM
zHdaI8sdAXsQ2jmIJuzZuCjU4FfSoEyzd4txD5qGgCZZfSO9TqSyJPsagKmaLGlX
wODnWe6wPkpOTbK00nyVe5ppz+kue3SbSThx2EnmKHbVCajPP8+mek7VooK/tGJn
WKcGdGyiNYy6Du5wgrKmLxugJH9EvcWACxQg8Y0Biyp1bDj3GoIzoyxOlwqt3Dc4
PpdasDtBIjC1XeX51JrUfWG0Xq8tLiJkWcyMpuoVyvqzSF8bem/XC3cMRVYzqKcd
JJ/+0V0b/mE14B0SuzkycjSS75MZfP7pNwClpq1+QmfS2rmeaK4=
=3NvB
-----END PGP SIGNATURE-----

--nextPart10894538.rmToC6h1BE--



