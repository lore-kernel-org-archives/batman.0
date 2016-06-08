Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 08 Jun 2016 13:20:40 +0200
Message-ID: <3964079.xB3saelhBu@bentobox>
In-Reply-To: <5757ED74.2010109@tu-bs.de>
References: <5757ED74.2010109@tu-bs.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2332901.4o85RCA3He";
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
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2332901.4o85RCA3He
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 08 June 2016 12:03:32 Harms, Hannes wrote:
> 
> Hi,
> 
> I want to test the new batman V with throughput based metric, but I
> could not find out how to compile batman-adv against cfg80211 from linux 
> backports.

You cannot build against the backports modules with the batman-adv Makefile.
This is only for systems which don't replace cfg80211 with an incompatible
version. But you should have a look at the OpenWrt compile rules (especially
NOSTDINC_FLAGS [1]). It basically uses its own compat-hack header and uses
the rest from the backports compat layer + the new cfg80211 headers.

Most important here is that you don't compile against cfg80211.h of your
kernel when your backports stuff uses complete different struct definitions
(this is most likely what causes the crash on your system).

Kind regards,
	Sven 

[1] https://github.com/openwrt-routing/packages/blob/master/batman-adv/Makefile

--nextPart2332901.4o85RCA3He
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXV/+IAAoJEF2HCgfBJntGLokP/A2e551PZiBs/zTr+qjC7V20
5GVM0syi98ktJda0Re3HEECnSsocHceASfd4J1BcR6LrWpX7yylCKjreg2rYQn8f
MZEoVeW664I6dWsSK5LAxfK2+5chdP/TVMA+I7u3fnCDLnDg3ZSyvMeaDnLRzdHg
07plN1UYyYKRmtwVinrz3BVf1ivdfRLqxPjt5L9DPbkACU0UxyHMLMMVHINrowTN
O8lXEC86HF47A4sNS6kkNGCpVQK8ZJWM0AKyRAgtkqKRz0+wZtJR1kzZe3vRZlW0
lkcraxLar+jz7tAyL9QVOl1eIUPvcHKOl4Td5z4Kluoe9cUuTykPTaY0M5vAnpGr
ZaIwsrdbSv+L6hpowbUOxB6AfjH6jq1UAhvP5ow/HtCcoAoJGZkhxLpnyrWUxzHg
eCYZqlgHCzg+WRmKSPKC96EZBCKhCqSBXSpQ2yjia2V0DvS6jzLDPHNY1zbC8CQ4
NTfqKN3SQUY4GC6kJX3+hclaAc7NvmUvboU5gViLvNt13jGw5tCfFO2UdOPhPBDA
B+xezVCQcNGgjwZJksWhs0FF8IPhGUlnZtJykbtN0aKbJig6l2V953syzi66JQjE
aoVvdSicI1fXSoan4RY8r1lPo7d4Su3JCPSL2LPcLYDtUDF1t3bLLm5FymVCtmFI
2AC1VAoZFurmvnro9tmC
=aGaQ
-----END PGP SIGNATURE-----

--nextPart2332901.4o85RCA3He--

