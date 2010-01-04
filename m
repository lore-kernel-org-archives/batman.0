Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon,  4 Jan 2010 23:46:14 +0800
Message-Id: <1262619976-5632-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201001042344.02273.lindner_marek@yahoo.de>
References: <201001042344.02273.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: adding gateway functionality
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Via the /proc filesystem you can change the gateway mode of a node
to server or client (default is: off). Servers will announce there
bandwidth, so that clients can choose their best gateway.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv-kernelland/Makefile.kbuild  |    2 +-
 batman-adv-kernelland/gateway_client.c |  335 ++++++++++++++++++++++++++++++++
 batman-adv-kernelland/gateway_client.h |   29 +++
 batman-adv-kernelland/gateway_common.c |  276 ++++++++++++++++++++++++++
 batman-adv-kernelland/gateway_common.h |   34 ++++
 batman-adv-kernelland/main.c           |    6 +
 batman-adv-kernelland/originator.c     |    6 +-
 batman-adv-kernelland/packet.h         |    4 +-
 batman-adv-kernelland/proc.c           |  144 ++++++++++++++
 batman-adv-kernelland/proc.h           |    2 +
 batman-adv-kernelland/routing.c        |   13 ++-
 batman-adv-kernelland/send.c           |    3 +
 batman-adv-kernelland/types.h          |   14 +-
 13 files changed, 860 insertions(+), 8 deletions(-)
 create mode 100644 batman-adv-kernelland/gateway_client.c
 create mode 100644 batman-adv-kernelland/gateway_client.h
 create mode 100644 batman-adv-kernelland/gateway_common.c
 create mode 100644 batman-adv-kernelland/gateway_common.h

diff --git a/batman-adv-kernelland/Makefile.kbuild b/batman-adv-kernelland/Makefile.kbuild
index f75d4af..dc357e7 100644
--- a/batman-adv-kernelland/Makefile.kbuild
+++ b/batman-adv-kernelland/Makefile.kbuild
@@ -32,4 +32,4 @@ EXTRA_CFLAGS += -DREVISION_VERSION=\"r$(REVISION)\"
 endif
 
 obj-m += batman-adv.o
