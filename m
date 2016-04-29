Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 14:30:14 +0200
Message-ID: <4599793.FlyVu9cJ6b@bentobox>
In-Reply-To: <20160429122753.GC4053@lunn.ch>
References: <1461876897-12677-1-git-send-email-andrew@lunn.ch>
 <6222779.RWVmag3jgT@sven-edge> <20160429122753.GC4053@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1468852.jSmeyDgOcq";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batctl: Use netlink when available,
	rather than debugfs
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1468852.jSmeyDgOcq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 29 April 2016 14:27:53 Andrew Lunn wrote:
[...]
> > 
> > It looks like this patch currently only adds the printing of netlink 
> > information in a way that looks similar to the output from the legacy debugfs 
> > files. This is ok but I find it weird that it claims in the commit message 
> > that it uses (for everything?) netlink instead of debugfs when things like 
> > translate_mac(...) and ping/traceroute still have to be ported to netlink.
[...]

> It never makes the claim it uses it for everything. I converted what i
> needed for netns in my setup, and a bit more. I pretty much never use
> ping/traceroute/BLA, gateways, etc, in my simulations, so i have no
> itch to scratch there.
> 
> I would suggest getting the current code in a state it can be
> accepted, i.e. add the extra error checking, etc. It is mostly
> mechanical work, once you have an example to copy. So it should not be
> too hard to finish off the debugfs equivalents by somebody who has a
> need for them.

It was not about the code but about the commit message. I've already said
that the print-only implementation "is ok" and is everything we need at
the beginning.

Kind regards,
	Sven
--nextPart1468852.jSmeyDgOcq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXI1PWAAoJEF2HCgfBJntGW8IQAMurfZtv7c3D6h7HJpIDwg+q
xd7XgiZ59OwV8Q0eqQZlU9ljCINtKfV8isP0E/hhkWtRBcrCIE5VGtX4m7z2Bfy6
g2xG1cVELZpMxhc/aj4aayYyQQxauwG06WnkITrHWmrGffy2DWvyQTHb5y6Atpav
gLdptxNTO5cKwbprV0Fj7bNsALTjCMk4Kv3iYO6i0MMWrFAiLojow6RqcjFFplev
zWk13gY0C7RO5wmCzgGJ6X2pj7hpL3A/k4EO4eeGE9B1J09sl+p30X9Jlsrb6+Yk
XFrtuZxm+yxSpIShgjdWWR0UtuRJCImT5FZm5deb9kWr+Cgg8ik5e9W9abmg6W8g
mK/aHNsNAfNIlYM8flxVatk5iMU6vbOpexVQWJCS+FVbH3fGEcD5Ct4lqQCOOl2S
h0NVN/jUPkHWtdKtnamek5kK2+hz0p9VXvzrom1UgNH+us4u3VgcHriHgR1SWGPd
JIzLQGsLdm+rR7M7WMJJWgZfz6euAi1Teir4oCBbkJoDg/HQ53dhWKvbb56ql/Ms
tgx9pwo5NMyFlzi4eaLGpDZR6RQ6Dl8kEBh2vwCGZAwEwsZcWagYO4+vLf6Bn4Q3
aFuK81NUUVbh1v9xk1uWX6J3uvo5jQSMqPCvqBh3i1bHCHubJ/5fUZWfqAS/JsiN
hjVPlgOieDlZW0fHJUiJ
=h4Th
-----END PGP SIGNATURE-----

--nextPart1468852.jSmeyDgOcq--

