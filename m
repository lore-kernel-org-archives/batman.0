Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 3/7] batman-adv: Fix typo metAdata
Date: Tue, 14 Jan 2020 15:23:47 +0100
Message-Id: <20200114142351.26622-4-sw@simonwunderlich.de>
In-Reply-To: <20200114142351.26622-1-sw@simonwunderlich.de>
References: <20200114142351.26622-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 47718a82eaf2..bdf9827b5f63 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -457,7 +457,7 @@ struct batadv_orig_node {
 	/**
 	 * @tt_lock: prevents from updating the table while reading it. Table
 	 *  update is made up by two operations (data structure update and
-	 *  metdata -CRC/TTVN-recalculation) and they have to be executed
+	 *  metadata -CRC/TTVN-recalculation) and they have to be executed
 	 *  atomically in order to avoid another thread to read the
 	 *  table/metadata between those.
 	 */
@@ -1011,7 +1011,7 @@ struct batadv_priv_tt {
 	/**
 	 * @commit_lock: prevents from executing a local TT commit while reading
 	 *  the local table. The local TT commit is made up by two operations
-	 *  (data structure update and metdata -CRC/TTVN- recalculation) and
+	 *  (data structure update and metadata -CRC/TTVN- recalculation) and
 	 *  they have to be executed atomically in order to avoid another thread
 	 *  to read the table/metadata between those.
 	 */
-- 
2.20.1

