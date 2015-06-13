Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 13 Jun 2015 15:58:35 +0200
Message-ID: <7101665.y6bS5x8EtZ@sven-edge>
In-Reply-To: <CALaFpeVMwOE5DtHoDWVA+CBXq2jMuKLdmU-CcOWhCNRkHQ9F5w@mail.gmail.com>
References: <CALaFpeVMwOE5DtHoDWVA+CBXq2jMuKLdmU-CcOWhCNRkHQ9F5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1538842.NXG3eVSLPk";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] batman-adv: Force line topology
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


--nextPart1538842.NXG3eVSLPk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 12 June 2015 13:31:54 Carlos Meralto wrote:
> Hello, I am developing my thesis on mesh networks. And I'm currently
> doing some tests with batman-adv.
> So my question is:
> I need to create a line topology. For example:
> A-> B-> C-> D
> 
> Of all the options I tried, I could not find a solution to do this
> https://lists.open-mesh.org/pipermail/batman/2012-September/008019.html
> https://lists.open-mesh.org/pipermail/batman/2011-July/005169.html
> 
> I can not use the ebtables because I am using the wlan0 interface. And
> when I try to create a bridge on the interface (wlan0) gives me an
> error.
> 
> root@OpenWrt:~# batctl if del adhoc0
> root@OpenWrt:~# brctl addbr bridgeWlan
> root@OpenWrt:~# brctl addif bridgeWlan adhoc0
> brctl: bridge bridgeWlan: Operation not supported

You can patch the driver to allow this (it is just a simple check which
disallows it in most drivers... or actually in wireless core [1]). But you
should make sure that you still use the same mac addresses for vif + bridge
and don't end up with 4 address packets.

> There is already a way to force a topology in batman-adv?

No. There were only different solutions (not acceptable for the linux kernel)
which did this directly in batman-adv. A very prominent (and easy to find)
solution was from Martin [2]

The idea behind batman-adv is that it finds paths and thus automatically
creates a good virtual topologies.

> I'm blocked with no solution.
> 
> Thanks in advance.

I don't know why you want to use wlan and you also don't explain it in your
mail. You could for example also use emulation + vde2 [3] since you already
try to emulate a setup which is not there in reality.

Kind regards,
	Sven

[1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/net/wireless/core.c#n1021
[2] http://git.open-mesh.org/batman-adv.git/commit/b6b01487d43ca82a53e61b3651506082a280f422
[3] http://www.open-mesh.org/projects/open-mesh/wiki/Emulation
--nextPart1538842.NXG3eVSLPk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVfDcPAAoJEF2HCgfBJntGWAEP/jE5ih7rrnjMqo2FpwlGHFFk
GmoPmddAEICouWDAJ4iU73ShW0Y7OOgfIk6Itg5nex+sBORTeUiQ9W6/heof7YMn
I39FGlJCfDlMgjm0HlDmie55tU3AMzaK9hPIuqFxAsW5Txy9MAi2RxNwKS3A3R5i
U6qAc4Wxb8AnFCSOYRz2lI05eVx24FMv9q7htdfNFb8g1KLSOTjn2+9Xzo02e03w
cVNq3sWuWqW8f/a7V9FlgnWAiEnF1lcSIF/lu924Id1/PbNqvImpbIFdt7Pe2MUW
ClDBG7Zz/kNY+LHMjjV17rajbUGLKWyzAztf5OYRlMSUqY7MSn0I5r0ZcaYau4Y6
JJyh4iv+7cgVIfqUD7RM0R3MLcjAaexZU/iRMXqac2QLh0LN6kT/KvVOjX5nSg2w
7iw2izmP3bTNBbvWUW69xytVbFieLlwEsoSXyIyDTXX3+J2yPMBQ6t02sUuB2yO7
fyH89pybdfeiBSYl+Mxdi7mS9F2LXBja1UO03CospTgXtRvRfABqyjITp4188hsN
5fjE792m9xrSz7x6rXRBMVYXa+G3ADm5Wc6OOemwUbsWdXvHExJXW1rYXYCJL8aO
180xUHQJ2bkOcQXlg7lu2QeddToIzThJjadE41c1QqPfzme5qOHMKNbWjOIUwL36
VgE035ClnuiVECgJ+UFZ
=dUeX
-----END PGP SIGNATURE-----

--nextPart1538842.NXG3eVSLPk--

