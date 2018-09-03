Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 03 Sep 2018 08:25:05 +0200
Message-ID: <3183122.uSX0CgPaFQ@bentobox>
In-Reply-To: <2246411.730f.1659d99341d.Coremail.heishuihe2008@163.com>
References: <2791173.mX5NbDZpiX@sven-edge> <3991773.ZLWj8GO7DM@bentobox>
 <2246411.730f.1659d99341d.Coremail.heishuihe2008@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4957786.098iAonMLE";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] mcast_rate setting of wifi interface has
 significant effect to performance of V. Re:Re: Recent test result. Re:Re:
 Paper "Performance Evaluation of BATMAN-adv Wireless Mesh Network Routing
 Algorithms "
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
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, a@unstable.cc, mareklindner@neomailbox.ch

--nextPart4957786.098iAonMLE
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 3. September 2018 12:03:07 CEST Ligang LIU wrote:
[...]
> I'm continuing to test in my deployment and has found an interesting thing:
> The mcast_rate setting of wifi interface has significent effect to performance of V,
> while it does not affect batman-adv IV too much.
> 
> config wifi-iface 'default_radio1'
>         option mcast_rate '18000'
>         ......
> 
> I generated the wireless configuration in web page and there is no mcast_rate setting for adhoc mode. When I noticed the line "option mcast_rate '18000'" in the batman-adv wiki page, I tried to set mcast_rate and repeated the test. I find that, with mcast_rate setting, batman-adv IV will get some performance improvement, and the performance of batman-adv V has significantly improved.

Still sounds like something is eating away airtime. Just changing the 
multicast rate here will just make more room for other frames since the 
multicast/broadcast packets take less time to get transmitted. There are other 
effects on the amount of multicast/broadcast packets which will be lost 
(interesting for B.A.T.M.A.N. IV) but I would guess that we can ignore that at 
the moment.


Did you investigate what is the problem here? Did you play around with the ELP 
interval? Did you check the RTS/CTS durations? Did you find anything else 
which eats too much airtime when you compare B.A.T.M.A.N. IV and B.A.T.M.A.N. 
V? Is the higher ELP broadcast interval (compared to B.A.T.M.A.N IV OGM 
interval) to blame here or the ELP unicast probes?

> I'm now trying to understand how the mcast_rate affects the performance of the adhoc network. If more tests can verify the importance of this setting, I so suggest that it should be highlighted for the end users of the batman-adv, especially for the new ones. For the OpenWRT system, if mcast_rate can be automatically set for the adhoc mode, or the related web page can explicitly provide a user interface  to set mcast_rate in adhoc mode, it should be more end user friendly.

Please get in touch with the OpenWrt LuCI developers [1] about the OpenWrt 
"webpage" configuration. We cannot really help you here.
 
> I hope my tests can be helpful to improve the batman-adv V and your comments and suggestions are appreciated.

Since it is not clear at the moment why it happens, we cannot do anything on 
our end.

Kind regards,
	Sven

[1] https://github.com/openwrt/luci/
    http://luci.subsignal.org/trac
--nextPart4957786.098iAonMLE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAluM08EACgkQXYcKB8Em
e0aCFQ//XNcjWW+fhvZdUAZ3tgrawdswtRG7faiu2KpDGboIrmJ7TE9kMdKAT6Qt
2IcBF8EPi3fDv0PpPh80BGlYLiRRP+gY7pldvVQKtdAmJruQ7HJV+7Oay3BuOuCJ
jn3A8zPe0MR2NRmLzJzChu6SBiW4cP9MlDvd9pybk+UIXu6kOoNj0CFj+Uou4R/N
Nho2DfsavrH05Ggzu4GbQMEs6/DCNDAW8Nx8R3QAKV/kf1XMCQUT/I+8CTbCpEIB
szzXSJEYDpuuie9hLOA9d6Cq2KLEKB+JA+UTpkskUU/j+LX3XmsZXS7UGvm6VhJ6
a3V1MOFnojfPorMiR4d+T59ZRLqoEy9p7yuTKBAD9/4e0gFbazicV7AElI5hll7D
qbCq/igpL0KE+0sI8k2W1ZasytI0rr68HdZr5RBANhg9dczkJwWkIzDVt72KR8fG
B3agKMm9a4m7gu9vvPNq1ktB+d4pm8CRJBt/t5uGvV2qWxA1nN6JCMKBhKexb3Jz
DXPri+z6SYFU7LgZtNMsqR7yDMa7dNc89NcFbmCzTNAd9Mse2MwS86fQn/1QbcOR
LtYUFBYC5hrdMD/qLGdU67Misml5RFj0XwxcbxpL0H1TYNQhY7KralPQS0FUfcQ6
NkYxwDw0oh5zoLZtxHIqY2WS1GJLc06BhXG70cm5a+92KGGPjVk=
=8bky
-----END PGP SIGNATURE-----

--nextPart4957786.098iAonMLE--

