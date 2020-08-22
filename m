Return-Path: <rdunlap@infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 7/8] net: batman-adv: soft-interface.c: delete duplicated words
Date: Sat, 22 Aug 2020 16:13:34 -0700
Message-Id: <20200822231335.31304-8-rdunlap@infradead.org>
In-Reply-To: <20200822231335.31304-1-rdunlap@infradead.org>
References: <20200822231335.31304-1-rdunlap@infradead.org>
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
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>

Drop the repeated word "the" in two places.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Marek Lindner <mareklindner@neomailbox.ch>
Cc: Simon Wunderlich <sw@simonwunderlich.de>
Cc: Antonio Quartulli <a@unstable.cc>
Cc: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
---
 net/batman-adv/soft-interface.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200731.orig/net/batman-adv/soft-interface.c
+++ linux-next-20200731/net/batman-adv/soft-interface.c
@@ -649,7 +649,7 @@ static void batadv_softif_destroy_vlan(s
 /**
  * batadv_interface_add_vid() - ndo_add_vid API implementation
  * @dev: the netdev of the mesh interface
- * @proto: protocol of the the vlan id
+ * @proto: protocol of the vlan id
  * @vid: identifier of the new vlan
  *
  * Set up all the internal structures for handling the new vlan on top of the
@@ -707,7 +707,7 @@ static int batadv_interface_add_vid(stru
 /**
  * batadv_interface_kill_vid() - ndo_kill_vid API implementation
  * @dev: the netdev of the mesh interface
- * @proto: protocol of the the vlan id
+ * @proto: protocol of the vlan id
  * @vid: identifier of the deleted vlan
  *
  * Destroy all the internal structures used to handle the vlan identified by vid
