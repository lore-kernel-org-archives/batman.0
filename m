Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 21 Nov 2013 09:26:48 +0800
Message-ID: <4479129.hAPeSrvt2c@diderot>
In-Reply-To: <1384366492-27310-4-git-send-email-sw@simonwunderlich.de>
References: <1384366492-27310-1-git-send-email-sw@simonwunderlich.de>
 <1384366492-27310-4-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4937099.xQZirJW5bV";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 3/8] batman-adv: split out router from
	orig_node
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
Cc: Simon Wunderlich <simon@open-mesh.com>


--nextPart4937099.xQZirJW5bV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 13 November 2013 19:14:47 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> For the network wide multi interface optimization there are different
> routers for each outgoing interface (outgoing from the OGM perspective,
> incoming for payload traffic). To reflect this, change the router and
> associated data to a list of routers.
> 
> While at it, rename batadv_orig_node_get_router() to
> batadv_orig_router_get() to follow the new naming scheme.
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
> Changes to PATCHv2:
>  * keep tvlv_ogm_receive() at its original place (Linus)
>  * only forward OGMs for the default interface (check removed
>    in the next patch) (Linus)
>  * add forgotten rcu_read_lock in _batadv_update_route() (Linus)
>  * add/repair kerneldoc and comments for batadv_purge_orig_ifinfo()
>    and batadv_purge_orig_node() (Linus)
>  * rename if_received -> if_outgoing (Linus)
>  * fix kerneldoc (Linus)
>  * various other style issues
> 
> Changes to PATCH:
>  * change orig_ifinfo locking from implicit rcu style to
>    refcount locking
>  * pass skb instead of buffers to the OGM processing functions
>  * remove unused tt_buff pointer from some bat_iv functions
>  * rename batadv_orig_node_ifinfo* to batadv_orig_ifinfo* - name
>    is still long enough
>  * rename batadv_orig_node_get_router to batadv_orig_router_get
>  * rename batadv_orig_node_get_ifinfo to batadv_orig_ifinfo_get
> 
> Changes to RFCv2:
>  * various style changes
>  * remove unneccesary batadv_orig_node_set_router prototype
> 
> Changes to RFC:
>  * rebase on current master
>  * remove useless goto
>  * split out batman_seqno_reset as well to avoid false seqno window
>    protections
> ---
>  bat_iv_ogm.c            |  452
> ++++++++++++++++++++++++++++------------------- distributed-arp-table.c
> |    3 +-
>  gateway_client.c        |   11 +-
>  icmp_socket.c           |    3 +-
>  network-coding.c        |    9 +-
>  originator.c            |  242 ++++++++++++++++++++++++-
>  originator.h            |   12 +-
>  routing.c               |   38 +++-
>  routing.h               |    1 +
>  translation-table.c     |    3 +-
>  types.h                 |   32 +++-
>  11 files changed, 590 insertions(+), 216 deletions(-)

Applied in revision de6bcc7.

Thanks,
Marek

--nextPart4937099.xQZirJW5bV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSjWFYAAoJEFNVTo/uthzACRcH/1l1y5JDsTu2sthWxQXTiBLS
EM+C/7DT5a4lzWmxKH9mj+6PIwh3hdusCnm6zY6WqAtPRxJohPxGdbevxUZ2422W
7qQ/1W+stiPviefm8AyKivmYt/k5q06jQuPNkQChu5E9ftkuM0dGcSEqm2smgrW7
Vu55SjfJpPrh4yULDJlMZrndqfk9BymZ5bcMOgvM0LG2SgYUhtsthnatltz0+/ns
GvtcRW+LR09K9TM02FBWG60+YePdF8yeLAw8a3hApkhTPdlUyas0bq5i8AvxUaU/
D8txwTj5z6m6oCP/kxTJP5rC6bx+QZyUSHqwnBDVm+Ys9j6luKrSaA0roawojGk=
=drBw
-----END PGP SIGNATURE-----

--nextPart4937099.xQZirJW5bV--

