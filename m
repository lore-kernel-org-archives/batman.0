Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 19 Jul 2016 22:44:08 +0200
Message-Id: <1468961051-6447-1-git-send-email-sven@narfation.org>
In-Reply-To: <3501586.3dVhjbZHzy@sven-edge>
References: <3501586.3dVhjbZHzy@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH 1/4] batctl: Replace list implementation with
	linux-like-list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

The list-batman implementation of linked lists has an interface which tries
to resample the linux double linked list implementation but in reality is
incompatible. This resulted in code which moves most of the pointer
arithmetic back to the actual code. This is rather unfortunate because this
abstraction should reduce the pointer arithmetic and not increase it.

Also the incompatibilities between the list implementation used in
batman-adv and the one used by batctl made coding features in both
components error prone because each component required a slightly different
implementation for the same list manipulation.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile      |   1 -
 bisect_iv.c   |  40 ++-
 bisect_iv.h   |  10 +-
 list-batman.c | 123 ---------
 list-batman.h | 120 ---------
 list.h        | 834 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tcpdump.c     |   7 +-
 tcpdump.h     |   2 +-
 8 files changed, 860 insertions(+), 277 deletions(-)
 delete mode 100644 list-batman.c
 delete mode 100644 list-batman.h
 create mode 100644 list.h

diff --git a/Makefile b/Makefile
index 5dc8fe8..e980587 100755
--- a/Makefile
+++ b/Makefile
@@ -32,7 +32,6 @@ OBJ += genl.o
 OBJ += hash.o
 OBJ += interface.o
 OBJ += ioctl.o
-OBJ += list-batman.o
 OBJ += main.o
 OBJ += netlink.o
 OBJ += ping.o
diff --git a/bisect_iv.c b/bisect_iv.c
index 0f2c0cb..1cb79eb 100644
--- a/bisect_iv.c
+++ b/bisect_iv.c
@@ -92,8 +92,8 @@ static struct bat_node *node_get(char *name)
 
 	strncpy(bat_node->name, name, NAME_LEN);
 	bat_node->name[NAME_LEN - 1] = '\0';
-	INIT_LIST_HEAD_FIRST(bat_node->orig_event_list);
-	INIT_LIST_HEAD_FIRST(bat_node->rt_table_list);
+	INIT_LIST_HEAD(&bat_node->orig_event_list);
+	INIT_LIST_HEAD(&bat_node->rt_table_list);
 	memset(bat_node->loop_magic, 0, sizeof(bat_node->loop_magic));
 	memset(bat_node->loop_magic2, 0, sizeof(bat_node->loop_magic2));
 	hash_add(node_hash, bat_node);
@@ -112,9 +112,8 @@ static struct orig_event *orig_event_new(struct bat_node *bat_node, struct bat_n
 		return NULL;
 	}
 
-	INIT_LIST_HEAD(&orig_event->list);
-	INIT_LIST_HEAD_FIRST(orig_event->event_list);
-	INIT_LIST_HEAD_FIRST(orig_event->rt_hist_list);
+	INIT_LIST_HEAD(&orig_event->event_list);
+	INIT_LIST_HEAD(&orig_event->rt_hist_list);
 	orig_event->orig_node = orig_node;
 	list_add_tail(&orig_event->list, &bat_node->orig_event_list);
 
@@ -166,21 +165,21 @@ static void node_free(void *data)
 
 	list_for_each_entry_safe(orig_event, orig_event_tmp, &bat_node->orig_event_list, list) {
 		list_for_each_entry_safe(seqno_event, seqno_event_tmp, &orig_event->event_list, list) {
-			list_del((struct list_head *)&orig_event->event_list, &seqno_event->list, &orig_event->event_list);
+			list_del(&seqno_event->list);
 			free(seqno_event);
 		}
 
 		list_for_each_entry_safe(rt_hist, rt_hist_tmp, &orig_event->rt_hist_list, list) {
-			list_del((struct list_head *)&orig_event->rt_hist_list, &rt_hist->list, &orig_event->rt_hist_list);
+			list_del(&rt_hist->list);
 			free(rt_hist);
 		}
 
-		list_del((struct list_head *)&bat_node->orig_event_list, &orig_event->list, &bat_node->orig_event_list);
+		list_del(&orig_event->list);
 		free(orig_event);
 	}
 
 	list_for_each_entry_safe(rt_table, rt_table_tmp, &bat_node->rt_table_list, list) {
-		list_del((struct list_head *)&bat_node->rt_table_list, &rt_table->list, &bat_node->rt_table_list);
+		list_del(&rt_table->list);
 
 		free(rt_table->entries);
 		free(rt_table);
@@ -248,10 +247,8 @@ static int routing_table_new(char *orig, char *next_hop, char *old_next_hop, cha
 		goto table_free;
 	}
 
-	INIT_LIST_HEAD(&rt_table->list);
 	rt_table->num_entries = 1;
 
-	INIT_LIST_HEAD(&rt_hist->list);
 	rt_hist->prev_rt_hist = NULL;
 	rt_hist->next_hop = next_hop_node;
 	rt_hist->flags = rt_flag;
@@ -310,7 +307,6 @@ static int routing_table_new(char *orig, char *next_hop, char *old_next_hop, cha
 				goto rt_hist_free;
 			}
 
-			INIT_LIST_HEAD(&seqno_event->list);
 			seqno_event->orig = node_get(orig);
 			seqno_event->neigh = NULL;
 			seqno_event->prev_sender = NULL;
@@ -449,7 +445,6 @@ static int seqno_event_new(char *iface_addr, char *orig, char *prev_sender, char
 		goto err;
 	}
 
-	INIT_LIST_HEAD(&seqno_event->list);
 	seqno_event->orig = orig_node;
 	seqno_event->neigh = neigh_node;
 	seqno_event->prev_sender = prev_sender_node;
@@ -986,7 +981,7 @@ static void seqno_trace_print_neigh(struct seqno_trace_neigh *seqno_trace_neigh,
 	}
 }
 
