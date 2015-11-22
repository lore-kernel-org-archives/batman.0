Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 22 Nov 2015 11:14:34 +0800
Message-ID: <2459891.XBGtB72ctb@voltaire>
In-Reply-To: <1448150370-27754-1-git-send-email-sven@narfation.org>
References: <1448150370-27754-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2578012.jcpvUvaMxZ";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Add missing forward
	declaration for net_device
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart2578012.jcpvUvaMxZ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, November 22, 2015 00:59:30 Sven Eckelmann wrote:
> A new function batadv_bla_status_update was introduced which uses the not
> yet defined struct net_device as parameter. Add the forward declaration to
> avoid compiler warnings about type declarations inside parameter list.
> 
> Fixes: 07ed3c31d795 ("batman-adv: purge bridge loop avoidance when its
> disabled") Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/bridge_loop_avoidance.h | 1 +
>  1 file changed, 1 insertion(+)

Applied in revision 5b0b10e.

Thanks,
Marek

--nextPart2578012.jcpvUvaMxZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWUTMaAAoJEFNVTo/uthzAZ7YIALxprMSZf2331EpvnQYgcU52
ONX9JCK51dnVqEsdNCu3XtEdvLjyozd6q6w0TP4VnCc8MToPieDbqo2y70gquhd0
JSWf+6z3bTz+otYLB5OHYvT6mdlNKBnsW7TeQXGx2lfzqOpGdNI1pjEBskDi+zAc
D+nN54kU+0lWfkdUU0Aqys/XLKhwx3jRA6F9qhwhlpw4tXJV7+UIKdam4DMpKWqN
+4dATAT3wAlBQLk1jKst3HAMcixhV0rTfcxV4k++Kiwurs9AzyhHGzGzEIJHQT2z
ftg7zJBiJUQYdumry1Ih3WlaB8ibCktW5Xu4Hnn5qrjQMxHZgPE7SJJYnLAebC0=
=z3xC
-----END PGP SIGNATURE-----

--nextPart2578012.jcpvUvaMxZ--

