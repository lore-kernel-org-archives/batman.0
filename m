Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 29 Jan 2013 23:33:23 +0800
References: <1359108763-31846-1-git-send-email-martin@hundeboll.net>
 <1359108763-31846-2-git-send-email-martin@hundeboll.net>
In-Reply-To: <1359108763-31846-2-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201301292333.23541.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 1/6] batman-adv: Add the initial code
	for network coding.
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

On Friday, January 25, 2013 18:12:38 Martin Hundeb=C3=B8ll wrote:
> Network coding exploits the 802.11 shared medium to allow multiple
> packets to be sent in a single transmission. In brief, a relay can XOR
> two packets, and send the coded packet to two destinations. The
> receivers can decode one of the original packets by XOR'ing the coded
> packet with the other original packet. This will lead to increased
> throughput in topologies where two packets cross one relay.
>=20
> In a simple topology with three nodes, it takes four transmissions
> without network coding to get one packet from Node A to Node B and one
> from Node B to Node A:
>=20
>  1.  Node A  ---- p1 --->  Node R                Node B
>  2.  Node A                Node R  <--- p2 ----  Node B
>  3.  Node A  <--- p2 ----  Node R                Node B
>  4.  Node A                Node R  ---- p1 --->  Node B
>=20
> With network coding, the relay only needs one transmission, which saves
> us one slot of valuable airtime:
>=20
>  1.  Node A  ---- p1 --->  Node R                Node B
>  2.  Node A                Node R  <--- p2 ----  Node B
>  3.  Node A  <- p1 x p2 -  Node R  - p1 x p2 ->  Node B
>=20
> The same principle holds for a topology including five nodes. Here the
> packets from Node A and Node B are overheard by Node C and Node D,
> respectively. This allows Node R to send a network coded packet to save
> one transmission:
>=20
>    Node A                  Node B
>=20
>     |     \              /    |
>     |      p1          p2     |
>     |       \          /      |
>     p1       > Node R <       p2
>     |                         |
>     |         /      \        |
>     |    p1 x p2    p1 x p2   |
>     v       /          \      v
>            /            \
>    Node C <              > Node D
>=20
> More information is available on the open-mesh.org wiki[1].
>=20
> This patch adds the initial code to support network coding in
> batman-adv. It sets up a worker thread to do house keeping and adds a
> sysfs file to enable/disable network coding. The feature is disabled by
> default, as it requires a wifi-driver with working promiscuous mode, and
> also because it adds a small delay at each hop.
>=20
> [1] http://www.open-mesh.org/projects/batman-adv/wiki/Catwoman
>=20
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
> ---
> v3:
>  * Changed and updated copyright years
>=20
>  Makefile               |  2 ++
>  Makefile.kbuild        |  1 +
>  gen-compat-autoconf.sh |  1 +
>  main.c                 |  6 ++++
>  main.h                 |  4 ++-
>  network-coding.c       | 81
> ++++++++++++++++++++++++++++++++++++++++++++++++++
> network-coding.h       | 48 ++++++++++++++++++++++++++++++
>  soft-interface.c       |  3 ++
>  sysfs-class-net-mesh   |  8 +++++
>  sysfs.c                |  6 ++++
>  types.h                | 14 +++++++++
>  11 files changed, 173 insertions(+), 1 deletion(-)

Applied in revision 2f92809.

Thanks,
Marek
