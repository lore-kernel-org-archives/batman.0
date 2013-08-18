Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 18 Aug 2013 12:40:03 +0200
Message-Id: <1376822403-3383-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix variable name in
	compat code
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
Cc: Antonio Quartulli <ordex@autistici.org>

compat code introduced by
0d941e82ab5f92faf33bee6abdde519056f3ac2d
("batman-adv: Unmap fragment page once iterator is done")
is declaring a variable having the same name of one used in
the batman-adv code. Rename it to prevent sparse warnings.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 compat.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/compat.h b/compat.h
index 346a824..35ed4d9 100644
--- a/compat.h
+++ b/compat.h
@@ -309,10 +309,10 @@ static int __batadv_interface_set_mac_addr(x, y)
 /* older kernels still need to call skb_abort_seq_read() */
 #define skb_seq_read(consumed, data, st) \
 	({ \
-		int len = skb_seq_read(consumed, data, st); \
-		if (len == 0) \
+		int __len = skb_seq_read(consumed, data, st); \
+		if (__len == 0) \
 			skb_abort_seq_read(st); \
-		len; \
+		__len; \
 	})
 #endif /* < KERNEL_VERSION(3, 11, 0) */
 
-- 
1.8.1.5

