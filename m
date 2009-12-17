Return-Path: <linus.luessing@web.de>
Date: Thu, 17 Dec 2009 20:04:33 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20091217190433.GA3960@Linus-Debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fixes rounding issues in vis.c
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
To: b.a.t.m.a.n@lists.open-mesh.net

This patches fixes two rounding issues in vis.c for sending and
purging vis packets. Before, the timers and timeouts always got
rounded down to seconds, though we want a precision in
milliseconds.
This also fixes a kernel panic that occures when lowering the
timer for sending vis packets (vis_interval) to less than 1000ms
in main.c manually.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---

Index: vis.c
===================================================================
--- vis.c	(revision 1505)
+++ vis.c	(working copy)
@@ -377,7 +377,7 @@
 		if (info == my_vis_info)	/* never purge own data. */
 			continue;
 		if (time_after(jiffies,
-			       info->first_seen + (VIS_TIMEOUT/1000)*HZ)) {
+			       info->first_seen + (VIS_TIMEOUT*HZ)/1000)) {
 			hash_remove_bucket(vis_hash, &hashit);
 			free_info(info);
 		}
@@ -556,5 +556,5 @@
 static void start_vis_timer(void)
 {
 	queue_delayed_work(bat_event_workqueue, &vis_timer_wq,
-			   (atomic_read(&vis_interval)/1000) * HZ);
+			   (atomic_read(&vis_interval) * HZ ) / 1000);
 }
