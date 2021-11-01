Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH] net: batman-adv: fix warning in batadv_v_ogm_free
Date: Mon, 01 Nov 2021 08:46:16 +0100
Message-ID: <3170956.dbteMgFBTL@ripper>
In-Reply-To: <20211101040103.388646-1-mudongliangabcd@gmail.com>
References: <20211101040103.388646-1-mudongliangabcd@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4506140.dEfYWnWTC4";
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
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Dongliang Mu <mudongliangabcd@gmail.com>
Cc: Dongliang Mu <mudongliangabcd@gmail.com>, Antonio Quartulli <antonio@open-mesh.com>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

 
--nextPart4506140.dEfYWnWTC4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Dongliang Mu <mudongliangabcd@gmail.com>
Cc: Dongliang Mu <mudongliangabcd@gmail.com>, Antonio Quartulli <antonio@open-mesh.com>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: batman-adv: fix warning in batadv_v_ogm_free
Date: Mon, 01 Nov 2021 08:46:16 +0100
Message-ID: <3170956.dbteMgFBTL@ripper>
In-Reply-To: <20211101040103.388646-1-mudongliangabcd@gmail.com>
References: <20211101040103.388646-1-mudongliangabcd@gmail.com>

On Monday, 1 November 2021 05:01:02 CET Dongliang Mu wrote:
> Call Trace:
>  __cancel_work_timer+0x1c9/0x280 kernel/workqueue.c:3170
>  batadv_v_ogm_free+0x1d/0x50 net/batman-adv/bat_v_ogm.c:1076
>  batadv_mesh_free+0x35/0xa0 net/batman-adv/main.c:244
>  batadv_mesh_init+0x22a/0x240 net/batman-adv/main.c:226
>  batadv_softif_init_late+0x1ad/0x240 net/batman-adv/soft-interface.c:804
>  register_netdevice+0x15d/0x810 net/core/dev.c:10229

This is definitely not a backtrace of the current code and its error handling. 
Please check the current code [1] and explain the situation against this 
version.

Kind regards,
	Sven

[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/net/batman-adv/main.c?id=ae0393500e3b0139210749d52d22b29002c20e16#n237
--nextPart4506140.dEfYWnWTC4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmF/m0gACgkQXYcKB8Em
e0bxPRAAzrrbbgZ90XBfIGxWDbp9z/P9TzluLSCD7NVCVy2o+23bt8jEsjh762a1
ChAnSLOf7xmtDxc+EubBQOkKFqCWDeVYPo7YiZcnihY+2k4lLdMX8bWo9L5OxwA6
GiJEXk5CHEhh6BUOL1Qv6RsrCfhHowPyi7ycDWiap9g6kwVLQUsthOn0B6quPonx
1AJBfmyHwxY9nyvx0JNP7P6UQkiNzuKVhBJbZnpmAX+AzNEHB10XxyM+kMXXFh1h
JGtsLs0Zcw6yEIwxSxWY4SxBeqK3LV/+9ym/jBGs+aPjgBblYHxndlQeS0+UB52p
/eM4zdnHk2x9rqvaqeikQb3OZw1wN+y73/Xq/z5knyqxABOHQnGE8QoBah3dLiF7
5fFdJZosHvboSV+YWnx79WHzTbBxKdG0/5hHEB0nbFfYfrUzlfkS8NYOqK6aBezC
hAPms928ro8D+AA6kotEYDN41h/Z4LdWOINwBG2za8nfAquPyC4iHCc3WYm4F9w2
QIpp61jkhoawboxtnn6w1n0S3w/ZY4tKL4j/YyBDjRHVZ7g7qDLnMY+yXCkHf6cW
dMHis7OC/Enf0LSN99sbE0R/3aSUBG7m9d1HY4tYZwfYFrPl25vNXXGdPZVf+apT
RMkmifjFyrfQ1rCUpT9OL1Z8hJIQxOXmM4G+ZOG+lGqukOC+5UE=
=QUqO
-----END PGP SIGNATURE-----

--nextPart4506140.dEfYWnWTC4--


