Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] batctl: Fix retrieval of meshif ap_isolation
Date: Sat, 31 Oct 2020 18:00:26 +0100
Message-Id: <20201031170026.106930-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Sven Eckelmann <sven@narfation.org>

The batadv command to retrieve the attributes is called
BATADV_CMD_GET_MESH. The used BATADV_CMD_SET_MESH will only return the
current settings via the "config" multicast group which is not evaluated by
the ap_isolation command.

Fixes: c56a63a5f12a ("batctl: Support generic netlink for ap_isolation command")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 ap_isolation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ap_isolation.c b/ap_isolation.c
index df19072..c8675f5 100644
--- a/ap_isolation.c
+++ b/ap_isolation.c
@@ -36,7 +36,7 @@ static int get_attrs_ap_isolation(struct nl_msg *msg, void *arg)
 
 static int get_ap_isolation(struct state *state)
 {
-	enum batadv_nl_commands nl_cmd = BATADV_CMD_SET_MESH;
+	enum batadv_nl_commands nl_cmd = BATADV_CMD_GET_MESH;
 
 	if (state->selector == SP_VLAN)
 		nl_cmd = BATADV_CMD_GET_VLAN;
-- 
2.28.0

