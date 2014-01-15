Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Thu, 16 Jan 2014 00:10:44 +0100
Message-Id: <1389827444-3911-2-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1389827444-3911-1-git-send-email-antonio@meshcoding.com>
References: <1389827444-3911-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix batman-adv header overhead
	calculation
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

From: Marek Lindner <mareklindner@neomailbox.ch>

Batman-adv prepends a full ethernet header in addition to its own
header. This has to be reflected in the MTU calculation, especially
since the value is used to set dev->hard_header_len.

Introduced by 411d6ed93a5d0601980d3e5ce75de07c98e3a7de
("batman-adv: consider network coding overhead when calculating required mtu")

Reported-by: cmsv <cmsv@wirelesspt.net>
Reported-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 1511f64..faba0f6 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -277,7 +277,7 @@ int batadv_max_header_len(void)
 			   sizeof(struct batadv_coded_packet));
 #endif
 
-	return header_len;
+	return header_len + ETH_HLEN;
 }
 
 /**
-- 
1.8.5.3

