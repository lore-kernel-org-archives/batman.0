Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 06 Oct 2018 08:07:07 +0200
Message-ID: <1669443.sp859k7IDk@sven-edge>
In-Reply-To: <babe56e8-b12c-8236-7012-20bb91d400fa@blastwaveinc.com>
References: <babe56e8-b12c-8236-7012-20bb91d400fa@blastwaveinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2846638.U4vq89iubD";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] B.A.T.M.A.N. port to ESP32
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

--nextPart2846638.U4vq89iubD
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 1. Oktober 2018 20:01:25 CEST John Gorkos wrote:
[...]
> From the RasPi, I am able to see the ESP32 as a neighbor, but not as an
> originator:
[...]
> Can someone explain to me why this might be occurring, and what I'm
> missing?

Looks like no one answered here. Most likely because it could be everything. 
You are comparing two different concepts here - neighbors and originators. The 
neighbor list is a rather new feature [1] (compared to the actual 
B.A.T.M.A.N. IV implementation). So a good idea would be to download the 
newest batman-adv + batctl [2] and compile it with debugging enabled [3] to 
get more insight [4].

I also don't know what kind of batctl you are using in the moment. Let us just 
assume for a moment that the bug is not in batctl (just check whether the 
newest batctl receives the same info via netlink as the file in debugfs [5]). 
Just keep in mind that both originator output methods remove some originators 
from the list when they just look "invalid" [6,7].

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/fed2826b490ce1daaf039a87a5b2a3d04b8940da
[2] https://www.open-mesh.org/projects/open-mesh/wiki/Download
[3] https://www.open-mesh.org/projects/batman-adv/wiki/Faq#Log-file-doesnt-exists-in-debugfs
[4] https://www.open-mesh.org/projects/batman-adv/wiki/Understand-your-batman-adv-network#Logging
[5] https://www.open-mesh.org/projects/batman-adv/wiki/Understand-your-batman-adv-network#originator-table
[6] https://git.open-mesh.org/batman-adv.git/blob/6f6cc4f54909127b236069207fe5691d31c29b24:/net/batman-adv/bat_iv_ogm.c#l1804
[7] https://git.open-mesh.org/batman-adv.git/blob/6f6cc4f54909127b236069207fe5691d31c29b24:/net/batman-adv/bat_iv_ogm.c#l1963
--nextPart2846638.U4vq89iubD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlu4UQsACgkQXYcKB8Em
e0Z4Kg//Ty/fhZ2Je1N/LcyVeOCuyzMv9RTxe7tF7/CvwYwBjo+3ifu/jKgdffiJ
viGaDa/TSxWon5QfXPXIGWWNbSckVx0oEaeVWz43AKbSYJ2170Wg1XsfNs1kJnab
/ZbRshSB8R+skoG8cVo8y/QCFp/hK0bMvA+E3VT1fg/5/6jGHud1Yg4HtcG7KJ3x
FkKHGZZLCopX78Zc6c5swclp6wA29BDlgAuYEh4rdhKH8m3q7Y9+wL15f7+yKEnC
eJugnPBsY7ZDEaCFPXvt2Fh4fRH5lluSNGfya3doZ6JISNZ1WW+LseaYmQucl+qR
2+E/NEy7b4eCvKl4be8WavRMDSo8m9wmD+cmum0tuywEj4dTlv3rZmaLpubnrpsR
eVlHdPLIrDdNHYAOO9jrNb2NGMo622slBm+Dkm6SttbmK1p9mbMU5A/GR3j1QdA7
IRvZ6/a3YylbDHSOr9cLblFQasC/VPLAJIQEM9Oz8By7MFFZV3wXCPO76NQEjg4/
k+SibBNJ0LCXSsZ6QA5Q9OosEj/Ae9vumsjEwaISJNyIfkOid8DzALEa2rPEApBK
jgWGAy9gFX8fFKuTqj9y4Zyet/p33NnADOxJ10VHUHKD48/LCr8kPvEcr/NFF856
Yjq3J3VQ1cKhS4+rWciZCih8Qif3k/HbLhOvNi5upNsky2ZE38Y=
=t6LB
-----END PGP SIGNATURE-----

--nextPart2846638.U4vq89iubD--



