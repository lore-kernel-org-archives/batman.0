Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 17 Feb 2012 15:18:24 +0800
Message-Id: <1329463110-856-5-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1329463110-856-1-git-send-email-lindner_marek@yahoo.de>
References: <1329463110-856-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 04/10] batman-adv: Rm empty line from
	is_my_mac() in main.c
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Martin Hundebøll <martin@hundeboll.net>

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/main.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index fb87bdc..71b56cf 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -170,7 +170,6 @@ int is_my_mac(const uint8_t *addr)
 	}
 	rcu_read_unlock();
 	return 0;
-
 }
 
 module_init(batman_init);
-- 
1.7.9

