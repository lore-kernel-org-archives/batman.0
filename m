Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 24 May 2013 02:16:16 +0800
References: <1369320783-1165-1-git-send-email-martin@hundeboll.net>
 <1369320783-1165-4-git-send-email-martin@hundeboll.net>
In-Reply-To: <1369320783-1165-4-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201305240216.16514.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 3/3] batman-adv: Fragment and send skbs
	larger than mtu
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

On Thursday, May 23, 2013 22:53:03 Martin Hundeb=C3=B8ll wrote:
> Non-broadcast packets larger than MTU are fragmented and sent with
> an encapsulating header. Up to 16 fragments are supported, which are
> sent in reverse order on the wire to allow minimal memory copying when
> creating fragments.
>=20
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
> ---
>=20
> v2:
> change commit message to explain the reverse order of packets
> remove parentheses and capital letters from kernel doc
> merge return statement for batadv_frag_create()
> add spaces around *-multiplication
> add kernel doc for FRAG_TX counters and frag_seqno
>=20
> v3:
> fix the use of ETH_HLEN when creating fragments
> remove ETH_HLEN when checking whether to fragment a packet
>=20
> v4:
> changed type from int to unsigned in min_t()
> removed a few third person kernel docs
>=20
>  fragmentation.c  | 119
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> fragmentation.h  |   3 ++
>  send.c           |  21 ++++++++--
>  soft-interface.c |   7 ++++
>  types.h          |   6 +++
>  5 files changed, 152 insertions(+), 4 deletions(-)

Applied in revision db56e4e.

Thanks,
Marek
