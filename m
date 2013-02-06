Return-Path: <emilgoode@gmail.com>
From: Emil Goode <emilgoode@gmail.com>
Date: Thu,  7 Feb 2013 00:32:37 +0100
Message-Id: <1360193557-27554-1-git-send-email-emilgoode@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v2] batman-adv: Remove unused variable
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
To: akpm@linux-foundation.org, lindner_marek@yahoo.de, siwu@hrz.tu-chemnitz.de, ordex@autistici.org, davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Emil Goode <emilgoode@gmail.com>, sasha.levin@oracle.com

The below commit removed one node parameter from iterators.
ed242d01bbe22ea0877472db49b2752d866c921c
(hlist: drop the node parameter from iterators)

This patch removes a hlist_node struct that is no longer used.

Sparse gives a warning:

net/batman-adv/originator.c:411:21: warning:
	unused variable ‘node_tmp’ [-Wunused-variable]

Signed-off-by: Emil Goode <emilgoode@gmail.com>
---
This patch applies to the linux-next tree.
v2: Added complete hash and message of dependant commit.

 net/batman-adv/originator.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 43d0f89..96fb80b 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -408,7 +408,6 @@ int batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct batadv_priv *bat_priv = netdev_priv(net_dev);
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
-	struct hlist_node *node_tmp;
 	struct hlist_head *head;
 	struct batadv_hard_iface *primary_if;
 	struct batadv_orig_node *orig_node;
-- 
1.7.10.4

