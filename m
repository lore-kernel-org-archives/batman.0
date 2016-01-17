Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 17 Jan 2016 16:49:46 +0800
Message-ID: <1558643.xJ0IxEzDkq@voltaire>
In-Reply-To: <1452561325-12947-1-git-send-email-a@unstable.cc>
References: <1452561325-12947-1-git-send-email-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3971281.TBo2fR0p96";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: remove unused
	BATADV_BONDING_TQ_THRESHOLD constant
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart3971281.TBo2fR0p96
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, January 12, 2016 09:15:25 Antonio Quartulli wrote:
> BATADV_BONDING_TQ_THRESHOLD is not used anymore since the implementation
> of the bat_neigh_is_similar_or_better() API function.
> Such function uses the more generic BATADV_TQ_SIMILARITY_THRESHOLD
> constant.
> 
> Therefore, remove definition of the unused BATADV_BONDING_TQ_THRESHOLD
> constant.
> 
> Signed-off-by: Antonio Quartulli <a@unstable.cc>
> ---
>  net/batman-adv/main.h | 5 -----
>  1 file changed, 5 deletions(-)

Applied in revision 82b7d70.

Thanks,
Marek

--nextPart3971281.TBo2fR0p96
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWm1WqAAoJEFNVTo/uthzAkkUH/jhy7WoPZ7jOG5rxXI3ogyT3
XmA3D3qXDhlDbX775eJEJgEZorcbXJyuo0pMudZMJaJxMqfjgTFtu7w1lD4VGc0V
o/Oo6+Y+pv58bVNsTyzEeUic8c9Z4TQeAjnmOiN2Whf6gDmZZnD8peu1n+t53XYM
Ig3/9zN0idXAUX7/BjNrFh1kiD915ECPJ4IfEYqOKOQN0SUWnt5PKVF0IYS9+dQ9
RHAJsnFJwhRuds/xM046/0Ch2GEZmCE1dbcTfkOeAF0jyqm3BP2BnrQxjSAIOAxK
VW+vBpt7T9bqhf1rU5OLtytXmIGw/nAn1rZpTklb2zq1NogrC3P25l85mIYPtY0=
=U4Hd
-----END PGP SIGNATURE-----

--nextPart3971281.TBo2fR0p96--

