Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 30 Aug 2018 10:17:34 +0200
Message-ID: <3703195.ExmNLY8AJ8@bentobox>
In-Reply-To: <5284774d.a8a9.16589cfe4e6.Coremail.heishuihe2008@163.com>
References: <2791173.mX5NbDZpiX@sven-edge> <1578855.qUiCBR2Cxb@sven-edge>
 <5284774d.a8a9.16589cfe4e6.Coremail.heishuihe2008@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3485037.KWd0CbytV1";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Recent test result. Re:Re: Paper "Performance
 Evaluation of BATMAN-adv Wireless Mesh Network Routing Algorithms "
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Ligang LIU <heishuihe2008@163.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart3485037.KWd0CbytV1
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 30. August 2018 15:50:27 CEST Ligang LIU wrote:
[...]
> One strange thing. Can I ignore this waring, even if I think the wifi driver is ok?
> [   30.628792] batman_adv: bat0: WiFi driver or ethtool info does not provide information about link speeds on interface wlan1, therefore defaulting to hardcoded throughput values of 1.0 Mbps. Consider overriding the throughput manually or checking your driver.
[...]

I would say that you cannot ignore it because it means that the wifi driver 
didn't provide the expected throughput for a station.

But it is most likely better to let Marek and/or Antonio answer this question.


Btw. please structure you mails better. I will not read through this 400KB+ 
text mail just to find your annotations and questions. One which I saw but 
which should be answered by a different person is "6-node case".

Kind regards,
	Sven
--nextPart3485037.KWd0CbytV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAluHqB4ACgkQXYcKB8Em
e0anrRAAj1vkn7cA0SYYuW/HyuCTBZ03QCZC8iI/Zha4PVcAiXOD82PMeSkPmeEr
IbSs+RpBbnZAG4BgiPYvW9la+PJ9gYxDqYNe8VVjklGHRtY9+irEKtIqeQIXhuHf
aZDUKFfKdb15FUQ2YnGTZMPJR9/MFyDn5v/n0Rg05ozqf3abiw4tWMYosbNeMWHs
HWI45bkaBLsEpMqiw60Mezm/6vc7JZzxacWsBXXDxA7nMPPXAMuFwswSVUT/u0WQ
ZU3kU34U9sVVptHkm1Ni+r55YchyuekHGnZcKf4FRfGCIxVoBx3muRhXcss4oxmu
9MKhmWAK6854tcL9NuY2frCBIpe7prBO4XZxDwAHsiRqFUYa8bBMy1fFmm6YqTnC
lvoq9rWxYSlKrbzc1ctbdpHVRPKExiz8kaBSZEWBA/Cno/ijIvlY9tifFXWACiNK
PtP/K60ST/KSBNSWMJ45wELukifxAo6g2eAmc+nDQPFrAJoPckD1jmk9EO4DR228
7B6brvN6NMZAt8ZoUle0z4JNpABGOCYXc0FpDtsM+l6HCjZuS+qeDqHA6JqXI+AP
UW4zS89OGeBDPZV9FaYQR4IkuO1YqQKGTY+e79OQxS25zF/lp9soBtpgd31F+NFd
BuRSulxSv24vFQjofWfeNudf1tgIe1UHQPBSNiPiqV7uwLYuQC0=
=3si5
-----END PGP SIGNATURE-----

--nextPart3485037.KWd0CbytV1--

