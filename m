Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Fri, 18 Jun 2010 19:54:04 +0200
Message-Id: <1276883644-3828-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: permit setting ogm interval to
	JITTER*2
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

When trying to set the originator interval to 40ms, we are asked to set
it to a minimum value of 40ms. This patch permits setting an
originator interval of JITTER*20 (40ms by default) now.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 bat_sysfs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index 05703c1..68ce453 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -259,7 +259,7 @@ static ssize_t store_orig_interval(struct kobject *kobj, struct attribute *attr,
 		return -EINVAL;
 	}
 
-	if (orig_interval_tmp <= JITTER * 2) {
+	if (orig_interval_tmp < JITTER * 2) {
 		printk(KERN_INFO "batman-adv:New originator interval too small: %li (min: %i)\n",
 		       orig_interval_tmp, JITTER * 2);
 		return -EINVAL;
-- 
1.7.1

