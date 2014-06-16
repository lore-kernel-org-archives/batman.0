Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 16 Jun 2014 14:14:15 +0800
Message-ID: <1768207.ba35ClYi8x@diderot>
In-Reply-To: <539E0DEF.90703@jluehr.de>
References: <539E0DEF.90703@jluehr.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2710272.vtn4Wxoqgz";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] DHCP-Monitoring of Gateways
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart2710272.vtn4Wxoqgz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"


Hi,

> we're running batman 2013.4, having multiple Gateways. For doing so,
> we'd like to monitor the availability of every dhcp-server on each Gateway.
> 
> I noticed: If DHCP-Packages (even unicast ones) that unicast
> DHCP-Requests / Discovery are unanswered, if
> -> they're sent locally on a gateway
> -> sent to a gateway not "chosen" (according to batctl gwl) by the
> monitoring host.
> 
> What's the best way of monitoring all DHCP-Servers? Is there a way to
> set up a monitoring node, that can reach all DHCP-Servers?
> If not, how can request an ip address locally?

if you don't wish batman to interfere with your DHCP requests I suggest to 
disable the gateway mode.

Cheers,
Marek

--nextPart2710272.vtn4Wxoqgz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJTnos3AAoJEFNVTo/uthzAHwwH/1d3RkQJDxk8KyIYdknDFvWS
0oZIhVY0T93jJmP1H5mcY9ui/LqLl6TQcxSwKta2cqa9ZHJpsFL8d8iRxRcMTAPf
LqU+mCgDTJkUzA3bXo60yu0WyWbxOmgYn/FKiMxrve3/oigifzmT/rng0uu2ZrTb
Qns3i+mIotHgMU83n4OXy9ikNeUA0pEEmWQOCv9Y9uUtD0PKZRKoTyED0fpANFqh
D+UXFWYYrGXAsqBV4YhakJr87pHO7fK+tz3nRthSiLfR51inB5bddByWTD6YB5ua
/phT6qI0RIYl/zSfsgmuf+faSxoJ6sotg93O/Mo2OtnAPIQC3BWdjHkYUq0VHnY=
=C7tb
-----END PGP SIGNATURE-----

--nextPart2710272.vtn4Wxoqgz--

