Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 06 Jul 2011 00:27:28 +0200
Message-ID: <1640517.S3sb13Hzrx@sven-desktop.home.narfation.org>
In-Reply-To: <CAOaDhSTMPWNi+Cbv8jqumA3S1Bkpetcqqmh-SMUROOe+LUFEbg@mail.gmail.com>
References: <CAOaDhSS0-EP6bPM+2kho3h9u8aGJXsP0QmaqFMAhHa_4Y=MA4Q@mail.gmail.com>
	<CAKeC-QH0D5R2dvXJ-KEoBPCc=rmYadCzmMW1kAeBxuur+okzrw@mail.gmail.com>
	<CAOaDhSTMPWNi+Cbv8jqumA3S1Bkpetcqqmh-SMUROOe+LUFEbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2384781.taStDdVUEU";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] batctl vd dot buggy
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, Andrew Lunn <andrew@lunn.ch>
Cc: siwu@hrz.tu-chemnitz.de


--nextPart2384781.taStDdVUEU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Tuesday 05 July 2011 23:29:07 Gioacchino Mazzurco wrote:
> Good job, but what we are trying to fix is the topology visualization
> we need that at moment

Just looked with one eye at the stuff and it seems that the data which comes 
from the kernel module is not what you expect. For example 00:15:6d:fc:72:0b 
isn't marked as primary or secondary.

It looks like one vis_if_list

So you can't use the module from 2.6.38 and expect that we fix it with batctl. 
And the correct people to ask here are:
 * Simon Wunderlich (author of the vis stuff)
 * Linus Luessing (the person which added the subgraph stuff)
 * Andrew Lunn (he introduced the format "vis raw" which is used in vis_data)

I don't want to touch it because it may explode in my hand. But you can also 
try whether you are lucky and check vis_seq_print_text. It is currently overly 
complex without any reason. It could easily use seq_file and don't do the 
precalculation (which was necessary in /sys).... I forgot the topic.

Kind regards,
	Sven
--nextPart2384781.taStDdVUEU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOE4/QAAoJEF2HCgfBJntGwVkQALw0+pFkKup3skOIHH2Ems9t
PLoQHkERgAjF6GnpNxPXaABj/AbUBdXYetNEIF7GlsdSLqacxz27QqHRBwWYp7Ut
7R1/AEUNVLTZw8PNX6Nk8Jf4prBxIa9MTndOeWBKZkmPAqxmz8KHgoaniRXDx/Em
+eKMScVXFUQvLiIvGzf/UF17a3cFGqqdSvbq33zSwFYf7W4A35urN2yU19JjRE8d
FpQss5BqAbinEG9E7f5CFrSmy1/Svc52lJyHRnNKPrtGoCAYu1MyEPYSDPNvbBaM
gJj0ueyCgZFB2OtZ1jLLjn2/X4WUf6jo6RhRMXMFD90EsaMVozDyrHFWoy9Fvp+k
WiLrCwugtqx/sFe6/M568QqkNkEizMYH6K+aN9z8MO9+BInVgpQdBJ2Ly+yrzwUd
NCStsD70SOtfQn+kRxEICMZaBYMuRg0o1Mu21osawLWE0wEwhd7fbxKaLEx15uFf
CzkY/EPfQXymmH85/OG+i45ltPSNq+TOUrhR24jpzgjv/XgJp3rjyFXgIAOMMt1S
sIfxUp3pjIHFNR3Zs/9iIMxDeW/YS4KIv0dyiDGIQiVuqET9qecRJPRmbgp2PFW9
6o6xVlA/vaeA2q1/lz+gGhriNxLV/haciS5fReAhFCPKHSJcTK2AAIXDW9BZvgCC
VfeAaI3CqjiA6pVvAaVD
=DL+0
-----END PGP SIGNATURE-----

--nextPart2384781.taStDdVUEU--

