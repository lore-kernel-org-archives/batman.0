Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 30 Mar 2016 10:08:45 +0200
Message-ID: <17187322.PaAoUXZz7c@prime>
In-Reply-To: <20160329000219.GB4528@otheros>
References: <56F5AF2F.6060904@t-online.de> <56F99FCD.5040704@t-online.de>
 <20160329000219.GB4528@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3003094.0DJECfRVUQ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] No rebroadcast on mesh links
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

--nextPart3003094.0DJECfRVUQ
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hey Linus,

On Tuesday 29 March 2016 02:02:19 Linus L=C3=BCssing wrote:
> On Mon, Mar 28, 2016 at 11:19:09PM +0200, Roland Volkmann wrote:
> > Node A cannot know, whether you have scenario 1 or 2.
>=20
> But an ethernet driver or mac80211 with AP/STA interfaces
> (without ap-isolation) could. Or tinc with forwarding enabled
> would know. All these can be pretty sure that things are
> transitive and could set a TRANSITIVE flag quite safely.
>=20
> Any other interface type, driver etc. would leave the
> TRANSITIVE flag unset by default to be on the safe side.

what do you think the chances are for linux-net guys to adopt this flag=
? We=20
could send an RFC to see how they would feel about it. I remember last =
time I=20
wanted to change something in SKB struct, they didn't like that at all =
(maybe=20
for good reason). Could be that they don't want to "bloat" the flags to=
o, but=20
we can/should try.

The other question would be more practical: This would not be backward=20=

compatible with older kernels, so everyone who wants to use that new fe=
atures=20
would need to upgrade the kernel (or wait until new kernels are availab=
le). Do=20
you agree?

Cheers,
      Simon
--nextPart3003094.0DJECfRVUQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW+4mNAAoJEKEr45hCkp6hi+sP/0T8ftpMyCkXKi5TZBaYRZki
cX2P+yOGPsl8Ev4ob9S5qb4s7AjPwWXqVY0EFHnKgYRxwoPJ9+DRqTFIfjn0emLI
yEZT+7340NbMQTnJWAgeQew7+D1xH706F/hYyEei9bD73T5kUA9Mgbzkb0YHDKW+
rJBztgTIvKnOJ5qp6uzr5hDsdTXJBaoUGzF5s+UNgmkF8Txjo2D2tXJfAeZ0pbIL
HYyCr1C/gk8oWGHovszhGU2j0kARpJ4YqMSxrHtdnuWvEHOuhlD10I4AIkYkdVjH
CC9oRfw0fiu+lrwfJMN9aNXSfLuUADEZ+eMwIwRdO0jPmtgHnRI0P0bRfJImFNKm
KkVYfIONG40zhF9vJquDuOfk5DZIJ94HBjYQJKiDtfhmEVdOwbIEvjFGUViB+Yjm
BJvqUhapmPywdri+xUX+rCuwAcOlyOwSaYphstHJcjZKondIk7gFz9KPKA12IWz/
8+zuhrkPR8aJk13vTjRhzRo2iCslVIaGv6ChWzd+MFPYMj2zCDNDrvn+yJ8Q8r3f
OLkkEbE1GzPNem1cPg+8nDRtVidpfN+rbM31wOuRr4GB6TLTno9VKKQMSiHBfiBu
iffnPbv2qDNtUggLKMxWWEVxi9ZmZIaxPgRCUg9ibjNjaV95VZymsinQLi9MHb0A
DxapQMFWS4ukHwuKGrhH
=aGPm
-----END PGP SIGNATURE-----

--nextPart3003094.0DJECfRVUQ--

