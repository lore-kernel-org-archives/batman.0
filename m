Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 29 Jan 2013 23:33:50 +0800
References: <1359108763-31846-1-git-send-email-martin@hundeboll.net>
 <1359108763-31846-3-git-send-email-martin@hundeboll.net>
In-Reply-To: <1359108763-31846-3-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201301292333.50455.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 2/6] batman-adv: Detect coding nodes
	and remove these after timeout
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

On Friday, January 25, 2013 18:12:39 Martin Hundeb=C3=B8ll wrote:
> To use network coding efficiently, a relay must know when neighbor nodes
> are likely to have enough information to be able to decode a network
> coded packet. This is detected by using OGMs from batman-adv to discover
> when one neighbor is in range of another neighbor. The relay check the
> TLL to detect when an OGM is forwarded from one neighbor by another
> neighbor, and thereby knows that the two neighbors are in range and thus
> overhear packets sent by each other.
>=20
> This information is saved in the orig_node struct to be used when
> searching for coding opportunities. Two lists are added to the
> orig_node struct: One for neighbors that can hear the orig_node
> (outgoing nc_nodes) and one for neighbors that the orig_node can hear
> (incoming nc_nodes).
>=20
> Information about nc_nodes is kept for 10 seconds and is available
> through debugfs in batman_adv/nc_nodes to use when debugging network
> coding.
>=20
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
> ---
> v3:
>  * Fixed typos in kernel doc
> v4:
>  * Added missing kernel doc entry for struct batadv_priv_nc
>=20
>  bat_iv_ogm.c     |   5 +
>  debugfs.c        |  18 +++
>  main.h           |   2 +
>  network-coding.c | 416
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++ network-coding.h
> |  47 +++++++
>  originator.c     |   6 +
>  types.h          |  32 +++++
>  7 files changed, 526 insertions(+)

Applied in revision 3ed7ada.

Thanks,
Marek
