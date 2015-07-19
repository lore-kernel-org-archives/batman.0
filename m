Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 19 Jul 2015 16:45:42 +0800
Message-ID: <3230991.6xtg0miGvl@voltaire>
In-Reply-To: <1437120223-11556-1-git-send-email-sven@narfation.org>
References: <1437120223-11556-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1578825.4X22QtQKN7";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 1/2] batman-adv: Fix conditional
	statements indentation
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


--nextPart1578825.4X22QtQKN7
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, July 17, 2015 10:03:42 Sven Eckelmann wrote:
> commit 29b9256e6631 ("batman-adv: consider outgoing interface in OGM
> sending") incorrectly indented the interface check code.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2: Change commit message to new git commit description style
> 
>  net/batman-adv/bat_iv_ogm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision a25feff.

Thanks,
Marek

--nextPart1578825.4X22QtQKN7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVq2O/AAoJEFNVTo/uthzA0RQH/05+oyCA3nZNFg065tPZ+KGo
k02yGdLXl01+wTJsMrv7tX/3Z8cB6MRsJoZU/DZeFmWX9ZaFn/tUMXIMafNCB5Ez
BC0hLB4d6bLwVvK6pX5VlVYSdkwq0NsqAz4koOkcT/a6fLXUbPuQLWeF/h4HTahh
2n6z8IDh6H0F1jWtxKv3OtuSo3z2C1ZT9KIp7k3bZY+0ddyg5GyonryUuGDx+ub/
FJL148r5dYVejMAIP+83wfxaZY1yyBmg7DdL0U0JdeQePI/J6KQJ/bZ4tysssDTE
uNRa+5uRykUg3Q0am4CPTQcsUPaLqbHw93OP57GTvgrZJ4HNrFhHmBb03dsuE4I=
=Ibk7
-----END PGP SIGNATURE-----

--nextPart1578825.4X22QtQKN7--

