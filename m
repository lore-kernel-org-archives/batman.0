Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: [PATCH] batman-adv: Use wifi rx/tx as fallback throughput
Date: Sun, 09 Jun 2019 19:40:24 +0800
Message-ID: <3224708.U1DPrJmi8S@rousseau>
In-Reply-To: <3378734.H6Auf9Yjlj@sven-edge>
References: <20190609101922.2366-1-treffer@measite.de>
 <3378734.H6Auf9Yjlj@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4206470.G2zM2DPCCd";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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

--nextPart4206470.G2zM2DPCCd
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, 9 June 2019 18:37:54 HKT Sven Eckelmann wrote:
> No, we are not interested in rx rate for tx throughput estimations.

Before ruling rx out, can you explain your thinking behind this magic formula 
(if smaller compute sum and divide by 6):

+               if (sinfo.filled & BIT(NL80211_STA_INFO_TX_BITRATE)) {
+                       tx = cfg80211_calculate_bitrate(&sinfo.txrate);
+                       if (sinfo.filled & BIT(NL80211_STA_INFO_RX_BITRATE)) {
+                               rx = 
cfg80211_calculate_bitrate(&sinfo.rxrate);
+                               if (rx < tx) {
+                                       return (rx + tx) / 6;
+                               }
+                       }
+                       return tx / 3;
+               }

Thanks,
Marek

--nextPart4206470.G2zM2DPCCd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAlz88CgACgkQU1VOj+62
HMA2jwf/Yl4MXQYVLBfJKjySr1BiWrYcuEwSEMQVsutREPS30bdBpgqHR/Kcrvh+
CLGguGOZ1NmcQn0Qd6wVSDasPeqoYBUXptrgFs5hXGRigJJcNeDIlgTUwJ7b6moe
9IxgqQsk66b+U5ikXsBA78kySVkHIrTBKhs0Uz8VVRfBNxt/3oFtFk1pG1ANLt4Q
GvEeFN89fARYOHet2AhOjJj6624mP3DC+ODfm4paJsPXBSkqAup7vuq84Rds8kac
ptGXRXKppOzjAhjJYf85L1vtZl/rUojrtbHqrvLsfQj8YDE06oDD3rh0nDIoDxhj
W7HHWPoyWtK6+F4eDFg3456SURA08A==
=d+Iq
-----END PGP SIGNATURE-----

--nextPart4206470.G2zM2DPCCd--



