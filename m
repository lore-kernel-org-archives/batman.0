Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 29 Jan 2013 23:36:40 +0800
References: <1359108763-31846-1-git-send-email-martin@hundeboll.net>
 <1359108763-31846-7-git-send-email-martin@hundeboll.net>
In-Reply-To: <1359108763-31846-7-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201301292336.40952.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 6/6] batman-adv: Receive coded packets
	and decode them.
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

On Friday, January 25, 2013 18:12:43 Martin Hundeb=C3=B8ll wrote:
> When receiving a network coded packet, the decoding buffer is searched
> for a packet to use for decoding. The source, destination, and crc32 from
> the coded packet is used to identify the wanted packet. The decoded
> packet is passed to the usual unicast receiver function, as had it never
> been network coded.
>=20
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
> ---
> v3:
>  * Free nc_packet in batadv_nc_recv_coded_packet() to avoid mem-leaks
> v4:
>  * Add missing kernel doc entry for enum batadv_counters
>=20
>  network-coding.c | 234
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++ soft-interface.c
> |   4 +
>  types.h          |  10 +++
>  3 files changed, 248 insertions(+)

Applied in revision aa45b9b.

Thanks,
Marek
