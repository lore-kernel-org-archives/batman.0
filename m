Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 21 Jul 2010 00:25:21 +0200
Message-Id: <1279664722-27500-3-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1279664722-27500-1-git-send-email-sven.eckelmann@gmx.de>
References: <1279664722-27500-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] Staging: batman-adv: don't use default
	init_module/cleanup_module function names
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
To: greg@kroah.com
Cc: Randy Dunlap <randy.dunlap@oracle.com>, b.a.t.m.a.n@lists.open-mesh.net

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix two staging drivers to use module_init()/module_exit()
instead of default init_module() and cleanup_module() function names
so that there are no name conflicts when both are built-in.

drivers/staging/dt3155/built-in.o: In function `cleanup_module':
(.text+0xc0): multiple definition of `cleanup_module'
drivers/staging/batman-adv/built-in.o:(.text+0x330): first defined here
drivers/staging/dt3155/built-in.o: In function `init_module':
(.text+0xe60): multiple definition of `init_module'
drivers/staging/batman-adv/built-in.o:(.text+0x400): first defined here

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
[sven.eckelmann@gmx.de: Mark module init and exit functions as static]
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/main.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/batman-adv/main.c b/drivers/staging/batman-adv/main.c
index a4d238b..2686019 100644
--- a/drivers/staging/batman-adv/main.c
+++ b/drivers/staging/batman-adv/main.c
@@ -59,7 +59,7 @@ static struct packet_type batman_adv_packet_type __read_mostly = {
 
 struct workqueue_struct *bat_event_workqueue;
 
-int init_module(void)
+static int __init batman_init(void)
 {
 	int retval;
 
@@ -131,7 +131,7 @@ end:
 	return -ENOMEM;
 }
 
-void cleanup_module(void)
+static void __exit batman_exit(void)
 {
 	deactivate_module();
 
@@ -273,6 +273,9 @@ int is_mcast(uint8_t *addr)
 	return *addr & 0x01;
 }
 
+module_init(batman_init);
+module_exit(batman_exit);
+
 MODULE_LICENSE("GPL");
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
-- 
1.7.1

