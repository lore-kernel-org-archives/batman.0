Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed, 19 Mar 2014 09:08:42 +0100
Message-Id: <1395216532-31099-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 next 01/11] batman-adv: remove useless goto
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

There is no need to use a label and a goto for code that is
used once only.
Moreover having a goto for a single return statement should
always be avoided.

Introduced by e368857f66620b8483166e8e6556d9c87f9b3e71
("batman-adv: Multicast Listener Announcements via Translation Table")

Cc: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---

Changes from v1:
- change "we are out of memory" to "in case of memory allocation failure" in
  3/11
- fix commit message in 10/11


 multicast.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/multicast.c b/multicast.c
index 998b429..d92de1e 100644
--- a/multicast.c
+++ b/multicast.c
@@ -194,12 +194,10 @@ static bool batadv_mcast_has_bridge(struct batadv_priv *bat_priv)
 
 	bridge = batadv_mcast_get_bridge(bat_priv);
 	if (!bridge)
-		goto out;
+		return false;
 
 	dev_put(bridge);
 	return true;
-out:
-	return false;
 }
 
 /**
-- 
1.8.3.2

