Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Wed, 30 Jan 2013 08:21:07 +0100
Message-Id: <1359530467-9224-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix alignment of
	batadv_nc_hash_key_gen
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

Make second and third arguments correctly aligned to the opening
parenthesis.

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 network-coding.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/network-coding.c b/network-coding.c
index 262061b..f97d6cd 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -372,8 +372,8 @@ static void batadv_nc_purge_paths(struct batadv_priv *bat_priv,
  * @dst: destination ethernet mac address going into the hash key
  */
 static void batadv_nc_hash_key_gen(struct batadv_nc_path *key,
-					  const char *src,
-					  const char *dst)
+				   const char *src,
+				   const char *dst)
 {
 	memcpy(key->prev_hop, src, sizeof(key->prev_hop));
 	memcpy(key->next_hop, dst, sizeof(key->next_hop));
-- 
1.8.1.2

