Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 20 Jul 2010 23:46:19 +0200
Message-Id: <1279662379-17592-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1279662080-17198-1-git-send-email-sven.eckelmann@gmx.de>
References: <1279662080-17198-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCHv3] batman-adv: don't use default
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
To: b.a.t.m.a.n@lists.open-mesh.org

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
 ... and again due to a copy and paste error

 batman-adv/main.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/batman-adv/main.c b/batman-adv/main.c
index 1b3acd1..64925dc 100644
--- a/batman-adv/main.c
+++ b/batman-adv/main.c
@@ -58,7 +58,7 @@ static struct packet_type batman_adv_packet_type __read_mostly = {
 
 struct workqueue_struct *bat_event_workqueue;
 
-int init_module(void)
+static int __init batman_init(void)
 {
 	int retval;
 
@@ -127,7 +127,7 @@ end:
 	return -ENOMEM;
 }
 
-void cleanup_module(void)
+static void __exit batman_exit(void)
 {
 	deactivate_module();
 
@@ -270,6 +270,9 @@ int is_mcast(uint8_t *addr)
 	return *addr & 0x01;
 }
 
+module_init(batman_init);
+module_exit(batman_exit);
+
 MODULE_LICENSE("GPL");
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
-- 
1.7.1

