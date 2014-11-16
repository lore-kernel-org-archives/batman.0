Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 16 Nov 2014 13:25:47 +0800
Message-ID: <1925022.mgu5EUMnux@diderot>
In-Reply-To: <1415815109-17111-2-git-send-email-sven@narfation.org>
References: <1415815109-17111-1-git-send-email-sven@narfation.org>
 <1415815109-17111-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6680742.XOmxiQtfBg";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/5] batctl: Parse only TVLV when header
	is available
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
Cc: Sven Eckelmann <sven@narfation.org>


--nextPart6680742.XOmxiQtfBg
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 12 November 2014 18:58:26 Sven Eckelmann wrote:
> The TVLV must only start parsing an header when at least one TVLV header is
> available. Otherwise data behind the received data might be accessed.
> 
> This regression was introduced by 4c39fb823b86036df40187f8bd342fe5398c28ef
> ("batctl: tcpdump - parse TVLV containers").
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  tcpdump.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied in revision e5c2e7f.

Thanks,
Marek

--nextPart6680742.XOmxiQtfBg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUaDVbAAoJEFNVTo/uthzAtDcIAMNqJZFEqtnp3gQoGYgWe7/V
2ticlRC6n7b/nI6GwKk5Wr/ux/IfnFiIDtdtLtL4zJZguo14Md8ZS7ivSw9ypYxy
SrmnC8M0V1YrmofAjA4TdvZQEA5bV9Zw2QMXnZuHjTrmwG1ZPvzkA3GUzNNh+97t
rEE0EeuooHNvmYgZmZIshSlLuT4UQpaTtSaYtP1/54PXXEO7ADVX3bxkclyd72LF
5uUrpYWlB6CJjkaI6Nn7doyXtIpWY60wPVm+F6aV3/g2zjpPaiAVBP71CO1UZvyW
DaF3KTabfBBf99Vfj1bA5OqCANLS3pJxtASYEasRmmeE/QuJFndboKN1Y8FqpL0=
=q5By
-----END PGP SIGNATURE-----

--nextPart6680742.XOmxiQtfBg--

