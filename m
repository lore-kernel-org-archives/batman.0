Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 01 Jun 2017 10:16:22 +0200
Message-ID: <1557491.4zHez3V5Fn@prime>
In-Reply-To: <OF89FEE322.19461B05-ONC1258132.0021BED4-C1258132.002222CC@phoenixcontact.com>
References: <OF367AF97D.9569B75C-ONC1258131.00480417-C1258131.00491EA2@phoenixcontact.com>
 <20170531142013.GD29826@otheros>
 <OF89FEE322.19461B05-ONC1258132.0021BED4-C1258132.002222CC@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2232043.6av0foQvxu";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Antwort: Re: MAC addresses of loop detect frames
 in global translation-table
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

--nextPart2232043.6av0foQvxu
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thursday, June 1, 2017 8:12:51 AM CEST Andreas Pape wrote:
> > Von: Linus L=FCssing <linus.luessing@c0d3.blue>
> > An: The list for a Better Approach To Mobile Ad-hoc Networking
> > <b.a.t.m.a.n@lists.open-mesh.org>
> > Datum: 31.05.2017 16:20
> > Betreff: Re: [B.A.T.M.A.N.] MAC addresses of loop detect frames in
> > global translation-table
> > Gesendet von: "B.A.T.M.A.N" <b.a.t.m.a.n-bounces@lists.open-mesh.org>
> >=20
> > On Wed, May 31, 2017 at 03:39:23PM +0200, Simon Wunderlich wrote:
> > > Hi Andreas,
> > >=20
> > > yes, those are loop detection packets. Preventing these entries
> >=20
> > from the local
> >=20
> > > translation table has been implemented only recently. We can
>=20
> potentially do
>=20
> > > the same for global addresses as well, it just hasn't been done so
> >=20
> > far ... at
> >=20
> > > least I don't see a reason prevening us from that. It is probably
>=20
> added by
>=20
> > > "speedy join" in the first place.
> >=20
> > This was the case at least for me. Andreas, do yours have the
> > temporary flag set, too?
>=20
> If I remember it correctly they are shown as "regular" MAC addresses
> without any
> special flags set (like any real mac address of existing devices). In the
> meantime
> I kick these entries in batadv_tt_global_add. But if you are interested I
> could
> revert my firmware and give a more precise answer.
>=20

To me, it would be sufficient to get a patch from your or Linus or anyone e=
lse=20
to fix this. :)

Thanks!
     Simon
--nextPart2232043.6av0foQvxu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlkvzVYACgkQoSvjmEKS
nqEfThAA1YX5gugNLe6fjz96G6lTGWYEkkCLlc97kT6UjHqmHGdOxuguC79AabIu
cMxnIF8BTp1PRLC6RWwkia0cPzdsY5rFFk5JCeTDydBL7Hus97B+szS759TP9l/h
8uwmonE/wB3wVAGK1ZlVDxM0rCgYGnqattv0IWZy+wGzpdabqg1PukUkiYeRTWVX
irkOm8IaZbPIz5sfGWancuUFHcIdI2gpn2FcDNXJSXR1BZ/227CNsomCqcFht0yn
9v0+f1lpt6IncbDOZ7X70xB4ovoJ/ZHZAeEjT2ffL4OFgES41uKtlBoIrR3CLbsI
OxqKyRCTDtU8WDfjhvhfdEARPXvSAd1Sqmizp6qWf6VbjQuPNwuBrcVKnEDqpDRe
ugF71Xct1J7uCMb3AaKxDnsXenKdR0UcGPYofrgN+ew8i5ATARvsCZjDZzmJyUqx
YarLi4PSfVlM/Yv5sd0f1NVjQ4HcHAW5kHTBX80xuYEqOqB8JYr9HYM+z9Yxsq++
XcDfqS6YxJvFtT6uV7SwQCIeuzRUPYMrMKJsihNSNm3e0oh9Jut5oWNA1cFqrE9g
e4b1evMZjSc+K0mJBsowDsK0gDRbbl8MPfi2qx2/qIsKHfjNdDB75GXKG7hMttI8
CiLr8TTs/XLUFY3QPR8b3qrNgID1smCsFCPb6BLwSq8tbkvPm6Q=
=jMg6
-----END PGP SIGNATURE-----

--nextPart2232043.6av0foQvxu--

