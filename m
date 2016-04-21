Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 21 Apr 2016 18:44:32 +0800
Message-ID: <3220028.GBF7ojiHLr@voltaire>
In-Reply-To: <1457711046-4603-2-git-send-email-sven@narfation.org>
References: <1457711046-4603-1-git-send-email-sven@narfation.org>
 <1457711046-4603-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart27571928.xi3a63gaPP";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Fix reference counting
	of hardif_neigh_node object for neigh_node
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

--nextPart27571928.xi3a63gaPP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, March 11, 2016 16:44:06 Sven Eckelmann wrote:
> The batadv_neigh_node was specific to a batadv_hardif_neigh_node and held
> an implicit reference to it. But this reference was never stored in form of
> a pointer in the batadv_neigh_node itself. Instead
> batadv_neigh_node_release depends on a consistent state of
> hard_iface->neigh_list and that batadv_hardif_neigh_get always returns the
> batadv_hardif_neigh_node object which it has a reference for. But
> batadv_hardif_neigh_get cannot guarantee that because it is working only
> with rcu_read_lock on this list. It can therefore happen that a neigh_addr
> is in this list twice or that batadv_hardif_neigh_get cannot find the
> batadv_hardif_neigh_node for an neigh_addr due to some other list
> operations taking place at the same time.
> 
> Instead add a batadv_hardif_neigh_node pointer directly in
> batadv_neigh_node which will be used for the reference counter decremented
> on release of batadv_neigh_node.
> 
> Fixes: fed2826b490c ("batman-adv: add list of unique single hop neighbors
> per hard-interface") Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> See https://www.open-mesh.org/issues/242
> 
> v1:
>  - Remove the old code blocks
>  - make the _put unconditional
> ---
>  net/batman-adv/originator.c | 16 +++++-----------
>  net/batman-adv/types.h      |  2 ++
>  2 files changed, 7 insertions(+), 11 deletions(-)

Applied in revision a198a23.

Thanks,
Marek

--nextPart27571928.xi3a63gaPP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXGK8QAAoJEFNVTo/uthzAT+QH/iqlZ8DYC8RkufKA9Dj97J75
EayVhYqWEjSsQFHd9Wqfro+euCLgvYcx6KxVqB/rCVO9x27aJdPguR8detUU7DR3
iZVdUVbRdr2sEPSRhTn98RN3H3mt383Vc645bm85hlcioJSDr1JAy+iQ5a34ds0p
rnS2GJugJoHeSLXu1XtGGSZA7jFd3gcEwNi2zQrlGSLJOGvGB1SGWAnw2pPPUUxO
orXoflElA7vV4+dpW+e/8dfl0+3DAPsxdOZptuVHtiJ7X+rISID7XKrlgsQ8EyWA
q75uY1xYmqouZAPED1fA0Ghqd4tNNpK+DiV0Ehvw29nnjWJNN6uinpI27zZarxo=
=m+KI
-----END PGP SIGNATURE-----

--nextPart27571928.xi3a63gaPP--

