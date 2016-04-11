Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 11 Apr 2016 18:29:32 +0800
Message-ID: <2627966.FG0dHkT4cf@voltaire>
In-Reply-To: <1457190564-11419-8-git-send-email-sven@narfation.org>
References: <1457190564-11419-1-git-send-email-sven@narfation.org>
 <1457190564-11419-8-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2297581.mjlPZUE8pd";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 8/9] batman-adv: Use kref_get for
	batadv_gw_node_add
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

--nextPart2297581.mjlPZUE8pd
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, March 05, 2016 16:09:23 Sven Eckelmann wrote:
> batadv_gw_node_add requires that the caller already has a valid reference
> for orig_node. It is therefore not possible that it has an reference
> counter of 0 and was still given to this function
> 
> The kref_get function instead WARNs (with debug information) when the
> reference counter would still be 0. This makes a bug in batman-adv better
> visible because kref_get_unless_zero would have ignored this problem.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/gateway_client.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Applied in revision 25a303d.

Thanks,
Marek

--nextPart2297581.mjlPZUE8pd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXC3yMAAoJEFNVTo/uthzAYiIH/3EXZx5XGXW7s8gwDFmRbqF8
MsbyORT5j3RFqi0emll80b4nZrornpaVr6HUcxW2UjJln0i9FIY2zkp9V6775mF1
oFX8Z7P7Z9KTYLueSSAUa7K0ElFq03OP6jsDLpt2wPtVaFS57q6vt71VzhNF77UK
vFaPJJCexJKPHuFbRwBs4jaz/UjWx66bKjAclnAK+S2NeC/EQU0W2swTEEy5LQss
+H9wZ0pOmacKVtSbu3BfqBQ3juYVsLOnKtvQoGPRGOVBLBPa+juRnWrC619v/AwS
3ieosvCzFeQKWo84F29Uu9t2ONOqYwqQaVthjrxlB7/gpHXlAZItTQLGqeH2C4g=
=jEmL
-----END PGP SIGNATURE-----

--nextPart2297581.mjlPZUE8pd--

