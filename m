Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 19 Jun 2012 11:51:50 +0200
Message-ID: <2579267.utmNKQaN8a@bentobox>
In-Reply-To: <20120619.020227.393422018169766346.davem@davemloft.net>
References: <1340090430-356-1-git-send-email-ordex@autistici.org>
	<1371147.SQlum5V1iP@bentobox>
	<20120619.020227.393422018169766346.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2371357.Ibh2nL8NgD";
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


--nextPart2371357.Ibh2nL8NgD
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 19 June 2012 02:02:27 David Miller wrote:
[....]
> Patches you want to end up in -stable should be submitted for 'net'
> not 'net-next'.
> 
> There is no other valid submission scheme.

I know that. This is also completely right and not contested by me. I did not 
submit/create the pull request and don't want to talk about that part too 
much. At least I am not very good in speaking for other people and don't want 
to create more hiccups than I already caused :)

The part that was more interesting for me is the backporting (+ submission of 
these patches) or annotation to which kernel that patch should be backported. 
The stable_kernel_rules.txt gives a nice overview about how to say which other 
patches should be cherry-picked to get this fix applied. But we could also 
have the problem with kernel version that are not obvious (since the patch 
doesn't apply directly on that version) and a backported patch is a better 
choice than cherry-picking many other things.

Is it correct as Antonio did it (submitting more than one patch, but with a 
special "# 3.x" for each one after the Cc: )?

I don't want a big discussion. Just a small hint how it is preferred (maybe 
nothing should be done and the stable committee will guess it.. for example 
the commit id that introduced the problem was missing, but could be used to 
find the affected kernels quite easily).

Thanks,
	Sven
--nextPart2371357.Ibh2nL8NgD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJP4Eu2AAoJEF2HCgfBJntGeQ0QANmmxsY97i8e/qV8bUUHTctj
UJweXNZV3e7I/x1Xr6RmMN6WRn27kxRmpVwAD+NE23bmQk6mo06FA92ipJu4RCvb
X7BehsmqwpXf1Jb7X+8EUms242SmktxfP8kdBtMnMsMpBYJLbT9cwM1mmIKReScA
KPvVUCoJ2PMD43AcEVTwmprEAm6LfmeLKSln2kJlS1HwQAGMlbMXxn1t/9YijREt
PODCWOf13mt95kBXGZUMCoIIsMU/0+PK6WgXp9/QrnZ0iBeNSPgngT+qwG20PGF9
86/7C+E4eUhHKQVpg/1deHyxz7VtGjxv0ukmY70PwpMH+DqDsA+COFalGgigO6sk
naCww9Sh3jHv5XE0V/IcydOmNcl1HIkpHgcEgbvIb8emMRcZasF1zvh09KYsDcdj
xtYk5Jenw4vMski1Uz6Uajzjc8cMKAHJZcJ7dfubMsIecnUHwc62YXAxYaPfsKmu
8x9ZGEk+QZod1q4r4Y16xncsrWVrgUGkyLztrfE8I9coNeaL5dSQT6cZYssZlDPE
b8b6y0nnAp9sI8zeTUZFtsEtxuQlFbPNQDfiIJKX4gDTggd6akIELseXtB0WB1Jf
42s3spiNh7bO7Y+/IykkwuGDCj4N2su/dI1WMC0AD9VL6rvKcQw8Y3XOx/BBi93K
aHahY4GkFaa3i7W2lYi3
=LeKC
-----END PGP SIGNATURE-----

--nextPart2371357.Ibh2nL8NgD--

