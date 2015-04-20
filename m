Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 20 Apr 2015 23:27 +0800
Message-ID: <3471641.Affe8L3RIT@voltaire>
In-Reply-To: <1429288461-26260-6-git-send-email-sven@narfation.org>
References: <13114664.Eg4ODy7KEo@bentobox>
 <1429288461-26260-1-git-send-email-sven@narfation.org>
 <1429288461-26260-6-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1477152.0XRRnhpKXM";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-next 6/6] batman-adv: Use kernel variable
	declaration order in batadv_send_skb_unicast
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


--nextPart1477152.0XRRnhpKXM
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, April 17, 2015 18:34:21 Sven Eckelmann wrote:
> The patches currently in the kernel for Linux 4.1 have a different variable
> order in batadv_send_skb_unicast than the out-of-tree module. Fix the
> order in the out-of-tree module because it is easier to get merged.

We know about this discrepancy but decided to live with it because we prefer 
the variable order you can find in the out-of-tree repos but can't imagine 
David is going to accept such a trivial patch ? In fact, we were hoping some 
other change would come along allowing us to get this into the kernel.

Cheers,
Marek

--nextPart1477152.0XRRnhpKXM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVNRrEAAoJEFNVTo/uthzAY08IAIEEkkZONLZvIYMPWkGxGGxn
vbFmqLlF5C9Lbg8W1W+Mal80QkMw0dMoEOGmvMpq/1EoclsarWH2ajAcuauxy6l6
wkXfSiIkus7jb73nQdLPLssvzh7cNtzet88EUeYvwOtmUY/DzIapOj0cUK9qOqq6
qIl68bVa3+qCaPeSfUePe9yaglINszmobJc8GBNhmmAGG/dBHyEynHl1okHEYOmv
ovusv0siLoCMvWsWQWUvHxZg+wr6gtU9FD9k1PnDt+41BP+0QbFUvBdhJMJfmbMZ
vdy5LmrKcJ0FfaqH64UVGxnDJbR9/2rVaarYuI+kH8ksUGYpcf1Ht1Ay5M6xPRQ=
=FDPc
-----END PGP SIGNATURE-----

--nextPart1477152.0XRRnhpKXM--

