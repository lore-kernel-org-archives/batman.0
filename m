Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 19 Jun 2012 10:07:12 +0200
Message-ID: <1371147.SQlum5V1iP@bentobox>
In-Reply-To: <20120619.004140.1665121006123027013.davem@davemloft.net>
References: <1340090430-356-1-git-send-email-ordex@autistici.org>
	<20120619.004140.1665121006123027013.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2271880.tBacEVxyqa";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix skb->data assignment
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
To: David Miller <davem@davemloft.net>
Cc: b.a.t.m.a.n@lists.open-mesh.org, stable@vger.kernel.org


--nextPart2271880.tBacEVxyqa
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 19 June 2012 00:41:40 David Miller wrote:
[....]
> You must only make stable submissions for patches that have
> made their way into Linus's tree.

That is correct. These patches were meant to be sent as reply to the patch you 
pulled today (that contained the initial Cc: stable@...). These were sent to 
avoid the cherry-pick of feature patches necessary to merge it and still give 
an idea how these versions could be fixed after the mentioned commit hit 
Linus' tree.

Somebody forgot the set the In-Reply-To:.. that made these mails missing the 
right context.

But we were wondering how to handle this situation anyway. The 
stable_kernel_rules.txt didn't gave us the correct information (or we did not 
understand them correctly) how to submit backported patches for affected 
kernels. Are there some general rules that we should be aware of?

Thanks,
	Sven
--nextPart2271880.tBacEVxyqa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJP4DMwAAoJEF2HCgfBJntGB0sP/2Zi8kBgMvsgj+BZLsS5ouPt
cjWTUPY80VBsC+IWyY7aurQtnhjbjrFLxvEOSXnCc8qEhij29zflEryTP64n3dNx
5zUd66+1TeypofXtGxV2wTC0g0Cf7iDxdlVKAj52MoZkJEKWpm52eBqxzQkfQX22
AgNNKGGcqU9XFMI2at+9+qyUneEiyZISSEyHwv2+zw9NNc4c/LJdYwSdffS+i+7E
6OSNEcxo3bW4PijaHDoGCZ2jRy2W1RcXa/h4FmzQ2E4I5obzifC3r9+eQcd/bkhS
r4Rtv4l08vgIX6Q+yP6x6fGfWFYsHVM8o+BM3cFQKuwc+FqxJsj3mf3SlI96UJz5
kKRXqbXNG4QtzF1xm4ieVJFvuSX0cferu3u2gaUKoujL9vaRWYJpCDsmTtEHNAUP
NiNcMKWg8jb44HcK5m+UCLhb7dleKlfCuv8EbL4VnULShLCqOu/CS2NFjOmsm4EX
vwQhoOBi/An6yOA+n3TyUKVVDhCUSd4z+iCWXsKbcVVJQPrHKCFP750jK+iqiy1x
pbYkFXwXt7SJLgqh+RJtvCfWavrWNfbDEn/xiWqCuG3ULUBl2KoIbUQ9v3YZT8DZ
RM95o5rsfGsgyhxeK9dE1a3qtmBge5wePyVyqhkEd+cmQWNKiKezQC9EnZU6VCd+
MmfiZ328QW5VTYazNwbt
=gVDv
-----END PGP SIGNATURE-----

--nextPart2271880.tBacEVxyqa--