-batman-adv-objs := main.o proc.o send.o routing.o soft-interface.o device.o translation-table.o bitarray.o hash.o ring_buffer.o vis.o hard-interface.o aggregation.o originator.o $(shell [ "2" -eq "$(VERSION)" ] && [ "6" -eq "$(PATCHLEVEL)" ] && [ "$(SUBLEVEL)" -le "28" ] && echo bat_printk.o)
+batman-adv-objs := main.o proc.o send.o routing.o soft-interface.o device.o translation-table.o bitarray.o hash.o ring_buffer.o vis.o hard-interface.o aggregation.o originator.o gateway_common.o gateway_client.o $(shell [ "2" -eq "$(VERSION)" ] && [ "6" -eq "$(PATCHLEVEL)" ] && [ "$(SUBLEVEL)" -le "28" ] && echo bat_printk.o)
diff --git a/batman-adv-kernelland/gateway_client.c b/batman-adv-kernelland/gateway_client.c
new file mode 100644
index 0000000..55789ad
--- /dev/null
+++ b/batman-adv-kernelland/gateway_client.c
@@ -0,0 +1,335 @@
+/*
+ * Copyright (C) 2009 B.A.T.M.A.N. contributors:
+ * Marek Lindner
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ */
+
+#include "main.h"
+#include "gateway_client.h"
+#include "gateway_common.h"
+
+LIST_HEAD(gw_list);
+DEFINE_SPINLOCK(curr_gw_lock);
+DEFINE_SPINLOCK(gw_list_lock);
+atomic_t gw_clnt_class;
+static struct gw_node *curr_gateway;
+
+void gw_deselect(void)
+{
+	spin_lock(&curr_gw_lock);
+	curr_gateway = NULL;
+	spin_unlock(&curr_gw_lock);
+}
+
+void gw_election(void)
+{
+	struct gw_node *gw_node, *curr_gw_tmp = NULL;
+	uint8_t max_tq = 0;
+	uint32_t max_gw_factor = 0, tmp_gw_factor = 0;
+	int down, up;
+
+	/**
+	 * The batman daemon checks here if we already passed a full originator
+	 * cycle in order to make sure we don't choose the first gateway we
+	 * hear about. This check is based on the daemon's uptime which we
+	 * don't have.
+	 **/
+	if (atomic_read(&gw_clnt_class) == 0)
+		return;
+
+	if (curr_gateway)
+		return;
+
+	rcu_read_lock();
+	if (list_empty(&gw_list)) {
+		rcu_read_unlock();
+
+		if (curr_gateway) {
+			bat_dbg(DBG_BATMAN,
+				"Removing selected gateway - no gateway in range\n");
+			gw_deselect();
+		}
+
+		return;
+	}
+
+	list_for_each_entry_rcu(gw_node, &gw_list, list) {
+		if (!gw_node->orig_node->router)
+			continue;
+
+		if (gw_node->deleted)
+			continue;
+
+		switch (atomic_read(&gw_clnt_class)) {
+		case 1: /* fast connection */
+			gw_srv_class_to_kbit(gw_node->orig_node->gw_flags,
+					     &down, &up);
+
+			tmp_gw_factor = (gw_node->orig_node->router->tq_avg *
+					 gw_node->orig_node->router->tq_avg *
+					 down * 100 * 100) /
+					 (TQ_LOCAL_WINDOW_SIZE *
+					 TQ_LOCAL_WINDOW_SIZE * 64);
+
+			if ((tmp_gw_factor > max_gw_factor) ||
+			    ((tmp_gw_factor == max_gw_factor) &&
+			     (gw_node->orig_node->router->tq_avg > max_tq)))
+				curr_gw_tmp = gw_node;
+			break;
+
+		default: /**
+			  * 2:  stable connection (use best statistic)
+			  * 3:  fast-switch (use best statistic but change as
+			  *     soon as a better gateway appears)
+			  * XX: late-switch (use best statistic but change as
+			  *     soon as a better gateway appears which has
+			  *     $routing_class more tq points)
+			  **/
+			if (gw_node->orig_node->router->tq_avg > max_tq)
+				curr_gw_tmp = gw_node;
+			break;
+		}
+
+		if (gw_node->orig_node->router->tq_avg > max_tq)
+			max_tq = gw_node->orig_node->router->tq_avg;
+
+		if (tmp_gw_factor > max_gw_factor)
+			max_gw_factor = tmp_gw_factor;
+	}
+	rcu_read_unlock();
+
+	spin_lock(&curr_gw_lock);
+	if (curr_gateway != curr_gw_tmp) {
+		if ((curr_gateway) && (!curr_gw_tmp))
+			bat_dbg(DBG_BATMAN,
+				"Removing selected gateway - no gateway in range\n");
+		else if ((!curr_gateway) && (curr_gw_tmp))
+			bat_dbg(DBG_BATMAN,
+				"Adding route to gateway %pM (gw_flags: %i, tq: %i)\n",
+				curr_gw_tmp->orig_node->orig,
+				curr_gw_tmp->orig_node->gw_flags,
+				curr_gw_tmp->orig_node->router->tq_avg);
+		else
+			bat_dbg(DBG_BATMAN,
+				"Changing route to gateway %pM (gw_flags: %i, tq: %i)\n",
+				curr_gw_tmp->orig_node->orig,
+				curr_gw_tmp->orig_node->gw_flags,
+				curr_gw_tmp->orig_node->router->tq_avg);
+
+		curr_gateway = curr_gw_tmp;
+	}
+	spin_unlock(&curr_gw_lock);
+}
+
+void gw_check_election(struct orig_node *orig_node)
+{
+	struct gw_node *curr_gateway_tmp;
+	uint8_t gw_tq_avg, orig_tq_avg;
+
+	spin_lock(&curr_gw_lock);
+	curr_gateway_tmp = curr_gateway;
+	spin_unlock(&curr_gw_lock);
+
+	if (!curr_gateway_tmp)
+		return;
+
+	/* this node already is the gateway */
+	if (curr_gateway_tmp->orig_node == orig_node)
+		return;
+
+	if (!orig_node->router)
+		return;
+
+	gw_tq_avg = curr_gateway_tmp->orig_node->router->tq_avg;
+	orig_tq_avg = orig_node->router->tq_avg;
+
+	/* the TQ value has to be better */
+	if (orig_tq_avg < gw_tq_avg)
+		return;
+
+	/**
+	 * if the routing class is greater than 3 the value tells us how much
+	 * greater the TQ value of the new gateway must be
+	 **/
+	if ((atomic_read(&gw_clnt_class) > 3) &&
+	    (orig_tq_avg - gw_tq_avg < atomic_read(&gw_clnt_class)))
+		return;
+
+	bat_dbg(DBG_BATMAN,
+		"Restarting gateway selection: better gateway found (tq curr: %i, tq new: %i) \n",
+		gw_tq_avg, orig_tq_avg);
+
+	gw_deselect();
+}
+
+static void gw_node_add(struct orig_node *orig_node, uint8_t new_gwflags)
+{
+	struct gw_node *gw_node;
+	int down, up;
+
+	gw_node = kmalloc(sizeof(struct gw_node), GFP_ATOMIC);
+	if (!gw_node)
+		return;
+
+	memset(gw_node, 0, sizeof(struct gw_node));
+	INIT_LIST_HEAD(&gw_node->list);
+	gw_node->orig_node = orig_node;
+
+	list_add_tail_rcu(&gw_node->list, &gw_list);
+
+	gw_srv_class_to_kbit(new_gwflags, &down, &up);
+	bat_dbg(DBG_BATMAN,
+		"Found new gateway %pM -> gw_class: %i - %i%s/%i%s\n",
+		orig_node->orig, new_gwflags,
+		(down > 2048 ? down / 1024 : down),
+		(down > 2048 ? "MBit" : "KBit"),
+		(up > 2048 ? up / 1024 : up),
+		(up > 2048 ? "MBit" : "KBit"));
+}
+
+void gw_node_update(struct orig_node *orig_node, uint8_t new_gwflags)
+{
+	struct gw_node *gw_node;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(gw_node, &gw_list, list) {
+		if (gw_node->orig_node != orig_node)
+			continue;
+
+		bat_dbg(DBG_BATMAN,
+			"Gateway class of originator %pM changed from %i to %i\n",
+			orig_node->orig, gw_node->orig_node->gw_flags,
+			new_gwflags);
+
+		gw_node->deleted = 0;
+
+		if (new_gwflags == 0) {
+			gw_node->deleted = jiffies;
+			bat_dbg(DBG_BATMAN,
+				"Gateway %pM removed from gateway list\n",
+				orig_node->orig);
+
+			if (gw_node == curr_gateway)
+				gw_deselect();
+		}
+
+		return;
+	}
+	rcu_read_unlock();
+
+	if (new_gwflags == 0)
+		return;
+
+	gw_node_add(orig_node, new_gwflags);
+}
+
+void gw_node_delete(struct orig_node *orig_node)
+{
+	return gw_node_update(orig_node, 0);
+}
+
+static void gw_node_free(struct rcu_head *rcu)
+{
+	struct gw_node *gw_node = container_of(rcu, struct gw_node, rcu);
+	kfree(gw_node);
+}
+
+void gw_node_purge_deleted(void)
+{
+	struct gw_node *gw_node, *gw_node_tmp;
+	unsigned long timeout = (2 * PURGE_TIMEOUT * HZ) / 1000;
+
+	spin_lock(&gw_list_lock);
+
+	list_for_each_entry_safe(gw_node, gw_node_tmp, &gw_list, list) {
+		if ((gw_node->deleted) &&
+		    (time_after(jiffies, gw_node->deleted + timeout))) {
+
+			list_del_rcu(&gw_node->list);
+			call_rcu(&gw_node->rcu, gw_node_free);
+		}
+	}
+
+	spin_unlock(&gw_list_lock);
+}
+
+void gw_node_list_free(void)
+{
+	struct gw_node *gw_node, *gw_node_tmp;
+
+	spin_lock(&gw_list_lock);
+
+	list_for_each_entry_safe(gw_node, gw_node_tmp, &gw_list, list) {
+		list_del_rcu(&gw_node->list);
+		call_rcu(&gw_node->rcu, gw_node_free);
+	}
+
+	gw_deselect();
+	spin_unlock(&gw_list_lock);
+}
+
+static int _write_buffer_text(unsigned char *buff, int bytes_written,
+			      struct gw_node *gw_node)
+{
+	int down, up;
+	char gw_str[ETH_STR_LEN], router_str[ETH_STR_LEN];
+
+	addr_to_string(gw_str, gw_node->orig_node->orig);
+	addr_to_string(router_str, gw_node->orig_node->router->addr);
+	gw_srv_class_to_kbit(gw_node->orig_node->gw_flags, &down, &up);
+
+	return sprintf(buff + bytes_written,
+		       "%s %-17s (%3i) %17s [%10s]: %3i - %i%s/%i%s\n",
+		       (curr_gateway == gw_node ? "=>" : "  "),
+		       gw_str,
+		       gw_node->orig_node->router->tq_avg,
+		       router_str,
+		       gw_node->orig_node->router->if_incoming->dev,
+		       gw_node->orig_node->gw_flags,
+		       (down > 2048 ? down / 1024 : down),
+		       (down > 2048 ? "MBit" : "KBit"),
+		       (up > 2048 ? up / 1024 : up),
+		       (up > 2048 ? "MBit" : "KBit"));
+}
+
+int gw_client_fill_buffer_text(unsigned char *buff, int buff_len)
+{
+	struct gw_node *gw_node;
+	int bytes_written = 0, gw_count = 0;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(gw_node, &gw_list, list) {
+		if (gw_node->deleted)
+			continue;
+
+		if (!gw_node->orig_node->router)
+			continue;
+
+		if (buff_len < bytes_written + (2 * ETH_STR_LEN) + 30)
+			break;
+
+		bytes_written += _write_buffer_text(buff,
+						    bytes_written,
+						    gw_node);
+		gw_count++;
+	}
+	rcu_read_unlock();
+
+	if (gw_count == 0)
+		sprintf(buff, "No gateways in range ... \n");
+
+	return bytes_written;
+}
diff --git a/batman-adv-kernelland/gateway_client.h b/batman-adv-kernelland/gateway_client.h
new file mode 100644
index 0000000..5eb1e4c
--- /dev/null
+++ b/batman-adv-kernelland/gateway_client.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2009 B.A.T.M.A.N. contributors:
+ * Marek Lindner
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ */
+
+extern atomic_t gw_clnt_class;
+
+void gw_deselect(void);
+void gw_election(void);
+void gw_check_election(struct orig_node *orig_node);
+void gw_node_update(struct orig_node *orig_node, uint8_t new_gwflags);
+void gw_node_delete(struct orig_node *orig_node);
+void gw_node_purge_deleted(void);
+void gw_node_list_free(void);
+int gw_client_fill_buffer_text(unsigned char *buff, int buff_len);
diff --git a/batman-adv-kernelland/gateway_common.c b/batman-adv-kernelland/gateway_common.c
new file mode 100644
index 0000000..1d7fd2c
--- /dev/null
+++ b/batman-adv-kernelland/gateway_common.c
@@ -0,0 +1,276 @@
+/*
+ * Copyright (C) 2009 B.A.T.M.A.N. contributors:
+ * Marek Lindner
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ */
+
+#include "main.h"
+#include "gateway_common.h"
+#include "gateway_client.h"
+
+atomic_t gw_mode;
+atomic_t gw_srv_class;
+
+/* calculates the gateway class from kbit */
+void kbit_to_gw_srv_class(int down, int up, long *gw_srv_class)
+{
+	int mdown = 0, tdown, tup, difference;
+	uint8_t sbit, part;
+
+	*gw_srv_class = 0;
+	difference = 0x0FFFFFFF;
+
+	/* test all downspeeds */
+	for (sbit = 0; sbit < 2; sbit++) {
+		for (part = 0; part < 16; part++) {
+			tdown = 32 * (sbit + 2) * (1 << part);
+
+			if (abs(tdown - down) < difference) {
+				*gw_srv_class = (sbit << 7) + (part << 3);
+				difference = abs(tdown - down);
+				mdown = tdown;
+			}
+		}
+	}
+
+	/* test all upspeeds */
+	difference = 0x0FFFFFFF;
+
+	for (part = 0; part < 8; part++) {
+		tup = ((part + 1) * (mdown)) / 8;
+
+		if (abs(tup - up) < difference) {
+			*gw_srv_class = (*gw_srv_class & 0xF8) | part;
+			difference = abs(tup - up);
+		}
+	}
+}
+
+/* returns the up and downspeeds in kbit, calculated from the class */
+void gw_srv_class_to_kbit(uint8_t gw_srv_class, int *down, int *up)
+{
+	char sbit = (gw_srv_class & 0x80) >> 7;
+	char dpart = (gw_srv_class & 0x7C) >> 3;
+	char upart = (gw_srv_class & 0x07);
+
+	if (!gw_srv_class) {
+		*down = 0;
+		*up = 0;
+		return;
+	}
+
+	*down = 32 * (sbit + 2) * (1 << dpart);
+	*up = ((upart + 1) * (*down)) / 8;
+}
+
+static bool parse_gw_mode_tok(char *tokptr, long *gw_mode_tmp,
+			      char **gw_mode_tmp_str, long *gw_clnt_class_tmp,
+			      long *up, long *down)
+{
+	int ret;
+	char *slash_ptr, *tmp_ptr;
+
+	switch (*gw_mode_tmp) {
+	case GW_MODE_CLIENT:
+		ret = strict_strtol(tokptr, 10, gw_clnt_class_tmp);
+		if (ret) {
+			printk(KERN_ERR "Client class of gateway mode invalid: %s\n",
+			       tokptr);
+			return false;
+		}
+
+		if (*gw_clnt_class_tmp > TQ_MAX_VALUE) {
+			printk(KERN_ERR "Client class of gateway mode greater than %i: %ld\n",
+					TQ_MAX_VALUE, *gw_clnt_class_tmp);
+			return false;
+		}
+
+		break;
+	case GW_MODE_SERVER:
+		slash_ptr = strchr(tokptr, '/');
+		if (slash_ptr)
+			*slash_ptr = 0;
+
+		ret = strict_strtol(tokptr, 10, down);
+		if (ret) {
+			printk(KERN_ERR "Download speed of gateway mode invalid: %s\n",
+			       tokptr);
+			return false;
+		}
+
+		tmp_ptr = tokptr + strlen(tokptr) - 4;
+
+		if ((strlen(tokptr) > 4) &&
+			((strncmp(tmp_ptr, "MBit", 4) == 0) ||
+			(strncmp(tmp_ptr, "mbit", 4) == 0) ||
+			(strncmp(tmp_ptr, "Mbit", 4) == 0)))
+			*down *= 1024;
+
+		/* we also got some upload info */
+		if (slash_ptr) {
+			ret = strict_strtol(slash_ptr + 1, 10, up);
+			if (ret) {
+				printk(KERN_ERR "Upload speed of gateway mode invalid: %s\n",
+				       slash_ptr + 1);
+				return false;
+			}
+
+			tmp_ptr = slash_ptr + 1 + strlen(slash_ptr + 1) - 4;
+
+			if ((strlen(slash_ptr + 1) > 4) &&
+				((strncmp(tmp_ptr, "MBit", 4) == 0) ||
+				(strncmp(tmp_ptr, "mbit", 4) == 0) ||
+				(strncmp(tmp_ptr, "Mbit", 4) == 0)))
+				*up *= 1024;
+
+			*slash_ptr = '/';
+		}
+
+		break;
+	default:
+		if (strcmp(tokptr, GW_MODE_OFF_NAME) == 0) {
+			*gw_mode_tmp = GW_MODE_OFF;
+			*gw_mode_tmp_str = GW_MODE_OFF_NAME;
+		}
+
+		if (strcmp(tokptr, GW_MODE_CLIENT_NAME) == 0) {
+			*gw_mode_tmp = GW_MODE_CLIENT;
+			*gw_mode_tmp_str = GW_MODE_CLIENT_NAME;
+		}
+
+		if (strcmp(tokptr, GW_MODE_SERVER_NAME) == 0) {
+			*gw_mode_tmp = GW_MODE_SERVER;
+			*gw_mode_tmp_str = GW_MODE_SERVER_NAME;
+		}
+	}
+
+	return true;
+}
+
+ssize_t gw_mode_set(const char __user *userbuffer, size_t count)
+{
+	char *gw_mode_string, *tokptr, *cp;
+	char *gw_mode_curr_str, *gw_mode_tmp_str = NULL;
+	int finished, not_copied = 0;
+	long gw_mode_curr, gw_mode_tmp = GW_MODE_OFF;
+	long gw_srv_class_tmp = 0, gw_clnt_class_tmp = 0, up = 0, down = 0;
+	bool ret;
+
+	gw_mode_string = kmalloc(count, GFP_KERNEL);
+
+	if (!gw_mode_string)
+		return -ENOMEM;
+
+	not_copied = copy_from_user(gw_mode_string, userbuffer, count);
+	gw_mode_string[count - not_copied - 1] = 0;
+
+	tokptr = gw_mode_string;
+	gw_mode_curr = atomic_read(&gw_mode);
+
+	for (cp = gw_mode_string, finished = 0; !finished; cp++) {
+		switch (*cp) {
+		case 0:
+			finished = 1;
+		case ' ':
+		case '\n':
+		case '\t':
+			*cp = 0;
+			ret = parse_gw_mode_tok(tokptr, &gw_mode_tmp,
+						&gw_mode_tmp_str,
+						&gw_clnt_class_tmp,
+						&up, &down);
+
+			if (!ret)
+				goto end;
+
+			tokptr = cp + 1;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (!gw_mode_tmp_str) {
+		printk(KERN_INFO "Gateway mode can only be set to: '%s', '%s' or '%s' - given value: %s\n",
+			GW_MODE_OFF_NAME, GW_MODE_CLIENT_NAME,
+			GW_MODE_SERVER_NAME, gw_mode_string);
+		goto end;
+	}
+
+	switch (gw_mode_curr) {
+	case GW_MODE_CLIENT:
+		gw_mode_curr_str = GW_MODE_CLIENT_NAME;
+		break;
+	case GW_MODE_SERVER:
+		gw_mode_curr_str = GW_MODE_SERVER_NAME;
+		break;
+	default:
+		gw_mode_curr_str = GW_MODE_OFF_NAME;
+		break;
+	}
+
+	switch (gw_mode_tmp) {
+	case GW_MODE_CLIENT:
+		if ((gw_mode_tmp == GW_MODE_CLIENT) && (!gw_clnt_class_tmp))
+			gw_clnt_class_tmp = 20;
+
+		printk(KERN_INFO "Changing gateway mode from: '%s' to: '%s' (gw_clnt_class: %ld)\n",
+			  gw_mode_curr_str, gw_mode_tmp_str,
+			  gw_clnt_class_tmp);
+		break;
+	case GW_MODE_SERVER:
+		if (!down)
+			down = 2000;
+
+		if (!up)
+			up = down / 5;
+
+		kbit_to_gw_srv_class(down, up, &gw_srv_class_tmp);
+
+		/**
+		 * the gw class we guessed above might not match the given
+		 * speeds, hence we need to calculate it back to show the
+		 * number that is going to be propagated
+		 **/
+		gw_srv_class_to_kbit((uint8_t)gw_srv_class_tmp,
+				     (int *)&down, (int *)&up);
+
+		printk(KERN_INFO
+			  "Changing gateway mode from: '%s' to: '%s' (gw_srv_class: %ld -> propagating: %ld%s/%ld%s)\n",
+			  gw_mode_curr_str, gw_mode_tmp_str,
+			  gw_srv_class_tmp,
+			  (down > 2048 ? down / 1024 : down),
+			  (down > 2048 ? "MBit" : "KBit"),
+			  (up > 2048 ? up / 1024 : up),
+			  (up > 2048 ? "MBit" : "KBit"));
+		break;
+	default:
+		printk(KERN_INFO "Changing gateway mode from: '%s' to: '%s'\n",
+			  gw_mode_curr_str, gw_mode_tmp_str);
+		break;
+	}
+
+	atomic_set(&gw_mode, gw_mode_tmp);
+	atomic_set(&gw_srv_class, gw_srv_class_tmp);
+	atomic_set(&gw_clnt_class, gw_clnt_class_tmp);
+
+	if (gw_clnt_class_tmp == 0)
+		gw_deselect();
+
+end:
+	kfree(gw_mode_string);
+	return count;
+}
diff --git a/batman-adv-kernelland/gateway_common.h b/batman-adv-kernelland/gateway_common.h
new file mode 100644
index 0000000..365cd00
--- /dev/null
+++ b/batman-adv-kernelland/gateway_common.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright (C) 2009 B.A.T.M.A.N. contributors:
+ * Marek Lindner
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ */
+
+enum gw_modes {
+	GW_MODE_OFF,
+	GW_MODE_CLIENT,
+	GW_MODE_SERVER,
+};
+
+#define GW_MODE_OFF_NAME	"off"
+#define GW_MODE_CLIENT_NAME	"client"
+#define GW_MODE_SERVER_NAME	"server"
+
+extern atomic_t gw_mode;
+extern atomic_t gw_srv_class;
+
+void gw_srv_class_to_kbit(uint8_t gw_class, int *down, int *up);
+ssize_t gw_mode_set(const char __user *userbuffer, size_t count);
diff --git a/batman-adv-kernelland/main.c b/batman-adv-kernelland/main.c
index 1d80ea3..a64f070 100644
--- a/batman-adv-kernelland/main.c
+++ b/batman-adv-kernelland/main.c
@@ -28,6 +28,8 @@
 #include "device.h"
 #include "translation-table.h"
 #include "hard-interface.h"
+#include "gateway_common.h"
+#include "gateway_client.h"
 #include "types.h"
 #include "vis.h"
 #include "hash.h"
@@ -85,6 +87,9 @@ int init_module(void)
 	atomic_set(&vis_interval, 1000);/* TODO: raise this later, this is only
 					 * for debugging now. */
 	atomic_set(&aggregation_enabled, 1);
+	atomic_set(&gw_mode, GW_MODE_OFF);
+	atomic_set(&gw_srv_class, 0);
+	atomic_set(&gw_clnt_class, 0);
 
 	/* the name should not be longer than 10 chars - see
 	 * http://lwn.net/Articles/23634/ */
@@ -191,6 +196,7 @@ void shutdown_module(void)
 
 	/* TODO: unregister BATMAN pack */
 
+	gw_node_list_free();
 	originator_free();
 
 	hna_local_free();
diff --git a/batman-adv-kernelland/originator.c b/batman-adv-kernelland/originator.c
index cff433e..a9ba24c 100644
--- a/batman-adv-kernelland/originator.c
+++ b/batman-adv-kernelland/originator.c
@@ -27,7 +27,7 @@
 #include "translation-table.h"
 #include "routing.h"
 #include "compat.h"
-
+#include "gateway_client.h"
 
 static DECLARE_DELAYED_WORK(purge_orig_wq, purge_orig);
 
@@ -241,6 +241,8 @@ void purge_orig(struct work_struct *work)
 	while (hash_iterate(orig_hash, &hashit)) {
 		orig_node = hashit.bucket->data;
 		if (purge_orig_node(orig_node)) {
+			if (orig_node->gw_flags)
+				gw_node_delete(orig_node);
 			hash_remove_bucket(orig_hash, &hashit);
 			free_orig_node(orig_node);
 		}
@@ -248,5 +250,7 @@ void purge_orig(struct work_struct *work)
 
 	spin_unlock_irqrestore(&orig_hash_lock, flags);
 
+	gw_node_purge_deleted();
+	gw_election();
 	start_purge_timer();
 }
diff --git a/batman-adv-kernelland/packet.h b/batman-adv-kernelland/packet.h
index ad006ce..b543b03 100644
--- a/batman-adv-kernelland/packet.h
+++ b/batman-adv-kernelland/packet.h
@@ -28,7 +28,7 @@
 #define BAT_VIS       0x05
 
 /* this file is included by batctl which needs these defines */
-#define COMPAT_VERSION 8
+#define COMPAT_VERSION 9
 #define DIRECTLINK 0x40
 #define VIS_SERVER 0x20
 
@@ -53,6 +53,8 @@ struct batman_packet {
 	uint8_t  prev_sender[6];
 	uint8_t  ttl;
 	uint8_t  num_hna;
+	uint8_t  gw_flags;  /* flags related to gateway class */
+	uint8_t  align;
 } __attribute__((packed));
 
 #define BAT_PACKET_LEN sizeof(struct batman_packet)
diff --git a/batman-adv-kernelland/proc.c b/batman-adv-kernelland/proc.c
index 1bf493f..747ed5f 100644
--- a/batman-adv-kernelland/proc.c
+++ b/batman-adv-kernelland/proc.c
@@ -28,6 +28,8 @@
 #include "hash.h"
 #include "vis.h"
 #include "compat.h"
+#include "gateway_common.h"
+#include "gateway_client.h"
 
 static struct proc_dir_entry *proc_batman_dir, *proc_interface_file;
 static struct proc_dir_entry *proc_orig_interval_file, *proc_originators_file;
@@ -35,6 +37,7 @@ static struct proc_dir_entry *proc_transt_local_file;
 static struct proc_dir_entry *proc_transt_global_file;
 static struct proc_dir_entry *proc_vis_srv_file, *proc_vis_data_file;
 static struct proc_dir_entry *proc_aggr_file;
+static struct proc_dir_entry *proc_gw_mode_file, *proc_gw_srv_list_file;
 
 static int proc_interfaces_read(struct seq_file *seq, void *offset)
 {
@@ -462,6 +465,99 @@ static int proc_aggr_open(struct inode *inode, struct file *file)
 	return single_open(file, proc_aggr_read, NULL);
 }
 
+static int proc_gw_mode_read(struct seq_file *seq, void *offset)
+{
+	int down, up;
+	long gw_mode_curr = atomic_read(&gw_mode);
+	uint8_t gw_srv_class_curr = (uint8_t)atomic_read(&gw_srv_class);
+
+	gw_srv_class_to_kbit(gw_srv_class_curr, &down, &up);
+
+	seq_printf(seq, "[%c] %s\n",
+		   (gw_mode_curr == GW_MODE_OFF) ? 'x' : ' ',
+		   GW_MODE_OFF_NAME);
+
+	if (gw_mode_curr == GW_MODE_CLIENT)
+		seq_printf(seq, "[x] %s (gw_clnt_class: %i)\n",
+			   GW_MODE_CLIENT_NAME,
+			   atomic_read(&gw_clnt_class));
+	else
+		seq_printf(seq, "[ ] %s\n", GW_MODE_CLIENT_NAME);
+
+	if (gw_mode_curr == GW_MODE_SERVER)
+		seq_printf(seq,
+			   "[x] %s (gw_srv_class: %i -> propagating: %i%s/%i%s)\n",
+			   GW_MODE_SERVER_NAME,
+			   gw_srv_class_curr,
+			   (down > 2048 ? down / 1024 : down),
+			   (down > 2048 ? "MBit" : "KBit"),
+			   (up > 2048 ? up / 1024 : up),
+			   (up > 2048 ? "MBit" : "KBit"));
+	else
+		seq_printf(seq, "[ ] %s\n", GW_MODE_SERVER_NAME);
+
+	return 0;
+}
+
+static int proc_gw_mode_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, proc_gw_mode_read, NULL);
+}
+
+static ssize_t proc_gw_mode_write(struct file *instance,
+				    const char __user *userbuffer,
+				    size_t count, loff_t *data)
+{
+	return gw_mode_set(userbuffer, count);
+}
+
+static int proc_gw_srv_list_read(struct seq_file *seq, void *offset)
+{
+	char *buff;
+	int buffsize = 4096;
+
+	buff = kmalloc(buffsize, GFP_KERNEL);
+	if (!buff)
+		return 0;
+
+	rcu_read_lock();
+	if (list_empty(&if_list)) {
+		rcu_read_unlock();
+		seq_printf(seq,
+			   "BATMAN disabled - please specify interfaces to enable it\n");
+		goto end;
+	}
+
+	if (((struct batman_if *)if_list.next)->if_active != IF_ACTIVE) {
+		rcu_read_unlock();
+		seq_printf(seq,
+			   "BATMAN disabled - primary interface not active\n");
+		goto end;
+	}
+
+	seq_printf(seq,
+		   "      %-12s (%s/%i) %17s [%10s]: gw_srv_class ... [B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s] \n",
+		   "Gateway", "#", TQ_MAX_VALUE, "Nexthop",
+		   "outgoingIF", SOURCE_VERSION, REVISION_VERSION_STR,
+		   ((struct batman_if *)if_list.next)->dev,
+		   ((struct batman_if *)if_list.next)->addr_str);
+
+	rcu_read_unlock();
+
+	gw_client_fill_buffer_text(buff, buffsize);
+	seq_printf(seq, "%s", buff);
+
+end:
+	kfree(buff);
+	return 0;
+}
+
+static int proc_gw_srv_list_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, proc_gw_srv_list_read, NULL);
+}
+
+
 /* satisfying different prototypes ... */
 static ssize_t proc_dummy_write(struct file *file, const char __user *buffer,
 				size_t count, loff_t *ppos)
