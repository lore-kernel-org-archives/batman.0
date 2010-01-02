Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat,  2 Jan 2010 11:30:38 +0100
Message-Id: <1262428252-26439-3-git-send-email-andrew@lunn.ch>
In-Reply-To: <1262428252-26439-2-git-send-email-andrew@lunn.ch>
References: <1262428252-26439-1-git-send-email-andrew@lunn.ch>
	<1262428252-26439-2-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 03/17] Staging: batman-adv: Replace
	KERN_DEBUG with bat_dbg
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

Ameya Palande requested we replace printk(KERN_DEBUG "") by pr_debug()
I decided it was better to use our debug macro.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Marek Lindner <lindner_marek@yahoo.de>
---
 drivers/staging/batman-adv/TODO     |    6 ------
 drivers/staging/batman-adv/device.c |    6 +++---
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/batman-adv/TODO b/drivers/staging/batman-adv/TODO
index ea6dcf9..8c2b89e 100644
--- a/drivers/staging/batman-adv/TODO
+++ b/drivers/staging/batman-adv/TODO
@@ -29,12 +29,6 @@
 -> PRIMARY)
 
 => logging
-* the log level LOG_TYPE_CRIT, LOG_TYPE_WARN & LOG_TYPE_NOTICE will be
-* unified to use printk
-* LOG_TYPE_BATMAN & LOG_TYPE_ROUTES will also use printk but only after the
-* internal debug level has been raised
-* the internal debug level can be modified using a module parameter (debug)
-* or at run time via /sys/module/batman-adv/parameters/debug
 * make use of printk %pM support instead of converting mac addresses
 * manually
 
diff --git a/drivers/staging/batman-adv/device.c b/drivers/staging/batman-adv/device.c
index 12f2de9..92cf8d5 100644
--- a/drivers/staging/batman-adv/device.c
+++ b/drivers/staging/batman-adv/device.c
@@ -207,7 +207,7 @@ ssize_t bat_device_write(struct file *file, const char __user *buff,
 	struct batman_if *batman_if;
 
 	if (len < sizeof(struct icmp_packet)) {
-		printk(KERN_DEBUG "batman-adv:Error - can't send packet from char device: invalid packet size\n");
+		bat_dbg(DBG_BATMAN, "batman-adv:Error - can't send packet from char device: invalid packet size\n");
 		return -EINVAL;
 	}
 
@@ -218,12 +218,12 @@ ssize_t bat_device_write(struct file *file, const char __user *buff,
 		return -EFAULT;
 
 	if (icmp_packet.packet_type != BAT_ICMP) {
-		printk(KERN_DEBUG "batman-adv:Error - can't send packet from char device: got bogus packet type (expected: BAT_ICMP)\n");
+		bat_dbg(DBG_BATMAN, "batman-adv:Error - can't send packet from char device: got bogus packet type (expected: BAT_ICMP)\n");
 		return -EINVAL;
 	}
 
 	if (icmp_packet.msg_type != ECHO_REQUEST) {
-		printk(KERN_DEBUG "batman-adv:Error - can't send packet from char device: got bogus message type (expected: ECHO_REQUEST)\n");
+		bat_dbg(DBG_BATMAN, "batman-adv:Error - can't send packet from char device: got bogus message type (expected: ECHO_REQUEST)\n");
 		return -EINVAL;
 	}
 
-- 
1.6.5.7

