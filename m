Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 29 Jan 2013 23:35:39 +0800
References: <1359108763-31846-1-git-send-email-martin@hundeboll.net>
 <1359108763-31846-5-git-send-email-martin@hundeboll.net>
In-Reply-To: <1359108763-31846-5-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201301292335.40186.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 4/6] batman-adv: Code and transmit
	packets if possible.
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

On Friday, January 25, 2013 18:12:41 Martin Hundeb=C3=B8ll wrote:
> Before adding forward-skbs to the coding buffer, the buffer is searched
> for a potential coding opportunity. If one is found, the two packets are
> network coded and transmitted right away. If not, the forward-skb is
> added to the buffer.
>=20
> Network coded packets are transmitted with information about the two
> receivers and the two coded packets. The first receiver is given by the
> MAC header, while the second is given in the payload/bat-header. The
> second receiver uses promiscuous mode to receive the packet and check
> the second destination.
>=20
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
> ---
> v3:
>  * Fix header-diff in batadv_nc_code_packets()
> v4:
>  * Add missing kernel doc entry for enum batadv_counters
>=20
>  main.h           |   6 +
>  network-coding.c | 403
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> packet.h         |  33 +++++
>  soft-interface.c |   6 +
>  types.h          |  20 +++
>  5 files changed, 468 insertions(+)

Applied in revision c3289f3.

Thanks,
Marek
