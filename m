Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 16 Oct 2012 22:42:16 +0800
References: <1350396828-21016-1-git-send-email-martin@hundeboll.net>
In-Reply-To: <1350396828-21016-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201210162242.17272.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv6] batman-adv: Add wrapper to look up
	neighbor and send skb
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

On Tuesday, October 16, 2012 22:13:48 Martin Hundeb=C3=B8ll wrote:
> By adding batadv_send_skb_to_orig() in send.c, we can remove duplicate
> code that looks up the next hop and then calls batadv_send_skb_packet().
>=20
> Furthermore, this prepares the upcoming new implementation of
> fragmentation, which requires the next hop to route packets.
>=20
> Please note that this doesn't entirely remove the next-hop lookup in
> routing.c and unicast.c, since it is used by the current fragmentation
> code.
>=20
> Also note that the next-hop info is removed from debug messages in
> translation-table.c, since it is looked up elsewhere.
>=20
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
> ---
>=20
> v2: batadv_send_skb_to_orig() returns boolean and let the caller decide
> what to propagate. v3: forgot to add files before doing "git commit
> --amend". Sorry for the noise. v4: Changed the argument order of
> batadv_send_skb_to_orig()
> v5: Added kernel documentation.
> v6: Refined kernel doc.
>=20
>  routing.c           | 37 +++++++-----------------------
>  send.c              | 33 +++++++++++++++++++++++++++
>  send.h              |  3 +++
>  translation-table.c | 65
> ++++++++++++++---------------------------------------
> unicast.c           |  8 +++----
>  vis.c               | 35 ++++++++---------------------
>  6 files changed, 74 insertions(+), 107 deletions(-)

Applied in revision 7e86840.

Thanks,
Marek
