Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 12 Jun 2014 17:29:12 +0800
Message-ID: <7231419.EVfXckXZaM@diderot>
In-Reply-To: <1400939778-12886-2-git-send-email-sven@narfation.org>
References: <1400939778-12886-1-git-send-email-sven@narfation.org>
 <1400939778-12886-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5797425.4HoEBn8xdE";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/3] batctl: Free hash iterator when
	breaking out of loop
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


--nextPart5797425.4HoEBn8xdE
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 24 May 2014 15:56:17 Sven Eckelmann wrote:
> The hash iterator is automatically allocated and freed by the hash_iterate
> function. But when using break (or goto outside of loop) during the
> iteration loop, the caller has to handle the free-operation of the
> hash_iterator to avoid memory leaks.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  bisect_iv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied in revision 690d846.

Thanks,
Marek

--nextPart5797425.4HoEBn8xdE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJTmXLoAAoJEFNVTo/uthzAqU0IAMKIg6NO1Td2nF/s2ko+IIF8
wH7WCMTw+ejRz4ySXJuNKxzuvU8no//GGJjkIhSuVIQTvQO5ZZrhuyR01fD5QiOr
LPQHtIgxojurnLJk4vPuxSuBBgHBG4fsRlLtPc82X8rCP2t2MWy++BdzICmq/DXG
atSjioG9LGbICUikTbhR8kEZB/CJTrCHkwBx+CZwRr4eTgX8l7SCxmW2ep0YMx3k
gccPKSx1EEGDW41PuB++68oNjCocE8vhyCOxOR6YT1r2GraRvZtY04f6ER3WnBDX
M+8YowkaeYvadpjjNtgOh285pg0DuxgIbdFD6Pyt9I988ZBP7xK9tHeyZB1WSF0=
=zita
-----END PGP SIGNATURE-----

--nextPart5797425.4HoEBn8xdE--

