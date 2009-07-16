Return-Path: <andrew.lunn@ascom.ch>
Date: Thu, 16 Jul 2009 09:44:01 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090716074401.GT19071@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [batman-adv]: move vis_format from vis.c to proc.c
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

vis_format is currently in vis.c however this variable is only used in
proc.c.  Move it into proc, and remove the volatile, which should not
be needed.

Signed-off-by: Andrew Lunn <andrew.lunn@ascom.ch>
Index: vis.c
===================================================================
--- vis.c	(revision 1345)
+++ vis.c	(working copy)
@@ -42,7 +42,6 @@
 void free_info(void *data);
 void send_vis_packet(struct vis_info *info);
 void start_vis_timer(void);
-volatile uint8_t vis_format = DOT_DRAW;
 
 
 int vis_info_cmp(void *data1, void *data2) {
Index: vis.h
===================================================================
--- vis.h	(revision 1345)
+++ vis.h	(working copy)
@@ -51,7 +51,6 @@
 
 extern struct hashtable_t *vis_hash;
 extern spinlock_t vis_hash_lock;
-extern volatile uint8_t vis_format;
 
 void receive_vis_packet(struct ethhdr *ethhdr, struct vis_packet *vis_packet, int vis_info_len);
 void vis_set_mode(int mode);
Index: proc.c
===================================================================
--- proc.c	(revision 1345)
+++ proc.c	(working copy)
@@ -31,6 +31,7 @@
 #include "types.h"
 #include "hash.h"
 
+static uint8_t vis_format = DOT_DRAW;
 
 
 static struct proc_dir_entry *proc_batman_dir = NULL, *proc_interface_file = NULL, *proc_orig_interval_file = NULL, *proc_originators_file = NULL;
