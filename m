Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 12 Mar 2010 00:04:47 +0100
References: <1268325529-10998-1-git-send-email-linus.luessing@web.de>
	<201003112306.48652.sven.eckelmann@gmx.de>
	<201003112333.15318.sven.eckelmann@gmx.de>
In-Reply-To: <201003112333.15318.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2173886.ut4C9Vc1nd";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201003120004.48753.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fixing wrap-around bug in vis
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2173886.ut4C9Vc1nd
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Sven Eckelmann wrote:
> That must be
> #define seq_before(x,y) ((x - y) > 1 << 7 + 8 * (sizeof(x) - 1))
> #define seq_after(x,y) ((y - x) > 1 << 7 + 8 * (sizeof(x) - 1))

Nearly correct but accidentally  deleted a =

#define seq_before(x,y) ((x - y) > 1 << 7 + 8 * (sizeof(x) - 1))
#define seq_after(x,y) ((y - x) >= 1 << 7 + 8 * (sizeof(x) - 1))

Best regards,
	Sven

--nextPart2173886.ut4C9Vc1nd
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLmXcQAAoJEF2HCgfBJntGwYsQAI31EY/bdYEaZeY5Clfue7C/
sodjNXgbIQNLqExtQOXQPbDdpl7eSdRTYoWY5JlJOKjE/wzOWTWAdRsprrUq/bHe
2h9pwht2UrKtoz2/6ZBb3p2LLs6G+4/iW6ctZkdsVPSwTftrmJlnbG4Q3OZBuxE4
fLtvcDAOnf74OYn1UofnaS1pR5md9VNaAh+FjkiHGyBZaFCOgYuxL3tvJ9xJ5z7w
an3vmoTADl71WBeSm0zBsCYpbtu+F+/4Kx8+8MtqLJBeubxMggiKu/9ZkmIz2L8V
+uauWTDjIG64Vs2TKF/krmHz0uyzvbz0f1b2IH4BFxoBgyl7tA8VsFuuQJh8PqNk
bvxo6D/a5G9OZOx/cyhiwPoKj/5plIkA48DnDRiYI3VsGCb1B46I9mkIewIICA//
vqlx6F4IXL7g8luwK4hpJ2cwFwYSxfEhs1p1+ISTfqIjVbdmumXMhjRDwKlacSGm
bwLpL0R+QOYeXPDK+692Wk3Jy5nAZhTf3m+pTrKt7KXz/0WRqq9yz4Ynu6+FIePd
Zb7oH40bj5DWdFs67CHAm0EzAgHpYBw9Vug9EY3sonWdyu6PQTF7jP+totjiz5i/
pYqHr1q7Q2T/jCA2yHWfwo+nzVnoMNUvUFr1Mw+mCikivy+3+XgiZZfwC18S3cxZ
MORw/I3ctbLzyd1KhHjc
=MqQP
-----END PGP SIGNATURE-----

--nextPart2173886.ut4C9Vc1nd--
