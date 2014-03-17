Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon, 17 Mar 2014 14:22:48 +0100
Message-Id: <1395062574-28291-5-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1395062574-28291-1-git-send-email-antonio@meshcoding.com>
References: <1395062574-28291-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH next 05/11] batman-adv: fix multicast
	kerneldoc
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

The kerneldoc should always use the third person singular in
the long function description.
Moreover it should always try use up to 80 chars per line.

Introduced by f70c60d236cddb28d9e576de774ad97f9b0fd1b7
("batman-adv: Announce new capability via multicast TVLV")

Cc: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 multicast.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/multicast.c b/multicast.c
index e2b32fd..f8a4c4d 100644
--- a/multicast.c
+++ b/multicast.c
@@ -185,11 +185,11 @@ static bool batadv_mcast_has_bridge(struct batadv_priv *bat_priv)
  * batadv_mcast_mla_tvlv_update - update multicast tvlv
  * @bat_priv: the bat priv with all the soft interface information
  *
- * Update the own multicast tvlv with our current multicast related settings,
+ * Updates the own multicast tvlv with our current multicast related settings,
  * capabilities and inabilities.
  *
- * Return true if the tvlv container is registered afterwards. Otherwise return
- * false.
+ * Returns true if the tvlv container is registered afterwards. Otherwise
+ * returns false.
  */
 static bool batadv_mcast_mla_tvlv_update(struct batadv_priv *bat_priv)
 {
@@ -226,7 +226,7 @@ static bool batadv_mcast_mla_tvlv_update(struct batadv_priv *bat_priv)
  * batadv_mcast_mla_update - update the own MLAs
  * @bat_priv: the bat priv with all the soft interface information
  *
- * Update the own multicast listener announcements in the translation
+ * Updates the own multicast listener announcements in the translation
  * table as well as the own, announced multicast tvlv container.
  */
 void batadv_mcast_mla_update(struct batadv_priv *bat_priv)
-- 
1.8.3.2

