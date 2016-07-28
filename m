Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 28 Jul 2016 16:13:57 +0200
Message-ID: <1997956.66WlV2qst8@sven-edge>
In-Reply-To: <CAHuRCtSLOUaV1NM6e1Gda74tMoiLKB8E3zyezoxT=8c5pV=KQg@mail.gmail.com>
References: <CAHuRCtSLOUaV1NM6e1Gda74tMoiLKB8E3zyezoxT=8c5pV=KQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2490597.I7jUsfHsxf";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] broadcast / flooding
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
Cc: jorge power <jorge@alumni.ufl.edu>

--nextPart2490597.I7jUsfHsxf
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 28. Juli 2016 09:04:24 CEST jorge power wrote:
> I am using batman (2012)

"batman (2012)"? What's that?

> Two Questions:
> 1) given that there are only two nodes , does BATMAN adv have a way to
> realize there aren't other nodes wanting to receive the broadcast and
> since the source of the broadcast is the only other batman node it
> shouldn't transmit it again?

Sounds like you are interested in the patch from Linus [1] which he send
some days ago. Maybe you can check this out and discuss it with him (mbox
for the reply is available from patchwork).

> 2) For cases of where batman is used in a more structured network
> instead of a true mesh/adhoc topology, are there parameters that could
> be used to limit re-broadcasting data received via wlan interface?

Are still talking about batman-adv here? Hm, I will just assume that.

There are currently none which can be adjusted manually. There are some people
which want to have a no-reproadcast flag [2] (which only solves their problem 
- and really only theirs and nothing else) but this was postponed until the 
original author of the patch tests a more general approach.

I also had a patch [3] which splitted the information about the number of re-
broadcasts into a "received via this interface" and "received via a different 
interface" counter for each interface. But this one didn't export the settings 
to the user. But maybe it can be used as a starting point for whatever you 
want to do.

Kind regards,
	Sven

[1] https://patchwork.open-mesh.org/patch/16569/
[2] https://patchwork.open-mesh.org/patch/4384/
[3] https://patchwork.open-mesh.org/patch/15945/
--nextPart2490597.I7jUsfHsxf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXmhMlAAoJEF2HCgfBJntGByAP+wQ+ATofANG+xHoSfpWJfVMz
cWXVwJWyKAXULqvijNXDUUvKzQXPmX67LeiD726ffJqchdbZGP7QKKCTFyINrLbF
N8vUfbe6LP53VJlPy/XFtUh9MywrNxmXxeUIJdyj6p5uOFzrendIOTudwpYnWSdH
ytUHXtX/qsSIV9DEjPVzIkwJ7mDdw9GG2N1WMmqrt3SkD0leFf0ms4eBzax719xO
VOXFpeVAkztNB6DLML6wp1RQUqimXrudxfD9Ffpwj7rttjW96e+E0bvm3GBTYuwT
QwMXjLE+bac8G+itkeicNFSKSP9vyjEGt0exJXB71+NKFCHqxTkfnQOuOgJrJyZq
VsneelaQjVw5k+5Jix9GShrftDI7ROzkCflm/obiZTsI9s7ekisnsoCezSadY48s
H3iop3g8LfkggJGVe8WiP2dne2YRmVKOLRnoGosOpCCqskMxfSjTfvFI12GJRsX1
RwFNXDVsKP/egE8urG8msfJit8v0+x6a9WmQDsqJJ/IwIyOE4cJ1i1Oud/RWs4CR
o4Kaxes48uany46oD8Nsy6F07u3/OgD2KetZZl29kQB+KJzHzyk8Goj0XbToRsT3
AyMofXRxGDkLHjoMK6kD0O7M5uqazz+2wig8jQ4E+5Eqvrit+yWQRmNPpI3QS/kN
ORMSpDTW8nkiVacYmKAb
=UDhR
-----END PGP SIGNATURE-----

--nextPart2490597.I7jUsfHsxf--

