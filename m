Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat,  2 Jan 2010 11:30:42 +0100
Message-Id: <1262428252-26439-7-git-send-email-andrew@lunn.ch>
In-Reply-To: <1262428252-26439-6-git-send-email-andrew@lunn.ch>
References: <1262428252-26439-1-git-send-email-andrew@lunn.ch>
	<1262428252-26439-2-git-send-email-andrew@lunn.ch>
	<1262428252-26439-3-git-send-email-andrew@lunn.ch>
	<1262428252-26439-4-git-send-email-andrew@lunn.ch>
	<1262428252-26439-5-git-send-email-andrew@lunn.ch>
	<1262428252-26439-6-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 07/17] Staging: batman-adv: Fixes rounding
	issues in vis.c
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: gregkh@suse.de
Cc: b.a.t.m.a.n@lists.open-mesh.net

From: Linus Lüssing <linus.luessing@web.de>

This patches fixes two rounding issues in vis.c for sending and
purging vis packets. Before, the timers and timeouts always got
rounded down to seconds, though we want a precision in
milliseconds.

This also fixes a kernel panic that occures when lowering the
timer for sending vis packets (vis_interval) to less than 1000ms
in main.c manually.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
Acked-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/vis.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/batman-adv/vis.c b/drivers/staging/batman-adv/vis.c
index ac7c7c5..0eb23d2 100644
--- a/drivers/staging/batman-adv/vis.c
+++ b/drivers/staging/batman-adv/vis.c
@@ -377,7 +377,7 @@ static void purge_vis_packets(void)
 		if (info == my_vis_info)	/* never purge own data. */
 			continue;
 		if (time_after(jiffies,
-			       info->first_seen + (VIS_TIMEOUT/1000)*HZ)) {
+			       info->first_seen + (VIS_TIMEOUT*HZ)/1000)) {
 			hash_remove_bucket(vis_hash, &hashit);
 			free_info(info);
 		}
@@ -556,5 +556,5 @@ void vis_quit(void)
 static void start_vis_timer(void)
 {
 	queue_delayed_work(bat_event_workqueue, &vis_timer_wq,
-			   (atomic_read(&vis_interval)/1000) * HZ);
+			   (atomic_read(&vis_interval) * HZ) / 1000);
 }
-- 
1.6.5.7

