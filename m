Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 20 Apr 2015 18:05:28 +0200
Message-ID: <31769616.xjVq0iO3v5@bentobox>
In-Reply-To: <3471641.Affe8L3RIT@voltaire>
References: <13114664.Eg4ODy7KEo@bentobox>
 <1429288461-26260-6-git-send-email-sven@narfation.org>
 <3471641.Affe8L3RIT@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1613592.BT76rtnnnz";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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
To: Marek Lindner <mareklindner@neomailbox.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <antonio@meshcoding.com>


--nextPart1613592.BT76rtnnnz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 20 April 2015 23:27:00 Marek Lindner wrote:
> On Friday, April 17, 2015 18:34:21 Sven Eckelmann wrote:
> > The patches currently in the kernel for Linux 4.1 have a different
> > variable
> > order in batadv_send_skb_unicast than the out-of-tree module. Fix the
> > order in the out-of-tree module because it is easier to get merged.
> 
> We know about this discrepancy but decided to live with it because we prefer
> the variable order you can find in the out-of-tree repos but can't imagine
> David is going to accept such a trivial patch ? In fact, we were hoping
> some other change would come along allowing us to get this into the kernel.

Ok, then maybe Antonio could try to put it in the same pull request as Markus 
Pargmann's stuff or his own cleanup patches. At least the patch would have 
some nice companions which don't look too different.

Kind regards,
	Sven
--nextPart1613592.BT76rtnnnz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVNSPMAAoJEF2HCgfBJntGtrkP/iPvxWeJNQBq6pltBRNiY4fo
sjED3aPv3vYkwMU1iS40q2X8jd6UDkRruSgNOhAPxGlFiAwSfSkO/e+yHLhfnJTu
3LiYA00V+vojFP9l26MtWhs5tOcj4w4xE3UFr9ppjFgLQ3njl/VhKRIHQbNnLoDj
TD6v5JNLHMaEgQfehvI8tBPtIMcxwDzaNcXG/AQJJacyjb6XjSlytCw6dbJbOOYL
nlpZ4qZUVPL1kHTJaEllW0JaCQcPVE7BQXKeFIKJym+ZkZuahdl/CIqWY20Idvc9
F5DI8UWDjakjoFJZY5pIfPEDmBJeBixfqGkeMBJBygf1L9DBqJIe3CSoNn10K4Uq
ld/sCqhgrWB5xbAXuXq1elGiTdSdcoNWRi//MOYjrVY6DYn5Mi7H376/68Bm1iMX
NWVv/jSfY+UKlzNtVGeqQLvQhvqNZZU7xCREIcSLQu2mqxEpT52EoAxDJImRjnhu
N64ilRbq9ee8spsKZY8QEkA2UhR3WSANU2A6EHOjE83yCCBlj9TbK7I9Kny+3dqG
gQx8FymRUlUP4dBZlO7W86ZXfzguxpVgGEQ5DHL/iGrWX9kIAH7e4jpBpSHvVPBu
300/cYjreXd6LSFjGzKee9lVSF3XMyLbq4xy99VSLNZjpV3PET5DFlGiDe6HHPNa
4r/qRXO2PHvkd86Nq0db
=xtY0
-----END PGP SIGNATURE-----

--nextPart1613592.BT76rtnnnz--

