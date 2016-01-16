Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 16 Jan 2016 12:49:36 +0800
Message-ID: <2841243.SVMAKRjdP2@voltaire>
In-Reply-To: <1452781699-14539-1-git-send-email-sven@narfation.org>
References: <1451992006-13191-3-git-send-email-sven@narfation.org>
 <1452781699-14539-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11551149.QG9oFnV4o8";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 03/31] batman-adv: Avoid recursive
	call_rcu for batadv_bla_claim
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

--nextPart11551149.QG9oFnV4o8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, January 14, 2016 15:28:19 Sven Eckelmann wrote:
> The batadv_claim_free_ref function uses call_rcu to delay the free of the
> batadv_bla_claim object until no (already started) rcu_read_lock is enabled
> anymore. This makes sure that no context is still trying to access the
> object which should be removed. But batadv_bla_claim also contains a
> reference to backbone_gw which must be removed.
> 
> The reference drop of backbone_gw was done in the call_rcu function
> batadv_claim_free_rcu but should actually be done in the
> batadv_claim_release function to avoid nested call_rcus. This is important
> because rcu_barrier (e.g. batadv_softif_free or batadv_exit) will not
> detect the inner call_rcu as relevant for its execution. Otherwise this
> barrier will most likely be inserted in the queue before the callback of
> the first call_rcu was executed. The caller of rcu_barrier will therefore
> continue to run before the inner call_rcu callback finished.
> 
> Fixes: a9ce0dc43e2c ("batman-adv: add basic bridge loop avoidance code")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v5:
>  - fix commit message ("batadv_hardif_neigh_free_ref()" ->
>    "batadv_claim_free_ref()"

Applied in revision 2783bc2.

Thanks,
Marek

--nextPart11551149.QG9oFnV4o8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWmcvgAAoJEFNVTo/uthzAblMH/RnHZi5LT0xgn2DTqiPtXIUQ
+Iv9wpEA+cJCCltq/Oct1nqduDbYGqa8zeXTVOvUPMvipnrJUtiyDVDDzL9mV9+J
m9ZpNVX9QtaHLwWxAzfIVPhX3Mp5iJbU+EQKtEf8EC8WufD9N0I6FL4ydgvkS0oN
hH6rPVEINEzadmEsXoTtkUwVHoy9hjkR8Hn5xUxVMoRho5sOYF16d7a+U5BwPh0O
txOac1Hl/0RYVj/shPDt/q1LA7vtquUvK1PUbF5mYTn8SwINWKai0BkQ5yjPkurF
X+mBZFgemIwSIwP+mQKwJwVEddfFg1lcJ6Eq2SM31dALwLbISn+TnYLSzLK3mKU=
=1Wtw
-----END PGP SIGNATURE-----

--nextPart11551149.QG9oFnV4o8--

