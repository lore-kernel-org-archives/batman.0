Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat,  7 Dec 2013 11:21:21 +0100
Message-Id: <1386411684-2448-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 1/4] batman-adv: fix typ0 in sysfs.c
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

Fix a small typ0 in sysfs.c.
Introduced by 99a6eb50ef5066e125cedb97bc0fcfcdff4f08cc
("batman-adv: deselect current GW on client mode switch off")

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sysfs.c b/sysfs.c
index 2f89a57..037f411 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -407,7 +407,7 @@ static ssize_t batadv_store_gw_mode(struct kobject *kobj,
 		    curr_gw_mode_str, buff);
 
 	/* Invoking batadv_gw_reselect() is not enough to really de-select the
-	 * current GW. It will only instruct the gateway clientcode to perform
+	 * current GW. It will only instruct the gateway client code to perform
 	 * a re-election the next time that this is needed.
 	 *
 	 * When gw client mode is being switched off the current GW must be
-- 
1.8.5.1

