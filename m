Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 05 Jul 2016 17:49:32 +0800
Message-ID: <4124259.vpW9uLYTxL@voltaire>
In-Reply-To: <1467536834-16185-1-git-send-email-sven@narfation.org>
References: <1467536834-16185-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1671224.9KHyXMQx2K";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3] batman-adv: iv_ogm,
	Reduce code duplication
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

--nextPart1671224.9KHyXMQx2K
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, July 03, 2016 11:07:14 Sven Eckelmann wrote:
> From: Markus Pargmann <mpa@pengutronix.de>
> 
> The difference between tq1 and tq2 are calculated the same way in two
> separate functions.
> 
> This patch moves the common code to a seperate function
> 'batadv_iv_ogm_neigh_diff' which handles everything necessary. The other
> two functions can then handle errors and use the difference directly.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> [sven@narfation.org: rebased on current version, initialize return variable
> in batadv_iv_ogm_neigh_diff, add kerneldoc, convert to bool return type]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v3:
>  - rebased on current version
>  - initialize return variable in batadv_iv_ogm_neigh_diff
>  - add kerneldoc for batadv_iv_ogm_neigh_diff
>  - convert batadv_iv_ogm_neigh_diff to bool return type
> ---
>  net/batman-adv/bat_iv_ogm.c | 77
> +++++++++++++++++++++++++++------------------ 1 file changed, 47
> insertions(+), 30 deletions(-)

Applied in revision b7232de.

Thanks,
Marek

--nextPart1671224.9KHyXMQx2K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXe4KsAAoJEFNVTo/uthzA/8MH/2f820QAlpmp06CRd2y/+b47
yI8ylVu05KGMHWp2SJVb7nghXEypfRCk2KBcSTVD/B3Fof2RZCNirz5NtSYXqEDu
mcuDFmfdgy8asrPMYT7mtJH3iRKH5CBf7G0BmC6EnTGF38hbzfBsF5fmWSJnZpzQ
2Na2ZmNY99AwF15AQVxLE9NYlYA2Cz/yPn3PKBWSYM4qYcvvl+eIxCtVlm7ZUwEI
uUbUMhnt8REa9FRNn4laGyEv6//CFkQTTjPXCteqCqsNtfqy8kWNBVbuODZFcmsA
5/jlnDBtzB1I/6tZ1KwDhZQV4uWv/TDsG0NT5nXhNXeHRbReBHgUdS1dn0H+qrs=
=EAO9
-----END PGP SIGNATURE-----

--nextPart1671224.9KHyXMQx2K--

