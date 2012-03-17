Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 17 Mar 2012 15:28:35 +0800
Message-Id: <1331969315-27535-4-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1331969315-27535-1-git-send-email-lindner_marek@yahoo.de>
References: <1331969315-27535-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 4/4] batman-adv: fix checkpatch opening
	parenthesis complaint
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

Regression introduced by: 7c73d4c1d61b3db2f8b6bdd999ecebd231429082

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 bat_sysfs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index 35c15e9..d0f8453 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -441,7 +441,7 @@ static BAT_ATTR(gw_mode, S_IRUGO | S_IWUSR, show_gw_mode, store_gw_mode);
 BAT_ATTR_SIF_UINT(orig_interval, S_IRUGO | S_IWUSR, 2 * JITTER, INT_MAX, NULL);
 BAT_ATTR_SIF_UINT(hop_penalty, S_IRUGO | S_IWUSR, 0, TQ_MAX_VALUE, NULL);
 BAT_ATTR_SIF_UINT(gw_sel_class, S_IRUGO | S_IWUSR, 1, TQ_MAX_VALUE,
-	      post_gw_deselect);
+		  post_gw_deselect);
 static BAT_ATTR(gw_bandwidth, S_IRUGO | S_IWUSR, show_gw_bwidth,
 		store_gw_bwidth);
 #ifdef CONFIG_BATMAN_ADV_DEBUG
-- 
1.7.9.1

