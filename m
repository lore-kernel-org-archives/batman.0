Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 16 Jan 2016 12:54:34 +0800
Message-ID: <1585686.f6fsVhBMXL@voltaire>
In-Reply-To: <1451992006-13191-4-git-send-email-sven@narfation.org>
References: <1451992006-13191-1-git-send-email-sven@narfation.org>
 <1451992006-13191-4-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8275267.D86HyekQtp";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 04/31] batman-adv: Avoid recursive
	call_rcu for batadv_nc_node
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

--nextPart8275267.D86HyekQtp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, January 05, 2016 12:06:19 Sven Eckelmann wrote:
> The batadv_nc_node_free_ref function uses call_rcu to delay the free of the
> batadv_nc_node object until no (already started) rcu_read_lock is enabled
> anymore. This makes sure that no context is still trying to access the
> object which should be removed. But batadv_nc_node also contains a
> reference to orig_node which must be removed.
> 
> The reference drop of orig_node was done in the call_rcu function
> batadv_nc_node_free_rcu but should actually be done in the
> batadv_nc_node_release function to avoid nested call_rcus. This is
> important because rcu_barrier (e.g. batadv_softif_free or batadv_exit) will
> not detect the inner call_rcu as relevant for its execution. Otherwise this
> barrier will most likely be inserted in the queue before the callback of
> the first call_rcu was executed. The caller of rcu_barrier will therefore
> continue to run before the inner call_rcu callback finished.
> 
> Fixes: 3ed7ada3f0bb ("batman-adv: network coding - detect coding nodes and
> remove these after timeout") Signed-off-by: Sven Eckelmann
> <sven@narfation.org>
> ---
> v4:
>  - fix function names in commit messages
>  - fix double whitespace in batadv_tt_orig_list_entry_release kerneldoc
>  - add extra patch for batadv_claim_free_ref kerneldoc fix
>  - change the phrase "free it" in all *_free_ref/*_put functions to "release
> it"

Applied in revision 3461a2e.

Thanks,
Marek

--nextPart8275267.D86HyekQtp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWmc0KAAoJEFNVTo/uthzAOuMH/A6mFtFZP/OIVyQckGK87RK5
0C4UtFNgT/cTnkrf8negx4U3hH/pUBaaXGg5VMb8fJMSFTySM4GVM3IJLFBlHApS
zZDvxV5aIeF5lY61Qa/miW3DFoMcB3JatTyaor0a4wOdnoCok72oIcSNoZLe83wn
7o7KqXNk7X2vFuxn2+sNIpomL3kamzFagX/C6A4FWzypLYexfCkzE2AyOdTwarYm
8JxnDgMMuU/Cz7QTKsTBiDeMcYqSJSEfQp/25+Yi/0BC2OQUDsajdZZ8WGdYS3Ox
1MUe+C7ipXGTC7kdv1YYpA4MbndgwXjZYxddWNQOSnZh8fp88kYZq3CiAswUFUY=
=MX2b
-----END PGP SIGNATURE-----

--nextPart8275267.D86HyekQtp--

