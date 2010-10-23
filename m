Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 24 Oct 2010 00:42:22 +0200
Message-Id: <1287873742-5039-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove useless braces
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
To: b.a.t.m.a.n@lists.open-mesh.org

54466268785c9892d6e2af2ac2a54a684face022 added changes to vis.c which
trigger a checkpatch.pl warning about braces which are not necessary
anymore.

WARNING: braces {} are not necessary for any arm of this statement
+               if (entry->primary)
[...]
+               else {
[...]

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/vis.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/batman-adv/vis.c b/batman-adv/vis.c
index bde423a..5aea153 100644
--- a/batman-adv/vis.c
+++ b/batman-adv/vis.c
@@ -136,9 +136,8 @@ static ssize_t vis_data_read_prim_sec(char *buff, struct hlist_head *if_list)
 	hlist_for_each_entry(entry, pos, if_list, list) {
 		if (entry->primary)
 			len += sprintf(buff + len, "PRIMARY, ");
-		else {
+		else
 			len += sprintf(buff + len,  "SEC %pM, ", entry->addr);
-		}
 	}
 
 	return len;
-- 
1.7.1

