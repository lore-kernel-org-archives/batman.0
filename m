Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 14 Jan 2016 15:24:47 +0100
Message-ID: <3073169.KBKbcuKg4h@prime>
In-Reply-To: <1451992006-13191-3-git-send-email-sven@narfation.org>
References: <1451992006-13191-1-git-send-email-sven@narfation.org>
 <1451992006-13191-3-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2357877.AGeLy3BuEt";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 03/31] batman-adv: Avoid recursive
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

--nextPart2357877.AGeLy3BuEt
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Tuesday 05 January 2016 12:06:18 Sven Eckelmann wrote:
> The batadv_hardif_neigh_free_ref function uses call_rcu to delay the free
> of the batadv_bla_claim object until no (already started) rcu_read_lock is
> enabled anymore. This makes sure that no context is still trying to access
> the object which should be removed. But batadv_bla_claim also contains a
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

Looks good!

Acked-by: Simon Wunderlich <sw@simonwunderlich.de>

Thanks,
     Simon
--nextPart2357877.AGeLy3BuEt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlaXr68ACgkQrzg/fFk7axbVZwCdGY+5CrNwCLcvUvcl4V4BiDG+
qZwAoKJFVePPbCiQjaDYtTBClWUO4P8v
=od82
-----END PGP SIGNATURE-----

--nextPart2357877.AGeLy3BuEt--

