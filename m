Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 May 2014 13:44:08 +0200
Message-Id: <1400931855-7961-3-git-send-email-sven@narfation.org>
In-Reply-To: <1400931855-7961-1-git-send-email-sven@narfation.org>
References: <1400931855-7961-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 03/10] batadv-vis: Avoid memory leak when tl
	parsing failed
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
Cc: Sven Eckelmann <sven@narfation.org>

The parsing function for the local translation table can fail to convert the
mac address and then jumps out of the function. This leaks the earlier
allocated v_entry.

Signed-off-by: Sven Eckelmann <sven@narfation.org>

---
 vis/vis.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/vis/vis.c b/vis/vis.c
index 9031b27..a5ac664 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -213,8 +213,10 @@ static int parse_transtable_local(struct globals *globals)
 					continue;
 
 				mac = str_to_mac(tptr);
-				if (!mac)
+				if (!mac) {
+					free(v_entry);
 					continue;
+				}
 
 				memcpy(v_entry->v.mac, mac, ETH_ALEN);
 				v_entry->v.ifindex = 255;
-- 
2.0.0.rc2

