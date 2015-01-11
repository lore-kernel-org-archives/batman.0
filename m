Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 11 Jan 2015 13:42:19 +0100
Message-ID: <1988941.zgNWlAv4EI@sven-edge>
In-Reply-To: <8409885.k5P06c4CWh@diderot>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
 <1419594103-10928-5-git-send-email-mpa@pengutronix.de>
 <8409885.k5P06c4CWh@diderot>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1720491.r3hj2lHLtG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 04/26] batman-adv: iv_ogm,
	divide and round for ring buffer avg
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
To: Marek Lindner <mareklindner@neomailbox.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <antonio@meshcoding.com>


--nextPart1720491.r3hj2lHLtG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 11 January 2015 20:32:49 Marek Lindner wrote:
> Is DIV_ROUND_CLOSEST available in 2.6.29 ? I could not find a conclusive
> hint whether or not we need compat code for the out-of-tree module ?

It was introduced in 2.6.29 in v2.6.28-6240-g9fe0608. So you would only need 
compat code in marek/compat_old_kernel

Kind regards,
	Sven
--nextPart1720491.r3hj2lHLtG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJUsm+uAAoJEF2HCgfBJntGfy0P/2Cf1yiodWREt75SjuAmYALP
fG8I8TmVS/2EjjFItTbKDRY8dyhfrn1XOpYB5lyDDF8TjuhoOnO3x5E5XUiSckS8
F62N+jSbbfkJh01KfysqXubvVQ390U6+CO4YkA/haU/yc//o5Om3E5MLcY/bF8dV
azUHlq9iWiEQiFbjwyVVwSfPmSxabTadfVLl0pK42O6eRe/g7lQFPduIG/7dId3P
OALFeKA+i5jeCkmrorXIyx/6/k9CRU+w3LBLz41y1e5j7FPi3fd5EAUgeKHxGecX
Pj+c0tjfd1N5MAKu0nBXVf2Q/ATOK/rMtxXtWskCYD+IhsNXlt81dYRaZtmg0Czs
/uoJL8bkUdnXH+lIB1iUfE+cW3ZE3HTYRjewEwPmhkGJH6yihc5HF/8nIUjqrjSy
Wig3Zg7KwrqZOr1vHUnVQZKfrDG3hqgiZlHpPWy8IKC/XhlV2zjoLs3dC8EnSsaO
mleaesnmo5mn+9S1DKQqcpz+fU+3BC8ip+7Py8yZmlpg8/0fxAz78BzsBWtxNI5O
bW5HKsZ4dQwlUhDI9s7cYTWOg9aiswRn9Uh7gXWA8RvYxI/WBgoUlHKCzlrFlBlC
ZUs+kxRR+XYVjWsj+T1t07pgJX41mq+dWdNmhA1tdJBIA9vtpMEsYN75cNMnM4Ns
xLxTI5S27J5gLjMXz5aS
=Js3c
-----END PGP SIGNATURE-----

--nextPart1720491.r3hj2lHLtG--

