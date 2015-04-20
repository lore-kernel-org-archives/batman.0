Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 20 Apr 2015 11:38:50 +0800
Message-ID: <1548954.2IfMJZdx7R@voltaire>
In-Reply-To: <1429290910-27079-1-git-send-email-sven@narfation.org>
References: <1429288461-26260-4-git-send-email-sven@narfation.org>
 <1429290910-27079-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1766691.6YvDbMDylc";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-nextv2 4/6] batman-adv: introduce
	dev_get_iflink()
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


--nextPart1766691.6YvDbMDylc
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, April 17, 2015 19:15:10 Sven Eckelmann wrote:
> From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> 
> The goal of this patch is to prepare the removal of the iflink field. It
> introduces a new ndo function, which will be implemented by virtual
> interfaces.
> 
> There is no functional change into this patch. All readers of iflink field
> now call dev_get_iflink().
> 
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> [sven@narfation.org: added compat code]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> This has to be moved to linux/netdevice.h for
> https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-April/012960.html
> 
> v2:
>  - Fix the comment in the compat code which still said "3, 19, 0"
> v3
>  - use batman-adv: prefix instead of dev:
> 
>  compat.h         | 6 ++++++
>  hard-interface.c | 5 +++--
>  2 files changed, 9 insertions(+), 2 deletions(-)

Applied in revision f8a8f60.

Thanks,
Marek

--nextPart1766691.6YvDbMDylc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVNHTKAAoJEFNVTo/uthzAg4UH/2LfutwtcqSEF4e73PGHZEpx
IH3aTmmVOTdx4S0YYDe8HkTWJfdBuZ0dKvUbUhYtVtlwb/pyG6ulGj58Q17LYb5e
J+Dn6U9NbBUvRe0nqTSVN8jPGRjo+biFTLMmUTcopzFtLpgipA1EUYSpUMO8FyMQ
leMAJtQxqqZzYTmmj1Bis//hutORquNAhD2gTaSzwC7BZa2OlJMWiu08oDzKSvqS
0kqvOHz5HKy8cUucUvYTfXpA5ukXgWrQxX2qdHt2Qol9hgJ5eniJeIg7Kn5fea12
pvNITqyR18yVJDae12+5DCzbMFGvOSnMQsj0jbIwHxNG62Aulz9gD5OQKYvWt3M=
=Jess
-----END PGP SIGNATURE-----

--nextPart1766691.6YvDbMDylc--

