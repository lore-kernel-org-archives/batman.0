Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 10 Jun 2016 10:15:32 +0200
Message-ID: <2212926.bPcQB8rWAG@bentobox>
In-Reply-To: <575972A3.8040505@tu-bs.de>
References: <5757ED74.2010109@tu-bs.de> <3964079.xB3saelhBu@bentobox>
 <575972A3.8040505@tu-bs.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart73279775.DPv1v5Zn8Y";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] How to compile BATMAN V against linux backports
	cfg80211
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "Harms, Hannes" <hannes.harms@tu-bs.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart73279775.DPv1v5Zn8Y
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 09 June 2016 15:44:03 Harms, Hannes wrote:
[...]
> But unfortunately now batctl always says that the mesh is not activated 
> (no interface),
> which is obviously wrong. Maybe  I made somewhere a mistake while 
> porting the code.
> 
> Can you guess what goes wrong?

I don't even know what code you've ported. Was it batman-adv 2016.2? Maybe you
are using an really old version and ran in an already fixed bug [1] which made
it impossible to add down interfaces and later use them in B.A.T.M.A.N. V. Or
there is something else because there is no "mesh is not activated" or "no
interface" error in batctl/batman-adv and so I have to guess what you may
have meant and what you have tried to execute.

Kind regards,
	Sven

[1] https://www.open-mesh.org/issues/248

--nextPart73279775.DPv1v5Zn8Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXWnckAAoJEF2HCgfBJntGZMUP/19cfwFCrLM2nb5WEd7jwQYM
4PvACEW1zV5kQF7TwMGmRTdwKXu4JUEJN4CXjWZxrlli3Y8wkMFHNx0v55Aa1ULn
8hpQSRoKelN7k9ERXXYf2PIS/cJHZG6DnRG/bH+0uoJqmjUeUqdLKTAMSkHDAQwP
/nJm4B80sakgdUP4G32UHBvho0tzpTWUauHWnHIqyL5t26ObOaS3hjxP9D/GJ01I
c4eSALVRWN1e8dxJESog74m54XKMkouDYBnj4xu94uGmekFGTh8PP26//N4mRHum
prfqq4z6/UjXSfAQvPxA6b9TuYG1LBCZaKS5lmaIFrTuVMikU8F8jAOnNm6s0ZcU
wPqHcNbOV7HNgLvDoUxIWfmNCkjl5Yb9gefrUO9XrUbpMX2UbMbOMD5ONEuTmeR1
oI/NyUOw4rpsoCDte7SzvsHqNdkOPU4rdVU+fGc0BUpyiQEo18jmh+VTOa/jkWyQ
N8B+m7F7BNbJovb7bwaCx46JteGhv/fd4PnU0rAxdVzhz/+BvD5pGa3Cf4vqw0UQ
ch4HQxMoyLMuiAQKvxkP6CbWI2D5n7i+qX1+riQhR3eFOsHj2hqa83B+AkMftqOD
XW2vuV3KjDCTJVFukLdrBoW/nAqvS/+nuW67f9X9iFBK32Z7A7WU/kK3AYPUCeWk
3BAG0JbSBwv/7VmRmH6H
=j5md
-----END PGP SIGNATURE-----

--nextPart73279775.DPv1v5Zn8Y--

