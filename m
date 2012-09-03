Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 03 Sep 2012 23:24:17 +0200
Message-ID: <14643387.Jjzfh3X5qT@sven-laptop.home.narfation.org>
In-Reply-To: <1490055.1D0A7yRGtZ@sven-laptop.home.narfation.org>
References: <1346703631-17948-1-git-send-email-linus.luessing@web.de>
 <2787714.Hq4L2aOJPu@sven-laptop.home.narfation.org>
 <1490055.1D0A7yRGtZ@sven-laptop.home.narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1754233.HMN0bGJ8A1";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: make batadv_test_bit()
	return 0 or 1 only
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart1754233.HMN0bGJ8A1
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Monday 03 September 2012 23:13:41 Sven Eckelmann wrote:
[...]
> >And the both version of the variable_test_bit seem to
> > return 0 and -1 (at least my quick interpretation of the asm listings).
> 
> Just checked a asm reference and noticed that I remembered sbb wrong. The
> calculation behind it is: op2 - (op1 + CF).
> I thought that it was: op2 - op1 + CF

And I think I confused everyone right now. My original sentence should have 
said "seem to return 0 and 1" and not something about "-1".

The variable_test_bit for non-boot is implemented in asm and uses "btc" to 
check for the bit (that info is stored in CF as 0 for "not set" and 1 for 
"set"). sbb is used to store this information in the destination variable by 
substracting the original content of the variable from itself + also 
substracting the content of CF from it. That's why we get a -1 as result of 
test_bit on kvm.

Great finding and excellent patch.

Kind regards,
	Sven
--nextPart1754233.HMN0bGJ8A1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQRSABAAoJEF2HCgfBJntG/ZwQAI/NPD/7YW2VkVM2zz0YFZi7
dbl7+gk2NixCaAToW0+8y0xuq40okwERNFndsPLN1QL4F/baOwTJcItnwIYOJPge
1iivT2IJxpgyo2Jr8ZGBka0Pu2UxDbL3Yh0lrSqfwEokO3C5w1TRVwiCUGJ3klOg
1pkUG7P4/Gq3tW2W2DPeBEbvQCEci/vefr9j0PP/FxLbO7PVxoXQp0twMzgmobKl
/yCqiDeFxwsXfak8CwKyebdAo++X9+1Vb9jEP2Rb1g659iKJb/dQKyBi0Z68atRQ
zdKT1xzh9Vjkn4cZWeI4M/slsnpmo11/c2wNaW3eZnjt8QQhqQL+TbZeOH3fUK3v
9YxQKGPnYjf4T9e/WFKdbNQiMSsBSJCSPkSun/XlrB/Pv4k7Ehwxxp+nNLVkunAw
jbIH+ZMVju6c06YtkSyCtebG59+SvgsaOindyUKC9lpJamtTELXINcSJmMqBwaR9
yE9o0Ex21oHfhOStiThEKx1z9pmMbyCLrtnf2yfAEqfEac2JCEwSXfyDPO4hSwyp
SO4UqzdwTDdL1IRAfWXelYSuXxeXfAr/boLn3Cbpy1lbciK5EeOixJNudCPMgDfp
gs8PZbr8nW+PhzcNakvROTtTPn75/UEXYq8yBK0LTf4L1ybBgLxKJdcgTjCfjS8U
ptPnk7mkHUyTIIXR2VY5
=Z2v7
-----END PGP SIGNATURE-----

--nextPart1754233.HMN0bGJ8A1--

