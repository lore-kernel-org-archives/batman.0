Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 29 Jan 2013 23:35:04 +0800
References: <1359108763-31846-1-git-send-email-martin@hundeboll.net>
 <1359108763-31846-4-git-send-email-martin@hundeboll.net>
In-Reply-To: <1359108763-31846-4-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201301292335.04543.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 3/6] batman-adv: Buffer unicast packets
	before forward.
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

On Friday, January 25, 2013 18:12:40 Martin Hundeb=C3=B8ll wrote:
> Two be able to network code two packets, one packet must be buffered
> until the next is available. This is done in a "coding buffer", which is
> essentially a hash table with lists of packets. Each entry in the hash
> table corresponds to a specific src-dst pair, which has a linked list of
> packets that are buffered.
>=20
> This patch adds skbs to the buffer just before forwarding them. The
> buffer is traversed every 10 ms, where timed skbs are removed from the
> buffer and transmitted. To allow experiments with the network coding
> scheme, the timeout is tunable through a file in debugfs.
>=20
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
> ---
> v3:
>  * Removed unused define
>=20
>  compat.c         |  10 ++
>  compat.h         |   1 +
>  network-coding.c | 492
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++ network-coding.h
> |  10 ++
>  routing.c        |  18 +-
>  types.h          |  49 ++++++
>  6 files changed, 573 insertions(+), 7 deletions(-)

Applied in revision d287859.

Thanks,
Marek
