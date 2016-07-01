Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 01 Jul 2016 15:54:41 +0200
Message-ID: <77232143.NV1dyT7Nfk@prime>
In-Reply-To: <1467380983-14959-1-git-send-email-sven@narfation.org>
References: <1467310294-5892-1-git-send-email-sven@narfation.org>
 <1467380983-14959-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1596529.HVDthZJ4DD";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 2/4] batman-adv: Fix non-atomic
	bla_claim::backbone_gw access
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1596529.HVDthZJ4DD
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Friday 01 July 2016 15:49:43 Sven Eckelmann wrote:
> The pointer batadv_bla_claim::backbone_gw can be changed at any time.
> Therefore, access to it must be protected to ensure that two function
> accessing the same backbone_gw are actually accessing the same. This is
> especially important when the crc_lock is used or when the backbone_gw of a
> claim is exchanged.
> 
> Not doing so leads to invalid memory access and/or reference leaks.
> 
> Fixes: a9ce0dc43e2c ("batman-adv: add basic bridge loop avoidance code")
> Fixes: b307e72d119f ("batman-adv: lock crc access in bridge loop avoidance")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Acked-by: Simon Wunderlich <sw@simonwunderlich.de>

Thanks,
     Simon
--nextPart1596529.HVDthZJ4DD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXdnYhAAoJEKEr45hCkp6hGQcQAI/h6HgHUS+kndjuntLsf3nq
UiP8df/gBC0LxIkR8apdfcrlcmdqjetq6CFTcn7e8H4dHwl6vWS1V8F9oZU3rKI2
qGeY5H5bvq44oLKPlNxRYpMkbEnBbFFRQ79TJbj0pa15rLqbZ1Y6RfKMPAHnwNvI
m+0tNC8PpBjU+PjhH9semM9NGVRZ2psvfcJALroXE+26wJSeeOnKlCVvfyvj497h
1x+OzkF7py5zALJ8tdZCtcEP4MsSA5jFJBU8azH1cw+UBCgA8RfB0fT9fmBQPqee
k2K1+85ptYlnJZz9y+Zm7uPrNc97DbFm5ceKaWY6A1Sbmhbon0GsTX4IXMBH72Om
gc5NuYezvqxxIAfqtQIVtYYnLXbaavW+2+z0RJD9BEXb9yw3/OsODjcenLGKuzak
hZqMMHs7gxZqAZ5cuGvU3LVIcpCI1Mq1jX/fTf39xkO+wbk1ZSIim9uoevC8BId3
Ndu0Q55TLRtHyWlplriiYW49ccZIFbSha9CVdDSSkAWBsPk/mE5RRwFIIdgAHrLM
VqTzBPExnFTFmVMfJ8GFKTou8m/zkiL9y7XmIkMXiPAH9rKvm9xPIg5F0iw3Pf5C
ezZXdnISPRFyqr88H0ghP+qAdnyGxxCptlI5iNDyHIzBjX21QXzMwME484nxNbi9
xd94YGXr1NMMQd9iR8Lb
=o+Xu
-----END PGP SIGNATURE-----

--nextPart1596529.HVDthZJ4DD--

