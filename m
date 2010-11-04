Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu,  4 Nov 2010 23:02:28 +0100
Message-Id: <1288908150-19744-2-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1288908150-19744-1-git-send-email-sven.eckelmann@gmx.de>
References: <1288908150-19744-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] Staging: batman-adv: Remove useless
	braces
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
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.org

77099f0afe94928b5b0066a7efa5fa9f81696b54 added changes to vis.c which
trigger a checkpatch.pl warning about braces which are not necessary
anymore.

WARNING: braces {} are not necessary for any arm of this statement
+               if (entry->primary)
[...]
+               else {
[...]

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/vis.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/batman-adv/vis.c b/drivers/staging/batman-adv/vis.c
index 3d2c1bc..4473cc8 100644
--- a/drivers/staging/batman-adv/vis.c
+++ b/drivers/staging/batman-adv/vis.c
@@ -135,9 +135,8 @@ static ssize_t vis_data_read_prim_sec(char *buff, struct hlist_head *if_list)
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
1.7.2.3

