Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 21 Nov 2010 14:32:43 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_89R6M9qMbPgM7mn"
Message-Id: <201011211432.44862.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] batman-adv crash on Intel 3945ABG & 4965 AGN
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: lesniak@sra.uni-hannover.de, b.a.t.m.a.n@lists.open-mesh.org

--Boundary-00=_89R6M9qMbPgM7mn
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit


Hi,

2 days ago I proposed a patch which fixes the crash you reported in ticket 
#141. Although you confirmed the patch solves the issue I haven't pushed it yet 
as the cause seems to be a bug within the Intel driver and should be fixed 
there (unless we do something horribly wrong). 
Could you please let us know the driver version that was used in your test 
setup ? A 'modinfo iwlagn | grep version' should do. We will then get in touch 
with the Intel wifi maintainers.

Regards,
Marek

--Boundary-00=_89R6M9qMbPgM7mn
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-batman-adv-dropped-skbs-that-are-too-short-intel-bug.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-batman-adv-dropped-skbs-that-are-too-short-intel-bug.patch"

=46rom a2496fe3ade7f6295b47f1271279de319831a8a7 Mon Sep 17 00:00:00 2001
=46rom: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 21 Nov 2010 14:15:22 +0100
Subject: [PATCH] batman-adv: dropped skbs that are too short (intel bug?)

Reported-by: Lesniak <lesniak@sra.uni-hannover.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
=2D--
 batman-adv/soft-interface.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/batman-adv/soft-interface.c b/batman-adv/soft-interface.c
index e93a99f..6ba796f 100644
=2D-- a/batman-adv/soft-interface.c
+++ b/batman-adv/soft-interface.c
@@ -493,6 +493,11 @@ void interface_rx(struct net_device *soft_iface,
 		goto out;
 	}
=20
+	printk(KERN_INFO "interface_rx(): skb->len: %i, skb->data_len: %i, bug: %=
i\n", skb->len, skb->data_len, skb->len - ETH_HLEN < skb->data_len);
+	if (!pskb_may_pull(skb, ETH_HLEN)) {
+		printk(KERN_INFO "interface_rx(): dropping small packet\n");
+		goto dropped;
+	}
 	/* skb->dev & skb->pkt_type are set here */
 	skb->protocol =3D eth_type_trans(skb, soft_iface);
=20
=2D-=20
1.7.2.3


--Boundary-00=_89R6M9qMbPgM7mn--
