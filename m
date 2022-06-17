Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: Question about batman for ARM
Date: Fri, 17 Jun 2022 15:53:07 +0200
Message-ID: <2037952.ni6AN7iZ1R@prime>
In-Reply-To: <3826484.QQW5a1qdB9@ripper>
References: 
 <CAKau_3_sEaG2w7M+rQ-nuVG3_5GWHEV3UxmdG1bM-WPY7S8WxA@mail.gmail.com>
 <049201d88226$14ca9ae0$3e5fd0a0$@creonexsystems.com>
 <3826484.QQW5a1qdB9@ripper>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5140804.hIKb1v7LjU";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: cchien@creonexsystems.com, b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>

 
--nextPart5140804.hIKb1v7LjU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Simon Wunderlich <sw@simonwunderlich.de>
To: cchien@creonexsystems.com, b.a.t.m.a.n@lists.open-mesh.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>
Subject: Re: Question about batman for ARM
Date: Fri, 17 Jun 2022 15:53:07 +0200
Message-ID: <2037952.ni6AN7iZ1R@prime>
In-Reply-To: <3826484.QQW5a1qdB9@ripper>
References: <CAKau_3_sEaG2w7M+rQ-nuVG3_5GWHEV3UxmdG1bM-WPY7S8WxA@mail.gmail.com> <049201d88226$14ca9ae0$3e5fd0a0$@creonexsystems.com> <3826484.QQW5a1qdB9@ripper>

On Friday, June 17, 2022 10:45:48 AM CEST Sven Eckelmann wrote:
> On Friday, 17 June 2022 10:41:46 CEST cchien@creonexsystems.com wrote:
> [...]
> 
> > We would like to use batman with a custom radio and are trying to figure
> > out what part of the source code we may need to modify to allow batman to
> > work with a custom radio. Custom radio means that the radio is not a
> > commercial radio, such as wi-fi or Bluetooth.
> batman-adv (especially with the B.A.T.M.A.N. IV algo) only requires that the
> device itself can transport ethernet frames (with proper unicast and
> broadcast behavior). If you need something else then you either need a
> virtual interface which does the translation from $whatever to ethernet
> (and back) - or you need to reimplement the B.A.T.M.A.N. IV/V algorithms
> yourself.

In other words, if your radio comes up as a regular Ethernet interface in 
Linux (like WiFi, for example), then you can easily run batman-adv on top of 
it. If that's not the case, then you can write a driver to present a (virtual) 
interface to the system like Sven suggested.

Cheers,
       Simon
--nextPart5140804.hIKb1v7LjU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAmKsh0MACgkQoSvjmEKS
nqGDXA/+MRM2h8LJxvMWqJe1hWsXSHI/njOZnTQGxV+49lODzZ3QhyrmfuJLP87P
bVmdOTwzCleenBalVvtUm2WwJli2PEVKp1xeYUf6PF4b+e69sot1w1xEty/gCYYu
bge+DlaBJwEMHu/AQYlOAp2rl50gqTRNZN286w2b+WdmCVaVLTkbpHsAvuaeC76h
R7PlSzg9kVV+hc8+CiR+sdb+8xTAUCI3ATygDkFzGa+AXIjbaoc2FBpv/T/Aq0lE
2XBxauqvAlyPr3gFpEKkmuZtTDhWjkWtBtNjWC7UR+4NURurp6dU79T9b0JVD+h+
UGotBDdMmswsKoy8pus64CAebYOD9X/cqVmpQhcBwbh3NuAZtbSPXpbO9T2BPAvW
7o6FI5k5zXbao+10ZbxXv2EjrHPGoctlEUyaMxAbIxAYnr82OHNIday9+xNjUbc0
49ieUF1JiUzyvLDtKk9yBCQEExgEpaN6XnHjpMm/b4905PSEu5wlOOFp7Zd9fuM8
h9ud8JnXVg8mfV2Y9KQ4IBr9T/463+tVrMsfQvxRrJ3y2UBqjkfR2//x0NRUoksM
qV9H/q4ggV6WydkmTtdOr1Zm9DxTHLx0sj5rPH1/MSADoWTUkc3Oya3wajY2Mw64
haDpu971M3PYPVaaLqDQsMYJbXSDFOxHwEtNa7LO4yL2jtsY6B8=
=7eZX
-----END PGP SIGNATURE-----

--nextPart5140804.hIKb1v7LjU--



