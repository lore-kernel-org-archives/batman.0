Return-Path: <linus.luessing@web.de>
Date: Thu, 31 Dec 2009 04:39:55 +0100
From: =?utf-8?B?PT9VVEYtOD9xP0xpbnVzPTIwTD1DMz1CQ3NzaW5nPz0=?=
	<linus.luessing@web.de>
Message-ID: <20091231033955.GB18781@Sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: No deact of aggregation on
	wrong input
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

A non-integer changes the aggregation mode. Therefore this patch changes
the behaviour to explicitly check strict_strtoul()'s return code.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 proc.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/proc.c b/proc.c
index e7b7bf3..232efe3 100644
--- a/proc.c
+++ b/proc.c
@@ -433,6 +433,7 @@ static ssize_t proc_aggr_write(struct file *file, const char __user *buffer,
 	char *aggr_string;
 	int not_copied = 0;
 	unsigned long aggregation_enabled_tmp;
+	int retval;
 
 	aggr_string = kmalloc(count, GFP_KERNEL);
 
@@ -442,22 +443,21 @@ static ssize_t proc_aggr_write(struct file *file, const char __user *buffer,
 	not_copied = copy_from_user(aggr_string, buffer, count);
 	aggr_string[count - not_copied - 1] = 0;
 
-	strict_strtoul(aggr_string, 10, &aggregation_enabled_tmp);
+	retval = strict_strtoul(aggr_string, 10, &aggregation_enabled_tmp);
 
-	if ((aggregation_enabled_tmp != 0) && (aggregation_enabled_tmp != 1)) {
+	if (retval == -EINVAL || aggregation_enabled_tmp > 1) {
 		printk(KERN_ERR "batman-adv:Aggregation can only be enabled (1) or disabled (0), given value: %li\n", aggregation_enabled_tmp);
-		goto end;
+	}
+	else {
+		printk(KERN_INFO "batman-adv:Changing aggregation from: %s (%i) to: %s (%li)\n",
+		       (atomic_read(&aggregation_enabled) == 1 ?
+			"enabled" : "disabled"),
+		       atomic_read(&aggregation_enabled),
+		       (aggregation_enabled_tmp == 1 ? "enabled" : "disabled"),
+		       aggregation_enabled_tmp);
+		atomic_set(&aggregation_enabled, (unsigned)aggregation_enabled_tmp);
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

