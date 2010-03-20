Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sat, 20 Mar 2010 04:31:48 +0100
Message-Id: <1269055908-20369-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1269055908-20369-1-git-send-email-linus.luessing@web.de>
References: <1269055908-20369-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Fix aggregation direct-link
	bug
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
To: b.a.t.m.a.n@lists.open-mesh.org

So far, neighbour's secondary interface OGMs can involuntarily
piggyback on primary interface OGMs that arrived on the same secondary
interface before. Secondary interface OGMs should NEVER leave their
direct neighbour broadcast domain! This patch ensures that secondary
interface OGMs can only be aggregated to other secondary interface OGMs.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 aggregation.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/batman-adv-kernelland/aggregation.c b/batman-adv-kernelland/aggregation.c
index 0635b5a..567c31a 100644
--- a/batman-adv-kernelland/aggregation.c
+++ b/batman-adv-kernelland/aggregation.c
@@ -81,9 +81,15 @@ static bool can_aggregate_with(struct batman_packet *new_batman_packet,
 		 * interface only - we still can aggregate */
 		if ((directlink) &&
 		    (new_batman_packet->ttl == 1) &&
-		    (forw_packet->if_incoming == if_incoming))
+		    (forw_packet->if_incoming == if_incoming) &&
+
+		    /* packets from direct neighbors or
+		     * own secondary interface packets
+		     * (= secondary interface packets in general) */
+		    (batman_packet->flags & DIRECTLINK ||
+		     (forw_packet->own &&
+		      forw_packet->if_incoming->if_num != 0)))
 			return true;
-
 	}
 
 	return false;
-- 
1.7.0

