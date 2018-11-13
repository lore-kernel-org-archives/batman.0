Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 13 Nov 2018 16:26:14 +0100
Message-ID: <2217702.0z5C6BKyfH@prime>
In-Reply-To: <B99A1AB9A294834C8DF94185A5E9D18101784D2AFE@NRTV96002.america.zf-world.com>
References: <B99A1AB9A294834C8DF94185A5E9D18101784CE751@NRTV96002.america.zf-world.com>
 <5197276.b4DnEGo6x7@prime>
 <B99A1AB9A294834C8DF94185A5E9D18101784D2AFE@NRTV96002.america.zf-world.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5142418.zUjExCIZgx";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] broadcast storms
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Jake.Harris@zf.com
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart5142418.zUjExCIZgx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, November 13, 2018 2:55:31 PM CET Jake.Harris@zf.com wrote:
> > Mhm, this is really not much data ... did you try the multicast as
> > suggested in an earlier reply?
> What earlier reply are you referring to? The only one I'm noticing is the
> tip to boost the multicast bandwidth, but I cannot see this being fruitful
> to update the configuration of all 50 nodes when worst-case I'm using less
> than 1% of the max throughput.

One aspect is that the multicast rate is also changing the modulation rate of 
beacons. If you have >50 nodes beaconing with 1 Mbit/s you are already filling 
up your airtime with beacons. Do the math - one beacon takes about 1ms on 1 
Mbit/s, each node sends about 10 beacons per second ...

This is actually very important and will most likely help already. It would be 
a better fix than changing the protection window.

> > BATADV_RESET_PROTECTION_MS is a define in the batman-adv C-code, so it
> > can't be set at runtime but only at compile time.
> While this sounds like an utter pain in the butt to recompile and update the
> code on all the nodes to make this change, I believe this has a far better
> chance of alleviating the issue, I'm looking into how to do this since I've
> never compiled anything myself but I can't see it being too difficult.
> 
> One observation I made when rebooting the swarm all at once, about a minute
> after all the pi's go down the laptop I work off (running batctl td bat0)
> reports a whole bunch of backbone unannounced messages I believe. I'm
> assuming there is one message per node but have not verified, my guess is
> this is normal and is not the cause of these issues?
> 
> Again, thank you


--nextPart5142418.zUjExCIZgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlvq7RYACgkQoSvjmEKS
nqFo9xAAjvN/QzAlyrBWFbUJoaQGSnABZCvK4Drzg07InfGH4x+tBmG1KXwN0b/N
vTnXkaqjBgAmb1raI6F/7ocWwb6Uk64GBNioAhCxO679q49sbc3dmCiPXRK2qKNy
90MB3qbsEySLsfpkXJNaPfQ9/cO7KMGPumn2u2OaRuy8RcwrUNkVjDUJYHv0hbrp
IWysGS3Xefnjh/0Jstpa5LRQHllAaaYIWN6mym0Q+V6M8nrHmm5A2MpE61744KA4
cPoac/GTnP02YGhmwlNjRa7276uuNEnDOGpdZ456c68bQtILe+UWm6eWtR/YQ+Np
8Wbxv89VOhevnsKO9jZQrnk/XwjkfGWxMZ0e4nnSIWoUi3Q2mfGMLYad127BG9Cd
ElsJeyoXD89kOndYggyzsirWf66NMEgXDoGx26nKHAcgiIMSzJMJYn1MLYVUGLEh
g2xZEpAWNbLGgcZut8RnWJEBAsrDSRUNXEpeD3GLFSzSv/cPlt7ooi5my56ueHIT
H7ufBmDCJa056lgVBL4zSMezrQIi3nBkkRoQsgFFMsD0CbKDzr4eibCswok1Xl21
vA/+GnhYRnSmKpF444lMsOmR5uaji1rU495ftztLyfoTvFp3Yzl2/zqJsxUT/Yyv
WWZZKB9b8OzWZvvEhp4PER1i1AcMNlCALsx6H+hABQ1141eaank=
=D5i0
-----END PGP SIGNATURE-----

--nextPart5142418.zUjExCIZgx--

