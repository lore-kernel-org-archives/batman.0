Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 08 Nov 2016 18:28:02 +0100
Message-ID: <2044854.g075mifYzn@bentobox>
In-Reply-To: <1478624389.17367.12.camel@edumazet-glaptop3.roam.corp.google.com>
References: <20161108164526.7518-1-sw@simonwunderlich.de>
 <20161108164526.7518-14-sw@simonwunderlich.de>
 <1478624389.17367.12.camel@edumazet-glaptop3.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart19485984.88u8rGP59H";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 13/17] batman-adv: Consume skb in receive
	handlers
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net

--nextPart19485984.88u8rGP59H
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 8. November 2016 08:59:49 CET Eric Dumazet wrote:
[...]
> > +free_skb:
> >  	consume_skb(skb);
> > -	return NET_RX_SUCCESS;
> > +
> > +	return ret;
> >  }
> 
> 
> Okay, but we do have kfree_skb() and consume_skb() and they should be
> used appropriately.

Yes, this patch is one part of reaching this goal. Some other parts are also
in this patchset. But other changes like the one you've mention here (change
some consume_skb partially back to kfree_skb) have still to be done. But
first we have to clean up the main portion of the mess :)

Kind regards,
	Sven
--nextPart19485984.88u8rGP59H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYIgsiAAoJEF2HCgfBJntGHbAP/iC8CjIcYNWBK6PORprNkgmd
DdhbpxGA/MbmA62tm1QHUnaXx3rkXD6gJIJF4WUWodg11KlO3lKXWRSBcUmXp1jE
UJVZCXI5W2ihk6O+1RSQ7qt2q6Hi2OndVy73+mHm9epPdqVkNvsQHM/MNi7xofeO
se1Nkv3EjLxg67T8b+s4DlOQDZEa5kmgRL4fXTe1xscMg+tEpAF4zrlN4uCcVOVc
/nGNQfRqNfcTATRkXYQt+7d2KCmPwlNqNVf88El/mS3f0RHT8Z8pAIkcxjGfW6Tc
ZZgY8nYBGfRUKe2+/qECaPU+3t7D8dse4tdTaRtMy2szMdonFGpooEEhrp7/Rdz4
OYaw6SD0H8XjNA09dxclD8UB6YSUYHuo2JHXdpZoyjmD3jU8cceytKpxo1OzhTz0
99VsuUzHwYQvKrLdfA42Qeoo8tI/NzO7lc7Xn30hXp9xPBn1/39rBqBet0Bfxxfq
uZ8TFOatO3tiLePfbTZK3Go0R+6UUsz/fpc6HH9hCXcaxxXLXiV5b4UjmARP/Yzq
2LZvoCIUWX2Ub0BRgvKcIunZq24XVEwabF7dRp8dfOguRRANAvoxVbvCcSYkgnNx
XHUC5iSQKw0kr0B3b2BF94mqw4B1daXqKEyWhxoUI8/1hXwUNVO8ImD5G4mWZHXA
LIZWtFlXhoevJxPZQJvg
=3YVA
-----END PGP SIGNATURE-----

--nextPart19485984.88u8rGP59H--

