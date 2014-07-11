Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Fri, 11 Jul 2014 14:26:32 +0200
Message-Id: <1405081595-23371-10-git-send-email-martin@hundeboll.net>
In-Reply-To: <1405081595-23371-1-git-send-email-martin@hundeboll.net>
References: <1405081595-23371-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 10/13] batman-adv: kernel doc fixes for
	soft-interface.c
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 soft-interface.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/soft-interface.c b/soft-interface.c
index 9bf382d..bc0e44d 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -563,6 +563,7 @@ static void batadv_softif_destroy_vlan(struct batadv_priv *bat_priv,
 /**
  * batadv_interface_add_vid - ndo_add_vid API implementation
  * @dev: the netdev of the mesh interface
+ * @proto: must be ETH_P_8021Q
  * @vid: identifier of the new vlan
  *
  * Set up all the internal structures for handling the new vlan on top of the
@@ -620,6 +621,7 @@ static int batadv_interface_add_vid(struct net_device *dev, __be16 proto,
 /**
  * batadv_interface_kill_vid - ndo_kill_vid API implementation
  * @dev: the netdev of the mesh interface
+ * @proto: must be ETH_P_8021Q
  * @vid: identifier of the deleted vlan
  *
  * Destroy all the internal structures used to handle the vlan identified by vid
-- 
2.0.1

