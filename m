Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 May 2015 11:29:23 +0200
Message-ID: <4200655.6GyRK0zN7P@sven-edge>
In-Reply-To: <20150517112110.201fce11@i3.local>
References: <20150516221537.2a6fad9a@i3.local> <1941799.temDJMhclT@sven-edge>
 <20150517112110.201fce11@i3.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2167862.0ZZFCtkvq5";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Patch which fixes a uint32overflow ;
	fix algorithm which was unintented changed on 2014 update
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
To: Ruben Wisniewski <ruben@freifunk-nrw.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart2167862.0ZZFCtkvq5
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Please don't drop the mailing list when replying (unless it is actually 
private conversation).

On Sunday 17 May 2015 11:21:10 Ruben Wisniewski wrote:
> > should be included:
> Since the overflow-bug seem to be is since epoch, the patch have to be
> applied to all versions.

I am talking about the part which you described yourself as regression. But I 
agree that the overflow bug is in there since the beginning of the gateway 
code.

> But I think batman-adv 2013.x is that old that
> nobody is using it anymore or kernels with that version. So we just
> have to fix all 2014.x versions.

There is a stable branch for Linux 2.6.32.x. Linux 2.6.32 came out 2009. So it 
is possible that David Miller decides to submit the overflow patch to stable 
for 2.6.32. This is not in our jurisdiction. The same may be the case for the 
regression - but then somebody (David Miller/stable team) must know how severe 
the problem is and when it was introduced.

Kind regards,
	Sven
--nextPart2167862.0ZZFCtkvq5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVWF92AAoJEF2HCgfBJntGJHQQAKw5KogdDEp2vFEYqYe52YmT
MlDz19gB8CmCrrhano5XzOQsBq8W8Wf5j//h5++to+ZN4jELUjXSSvg4xZIcPgF5
U0o3Rwso2YXvJzeqxisXn6gqcacxUHnIFKtiMutH4RBgZt6Em1LFnzdf19PtbUsF
t+Do8T9MnbH3Kw9LdIUGtQHpjOL0s/DeouJ/a2WdZ2b6S3hfLKfGrB9fSKQS3eGX
t1RKaKcZ7n7IE6FuRl//iWhDgSqTs3OP7nRFHW/srrT96AedJOhT8pLMoxrn4YWc
EpxfBq6bSc+nAYvLMrWVfDdnmSjSg0ToWqv4UpyaSgL/JzhHHWOUmI2vUZDggDub
HsIj4pacMU0Yg46j+IFZRW/VTE6NVjzyoTWcdpD+bJwSnLxSizvqFx72I7ziSGCA
jfMXIsnqh7b4jjXs4YRkU0MBlfUyvWeD2MwS8Y0iOjltnkM/FUMGRrL4J9p2McV3
16kvq6B7eVcLHn5no0GP4FDxbSxNNkz6tcqdyiFrvqkCzSwmenzgOv+rcrWJNEQD
+Y6M7A0+UnArCu+TNTCXkaxI4UJ5hJwz767A2r9AbknGUiDzFkpF0mgKceDdblC0
8/lZaEr7mlA5Vd8c12ZVipEP3IOef2TWowN24V/zWK6q0PRvLaF6rl4JqQJGdyCX
HJHUn57pf+Q4pH8SrlCb
=Yi08
-----END PGP SIGNATURE-----

--nextPart2167862.0ZZFCtkvq5--

