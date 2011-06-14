Return-Path: <dhowells@redhat.com>
From: David Howells <dhowells@redhat.com>
Date: Wed, 15 Jun 2011 00:51:32 +0100
Message-ID: <20110614235132.3724.57632.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: count_real_packets() in
 batman-adv assumes char is signed
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, David Howells <dhowells@redhat.com>, Marek Lindner <lindner_marek@yahoo.de>

count_real_packets() in batman-adv assumes char is signed, and returns -1
through it:

net/batman-adv/routing.c: In function 'receive_bat_packet':
net/batman-adv/routing.c:739: warning: comparison is always false due to limited range of data type

Use int instead.

This is also looks a bit weird as (presumably signed) is_duplicate is
constructed by OR'ding together the unsigned results of get_bit_status()
(though the latter only returns 0 or 1).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marek Lindner <lindner_marek@yahoo.de>
cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
cc: Sven Eckelmann <sven@narfation.org>
cc: b.a.t.m.a.n@lists.open-mesh.org
cc: netdev@vger.kernel.org
---

 net/batman-adv/routing.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index bb1c3ec..3075fcb 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -531,15 +531,15 @@ static int window_protected(struct bat_priv *bat_priv,
  *  -1 the packet is old and has been received while the seqno window
  *     was protected. Caller should drop it.
  */
-static char count_real_packets(struct ethhdr *ethhdr,
-			       struct batman_packet *batman_packet,
-			       struct hard_iface *if_incoming)
+static int count_real_packets(struct ethhdr *ethhdr,
+			      struct batman_packet *batman_packet,
+			      struct hard_iface *if_incoming)
 {
 	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct orig_node *orig_node;
 	struct neigh_node *tmp_neigh_node;
 	struct hlist_node *node;
-	char is_duplicate = 0;
+	uint8_t is_duplicate = 0;
 	int32_t seq_diff;
 	int need_update = 0;
 	int set_mark, ret = -1;
@@ -608,7 +608,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	char has_directlink_flag;
 	char is_my_addr = 0, is_my_orig = 0, is_my_oldorig = 0;
 	char is_broadcast = 0, is_bidirectional, is_single_hop_neigh;
-	char is_duplicate;
+	int is_duplicate;
 	uint32_t if_incoming_seqno;
 
 	/* Silently drop when the batman packet is actually not a