-static void seqno_trace_print(struct list_head_first *trace_list, char *trace_orig,
+static void seqno_trace_print(struct list_head *trace_list, char *trace_orig,
                               long long seqno_min, long long seqno_max, char *filter_orig, int read_opt)
 {
 	struct seqno_trace *seqno_trace;
@@ -1180,7 +1175,6 @@ static struct seqno_trace *seqno_trace_new(struct seqno_event *seqno_event)
 		return NULL;
 	}
 
-	INIT_LIST_HEAD(&seqno_trace->list);
 	seqno_trace->seqno = seqno_event->seqno;
 	seqno_trace->print = 0;
 
@@ -1199,7 +1193,7 @@ static void seqno_trace_free(struct seqno_trace *seqno_trace)
 	free(seqno_trace);
 }
 
-static int seqno_trace_add(struct list_head_first *trace_list, struct bat_node *bat_node,
+static int seqno_trace_add(struct list_head *trace_list, struct bat_node *bat_node,
 		           struct seqno_event *seqno_event, char print_trace)
 {
 	struct seqno_trace *seqno_trace = NULL, *seqno_trace_tmp = NULL, *seqno_trace_prev = NULL;
@@ -1223,12 +1217,12 @@ static int seqno_trace_add(struct list_head_first *trace_list, struct bat_node *
 			goto err;
 
 		if ((list_empty(trace_list)) ||
-		    (seqno_event->seqno > ((struct seqno_trace *)trace_list->prev)->seqno))
+		    (seqno_event->seqno > list_last_entry(trace_list, struct seqno_trace, list)->seqno))
 			list_add_tail(&seqno_trace->list, trace_list);
-		else if (seqno_event->seqno < ((struct seqno_trace *)trace_list->next)->seqno)
-			list_add_before((struct list_head *)trace_list, trace_list->next, &seqno_trace->list);
+		else if (seqno_event->seqno < list_first_entry(trace_list, struct seqno_trace, list)->seqno)
+			list_add(&seqno_trace->list, trace_list);
 		else
-			list_add_before(&seqno_trace_prev->list, &seqno_trace_tmp->list, &seqno_trace->list);
+			list_add_behind(&seqno_trace->list, &seqno_trace_prev->list);
 	}
 
 	if (print_trace)
@@ -1260,14 +1254,14 @@ static void trace_seqnos(char *trace_orig, long long seqno_min, long long seqno_
 	struct orig_event *orig_event;
 	struct seqno_event *seqno_event;
 	struct hash_it_t *hashit = NULL;
-	struct list_head_first trace_list;
+	struct list_head trace_list;
 	struct seqno_trace *seqno_trace, *seqno_trace_tmp;
 	char check_orig[NAME_LEN], print_trace;
 	int res;
 
 	/* if no option was given filter_orig is empty */
 	memset(check_orig, 0, NAME_LEN);
-	INIT_LIST_HEAD_FIRST(trace_list);
+	INIT_LIST_HEAD(&trace_list);
 
 	while (NULL != (hashit = hash_iterate(node_hash, hashit))) {
 		bat_node = hashit->bucket->data;
@@ -1313,7 +1307,7 @@ static void trace_seqnos(char *trace_orig, long long seqno_min, long long seqno_
 
 out:
 	list_for_each_entry_safe(seqno_trace, seqno_trace_tmp, &trace_list, list) {
-		list_del((struct list_head *)&trace_list, &seqno_trace->list, &trace_list);
+		list_del(&seqno_trace->list);
 		seqno_trace_free(seqno_trace);
 	}
 
diff --git a/bisect_iv.h b/bisect_iv.h
index ace76c7..43aa80b 100644
--- a/bisect_iv.h
+++ b/bisect_iv.h
@@ -22,7 +22,7 @@
 #ifndef _BATCTL_BISECT_IV_H
 #define _BATCTL_BISECT_IV_H
 
-#include "list-batman.h"
+#include "list.h"
 
 #define NAME_LEN 18
 #define MAX_LINE 256
@@ -38,8 +38,8 @@ int bisect_iv(int argc, char **argv);
 
 struct bat_node {
 	char name[NAME_LEN];
-	struct list_head_first orig_event_list;
-	struct list_head_first rt_table_list;
+	struct list_head orig_event_list;
+	struct list_head rt_table_list;
 	char loop_magic[LOOP_MAGIC_LEN];
 	char loop_magic2[LOOP_MAGIC_LEN];
 };
@@ -47,8 +47,8 @@ struct bat_node {
 struct orig_event {
 	struct list_head list;
 	struct bat_node *orig_node;
-	struct list_head_first event_list;
-	struct list_head_first rt_hist_list;
+	struct list_head event_list;
+	struct list_head rt_hist_list;
 };
 
 struct rt_table {
diff --git a/list-batman.c b/list-batman.c
deleted file mode 100644
index affedb6..0000000
--- a/list-batman.c
+++ /dev/null
@@ -1,123 +0,0 @@
-/* 
- * Copyright (C) 2006-2016  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
- */
-
-
-
-#include "list-batman.h"
-
-
-
-/*
- * Insert a new entry between two known consecutive entries.
- *
- * This is only for internal list manipulation where we know
- * the next entries already!
- */
-static void __list_add( struct list_head *new, struct list_head *prev, struct list_head *next ) {
-
-	new->next = next;
-	prev->next = new;
-
-}
-
-/**
- * list_add - add a new entry
- * @new: new entry to be added
- * @head: list head to add it after
- *
- * Insert a new entry after the specified head.
- * This is good for implementing stacks.
- */
-void list_add( struct list_head *new, struct list_head_first *head ) {
-
-	__list_add( new, (struct list_head *)head, head->next );
-
-	if ( head->prev == (struct list_head *)head )
-		head->prev = new;
-
-}
-
-/**
- * list_add_tail - add a new entry
- * @new: new entry to be added
- * @head: list head to add it before
- *
- * Insert a new entry before the specified head.
- * This is useful for implementing queues.
- */
-void list_add_tail( struct list_head *new, struct list_head_first *head ) {
-
-	__list_add( new, head->prev, (struct list_head *)head );
-
-	head->prev = new;
-
-}
-
-void list_add_before( struct list_head *prev_node, struct list_head *next_node, struct list_head *new_node ) {
-
-	prev_node->next = new_node;
-	new_node->next = next_node;
-
-}
-
-
-
-/*
- * Delete a list entry by making the next entries
- * point to each other.
- *
- * This is only for internal list manipulation where we know
- * the next entries already!
- */
-static void __list_del( struct list_head *prev, struct list_head *next ) {
-
-	prev->next = next;
-
-}
-
-/**
- * list_del - deletes entry from list.
- * @entry: the element to delete from the list.
- * Note: list_empty on entry does not return true after this, the entry is in an undefined state.
- */
-void list_del( struct list_head *prev_entry, struct list_head *entry, struct list_head_first *head ) {
-
-	if ( head->prev == entry )
-		head->prev = prev_entry;
-
-	__list_del( prev_entry, entry->next );
-
-	entry->next = (void *) 0;
-
-}
-
-
-
-/**
- * list_empty - tests whether a list is empty
- * @head: the list to test.
- */
-int list_empty( struct list_head_first *head ) {
-
-	return head->next == (struct list_head *)head;
-
-}
-
diff --git a/list-batman.h b/list-batman.h
deleted file mode 100644
index 53b8413..0000000
--- a/list-batman.h
+++ /dev/null
@@ -1,120 +0,0 @@
-/*
- * Copyright (C) 2006-2016  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
- */
-
-#ifndef _LINUX_LIST_H
-#define _LINUX_LIST_H
-
-/*
- * XXX: Resolve conflict between this file and <sys/queue.h> on BSD systems.
- */
-#ifdef LIST_HEAD
-#undef LIST_HEAD
-#endif
-
-/*
- * Simple linked list implementation.
- *
- * Some of the internal functions ("__xxx") are useful when
- * manipulating whole lists rather than single entries, as
- * sometimes we already know the next entries and we can
- * generate better code by using them directly rather than
- * using the generic single-entry routines.
- */
-
-struct list_head {
-	struct list_head *next;
-};
-
-struct list_head_first {
-	struct list_head *next, *prev;
-};
-
-
-void list_add( struct list_head *new, struct list_head_first *head );
-void list_add_tail( struct list_head *new, struct list_head_first *head );
-void list_add_before( struct list_head *prev_node, struct list_head *next_node, struct list_head *new_node );
-void list_del( struct list_head *prev_entry, struct list_head *entry, struct list_head_first *head );
-int list_empty( struct list_head_first *head );
-
-
-
-#define INIT_LIST_HEAD(ptr) do { \
-	(ptr)->next = (ptr); \
-} while (0)
-
-#define INIT_LIST_HEAD_FIRST(ptr) \
-	ptr.next = (struct list_head *)&ptr; ptr.prev = (struct list_head *)&ptr; \
-
-
-/**
- * list_entry - get the struct for this entry
- * @ptr:	the &struct list_head pointer.
- * @type:	the type of the struct this is embedded in.
- * @member:	the name of the list_struct within the struct.
- */
-#define list_entry(ptr, type, member) \
-	((type *)((char *)(ptr)-(unsigned long)(&((type *)0)->member)))
-
-/**
- * list_for_each	-	iterate over a list
- * @pos:	the &struct list_head to use as a loop counter.
- * @head:	the head for your list.
- */
-#define list_for_each(pos, head) \
-	for (pos = (head)->next; pos != (struct list_head *)(head); \
-        	pos = pos->next)
-
-/**
- * list_for_each_safe	-	iterate over a list safe against removal of list entry
- * @pos:	the &struct list_head to use as a loop counter.
- * @n:		another &struct list_head to use as temporary storage
- * @head:	the head for your list.
- */
-#define list_for_each_safe(pos, n, head) \
-	for (pos = (head)->next, n = pos->next; pos != (struct list_head *)(head); \
-		pos = n, n = pos->next)
-
-/**
- * list_for_each_entry  -       iterate over list of given type
- * @pos:        the type * to use as a loop counter.
- * @head:       the head for your list.
- * @member:     the name of the list_struct within the struct.
- */
-#define list_for_each_entry(pos, head, member)                          \
-        for (pos = list_entry((head)->next, typeof(*pos), member);      \
-             &pos->member != (struct list_head *)(head);                \
-             pos = list_entry(pos->member.next, typeof(*pos), member))
-
-/**
- * list_for_each_entry_safe - iterate over list of given type safe against removal of list entry
- * @pos:        the type * to use as a loop counter.
- * @n:          another type * to use as temporary storage
- * @head:       the head for your list.
- * @member:     the name of the list_struct within the struct.
- */
-#define list_for_each_entry_safe(pos, n, head, member)                  \
-        for (pos = list_entry((head)->next, typeof(*pos), member),      \
-                n = list_entry(pos->member.next, typeof(*pos), member); \
-             &pos->member != (struct list_head *)(head);                \
-             pos = n, n = list_entry(n->member.next, typeof(*n), member))
-
-
-#endif
diff --git a/list.h b/list.h
new file mode 100644
index 0000000..41feaa0
--- /dev/null
+++ b/list.h
@@ -0,0 +1,834 @@
+/* Minimal Linux-like double-linked list helper functions
+ *
+ * Copyright (c) 2012-2016, Sven Eckelmann <sven@narfation.org>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef __LINUX_LIKE_LIST_H__
+#define __LINUX_LIKE_LIST_H__
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <stddef.h>
+
+#if defined(__GNUC__)
+#define  LIST_TYPEOF_USE 1
+#endif
+
+#if defined(_MSC_VER)
+#define __inline__ __inline
+#endif
+
+/**
+ * container_of() - Calculate address of object that contains address ptr
+ * @ptr: pointer to member variable
+ * @type: type of the structure containing ptr
+ * @member: name of the member variable in struct @type
+ *
+ * Return: @type pointer of object containing ptr
+ */
+#ifndef container_of
+#ifdef LIST_TYPEOF_USE
+#define container_of(ptr, type, member) __extension__ ({ \
+	const __typeof__(((type *)0)->member) *__pmember = (ptr); \
+	(type *)((char *)__pmember - offsetof(type, member)); })
+#else
+#define container_of(ptr, type, member) \
+	((type *)((char *)(ptr) - offsetof(type, member)))
+#endif
+#endif
+
+/**
+ * struct list_head - Head and node of a double-linked list
+ * @prev: pointer to the previous node in the list
+ * @next: pointer to the next node in the list
+ *
+ * The simple double-linked list consists of a head and nodes attached to
+ * this head. Both node and head share the same struct type. The list_*
+ * functions and macros can be used to access and modify this data structure.
+ *
+ * The @prev pointer of the list head points to the last list node of the
+ * list and @next points to the first list node of the list. For an empty list,
+ * both member variables point to the head.
+ *
+ * The list nodes are usually embedded in a container structure which holds the
+ * actual data. Such an container object is called entry. The helper list_entry
+ * can be used to calculate the object address from the address of the node.
+ */
+struct list_head {
+	struct list_head *prev;
+	struct list_head *next;
+};
+
+/**
+ * LIST_HEAD - Declare list head and initialize it
+ * @head: name of the new object
+ */
+#define LIST_HEAD(head) \
+	struct list_head head = { &(head), &(head) }
+
+/**
+ * INIT_LIST_HEAD() - Initialize empty list head
+ * @head: pointer to list head
+ *
+ * This can also be used to initialize a unlinked list node.
+ *
+ * A node is usually linked inside a list, will be added to a list in
+ * the near future or the entry containing the node will be free'd soon.
+ *
+ * But an unlinked node may be given to a function which uses list_del(_init)
+ * before it ends up in a previously mentioned state. The list_del(_init) on an
+ * initialized node is well defined and safe. But the result of a
+ * list_del(_init) on an uninitialized node is undefined (unrelated memory is
+ * modified, crashes, ...).
+ */
+static __inline__ void INIT_LIST_HEAD(struct list_head *head)
+{
+	head->next = head;
+	head->prev = head;
+}
+
+/**
+ * list_add() - Add a list node to the beginning of the list
+ * @node: pointer to the new node
+ * @head: pointer to the head of the list
+ */
+static __inline__ void list_add(struct list_head *node,
+				struct list_head *head)
+{
+	struct list_head *next = head->next;
+
+	next->prev = node;
+	node->next = next;
+	node->prev = head;
+	head->next = node;
+}
+
+/**
+ * list_add_tail() - Add a list node to the end of the list
+ * @node: pointer to the new node
+ * @head: pointer to the head of the list
+ */
+static __inline__ void list_add_tail(struct list_head *node,
+				     struct list_head *head)
+{
+	struct list_head *prev = head->prev;
+
+	prev->next = node;
+	node->next = head;
+	node->prev = prev;
+	head->prev = node;
+}
+
+/**
+ * list_add_before() - Add a list node before another node to the list
+ * @new_node: pointer to the new node
+ * @node: pointer to the reference node in the list
+ *
+ * WARNING this functionality is not available in the Linux list implementation
+ */
+#define list_add_before(new_node, node) \
+	list_add_tail(new_node, node)
+
+/**
+ * list_add_behind() - Add a list node behind another node to the list
+ * @new_node: pointer to the new node
+ * @node: pointer to the reference node in the list
+ *
+ * WARNING this functionality is not available in the Linux list implementation
+ */
+#define list_add_behind(new_node, node) \
+	list_add(new_node, node)
+
+/**
+ * list_del() - Remove a list node from the list
+ * @node: pointer to the node
+ *
+ * The node is only removed from the list. Neither the memory of the removed
+ * node nor the memory of the entry containing the node is free'd. The node
+ * has to be handled like an uninitialized node. Accessing the next or prev
+ * pointer of the node is not safe.
+ *
+ * Unlinked, initialized nodes are also uninitialized after list_del.
+ *
+ * LIST_POISONING can be enabled during build-time to provoke an invalid memory
+ * access when the memory behind the next/prev pointer is used after a list_del.
+ * This only works on systems which prohibit access to the predefined memory
+ * addresses.
+ */
+static __inline__ void list_del(struct list_head *node)
+{
+	struct list_head *next = node->next;
+	struct list_head *prev = node->prev;
+
+	next->prev = prev;
+	prev->next = next;
+
+#ifdef LIST_POISONING
+	node->prev = (struct list_head *)(0x00100100);
+	node->next = (struct list_head *)(0x00200200);
+#endif
+}
+
+/**
+ * list_del_init() - Remove a list node from the list and reinitialize it
+ * @node: pointer to the node
+ *
+ * The removed node will not end up in an uninitialized state like when using
+ * list_del. Instead the node is initialized again to the unlinked state.
+ */
+static __inline__ void list_del_init(struct list_head *node)
+{
+	list_del(node);
+	INIT_LIST_HEAD(node);
+}
+
+/**
+ * list_empty() - Check if list head has no nodes attached
+ * @head: pointer to the head of the list
+ *
+ * Return: 0 - list is not empty !0 - list is empty
+ */
+static __inline__ int list_empty(const struct list_head *head)
+{
+	return (head->next == head);
+}
+
+/**
+ * list_is_singular() - Check if list head has exactly one node attached
+ * @head: pointer to the head of the list
+ *
+ * Return: 0 - list is not singular !0 -list has exactly one entry
+ */
+static __inline__ int list_is_singular(const struct list_head *head)
+{
+	return (!list_empty(head) && head->prev == head->next);
+}
+
+/**
+ * list_splice() - Add list nodes from a list to beginning of another list
+ * @list: pointer to the head of the list with the node entries
+ * @head: pointer to the head of the list
+ *
+ * All nodes from @list are added to to the beginning of the list of @head.
+ * It is similar to list_add but for multiple nodes. The @list head is not
+ * modified and has to be initialized to be used as a valid list head/node
+ * again.
+ */
+static __inline__ void list_splice(struct list_head *list,
+				   struct list_head *head)
+{
+	struct list_head *head_first = head->next;
+	struct list_head *list_first = list->next;
+	struct list_head *list_last = list->prev;
+
+	if (list_empty(list))
+		return;
+
+	head->next = list_first;
+	list_first->prev = head;
+
+	list_last->next = head_first;
+	head_first->prev = list_last;
+}
+
+/**
+ * list_splice_tail() - Add list nodes from a list to end of another list
+ * @list: pointer to the head of the list with the node entries
+ * @head: pointer to the head of the list
+ *
+ * All nodes from @list are added to to the end of the list of @head.
+ * It is similar to list_add_tail but for multiple nodes. The @list head is not
+ * modified and has to be initialized to be used as a valid list head/node
+ * again.
+ */
+static __inline__ void list_splice_tail(struct list_head *list,
+					struct list_head *head)
+{
+	struct list_head *head_last = head->prev;
+	struct list_head *list_first = list->next;
+	struct list_head *list_last = list->prev;
+
+	if (list_empty(list))
+		return;
+
+	head->prev = list_last;
+	list_last->next = head;
+
+	list_first->prev = head_last;
+	head_last->next = list_first;
+}
+
+/**
+ * list_splice_init() - Move list nodes from a list to beginning of another list
+ * @list: pointer to the head of the list with the node entries
+ * @head: pointer to the head of the list
+ *
+ * All nodes from @list are added to to the beginning of the list of @head.
+ * It is similar to list_add but for multiple nodes.
+ *
+ * The @list head will not end up in an uninitialized state like when using
+ * list_splice. Instead the @list is initialized again to the an empty
+ * list/unlinked state.
+ */
+static __inline__ void list_splice_init(struct list_head *list,
+					struct list_head *head)
+{
+	list_splice(list, head);
+	INIT_LIST_HEAD(list);
+}
+
+/**
+ * list_splice_tail_init() - Move list nodes from a list to end of another list
+ * @list: pointer to the head of the list with the node entries
+ * @head: pointer to the head of the list
+ *
+ * All nodes from @list are added to to the end of the list of @head.
+ * It is similar to list_add_tail but for multiple nodes.
+ *
+ * The @list head will not end up in an uninitialized state like when using
+ * list_splice. Instead the @list is initialized again to the an empty
+ * list/unlinked state.
+ */
+static __inline__ void list_splice_tail_init(struct list_head *list,
+					     struct list_head *head)
+{
+	list_splice_tail(list, head);
+	INIT_LIST_HEAD(list);
+}
+
+/**
+ * list_cut_position() - Move beginning of a list to another list
+ * @head_to: pointer to the head of the list which receives nodes
+ * @head_from: pointer to the head of the list
+ * @node: pointer to the node in which defines the cutting point
+ *
+ * All entries from the beginning of the list @head_from to (including) the
+ * @node is moved to @head_from.
+ *
+ * @head_to is replaced when @head_from is not empty. @node must be a real
+ * list node from @head_from or the behavior is undefined.
+ */
+static __inline__ void list_cut_position(struct list_head *head_to,
+					 struct list_head *head_from,
+					 struct list_head *node)
+{
+	struct list_head *head_from_first = head_from->next;
+
+	if (list_empty(head_from))
+		return;
+
+	if (head_from == node) {
+		INIT_LIST_HEAD(head_to);
+		return;
+	}
+
+	head_from->next = node->next;
+	head_from->next->prev = head_from;
+
+	head_to->prev = node;
+	node->next = head_to;
+	head_to->next = head_from_first;
+	head_to->next->prev = head_to;
+}
+
+/**
+ * list_move() - Move a list node to the beginning of the list
+ * @node: pointer to the node
+ * @head: pointer to the head of the list
+ *
+ * The @node is removed from its old position/node and add to the beginning of
+ * @head
+ */
+static __inline__ void list_move(struct list_head *node, struct list_head *head)
+{
+	list_del(node);
+	list_add(node, head);
+}
+
+/**
+ * list_move_tail() - Move a list node to the end of the list
+ * @node: pointer to the node
+ * @head: pointer to the head of the list
+ *
+ * The @node is removed from its old position/node and add to the end of @head
+ */
+static __inline__ void list_move_tail(struct list_head *node,
+				      struct list_head *head)
+{
+	list_del(node);
+	list_add_tail(node, head);
+}
+
+/**
+ * list_entry() - Calculate address of entry that contains list node
+ * @node: pointer to list node
+ * @type: type of the entry containing the list node
+ * @member: name of the list_head member variable in struct @type
+ *
+ * Return: @type pointer of entry containing node
+ */
+#define list_entry(node, type, member) container_of(node, type, member)
+
+/**
+ * list_first_entry() - get first entry of the list
+ * @head: pointer to the head of the list
+ * @type: type of the entry containing the list node
+ * @member: name of the list_head member variable in struct @type
+ *
+ * Return: @type pointer of first entry in list
+ */
+#define list_first_entry(head, type, member) \
+	list_entry((head)->next, type, member)
+
+/**
+ * list_last_entry() - get last entry of the list
+ * @head: pointer to the head of the list
+ * @type: type of the entry containing the list node
+ * @member: name of the list_head member variable in struct @type
+ *
+ * Return: @type pointer of last entry in list
+ */
+#define list_last_entry(head, type, member) \
+	list_entry((head)->prev, type, member)
+
+/**
+ * list_for_each - iterate over list nodes
+ * @node: list_head pointer used as iterator
+ * @head: pointer to the head of the list
+ *
+ * The nodes and the head of the list must must be kept unmodified while
+ * iterating through it. Any modifications to the the list will cause undefined
+ * behavior.
+ */
+#define list_for_each(node, head) \
+	for (node = (head)->next; \
+	     node != (head); \
+	     node = node->next)
+
+/**
+ * list_for_each_entry_t - iterate over list entries
+ * @entry: @type pointer used as iterator
+ * @head: pointer to the head of the list
+ * @type: type of the entries containing the list nodes
+ * @member: name of the list_head member variable in struct @type
+ *
+ * The nodes and the head of the list must must be kept unmodified while
+ * iterating through it. Any modifications to the the list will cause undefined
+ * behavior.
+ *
+ * WARNING this functionality is not available in the Linux list implementation
+ */
+#define list_for_each_entry_t(entry, head, type, member) \
+	for (entry = list_entry((head)->next, type, member); \
+	     &entry->member != (head); \
+	     entry = list_entry(entry->member.next, type, member))
+
+/**
+ * list_for_each_entry - iterate over list entries
+ * @entry: pointer used as iterator
+ * @head: pointer to the head of the list
+ * @member: name of the list_head member variable in struct type of @entry
+ *
+ * The nodes and the head of the list must must be kept unmodified while
+ * iterating through it. Any modifications to the the list will cause undefined
+ * behavior.
+ */
+#ifdef LIST_TYPEOF_USE
+#define list_for_each_entry(entry, head, member) \
+	list_for_each_entry_t(entry, head, __typeof__(*entry), member)
+#endif
+
+/**
+ * list_for_each_safe - iterate over list nodes and allow deletes
+ * @node: list_head pointer used as iterator
+ * @safe: list_head pointer used to store info for next entry in list
+ * @head: pointer to the head of the list
+ *
+ * The current node (iterator) is allowed to be removed from the list. Any
+ * other modifications to the the list will cause undefined behavior.
+ */
+#define list_for_each_safe(node, safe, head) \
+	for (node = (head)->next, safe = node->next; \
+	     node != (head); \
+	     node = safe, safe = node->next)
+
+/**
+ * list_for_each_entry_safe_t - iterate over list entries and allow deletes
+ * @entry: @type pointer used as iterator
+ * @safe: @type pointer used to store info for next entry in list
+ * @head: pointer to the head of the list
+ * @type: type of the entries containing the list nodes
+ * @member: name of the list_head member variable in struct @type
+ *
+ * The current node (iterator) is allowed to be removed from the list. Any
+ * other modifications to the the list will cause undefined behavior.
+ *
+ * WARNING this functionality is not available in the Linux list implementation
+ */
+#define list_for_each_entry_safe_t(entry, safe, head, type, member) \
+	for (entry = list_entry((head)->next, type, member), \
+	     safe = list_entry(entry->member.next, type, member); \
+	     &entry->member != (head); \
+	     entry = safe, \
+	     safe = list_entry(safe->member.next, type, member))
+
+/**
+ * list_for_each_entry_safe - iterate over list entries and allow deletes
+ * @entry: pointer used as iterator
+ * @safe: @type pointer used to store info for next entry in list
+ * @head: pointer to the head of the list
+ * @member: name of the list_head member variable in struct type of @entry
+ *
+ * The current node (iterator) is allowed to be removed from the list. Any
+ * other modifications to the the list will cause undefined behavior.
+ */
+#ifdef LIST_TYPEOF_USE
+#define list_for_each_entry_safe(entry, safe, head, member) \
+	list_for_each_entry_safe_t(entry, safe, head, __typeof__(*entry), \
+				   member)
+#endif
+
+/**
+ * struct hlist_node - Node of a double-linked list with single pointer head
+ * @next: pointer to the next node in the list
+ * @pprev: pointer to @next of the previous node in the hlist
+ *
+ * The double-linked list with single pointer head consists of a head and nodes
+ * attached to this head. The hlist_* functions and macros can be used to access
+ * and modify this data structure.
+ *
+ * The @pprev pointer is used to find the previous node (or head) in the list
+ * when doing hlist_del operations
+ *
+ * The hlist nodes are usually embedded in a container structure which holds the
+ * actual data. Such an container object is called entry. The helper hlist_entry
+ * can be used to calculate the object address from the address of the node.
+ */
+struct hlist_node {
+	struct hlist_node *next;
+	struct hlist_node **pprev;
+};
+
+/**
+ * struct hlist_head - Head of a double-linked list with single pointer head
+ * @first: pointer to the first node in the hlist
+ *
+ * The hlist doesn't have a pointer to the last node. This makes it harder to
+ * access or modify the tail of the list. But the single pointer to the first
+ * entry makes it well suited for implementation of hash tables because it
+ * cuts the size cost of the head pointers by half compared to the list_head.
+ */
+struct hlist_head {
+	struct hlist_node *first;
+};
+
+/**
+ * HLIST_HEAD - Declare hlist head and initialize it
+ * @head: name of the new object
+ */
+#define HLIST_HEAD(head) \
+	struct hlist_head head = { NULL }
+
+/**
+ * INIT_HLIST_HEAD() - Initialize empty hlist head
+ * @head: pointer to hlist head
+ */
+static __inline__ void INIT_HLIST_HEAD(struct hlist_head *head)
+{
+	head->first = NULL;
+}
+
+/**
+ * INIT_HLIST_NODE() - Initialize unhashed hlist node
+ * @node: pointer to hlist node
+ *
+ * A hlist_node is usually linked inside a hlist, will be added to a hlist in
+ * the near future or the entry containing the node will be free'd soon.
+ *
+ * But an unlinked node may be given to a function which uses hlist_del(_init)
+ * before it ends up in a previously mentioned state. The hlist_del(_init) on an
+ * initialized node is well defined and safe. But the result of a
+ * hlist_del(_init) on an uninitialized node is undefined (unrelated memory is
+ * modified, crashes, ...).
+ */
+static __inline__ void INIT_HLIST_NODE(struct hlist_node *node)
+{
+	node->next = NULL;
+	node->pprev = NULL;
+}
+
+/**
+ * hlist_add_head() - Add a hlist node to the beginning of the hlist
+ * @node: pointer to the new node
+ * @head: pointer to the head of the hlist
+ */
+static __inline__ void hlist_add_head(struct hlist_node *node,
+				      struct hlist_head *head)
+{
+	struct hlist_node *first = head->first;
+
+	head->first = node;
+	node->next = first;
+	node->pprev = &head->first;
+	if (first)
+		first->pprev = &node->next;
+}
+
+/**
+ * hlist_add_before() - Add a hlist node before another node to the hlist
+ * @new_node: pointer to the new node
+ * @node: pointer to the reference node in the hlist
+ */
+static __inline__ void hlist_add_before(struct hlist_node *new_node,
+					struct hlist_node *node)
+{
+	struct hlist_node **pprev = node->pprev;
+
+	*pprev = new_node;
+	new_node->next = node;
+	new_node->pprev = pprev;
+	node->pprev = &new_node->next;
+}
+
+/**
+ * hlist_add_behind() - Add a hlist node behind another node to the hlist
+ * @new_node: pointer to the new node
+ * @node: pointer to the reference node in the hlist
+ */
+static __inline__ void hlist_add_behind(struct hlist_node *new_node,
+					struct hlist_node *node)
+{
+	struct hlist_node *next = node->next;
+
+	node->next = new_node;
+	new_node->pprev = &node->next;
+	new_node->next = next;
+	if (next)
+		next->pprev = &new_node->next;
+}
+
+/**
+ * hlist_del() - Remove a hlist node from the hlist
+ * @node: pointer to the node
+ *
+ * The node is only removed from the hlist. Neither the memory of the removed
+ * node nor the memory of the entry containing the node is free'd. The node
+ * has to be handled like an uninitialized node. Accessing the next or pprev
+ * pointer of the node is not safe.
+ *
+ * Unlinked, initialized nodes are also uninitialized after hlist_del.
+ *
+ * LIST_POISONING can be enabled during build-time to provoke an invalid memory
+ * access when the memory behind the next/prev pointer is used after an
+ * hlist_del. This only works on systems which prohibit access to the predefined
+ * memory addresses.
+ */
+static __inline__ void hlist_del(struct hlist_node *node)
+{
+	struct hlist_node *next = node->next;
+	struct hlist_node **pprev = node->pprev;
+
+	if (pprev)
+		*pprev = next;
+
+	if (next)
+		next->pprev = pprev;
+
+#ifdef LIST_POISONING
+	node->pprev = (struct hlist_node **)(0x00100100);
+	node->next = (struct hlist_node *)(0x00200200);
+#endif
+}
+
+/**
+ * hlist_del_init() - Remove a hlist node from the hlist and reinitialize it
+ * @node: pointer to the node
+ *
+ * The removed node will not end up in an uninitialized state like when using
+ * hlist_del. Instead the node is initialized again to the unlinked state.
+ */
+static __inline__ void hlist_del_init(struct hlist_node *node)
+{
+	hlist_del(node);
+	INIT_HLIST_NODE(node);
+}
+
+/**
+ * hlist_empty() - Check if hlist head has no nodes attached
+ * @head: pointer to the head of the hlist
+ *
+ * Return: 0 - hlist is not empty !0 - hlist is empty
+ */
+static __inline__ int hlist_empty(const struct hlist_head *head)
+{
+	return !head->first;
+}
+
+/**
+ * hlist_move_list() - Move hlist nodes from a hlist head new hlist head
+ * @list: pointer to the head of the hlist with the node entries
+ * @head: pointer to the head of the hlist
+ *
+ * All nodes from @list are added to to the beginning of the list of @head.
+ * @head can be uninitialized or an empty, initialized hlist. All entries of
+ * a non-empty hlist @head would be lost after this operation.
+ *
+ * The @list head will not end up in an uninitialized state. Instead the @list
+ * is initialized again to an empty hlist.
+ */
+static __inline__ void hlist_move_list(struct hlist_head *list,
+				       struct hlist_head *head)
+{
+	head->first = list->first;
+	if (head->first)
+		head->first->pprev = &head->first;
+	INIT_HLIST_HEAD(list);
+}
+
+/**
+ * hlist_entry() - Calculate address of entry that contains hlist node
+ * @node: pointer to hlist node
+ * @type: type of the entry containing the hlist node
+ * @member: name of the hlist_node member variable in struct @type
+ *
+ * Return: @type pointer of entry containing node
+ */
+#define hlist_entry(node, type, member) container_of(node, type, member)
+
+/**
+ * hlist_entry_safe() - Calculate address of entry that contains hlist node
+ * @node: pointer to hlist node or (struct hlist_node *)NULL
+ * @type: type of the entry containing the hlist node
+ * @member: name of the hlist_node member variable in struct @type
+ *
+ * Return: @type pointer of entry containing node or NULL
+ */
+#ifdef LIST_TYPEOF_USE
+#define hlist_entry_safe(node, type, member) __extension__ ({ \
+	 __typeof__(node) __node = (node); \
+	 !__node ? NULL : hlist_entry(__node, type, member); })
+#else
+#define hlist_entry_safe(node, type, member) \
+	(node) ? hlist_entry(node, type, member) : NULL
+#endif
+
+/**
+ * hlist_for_each - iterate over hlist nodes
+ * @node: hlist_node pointer used as iterator
+ * @head: pointer to the head of the hlist
+ *
+ * The nodes and the head of the hlist must must be kept unmodified while
+ * iterating through it. Any modifications to the the hlist will cause undefined
+ * behavior.
+ */
+#define hlist_for_each(node, head) \
+	for (node = (head)->first; \
+	     node; \
+	     node = node->next)
+
+/**
+ * hlist_for_each_entry_t - iterate over hlist entries
+ * @entry: @type pointer used as iterator
+ * @head: pointer to the head of the hlist
+ * @type: type of the entries containing the hlist nodes
+ * @member: name of the hlist_node member variable in struct @type
+ *
+ * The nodes and the head of the hlist must must be kept unmodified while
+ * iterating through it. Any modifications to the the hlist will cause undefined
+ * behavior.
+ *
+ * WARNING this functionality is not available in the Linux list implementation
+ */
+#define hlist_for_each_entry_t(entry, head, type, member) \
+	for (entry = hlist_entry_safe((head)->first, type, member); \
+	     entry; \
+	     entry = hlist_entry_safe(entry->member.next, type, member))
+
+/**
+ * hlist_for_each_entry - iterate over hlist entries
+ * @entry: pointer used as iterator
+ * @head: pointer to the head of the hlist
+ * @member: name of the hlist_node member variable in struct type of @entry
+ *
+ * The nodes and the head of the hlist must must be kept unmodified while
+ * iterating through it. Any modifications to the the hlist will cause undefined
+ * behavior.
+ */
+#ifdef LIST_TYPEOF_USE
+#define hlist_for_each_entry(entry, head, member) \
+	hlist_for_each_entry_t(entry, head, __typeof__(*entry), member)
+#endif
+
+/**
+ * hlist_for_each_safe - iterate over hlist nodes and allow deletes
+ * @node: hlist_node pointer used as iterator
+ * @safe: hlist_node pointer used to store info for next entry in hlist
+ * @head: pointer to the head of the hlist
+ *
+ * The current node (iterator) is allowed to be removed from the hlist. Any
+ * other modifications to the the hlist will cause undefined behavior.
+ */
+#define hlist_for_each_safe(node, safe, head) \
+	for (node = (head)->first; \
+	     node && ((safe = node->next) || 1); \
+	     node = safe)
+
+/**
+ * hlist_for_each_entry_safe_t - iterate over hlist entries and allow deletes
+ * @entry: @type pointer used as iterator
+ * @safe: hlist_node pointer used to store info for next entry in hlist
+ * @head: pointer to the head of the hlist
+ * @type: type of the entries containing the hlist nodes
+ * @member: name of the hlist_node member variable in struct @type
+ *
+ * The current node (iterator) is allowed to be removed from the hlist. Any
+ * other modifications to the the hlist will cause undefined behavior.
+ *
+ * WARNING this functionality is not available in the Linux list implementation
+ */
+#define hlist_for_each_entry_safe_t(entry, safe, head, type, member) \
+	for (entry = hlist_entry_safe((head)->first, type, member); \
+	     entry && ((safe = entry->member.next) || 1); \
+	     entry = hlist_entry_safe(safe, type, member))
+
+/**
+ * hlist_for_each_entry_safe - iterate over hlist entries and allow deletes
+ * @entry: pointer used as iterator
+ * @safe: hlist_node pointer used to store info for next entry in hlist
+ * @head: pointer to the head of the hlist
+ * @member: name of the hlist_node member variable in struct type of @entry
+ *
+ * The current node (iterator) is allowed to be removed from the hlist. Any
+ * other modifications to the the hlist will cause undefined behavior.
+ */
+#ifdef LIST_TYPEOF_USE
+#define hlist_for_each_entry_safe(entry, safe, head, member) \
+	hlist_for_each_entry_safe_t(entry, safe, head, __typeof__(*entry),\
+				    member)
+#endif
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __LINUX_LIKE_LIST_H__ */
diff --git a/tcpdump.c b/tcpdump.c
index be0c4f0..2125b66 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -1118,7 +1118,7 @@ int tcpdump(int argc, char **argv)
 	struct ifreq req;
 	struct timeval tv;
 	struct dump_if *dump_if, *dump_if_tmp;
-	struct list_head_first dump_if_list;
+	struct list_head dump_if_list;
 	fd_set wait_sockets, tmp_wait_sockets;
 	ssize_t read_len;
 	int ret = EXIT_FAILURE, res, optchar, found_args = 1, max_sock = 0, tmp;
@@ -1168,7 +1168,7 @@ int tcpdump(int argc, char **argv)
 	bat_hosts_init(read_opt);
 
 	/* init interfaces list */
-	INIT_LIST_HEAD_FIRST(dump_if_list);
+	INIT_LIST_HEAD(&dump_if_list);
 	FD_ZERO(&wait_sockets);
 
 	while (argc > found_args) {
@@ -1176,7 +1176,6 @@ int tcpdump(int argc, char **argv)
 		dump_if = malloc(sizeof(struct dump_if));
 		memset(dump_if, 0, sizeof(struct dump_if));
 		dump_if->raw_sock = -1;
-		INIT_LIST_HEAD(&dump_if->list);
 
 		dump_if->dev = argv[found_args];
 
@@ -1306,7 +1305,7 @@ out:
 		if (dump_if->raw_sock >= 0)
 			close(dump_if->raw_sock);
 
-		list_del((struct list_head *)&dump_if_list, &dump_if->list, &dump_if_list);
+		list_del(&dump_if->list);
 		free(dump_if);
 	}
 
diff --git a/tcpdump.h b/tcpdump.h
index 229ee70..38d07c5 100644
--- a/tcpdump.h
+++ b/tcpdump.h
@@ -27,7 +27,7 @@
 #include <net/if_arp.h>
 #include <sys/types.h>
 #include "main.h"
-#include "list-batman.h"
+#include "list.h"
 
 #ifndef ARPHRD_IEEE80211_PRISM
 #define ARPHRD_IEEE80211_PRISM 802
-- 
2.8.1

