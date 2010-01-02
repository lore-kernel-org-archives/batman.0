Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat,  2 Jan 2010 11:30:43 +0100
Message-Id: <1262428252-26439-8-git-send-email-andrew@lunn.ch>
In-Reply-To: <1262428252-26439-7-git-send-email-andrew@lunn.ch>
References: <1262428252-26439-1-git-send-email-andrew@lunn.ch>
	<1262428252-26439-2-git-send-email-andrew@lunn.ch>
	<1262428252-26439-3-git-send-email-andrew@lunn.ch>
	<1262428252-26439-4-git-send-email-andrew@lunn.ch>
	<1262428252-26439-5-git-send-email-andrew@lunn.ch>
	<1262428252-26439-6-git-send-email-andrew@lunn.ch>
	<1262428252-26439-7-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 08/17] Staging: batman-adv: fix minor orig
	table layout bug
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: gregkh@suse.de
Cc: Marek Lindner <lindner_marek@yahoo.de>, b.a.t.m.a.n@lists.open-mesh.net

From: Marek Lindner <lindner_marek@yahoo.de>

The originator table contained a TAB instead of a space which broke
the layout as well as the batctl parser.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/proc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/batman-adv/proc.c b/drivers/staging/batman-adv/proc.c
index 22471ee..e48b820 100644
--- a/drivers/staging/batman-adv/proc.c
+++ b/drivers/staging/batman-adv/proc.c
@@ -230,7 +230,7 @@ static int proc_originators_read(struct seq_file *seq, void *offset)
 		addr_to_string(orig_str, orig_node->orig);
 		addr_to_string(router_str, orig_node->router->addr);
 
-		seq_printf(seq, "%-17s	(%3i) %17s [%10s]:",
+		seq_printf(seq, "%-17s  (%3i) %17s [%10s]:",
 			   orig_str, orig_node->router->tq_avg,
 			   router_str, orig_node->router->if_incoming->dev);
 
-- 
1.6.5.7

