Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 24 May 2013 01:12:27 +0800
References: <1369320783-1165-1-git-send-email-martin@hundeboll.net>
 <1369320783-1165-3-git-send-email-martin@hundeboll.net>
In-Reply-To: <1369320783-1165-3-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201305240112.27902.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 2/3] batman-adv: Receive fragmented
	packets and merge
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
Cc: Martin =?utf-8?q?Hundeb=C3=B8ll?= <martin@hundeboll.net>

On Thursday, May 23, 2013 22:53:02 Martin Hundeb=C3=B8ll wrote:
> Fragments arriving at their destination are buffered for later merge.
> Merged packets are passed to the main receive function as had they never
> been fragmented.
>=20
> Fragments are forwarded without merging if the MTU of the outgoing
> interface is smaller than the size of the merged packet.
>=20
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
> ---
>=20
> v2:
> update copyright years
> remove () and uppercase beginnings from kernel doc
> use hlist_for_entry_safe() in batadv_frag_clear_list()
> merge batadv_frag_clear_orig() and batadv_frag_check_orig()
> update some kernel doc with return values
> remove "inline" from static function in .c file
> rename lists of fragments to "chain"
> remove type in kernel doc
> remove initialization from "curr" and "new" in insert_packet()
> rename "curr" and "new" to "frag_entry_{curr,new}"
> rename packet to frag_packet
> change return description in kernel doc for batadv_frag_merge_packets()
> fix return value on failure in pskb_expand_head() in merge_packets()
> add kernel doc for counters in types.h
>=20
> v3:
> added blank lines to int batadv_frag_size_limit()
> added comment to explain linearization of received fragments
> removed ETH_HLEN in counters for received fragments
>=20
> v4:
> remove ETH_HLEN from size check in batadv_frag_skb_fwd()
> don't third person in kernel doc
> correct some kernel doc leftovers from namechange to "chains"
>=20
>  Makefile.kbuild  |   1 +
>  fragmentation.c  | 366
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> fragmentation.h  |  47 +++++++
>  main.c           |   4 +
>  main.h           |   9 ++
>  originator.c     |  14 ++-
>  packet.h         |  27 ++++
>  routing.c        |  59 +++++++++
>  routing.h        |   2 +
>  soft-interface.c |   4 +
>  types.h          |  38 ++++++
>  11 files changed, 570 insertions(+), 1 deletion(-)
>  create mode 100644 fragmentation.c
>  create mode 100644 fragmentation.h

Applied in revision 9b3eab6.

Thanks,
Marek
