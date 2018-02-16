Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 16 Feb 2018 19:32:12 +0100
Message-ID: <8487269.uRpeearfos@sven-edge>
In-Reply-To: <16f5ebd27da0414cac5517460d4da8b4@DM2PR0201MB028.001f.mgd2.msft.net>
References: <16f5ebd27da0414cac5517460d4da8b4@DM2PR0201MB028.001f.mgd2.msft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5606769.AYRLmeyWyj";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Debian Testing kernel module,
 BATMAN_V not supported
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
Cc: "Fox, Fred" <Fred.Fox@ars.usda.gov>

--nextPart5606769.AYRLmeyWyj
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 16. Februar 2018 18:52:45 CET Fox, Fred wrote:
> In testing BATMAN_IV with my hardware, I noticed that as long as Node A could see Node C, it would communicate directly with it, even if the links between nodes A-B and nodes B-C had much higher throughput (tested with batctl tp). Would like to see if BATMAN_V would select the higher throughput path.

Forgot something: You can also increase the hop penalty [1] on all nodes to 
let B.A.T.M.A.N. IV know that it should prefer shorter paths (as in hop
count - not as in packet loss).

But first try to increase the multicast rate on all nodes. Also make sure that 
the wifi driver/hw is actually using the multicast rate setting. For example 
by monitoring the rate with wireshark [2] or a similar tool on a wifi monitor 
interface [3].

Kind regards,
	Sven

[1] https://www.open-mesh.org/projects/batman-adv/wiki/Tweaking#hop-penalty
[2] https://www.wireshark.org/
[3] https://wireless.wiki.kernel.org/en/users/documentation/iw#adding_interfaces_with_iw
--nextPart5606769.AYRLmeyWyj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlqHI6wACgkQXYcKB8Em
e0a/sg//XLZqz7eS2SrTxInPjye3Gg5MXJFMNmSOM53htc1DHadQ0lg35Vq2n6j7
WK3HkPTvHvuR9g+SAU3O9HeWkL84dMRw77Yv6QghcXBMOnBbRIbAV2C56tNUiNU7
jf1mbQBcZLscKMejggkZ/s2QmlyUNq9tqm+uZlzsT5rZE7e6DuEpinh5k5fRL23C
vqwapcfVgZ205ymyrefdtJVp9lODAMxuyvZ+w7uNLjBPxzGhCk6FBUuJUTuDnISy
WrG0PlFHIerkPiuSU65ErXuk+kyh8qvwKdyYJiXsrkR+4QNncHB+3MbHfSDj25Kf
/sn9o8yX+1fVytDUjW4mYg6szeu9i4m63XQWKL2sLCa/XFWiQ7QQ8rK+TuGexd0V
5R0G9IRGZSiBmcUa5jcVTqekRV1hffJ9Gh2ajbG1LrUleriqekcO38y0AjpRcB6D
qQhRLH7nWDcdnlWYaxbuMRxHTDRm29Uc/IaPMvbiLKtGGVvuN9pPQYhdm8GhUqrV
QcTKOXXMva49VukTEqT7IxjZ0CXCC7TgpU3hNPWAWbFsMbiqR7Tj+n+uP/9umaRy
gj5KX0wmNLwiGL1FlDE8U/fPFW6X7m1TKhmShB6oU1D4Rcb1fCfQrRkOwn4J44dx
Z3fXqX7n5Vs+N0jgvN5C2qOeyDe79A7E55XPdy5OoX7nW40CF7A=
=HQxG
-----END PGP SIGNATURE-----

--nextPart5606769.AYRLmeyWyj--

