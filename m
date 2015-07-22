Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 22 Jul 2015 17:12:20 +0200
Message-ID: <15974886.03QyElGMEP@bentobox>
In-Reply-To: <CALaFpeUvicwHWQag0Upv5UNQ935TYY-RJuXVUtpT7gfORWZm7A@mail.gmail.com>
References: <CALaFpeUvicwHWQag0Upv5UNQ935TYY-RJuXVUtpT7gfORWZm7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1485366.DdeML3LUjN";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Recover in case of node fail
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


--nextPart1485366.DdeML3LUjN
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 22 July 2015 15:26:23 Carlos Meralto wrote:
> Hi guys,
> 
> I'm trying to make a study of various protocols for WMN and one of
> them is BATMAN. One the tests is the time to recovery in case of node
> fail.
> 
> I have a topology with 4 routers with 2 possible paths:
> A-B-C
> A-D-C
> 
> For the test i'm doing a continuous ping from A to C (level 3 ping)
> and shut down the router that forward the message (i.e B or C). In
> this test BATMAN can't recover the PING. But when i cancel the ping
> and check the Originators table (batctl o) the route is refreshed. And
> when i try to ping again it works.
> 
> Is any limitation in BATMAN for recovery in a continuous PING?

No, sounds more like you are not using batman-adv. Because
batman-adv doesn't know about the l3 stuff. It just
transfers ethernet frames from A to C. B and D are
chosen automatically for each frame (and not for a
l3/l4/... connection).

A `batctl o` does not trigger any route re-calculation.

You can use batctl ping with -R to see the hops and the
switch of the route when D fails.

Btw. if you have a setup with many dynamic changes then you
may want to reduce the originator interval on each node.

> Has anyone done this type of test and values obtained?

Yes, there is a long list of papers doing such things with
batman-adv, bmx, olsrd, babel, ...

And the fall-over worked fine in my last tests. There is
always a small time before the disappeared node is detected
by the tq metric but it is nothing breaks normal connections.

Kind regards,
	Sven
--nextPart1485366.DdeML3LUjN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVr7LXAAoJEF2HCgfBJntGRJYQALdrXp3ca8cJY0HL7PGwbnLg
h2K/nAq5UoLXCQQ4A2HQ57tjeeijc/zZF4mcQKwF9TmpRuz4crj3X2pnmE/LRsen
D1pPtKLkaRJuRaDX0uZy4YpClpQ/4Gtp/1Ejg/7bmcKU3cPSmMursn0SfX648b77
FMlscw8x8qrkasLJMSLgmfhk/UxbBU0ZgypogUcPJP4lXPu2qffWJIjX8K4sGHTx
84qyIlzu3OY4B2m/ggBRibkxJpniQMnd8HhUKW5xYLSXEv3ahIM7GuOcPjuZDosa
ov3KM/nBFiMIZjG5TDn6rESG7HmJYxpub1ukvufHDgf+lwb/20ftZ7kpJBKSocDh
4keQBSGKJPxMIdctlN/RNoMVD3ICmnk75pAoh4ahu+7mqvpmJSNg6TwCLvk5CZKq
0hrk3A5OVUhj0RVwFGYTrxSHJKsNdDP5UjaX0/DXS4pm6GwHWmc0P69OLUwh+KBX
aHRNxuGlYn1rkDWShYUmfzrILyl6UsDpCFlZGPUWLrbjHfx7ziIAKSDMBcpyBje6
bj0UikCLdCFDrb60mY5t8PkDg9dfZJQswNVq1Ju7M/wqu28stjJ8zA/mVE6qpSbW
we52f1ZJdgttIjQVmT6AgRLR5GRsioLpnLVT3GkPcVpcxYzwvPTYqexgD/MzSRvI
pBH397hjjNmIinzq1TWm
=FOG7
-----END PGP SIGNATURE-----

--nextPart1485366.DdeML3LUjN--

