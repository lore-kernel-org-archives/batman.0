Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 10 May 2012 12:54:03 +0800
Message-Id: <1336625644-29442-2-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1336625644-29442-1-git-send-email-lindner_marek@yahoo.de>
References: <1336625644-29442-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: change comment style for
	David
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Should be merged with bd83b4cfaeff6a78440b955598afccafad081dbe

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 types.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/types.h b/types.h
index 15f538a..6474324 100644
--- a/types.h
+++ b/types.h
@@ -399,7 +399,8 @@ struct bat_algo_ops {
 	/* de-init routing info when hard-interface is disabled */
 	void (*bat_iface_disable)(struct hard_iface *hard_iface);
 	/* (re-)init mac addresses of the protocol information
-	 * belonging to this hard-interface */
+	 * belonging to this hard-interface
+	 */
 	void (*bat_iface_update_mac)(struct hard_iface *hard_iface);
 	/* called when primary interface is selected / changed */
 	void (*bat_primary_iface_set)(struct hard_iface *hard_iface);
-- 
1.7.9.1

