Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 06 Jun 2016 23:24:45 +0800
Message-ID: <1579809.XPBnnFdxxn@voltaire>
In-Reply-To: <1465023132-19011-1-git-send-email-sven@narfation.org>
References: <1465023132-19011-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2737814.jyjDZgA0oY";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint v3] batman-adv: Fix
	use-after-free/double-free of tt_req_node
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

--nextPart2737814.jyjDZgA0oY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, June 04, 2016 08:52:12 Sven Eckelmann wrote:
> The tt_req_node is added and removed from a list inside a spinlock. But the
> locking is sometimes removed even when the object is still referenced and
> will be used later via this reference. For example batadv_send_tt_request
> can create a new tt_req_node (including add to a list) and later
> re-acquires the lock to remove it from the list and to free it. But at this
> time another context could have already removed this tt_req_node from the
> list and freed it.
> 
> CPU#0
> 
>     batadv_batman_skb_recv from net_device 0
>     -> batadv_iv_ogm_receive
>       -> batadv_iv_ogm_process
>         -> batadv_iv_ogm_process_per_outif
>           -> batadv_tvlv_ogm_receive
>             -> batadv_tvlv_ogm_receive
>               -> batadv_tvlv_containers_process
>                 -> batadv_tvlv_call_handler
>                   -> batadv_tt_tvlv_ogm_handler_v1
>                     -> batadv_tt_update_orig
>                       -> batadv_send_tt_request
>                         -> batadv_tt_req_node_new
>                            spin_lock(...)
>                            allocates new tt_req_node and adds it to list
>                            spin_unlock(...)
>                            return tt_req_node
> 
> CPU#1
> 
>     batadv_batman_skb_recv from net_device 1
>     -> batadv_recv_unicast_tvlv
>       -> batadv_tvlv_containers_process
>         -> batadv_tvlv_call_handler
>           -> batadv_tt_tvlv_unicast_handler_v1
>             -> batadv_handle_tt_response
>                spin_lock(...)
>                tt_req_node gets removed from list and is freed
>                spin_unlock(...)
> 
> CPU#0
> 
>                       <- returned to batadv_send_tt_request
>                          spin_lock(...)
>                          tt_req_node gets removed from list and is freed
>                          MEMORY CORRUPTION/SEGFAULT/...
>                          spin_unlock(...)
> 
> This can only be solved via reference counting to allow multiple contexts
> to handle the list manipulation while making sure that only the last
> context holding a reference will free the object.
> 
> Fixes: cea194d90b11 ("batman-adv: improved client announcement mechanism")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Tested-by: Martin Weinelt <martin@darmstadt.freifunk.net>
> ---
> v3:
>  - add wrapper function batadv_tt_req_node_put for kref_put(....)
> v2:
>  - fixed list->object in commit message
>  - add example what could have gone wrong in commit message
> ---
>  net/batman-adv/translation-table.c | 37
> +++++++++++++++++++++++++++++++++----
> net/batman-adv/types.h             |  2 ++
>  2 files changed, 35 insertions(+), 4 deletions(-)

Applied in revision c3fef3d.

Thanks,
Marek

--nextPart2737814.jyjDZgA0oY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXVZW9AAoJEFNVTo/uthzA+yMH/j5LygK+qVSEZUZOiVY0Og6o
wjQOjiW1c3plpgyXLpiljX7xu6ryO36E2L0REKfL9rYb2nWwfBB1lI8Oy96Brr8P
4pxqL0M6PvMvb3MrH/Vg317AOo1wdeJcj/hDbRElwB5+DcLlk0EqHCD6nrS4c0iP
Nph72P9lFhD7bO6c9g/ltsTEVKyU1/swf1jcvScM4wWOqCWd+pmym8MGHj8ka4AA
blN3/l0PQRWLZT7lavonMU8+TL4rpDpCug81ZGrWf2whozMR+Ttw9m+DcrDxByJj
WDklZuQHyiBCdw9G3X1T0VYHwZccpxXCcKocHTTzBFqDC6O0RjIXPOaxz6v3z0U=
=2q3/
-----END PGP SIGNATURE-----

--nextPart2737814.jyjDZgA0oY--