@@ -469,6 +565,24 @@ static ssize_t proc_dummy_write(struct file *file, const char __user *buffer,
 	return count;
 }
 
+static const struct file_operations proc_gw_srv_list_fops = {
+	.owner		= THIS_MODULE,
+	.open		= proc_gw_srv_list_open,
+	.read		= seq_read,
+	.write		= proc_dummy_write,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static const struct file_operations proc_gw_mode_fops = {
+	.owner		= THIS_MODULE,
+	.open		= proc_gw_mode_open,
+	.read		= seq_read,
+	.write		= proc_gw_mode_write,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static const struct file_operations proc_aggr_fops = {
 	.owner		= THIS_MODULE,
 	.open		= proc_aggr_open,
@@ -567,6 +681,12 @@ void cleanup_procfs(void)
 	if (proc_aggr_file)
 		remove_proc_entry(PROC_FILE_AGGR, proc_batman_dir);
 
+	if (proc_gw_mode_file)
+		remove_proc_entry(PROC_FILE_GW_MODE, proc_batman_dir);
+
+	if (proc_gw_srv_list_file)
+		remove_proc_entry(PROC_FILE_GW_SRV_LIST, proc_batman_dir);
+
 	if (proc_batman_dir)
 #ifdef __NET_NET_NAMESPACE_H
 		remove_proc_entry(PROC_ROOT_DIR, init_net.proc_net);
@@ -671,5 +791,29 @@ int setup_procfs(void)
 		return -EFAULT;
 	}
 
+	proc_gw_mode_file = create_proc_entry(PROC_FILE_GW_MODE,
+					   S_IWUSR | S_IRUGO,
+					   proc_batman_dir);
+	if (proc_gw_mode_file) {
+		proc_gw_mode_file->proc_fops = &proc_gw_mode_fops;
+	} else {
+		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n",
+		       PROC_ROOT_DIR, PROC_FILE_GW_MODE);
+		cleanup_procfs();
+		return -EFAULT;
+	}
+
+	proc_gw_srv_list_file = create_proc_entry(PROC_FILE_GW_SRV_LIST,
+					   S_IWUSR | S_IRUGO,
+					   proc_batman_dir);
+	if (proc_gw_srv_list_file) {
+		proc_gw_srv_list_file->proc_fops = &proc_gw_srv_list_fops;
+	} else {
+		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n",
+		       PROC_ROOT_DIR, PROC_FILE_GW_SRV_LIST);
+		cleanup_procfs();
+		return -EFAULT;
+	}
+
 	return 0;
 }
