Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat,  2 Jan 2010 11:30:52 +0100
Message-Id: <1262428252-26439-17-git-send-email-andrew@lunn.ch>
In-Reply-To: <1262428252-26439-16-git-send-email-andrew@lunn.ch>
References: <1262428252-26439-1-git-send-email-andrew@lunn.ch>
	<1262428252-26439-2-git-send-email-andrew@lunn.ch>
	<1262428252-26439-3-git-send-email-andrew@lunn.ch>
	<1262428252-26439-4-git-send-email-andrew@lunn.ch>
	<1262428252-26439-5-git-send-email-andrew@lunn.ch>
	<1262428252-26439-6-git-send-email-andrew@lunn.ch>
	<1262428252-26439-7-git-send-email-andrew@lunn.ch>
	<1262428252-26439-8-git-send-email-andrew@lunn.ch>
	<1262428252-26439-9-git-send-email-andrew@lunn.ch>
	<1262428252-26439-10-git-send-email-andrew@lunn.ch>
	<1262428252-26439-11-git-send-email-andrew@lunn.ch>
	<1262428252-26439-12-git-send-email-andrew@lunn.ch>
	<1262428252-26439-13-git-send-email-andrew@lunn.ch>
	<1262428252-26439-14-git-send-email-andrew@lunn.ch>
	<1262428252-26439-15-git-send-email-andrew@lunn.ch>
	<1262428252-26439-16-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 17/17] Staging: batman-adv: Dont deactivate
	aggregation on wrong input
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

A non-integer changes the aggregation mode. Therefore this patch changes
the behaviour to explicitly check strict_strtoul()'s return code.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
Acked-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/proc.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/batman-adv/proc.c b/drivers/staging/batman-adv/proc.c
index 6a7c8bb..2aeee7a 100644
--- a/drivers/staging/batman-adv/proc.c
+++ b/drivers/staging/batman-adv/proc.c
@@ -427,6 +427,7 @@ static ssize_t proc_aggr_write(struct file *file, const char __user *buffer,
 	char *aggr_string;
 	int not_copied = 0;
 	unsigned long aggregation_enabled_tmp;
+	int retval;
 
 	aggr_string = kmalloc(count, GFP_KERNEL);
 
@@ -436,22 +437,21 @@ static ssize_t proc_aggr_write(struct file *file, const char __user *buffer,
 	not_copied = copy_from_user(aggr_string, buffer, count);
 	aggr_string[count - not_copied - 1] = 0;
 
-	strict_strtoul(aggr_string, 10, &aggregation_enabled_tmp);
+	retval = strict_strtoul(aggr_string, 10, &aggregation_enabled_tmp);
 
-	if ((aggregation_enabled_tmp != 0) && (aggregation_enabled_tmp != 1)) {
+	if (retval || aggregation_enabled_tmp > 1) {
 		printk(KERN_ERR "batman-adv:Aggregation can only be enabled (1) or disabled (0), given value: %li\n", aggregation_enabled_tmp);
-		goto end;
+	} else {
+		printk(KERN_INFO "batman-adv:Changing aggregation from: %s (%i) to: %s (%li)\n",
+		       (atomic_read(&aggregation_enabled) == 1 ?
+			"enabled" : "disabled"),
+		       atomic_read(&aggregation_enabled),
+		       (aggregation_enabled_tmp == 1 ? "enabled" : "disabled"),
+		       aggregation_enabled_tmp);
+		atomic_set(&aggregation_enabled,
+			   (unsigned)aggregation_enabled_tmp);
 	}
 
-	printk(KERN_INFO "batman-adv:Changing aggregation from: %s (%i) to: %s (%li)\n",
-	       (atomic_read(&aggregation_enabled) == 1 ?
-		"enabled" : "disabled"),
-	       atomic_read(&aggregation_enabled),
-	       (aggregation_enabled_tmp == 1 ? "enabled" : "disabled"),
-	       aggregation_enabled_tmp);
-
-	atomic_set(&aggregation_enabled, (unsigned)aggregation_enabled_tmp);
-end:
 	kfree(aggr_string);
 	return count;
 }
-- 
1.6.5.7

