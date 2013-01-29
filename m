Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 29 Jan 2013 23:36:10 +0800
References: <1359108763-31846-1-git-send-email-martin@hundeboll.net>
 <1359108763-31846-6-git-send-email-martin@hundeboll.net>
In-Reply-To: <1359108763-31846-6-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201301292336.10438.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 5/6] batman-adv: Save overheard and tx
	packets for decoding.
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

On Friday, January 25, 2013 18:12:42 Martin Hundeb=C3=B8ll wrote:
> To be able to decode a network coded packet, a node must already know
> one of the two coded packets. This is done by buffering skbs before
> transmission and buffering packets sniffed with promiscuous mode from
> other hosts.
>=20
> Packets are kept in a buffer similar to the one with forward-skbs: A
> hash table, where each entry, which corresponds to a src-dst pair, has a
> linked list packets.
>=20
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
> ---
> This patch depends on my previous patch on the mailing list:
> "Return reason for failure in batadv_check_unicast_packet()"
>=20
> v3:
>  * Use new return values from batadv_check_unicast_packet()
> v4:
>  * Added missing kernel doc entry for enum batadv_counters
>=20
>  network-coding.c | 208
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++- network-coding.h
> |  18 +++++
>  routing.c        |  13 +++-
>  send.c           |   5 ++
>  soft-interface.c |   1 +
>  types.h          |  11 +++
>  6 files changed, 253 insertions(+), 3 deletions(-)

Applied in revision 65aa656.

Thanks,
Marek
