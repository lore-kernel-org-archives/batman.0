Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH] net: batman-adv: fix error handling
Date: Sun, 24 Oct 2021 16:58:30 +0200
Message-ID: <2526100.mKikVBQdmv@sven-l14>
In-Reply-To: <20211024131356.10699-1-paskripkin@gmail.com>
References: <2056331.oJahCzYEoq@sven-desktop>
 <20211024131356.10699-1-paskripkin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2606459.3l26UXsCK9";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, davem@davemloft.net, kuba@kernel.org, Pavel Skripkin <paskripkin@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Skripkin <paskripkin@gmail.com>, syzbot+28b0702ada0bf7381f58@syzkaller.appspotmail.com

 
--nextPart2606459.3l26UXsCK9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, davem@davemloft.net, kuba@kernel.org, Pavel Skripkin <paskripkin@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Skripkin <paskripkin@gmail.com>, syzbot+28b0702ada0bf7381f58@syzkaller.appspotmail.com
Subject: Re: [PATCH] net: batman-adv: fix error handling
Date: Sun, 24 Oct 2021 16:58:30 +0200
Message-ID: <2526100.mKikVBQdmv@sven-l14>
In-Reply-To: <20211024131356.10699-1-paskripkin@gmail.com>
References: <2056331.oJahCzYEoq@sven-desktop> <20211024131356.10699-1-paskripkin@gmail.com>

On Sunday, 24 October 2021 15:13:56 CEST Pavel Skripkin wrote:
> Syzbot reported ODEBUG warning in batadv_nc_mesh_free(). The problem was
> in wrong error handling in batadv_mesh_init().
> 
> Before this patch batadv_mesh_init() was calling batadv_mesh_free() in case
> of any batadv_*_init() calls failure. This approach may work well, when
> there is some kind of indicator, which can tell which parts of batadv are
> initialized; but there isn't any.
> 
> All written above lead to cleaning up uninitialized fields. Even if we hide
> ODEBUG warning by initializing bat_priv->nc.work, syzbot was able to hit
> GPF in batadv_nc_purge_paths(), because hash pointer in still NULL. [1]
> 
> To fix these bugs we can unwind batadv_*_init() calls one by one.
> It is good approach for 2 reasons: 1) It fixes bugs on error handling
> path 2) It improves the performance, since we won't call unneeded
> batadv_*_free() functions.
> 
> So, this patch makes all batadv_*_init() clean up all allocated memory
> before returning with an error to no call correspoing batadv_*_free()
> and open-codes batadv_mesh_free() with proper order to avoid touching
> uninitialized fields.
> 
> Link: https://lore.kernel.org/netdev/000000000000c87fbd05cef6bcb0@google.com/ [1]
> Reported-and-tested-by: syzbot+28b0702ada0bf7381f58@syzkaller.appspotmail.com
> Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>

Acked-by: Sven Eckelmann <sven@narfation.org>


Kind regards,
	Sven
--nextPart2606459.3l26UXsCK9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmF1dJYACgkQXYcKB8Em
e0bQcQ//Sla8E/Y1+ZjgSouR6oFVDORn2++Z0+TxHuzHzNw1m6/XePtcgybcRHXO
LSAFMlQjhm6s0Rb4oJx3v4RUraWQgb87EZSXReFl85xWByHHZ61at3na6e/cmgdG
BzYXkTynIb0BI4j2MVV7xE0bBDGzcdm2drlEGE/BOpughyUISpFqhv/S4Y6fPHl8
x9HyGlWZU/Iud2tIN6hkYAJFWCkFYryqh9eKQ2kE8rWugKyLiwuc71JDcFgALx1f
GjSEyBIok+m4nMOkXhx8VA9aJCVd8yzxml0Cs9Tnge+AwAA9xpR8Xl9wvfHHflM3
cKwjv8rOl4KbXuhs++I0Qsqb6IciUUCMIFzLhw89daEKVEkzTnHIWBQPaGq+87Pi
YM8LnVkUx0Bepsig5DArFIxBjVQS7tP9agvza8Skcgw46q+gcaC3QqJBfpoi1NAy
aiAWCJDMr3q6ui/R4fmMCJh7lGHveKwF91yuSOl5V1RCao7L/Ltix4+GapUYiDky
0Vg5XDy97jMJp+hcVhT1Lmd5ZbAzzbl1nQLyTeg/+aTwraLQFKOM9QfEfsR4ce4h
IgkOKVTekBJ6b7NUcgZP2CnJ2fncNm3B9AA//8mUjzFgUQV+ST5jwpue44c/y25d
sUVpC2h7rh9uH3Stc9IlECudAihLrkQLxr+L2hvMqUu+F/86yjA=
=OD+V
-----END PGP SIGNATURE-----

--nextPart2606459.3l26UXsCK9--


