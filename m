Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Passing VID-aware ethernet frames on plain batX interfaces
Date: Fri, 11 Sep 2020 16:02:27 +0200
Message-ID: <4337705.76P5Ur0oAU@sven-edge>
In-Reply-To: <CADJ1cUQZ2YqFSVj=SNhPcC_sOjy+AkrEr=dQ=8T_0HegFou=Hw@mail.gmail.com>
References: <CADJ1cURtCsWdy6rovfgb_XPhbsTc5epCv3yLgRCLcOVjfNSFdw@mail.gmail.com> <38142483.hY40ij8To5@ripper> <CADJ1cUQZ2YqFSVj=SNhPcC_sOjy+AkrEr=dQ=8T_0HegFou=Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2823689.4OuIXJuOzZ"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Alessandro Bolletta <abolletta@netter.io>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>

 
--nextPart2823689.4OuIXJuOzZ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, 11 September 2020 15:03:13 CEST Alessandro Bolletta wrote:
> I see. Ok for transmission purposes, but what if I have to receive a tagged
> frame?

It should not have been send to the other node when there is no TT entry for 
this mac + VID from the receiver.

> Should I only rely to the 8021q interface (eg. bat0.1) or receive the whole
> traffic (untagged and tagged) from the plain bat0 interface?

Hm?

> If this is not feasible, is it possible to handle in someway this?

Hm?

> A linux
> bridge on the top of bat0 interface could make it possible?

No, the bridge must also enable the vlan for this bat0 interface.

See also
https://www.open-mesh.org/projects/batman-adv/wiki/Faq#BATMAN-Advanced-VLAN-questions

Maybe Antonio wants to add more things to this discussion.

Kind regards,
	Sven

--nextPart2823689.4OuIXJuOzZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl9bg3QACgkQXYcKB8Em
e0bddhAAzGSla8K4Z2fabst3X+L7RgPImxl6sJg49bFbGkbqYxoNZE0QO3kYufTP
AfMMt3SKUYzGSV4xeQujPTclIr9Bn3LSfNP9z6PfwVDjgdfiuKzbkL92VIVCjG8X
fdfLmdF0cLYtxG2JCsqM/cWxR55JHOS4cWJgTKDa5nr0ZxLyrFuKowAbKKVC1ZxC
jv9aw3qOO1aIW8mrBJcCgjlzLunYyaeisJ+oMhlSS1np7bqZAeFWa/32LMficNWh
Jy01he+VThTYPi4yCvkgUoxC1aYSZPxD4g6w6Ta68MFSVYpYi+YmcwCCp3t9bsE4
7SQU6ypL6dc4aUtXmHWXbtxCTYt8ZwDFHulWHhv3D09fEK5L1lRC66psh4kkMuAU
wFH7XKMKOoh1nT2MoM1LusaqCJ0cIc+DBhm8SIiDbgkN4smO8A0ccOHm2ELuoww8
PlyVZ0Pi5OPV1ZGfEkehc/MHqaOu7PGGq1BRhy7tQ2dVMNFP+BNIeewudwzMiCYP
dhyf4iVT33uEpTfLz1X0guTOIYAwxhj6TQTqBWpgkbgmS00lrROBEFZ0d6GDQmPK
VB107caPei9qDCJXufL1fUzYjeqMoQaAlBBq/8gxjszF+yOn6yV8o+mv3nb/L0IE
a1bg4FHtHviDAgx8ceNSPFpSBNNViykTK9210AhcDQ0HjZaZeco=
=4gCe
-----END PGP SIGNATURE-----

--nextPart2823689.4OuIXJuOzZ--


