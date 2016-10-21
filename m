Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 21 Oct 2016 16:43:41 +0200
Message-ID: <1744565.jjMyA2xSBQ@bentobox>
In-Reply-To: <580A26A4.5030005@yahoo.com>
References: <580A26A4.5030005@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2017016.SqLqlF2AZ5";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] i found time delay is very high and there are
	more caution info , if possible , please give me some advisement
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: johnzeng <johnzeng2013@yahoo.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2017016.SqLqlF2AZ5
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 21. Oktober 2016 22:31:00 CEST johnzeng wrote:
[..] 
> my problem is :
> 
> when i try to ping hostB from hostA
> 
> i found time delay is very high and there are more caution info

* What means high?
* What would not be high?
* What kind of "caution" info?
* Did you try to disable offloading for your ethernet chip via ethtool?
* Are these two devices directly connected via cable or is there some
  kind of device in the middle (like a switch/firewall/...)?
* What batman-adv version are you using?
* Did you check the packets sent via eth0 on both ends with wireshark 2.x?

> because i tested between ethernet network port ( i don't test in wifi
> port ) , whether it will master reason ?

Should not be the "reason". batman-adv doesn't care much about it. It just
requires an ethernet compatible device. The re-broadcast is a little bit
less aggressive on non-wifi devices but this has nothing to do with your
problem.

Kind regards,
	Sven


--nextPart2017016.SqLqlF2AZ5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYCimdAAoJEF2HCgfBJntGdZEP/jURhd7c/sn+m6eO7DHgejrW
ZgjGzv0aqiZOQMtUbA/cRTswb0G1z6hGaMVVQWG1BNfDyHyAtpk6bn+Yv9j0gSMH
X4zXa2mNWHIN3kL1Bdl4R5bMvuW3ktOGAzEVJhTASa9i4Lfn/B8JhUCCinrMHJqS
5Fym+pFQj3Rw6pHNeHOoSwSfkhnyDRQ1annUCrQl7aqiubMpmPWnpsWROj/Adl6E
2Tp3XYF0RYpzSJp9GR03Pvs6/gNyz1EDem9jJNkxS2HC/Af6IIv0k5yIF0MBxSNK
0p14qNueZw8VHtFfLh3ZwtIUouqv7g1uIrTBdZogZ46lxdDMD58bKqj1Yckl4RAF
dRRxjQEOstOqllguVO8/et8SzYwDNzvuwXwWXysWkXuS/FOLToc1aC1xRLPKKxbg
Wl2CGDiMy2ylchE2Ne7xTNhki6AfWuSS8Q4WVJfsa7kHURJhsiMaHDZg/PdV0TGk
1/bl6uErobvnbZFEGpAaVKH2mXy4JrPRRvGZ/4VU477rW838YdOET+r47i0DevTT
HL4T19c5kYWEDg+p7vO3hZr7ilTRt0mXtbOVzr2KEsIFX2bvqfG556tB6y/sdxAo
rU6KDYZYosgADQ+IEqH2WPTFGrHv7GCN+vlu9Ed1p3QdpvvEptkyV4HZRqSbBLX0
RdRYOGd29FYJPPd2POqO
=p4HI
-----END PGP SIGNATURE-----

--nextPart2017016.SqLqlF2AZ5--

