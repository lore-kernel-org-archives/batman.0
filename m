Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 09 Nov 2014 12:57:26 +0800
Message-ID: <202220095.ipQiVIkzDN@diderot>
In-Reply-To: <5419358C.4030500@meshcoding.com>
References: <1410936979-2219-1-git-send-email-martin@hundeboll.net>
 <5419358C.4030500@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1896908.Vny0PQSx4f";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: clear control block of
	received socket buffers
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Martin =?ISO-8859-1?Q?Hundeb=F8ll?= <martin@hundeboll.net>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart1896908.Vny0PQSx4f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday 17 September 2014 09:17:32 Antonio Quartulli wrote:
> On 17/09/14 08:56, Martin Hundeb=F8ll wrote:
> > Since other network components (and some drivers) uses the control =
block
> > provided in skb's, the network coding feature might wrongly assume =
that
> > an SKB has been decoded, and thus not try to code it with another p=
acket
> > again. This happens for instance when batman-adv is running on a br=
idge
> > device.>
> >=20
> >
> > Fix this by clearing the control block for every received SKB.
> >
> >=20
> >
> > Introduced-by: 3c12de9a5c756b23fe7c9ab332474ece1568914c ("batman-ad=
v:
> > network coding - code and transmit packets if possible")
> maybe the maintainer can split this line before pushing the patch, bu=
t
> next time split this it in two of them  (like other patches we have)

Your bastard maintainer from hell also overlooks the missing 'v2' in th=
e PATCH=20
subject. He had to dig through the mailing list to find the latest & gr=
eatest=20
version this patch has to offer.

Applied in revision 9ed2fc7.

Thanks,
Marek


PS: You did ask for more marecasms, didn't you ? :)

--nextPart1896908.Vny0PQSx4f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUXvQ5AAoJEFNVTo/uthzAqgQH/3QddQ3nwaWdkieTXkuuQGSf
6a5xalnKCmC6X90+TXX5BqOHOucpLzTE3yd8UNVrGfF7cekQpl6Ibu3IVt8KMMMO
/nvUsM4A8NO52PQI0Vv8XMmEmPToOhHfw5Ecm2EBk+cBIjOJSiijW+Chw1Zor8hl
G4a9xhh4Ai84ImtgIUaMv9cgDyUoCx1HH072bivCVxn3cAfHItpGhEAg+/ZGa/0c
IPuC+B8BjynNZRHk7JbatZphOEQQq12N/4xi8jusRQ8QFOShrjIQ1R2LRYdIJ8wp
2hVqYU0pjL3Oip2DYVW+svXHanuJJgJIwmqpb3DqmEE4bQiU5IK8VmiR3PtII7Q=
=TyaU
-----END PGP SIGNATURE-----

--nextPart1896908.Vny0PQSx4f--

