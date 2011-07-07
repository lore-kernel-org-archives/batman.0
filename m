Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu,  7 Jul 2011 15:25:03 +0200
Message-Id: <1310045106-23202-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1310045106-23202-1-git-send-email-ordex@autistici.org>
References: <1310045106-23202-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv3 1/4] batman-adv: initialise last_ttvn and
	tt_crc for the orig_node structure
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

The last_ttvn and tt_crc fields of the orig_node structure were not
initialised causing an immediate TT_REQ/RES dialogue even if not needed.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 originator.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/originator.c b/originator.c
index 4cc94d4..f3c3f62 100644
--- a/originator.c
+++ b/originator.c
@@ -223,6 +223,8 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, const uint8_t *addr)
 	orig_node->bat_priv = bat_priv;
 	memcpy(orig_node->orig, addr, ETH_ALEN);
 	orig_node->router = NULL;
+	orig_node->tt_crc = 0;
+	atomic_set(&orig_node->last_ttvn, 0);
 	orig_node->tt_buff = NULL;
 	orig_node->tt_buff_len = 0;
 	atomic_set(&orig_node->tt_size, 0);
-- 
1.7.3.4

