Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 06 Apr 2017 09:10:38 +0200
Message-ID: <1564983.uhzQdRUYbV@bentobox>
In-Reply-To: <9309484e-a9c2-0476-3ddf-a2d68a51c58e@gmail.com>
References: <9309484e-a9c2-0476-3ddf-a2d68a51c58e@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1578093.r46Xzaip5L";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [batman-adv] Does batman-adv works perfectly?
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
Cc: Xuebing Wang <xbing6@gmail.com>

--nextPart1578093.r46Xzaip5L
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 6. April 2017 10:32:29 CEST Xuebing Wang wrote:
> Hi community,
> 
> We have batman-adv working on OpenWRT Chaos Calmer.
> - Atheros ar9331 MIPS platform + built-in ath9k WiFi
> - batman-adv version 2016.1

Please update your batman-adv version. This one is known to have problems
which can cause crashes or memory corruptions.

If you are using the Chaos Calmer packages version 2016.1-3 then you should 
already have some of the fixes (I think all fixes up to 2016.3 or so). But no 
one is updating the Chaos Calmer branch in the openwrt-routing packages feed 
anymore. And I doubt that anyone will do that now because LEDE 17.01 was 
released a while ago.

[...]
> - Wireless interface MTU = 1532, adhoc network encryption "psk2-ccmp"
[..]
> We have batman-adv running on 10+ sites. For each site, there are 10-20 
> nodes in the mesh network.
> 
> batman-adv runs almost perfectly (*almost*). Occasionally (occurrence 
> rate is low), node drops off the batman-adv / adhoc mesh.
> - Sometimes, node can recover (re-joins the mesh network automatically), 
> but not always.

This sounds like problems in the wifi stack/hw. batman-adv is not handling 
adhoc or encryption - it is simply using the links which are provided by your 
wifi stack/hardware.

Your description therefore looks more like you should fix your wifi. I don't 
know why you have low rates but the IBSS problems with enabled encryption 
could be caused by an HW issue. You should check out a workaround to refresh 
the HW key cache [1] when incoming packets cannot be decrypted anymore.

> Any suggestions? Does batman-adv works perfectly in the field (i.e. 
> running for 1 year with 100+ nodes without any issues)?

There are a lot of other components which will fail during that time. For 
example your wifi stack

> What about I use one node as Master, and other nodes ping this Master 
> every 10s (or 30 seconds) (to keep mesh from inactivity)? Does this help?

I have absolutely no idea against what this should help.

Kind regards,
	Sven

[1] https://patchwork.kernel.org/patch/9381651/
--nextPart1578093.r46Xzaip5L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAljl6e4ACgkQXYcKB8Em
e0YUfBAAtqmGlWr177fJI8MZW3Rym8sucoamrsH9MPOEHrUWlJINYEPEsPKC+/22
s+cYOj7xNJs9l/YbK0w+wFXdWOoy2zvYfkU755n3FWTQElwhC50OT8bTlxn9zgZl
/zhrhzRbVi0HktwPkhxoGbUazSY4RPqy+sYCj0YmzOZ8BRx20Y8AmU0zwKZSqLmQ
Z7p33H5sWjV/Xax0FrN7Rito594nUbwWloqcowuywUVG5wdkHCEzSosRgt9JGlSx
qFQXgHp87cA2l02L7W1nHdSNeXeJzWFaO20vZ801lbz4r96YmanUo+FMV1wSbxTR
3essjAP8HJFyovlZeB+jFdqb1nlgsw0EQs6ePNj4P94p2AMOrtF3GE+D77zg+zSc
uqVzwzRG6glqPqjgoRZz2LWyKjalZ+3XYG9Iw0shzrmncqYn20ijImlNVKfgsNJS
e6v/g16A8tWyTQmz2P11fJcwa3hBy7IwPkD9jS8Xkmyi70qnRK09h5lfO00cfaXu
qDX0rCs5xKU2hxikyVUkGWTxfruvX1PdTmIXGkrWcoLZnfriqP0gQDICxIw5hzVt
AfETo6+p5IcSZcgOjBvGZdTH1UP8MMmQtF7YrQ0ci2Up6msSpnIA/5t24q4LvWCM
DleYB1uyPqpsUtthmhaqJV1UoQTB//3JptcXVqLbr8POSUGgsdw=
=B3J3
-----END PGP SIGNATURE-----

--nextPart1578093.r46Xzaip5L--