diff --git a/batman-adv-kernelland/proc.h b/batman-adv-kernelland/proc.h
index cd690e0..af38d40 100644
--- a/batman-adv-kernelland/proc.h
+++ b/batman-adv-kernelland/proc.h
@@ -34,6 +34,8 @@
 #define PROC_FILE_VIS_SRV "vis_server"
 #define PROC_FILE_VIS_DATA "vis_data"
 #define PROC_FILE_AGGR "aggregate_ogm"
+#define PROC_FILE_GW_MODE "gateway_mode"
+#define PROC_FILE_GW_SRV_LIST "gateway_srv_list"
 
 void cleanup_procfs(void);
 int setup_procfs(void);
diff --git a/batman-adv-kernelland/routing.c b/batman-adv-kernelland/routing.c
index 2eb932f..da6a779 100644
--- a/batman-adv-kernelland/routing.c
+++ b/batman-adv-kernelland/routing.c
@@ -33,6 +33,7 @@
 #include "vis.h"
 #include "aggregation.h"
 #include "compat.h"
+#include "gateway_client.h"
 
 DECLARE_WAIT_QUEUE_HEAD(thread_wait);
 
@@ -306,10 +307,20 @@ static void update_orig(struct orig_node *orig_node, struct ethhdr *ethhdr,
 		goto update_hna;
 
 	update_routes(orig_node, neigh_node, hna_buff, tmp_hna_buff_len);
-	return;
+	goto update_gw;
 
 update_hna:
 	update_routes(orig_node, orig_node->router, hna_buff, tmp_hna_buff_len);
+
+update_gw:
+	if (orig_node->gw_flags != batman_packet->gw_flags)
+		gw_node_update(orig_node, batman_packet->gw_flags);
+
+	orig_node->gw_flags = batman_packet->gw_flags;
+
+	/* restart gateway selection if fast or late switching was enabled */
+	if ((orig_node->gw_flags) && (atomic_read(&gw_clnt_class) > 2))
+		gw_check_election(orig_node);
 }
 
 static char count_real_packets(struct ethhdr *ethhdr,
diff --git a/batman-adv-kernelland/send.c b/batman-adv-kernelland/send.c
index edfdd5d..a40e8b8 100644
--- a/batman-adv-kernelland/send.c
+++ b/batman-adv-kernelland/send.c
@@ -28,6 +28,7 @@
 #include "types.h"
 #include "vis.h"
 #include "aggregation.h"
+#include "gateway_common.h"
 
 #include "compat.h"
 
@@ -279,6 +280,8 @@ void schedule_own_packet(struct batman_if *batman_if)
 	else
 		batman_packet->flags = 0;
 
+	batman_packet->gw_flags = (uint8_t)atomic_read(&gw_srv_class);
+
 	/* could be read by receive_bat_packet() */
 	atomic_inc(&batman_if->seqno);
 
diff --git a/batman-adv-kernelland/types.h b/batman-adv-kernelland/types.h
index dec1b54..495d94a 100644
--- a/batman-adv-kernelland/types.h
+++ b/batman-adv-kernelland/types.h
@@ -43,7 +43,6 @@ struct batman_if {
 	unsigned char *packet_buff;
 	int packet_len;
 	struct rcu_head rcu;
-
 };
 
 struct orig_node {               /* structure for orig_list maintaining nodes of mesh */
@@ -55,10 +54,10 @@ struct orig_node {               /* structure for orig_list maintaining nodes of
 	uint8_t tq_own;
 	int tq_asym_penalty;
 	unsigned long last_valid;        /* when last packet from this node was received */
-/*	uint8_t  gwflags;      * flags related to gateway functions: gateway class */
-	uint8_t  flags;    		/* for now only VIS_SERVER flag. */
+	uint8_t gw_flags;      /* flags related to gateway class */
+	uint8_t flags;    /* for now only VIS_SERVER flag. */
 	unsigned char *hna_buff;
-	int16_t  hna_buff_len;
+	int16_t hna_buff_len;
 	uint16_t last_real_seqno;   /* last and best known squence number */
 	uint8_t last_ttl;         /* ttl of last received packet */
 	TYPE_OF_WORD bcast_bits[NUM_WORDS];
@@ -66,6 +65,13 @@ struct orig_node {               /* structure for orig_list maintaining nodes of
 	struct list_head neigh_list;
 };
 
+struct gw_node {
+	struct list_head list;
+	struct orig_node *orig_node;
+	unsigned long deleted;
+	struct rcu_head rcu;
+};
+
 struct neigh_node {
 	struct list_head list;
 	uint8_t addr[ETH_ALEN];
-- 
1.6.5.7

