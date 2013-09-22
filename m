Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun, 22 Sep 2013 19:30:36 +0200
Message-Id: <1379871036-1715-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCHv2 next] batman-adv: properly format kernel doc
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

Introduced by: 0b6aa0d43767889eeda43a132cf5e73df4e63bf2
("batman-adv: tvlv - basic infrastructure")

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
v2:
- properly align also the rest of the text

 main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/main.c b/main.c
index 5c5e64b..5ee2abb 100644
--- a/main.c
+++ b/main.c
@@ -1014,10 +1014,10 @@ void batadv_tvlv_ogm_receive(struct batadv_priv *bat_priv,
  *  payload
  * @bat_priv: the bat priv with all the soft interface information
  * @optr: ogm tvlv handler callback function. This function receives the orig
- *	  node, flags and the tvlv content as argument to process.
- * uptr: unicast tvlv handler callback function. This function receives the
- *	 source & destination of the unicast packet as well as the tvlv content
- *	 to process.
+ *  node, flags and the tvlv content as argument to process.
+ * @uptr: unicast tvlv handler callback function. This function receives the
+ *  source & destination of the unicast packet as well as the tvlv content
+ *  to process.
  * @type: tvlv handler type to be registered
  * @version: tvlv handler version to be registered
  * @flags: flags to enable or disable TVLV API behavior
-- 
1.8.1.5

