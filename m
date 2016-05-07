Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 08 May 2016 06:32:22 +0800
Message-ID: <487554826.P4LepzjpBA@voltaire>
In-Reply-To: <1462607444-16656-1-git-send-email-sven@narfation.org>
References: <1462607444-16656-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2549567.jWkeoGTbZk";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Add missing include
	for batadv_v_neigh_is_sob
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

--nextPart2549567.jWkeoGTbZk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, May 07, 2016 09:50:44 Sven Eckelmann wrote:
> batadv_v_neigh_is_sob started to use false which is defined in
> linux/stddef.h.
> 
> Fixes: 036aa7b7181e ("batman-adv: Avoid nullptr derefence in
> batadv_v_neigh_is_sob") Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/bat_v.c | 1 +
>  1 file changed, 1 insertion(+)

Applied in revision 9685688.

Thanks,
Marek

--nextPart2549567.jWkeoGTbZk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXLmz2AAoJEFNVTo/uthzAM/IH/izjiFRE35sZDI4+N0ujnVRi
X1YGdoDDLUM58/8IFGBcCpanjwaZThh6b8PZXmfo+VLO5pzHsmYcXo9Cq0U9+7Rs
zhcAEDaBfa4JQ6mx+ZFE6xnp8iBgSunz6vJyZVtbu9PKN/1/HFKiqlnJ5RscYE2g
bnNt3oYtKVeHDUZMvYAIsvBdQyGbosJzY0KSd+Ed8w+5LH7nBJVrDs9VFUU2bkAu
gY4m3PKaXD0c/y6464u2CDwVaMd+vzd3KaItLvlh+aTGxt+XCKNk9qSSJ+0bTDg6
lM9kdsBKUJShQtGgXZHvDtboZFCHN8uLiwLSb7CPB5TVWjcRtoPCWAARylXQyLg=
=RsP1
-----END PGP SIGNATURE-----

--nextPart2549567.jWkeoGTbZk--

