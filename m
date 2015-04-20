Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 20 Apr 2015 12:02:14 +0800
Message-ID: <2006787.hhLOXWT3gY@voltaire>
In-Reply-To: <1426578625-3113-1-git-send-email-sven@narfation.org>
References: <1426578625-3113-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3273047.yMnej0BVht";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Remove manual \0 terminator
	after snprintf
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


--nextPart3273047.yMnej0BVht
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, March 17, 2015 08:50:25 Sven Eckelmann wrote:
> snprintf already guarantees \0 terminated strings for size arguments is > 0.
> 
> Reported-by: Anatoliy Lapitskiy <anatoliy.lapitskiy@gmail.com>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  bisect_iv.c |  4 ----
>  debugfs.c   |  1 -
>  sys.c       | 14 +-------------
>  3 files changed, 1 insertion(+), 18 deletions(-)

Applied in revision 8c596e1.

Thanks,
Marek

--nextPart3273047.yMnej0BVht
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVNHpOAAoJEFNVTo/uthzA1rwIALo9JX7gUgCkGRVq50BJpwcm
Bn3j2vHmP/9Df1hqM/Vadd443LUAw4XbVmmTYQ0HX5o23BUMYYUYFmnuigrGqg/i
OAT4kN3wNznS3km1YtQsLYxSkB7P0HdWf+ZGBw7Hk84tusoLkLFBQufqhKLYTIlN
1WdB1otsuRvFtXkt5+F4ACQErDmYVJm5ZoZuOVQtWLzHb8IYRSa2hFW1qF5odDDA
l5+C+OsTCGOeMCwWYsHGK/n8Kf5p2dnuNE8xQcW4HNTPqbaDyfppXlA9EuS/MqYG
syh36czEp+d+E6wYHjn/khuiRrfCmG0FyMWnUl0RtcIewzOCdwZvpDXJoh4agFg=
=Lr16
-----END PGP SIGNATURE-----

--nextPart3273047.yMnej0BVht--

