Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Tue, 23 Nov 2010 13:13:18 +0100
Message-Id: <1290514400-6887-2-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <201011230044.58352.lindner_marek@yahoo.de>
References: <201011230044.58352.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 1/3] batctl: Fix bisecting of OGMs with
	32bit seqno
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>

This patch increases the size of the seqno variable for bisect and now
uses UINT32_MAX for format checking. To be consistent, also "255"s got
substituted by UINT8_MAX

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 bisect.c |   75 ++++++++++++++++++++++++++++++++-----------------------------
 bisect.h |    4 +-
 2 files changed, 41 insertions(+), 38 deletions(-)

diff --git a/bisect.c b/bisect.c
index b7d8969..bdb51a8 100644
--- a/bisect.c
+++ b/bisect.c
@@ -385,7 +385,7 @@ err:
 	return 0;
 }
 
-static int seqno_event_new(char *iface_addr, char *orig, char *prev_sender, char *neigh, int seqno, int tq, int ttl)
+static int seqno_event_new(char *iface_addr, char *orig, char *prev_sender, char *neigh, long long seqno, int tq, int ttl)
 {
 	struct bat_node *orig_node, *neigh_node, *prev_sender_node;
 	struct orig_event *orig_event;
@@ -406,17 +406,17 @@ static int seqno_event_new(char *iface_addr, char *orig, char *prev_sender, char
 		goto err;
 	}
 
-	if ((seqno < 0) || (seqno > 65535)) {
-		fprintf(stderr, "Invalid sequence number found (%i) - skipping", seqno);
+	if ((seqno < 0) || (seqno > UINT32_MAX)) {
+		fprintf(stderr, "Invalid sequence number found (%lli) - skipping", seqno);
 		goto err;
 	}
 
-	if ((tq < 0) || (tq > 255)) {
+	if ((tq < 0) || (tq > UINT8_MAX)) {
 		fprintf(stderr, "Invalid tq value found (%i) - skipping", tq);
 		goto err;
 	}
 
-	if ((ttl < 0) || (ttl > 255)) {
+	if ((ttl < 0) || (ttl > UINT8_MAX)) {
 		fprintf(stderr, "Invalid ttl value found (%i) - skipping", ttl);
 		goto err;
 	}
@@ -468,7 +468,8 @@ static int parse_log_file(char *file_path)
 	FILE *fd;
 	char line_buff[MAX_LINE], *start_ptr, *start_ptr_safe, *tok_ptr;
 	char *neigh, *iface_addr, *orig, *prev_sender, rt_flag;
-	int line_count = 0, tq, ttl, seqno, i, res, max;
+	int line_count = 0, tq, ttl, i, res, max;
+	long long seqno;
 
 	fd = fopen(file_path, "r");
 
@@ -510,7 +511,7 @@ static int parse_log_file(char *file_path)
 					prev_sender[strlen(prev_sender) - 1] = 0;
 					break;
 				case 16:
-					seqno = strtol(tok_ptr, NULL, 10);
+					seqno = strtoll(tok_ptr, NULL, 10);
 					break;
 				case 18:
 					tq = strtol(tok_ptr, NULL, 10);
@@ -602,7 +603,7 @@ static int parse_log_file(char *file_path)
 	return 1;
 }
 
-static struct rt_hist *get_rt_hist_by_seqno(struct orig_event *orig_event, int seqno)
+static struct rt_hist *get_rt_hist_by_seqno(struct orig_event *orig_event, long long seqno)
 {
 	struct seqno_event *seqno_event;
 	struct rt_hist *rt_hist = NULL;
@@ -618,7 +619,7 @@ static struct rt_hist *get_rt_hist_by_seqno(struct orig_event *orig_event, int s
 	return rt_hist;
 }
 
-static struct rt_hist *get_rt_hist_by_node_seqno(struct bat_node *bat_node, struct bat_node *orig_node, int seqno)
+static struct rt_hist *get_rt_hist_by_node_seqno(struct bat_node *bat_node, struct bat_node *orig_node, long long seqno)
 {
 	struct orig_event *orig_event;
 	struct rt_hist *rt_hist;
@@ -632,7 +633,7 @@ static struct rt_hist *get_rt_hist_by_node_seqno(struct bat_node *bat_node, stru
 }
 
 static int print_rt_path_at_seqno(struct bat_node *src_node, struct bat_node *dst_node,
-                            struct bat_node *next_hop, int seqno, int seqno_rand, int read_opt)
+                            struct bat_node *next_hop, long long seqno, long long seqno_rand, int read_opt)
 {
 	struct bat_node *next_hop_tmp;
 	struct orig_event *orig_event;
@@ -640,10 +641,10 @@ static int print_rt_path_at_seqno(struct bat_node *src_node, struct bat_node *ds
 	char curr_loop_magic[LOOP_MAGIC_LEN];
 
 	memset(curr_loop_magic, 0, LOOP_MAGIC_LEN);
-	snprintf(curr_loop_magic, LOOP_MAGIC_LEN, "%s%s%i%i", src_node->name,
+	snprintf(curr_loop_magic, LOOP_MAGIC_LEN, "%s%s%lli%lli", src_node->name,
 	         dst_node->name, seqno, seqno_rand);
 
-	printf("Path towards %s (seqno %i ",
+	printf("Path towards %s (seqno %lli ",
 	       get_name_by_macstr(dst_node->name, read_opt), seqno);
 
 	printf("via neigh %s):", get_name_by_macstr(next_hop->name, read_opt));
@@ -694,13 +695,14 @@ out:
 }
 
 static int find_rt_table_change(struct bat_node *src_node, struct bat_node *dst_node,
-                                struct bat_node *curr_node, int seqno_min, int seqno_max,
-                                int seqno_rand, int read_opt)
+                                struct bat_node *curr_node, long long seqno_min, long long seqno_max,
+                                long long seqno_rand, int read_opt)
 {
 	struct orig_event *orig_event;
 	struct rt_hist *rt_hist, *rt_hist_tmp;
 	char curr_loop_magic[LOOP_MAGIC_LEN], loop_check = 0;
-	int res, seqno_tmp, seqno_min_tmp = seqno_min;
+	int res;
+	long long seqno_tmp, seqno_min_tmp = seqno_min;
 
 	/* printf("%i: curr_node: %s ", bla,
 		       get_name_by_macstr(curr_node->name, read_opt));
@@ -719,7 +721,7 @@ static int find_rt_table_change(struct bat_node *src_node, struct bat_node *dst_
 	}
 
 	memset(curr_loop_magic, 0, LOOP_MAGIC_LEN);
-	snprintf(curr_loop_magic, LOOP_MAGIC_LEN, "%s%s%i%i",
+	snprintf(curr_loop_magic, LOOP_MAGIC_LEN, "%s%s%lli%lli",
 	         src_node->name, dst_node->name,
 	         seqno_min_tmp, seqno_rand);
 
@@ -819,13 +821,14 @@ loop:
 	return -2;
 }
 
-static void loop_detection(char *loop_orig, int seqno_min, int seqno_max, char *filter_orig, int read_opt)
+static void loop_detection(char *loop_orig, long long seqno_min, long long seqno_max, char *filter_orig, int read_opt)
 {
 	struct bat_node *bat_node;
 	struct orig_event *orig_event;
 	struct hash_it_t *hashit = NULL;
 	struct rt_hist *rt_hist, *prev_rt_hist;
-	int last_seqno = -1, seqno_count = 0, res;
+	long long last_seqno = -1, seqno_count = 0;
+	int res;
 	char check_orig[NAME_LEN];
 
 	printf("\nAnalyzing routing tables ");
@@ -839,9 +842,9 @@ static void loop_detection(char *loop_orig, int seqno_min, int seqno_max, char *
 	if ((seqno_min == -1) && (seqno_max == -1))
 		printf("[all sequence numbers]");
 	else if (seqno_min == seqno_max)
-		printf("[sequence number: %i]", seqno_min);
+		printf("[sequence number: %lli]", seqno_min);
 	else
-		printf("[sequence number range: %i-%i]", seqno_min, seqno_max);
+		printf("[sequence number range: %lli-%lli]", seqno_min, seqno_max);
 
 	if (!compare_name(filter_orig, check_orig))
 		printf(" [filter originator: %s]",
@@ -915,7 +918,7 @@ static void loop_detection(char *loop_orig, int seqno_min, int seqno_max, char *
 				    (rt_hist->seqno_event->seqno != prev_rt_hist->seqno_event->seqno)) {
 					if (rt_hist->seqno_event->seqno < prev_rt_hist->seqno_event->seqno) {
 						fprintf(stderr,
-						        "Smaller seqno (%i) than previously received seqno (%i) of orig %s triggered routing table change - skipping recursive check\n",
+						        "Smaller seqno (%lli) than previously received seqno (%lli) of orig %s triggered routing table change - skipping recursive check\n",
 						        rt_hist->seqno_event->seqno, prev_rt_hist->seqno_event->seqno,
 						        get_name_by_macstr(rt_hist->seqno_event->orig->name, read_opt));
 						goto validate_path;
@@ -984,7 +987,7 @@ static void seqno_trace_print_neigh(struct seqno_trace_neigh *seqno_trace_neigh,
 }
 
 static void seqno_trace_print(struct list_head_first *trace_list, char *trace_orig,
-                              int seqno_min, int seqno_max, char *filter_orig, int read_opt)
+                              long long seqno_min, long long seqno_max, char *filter_orig, int read_opt)
 {
 	struct seqno_trace *seqno_trace;
 	char head[MAX_LINE], check_orig[NAME_LEN];
@@ -999,9 +1002,9 @@ static void seqno_trace_print(struct list_head_first *trace_list, char *trace_or
 	if ((seqno_min == -1) && (seqno_max == -1))
 		printf("[all sequence numbers]");
 	else if (seqno_min == seqno_max)
-		printf("[sequence number: %i]", seqno_min);
+		printf("[sequence number: %lli]", seqno_min);
 	else
-		printf("[sequence number range: %i-%i]", seqno_min, seqno_max);
+		printf("[sequence number range: %lli-%lli]", seqno_min, seqno_max);
 
 	if (!compare_name(filter_orig, check_orig))
 		printf(" [filter originator: %s]",
@@ -1013,7 +1016,7 @@ static void seqno_trace_print(struct list_head_first *trace_list, char *trace_or
 		if (!seqno_trace->print)
 			continue;
 
-		printf("+=> %s (seqno %i)\n",
+		printf("+=> %s (seqno %lli)\n",
 		       get_name_by_macstr(trace_orig, read_opt),
 		       seqno_trace->seqno);
 
@@ -1251,7 +1254,7 @@ err:
 	return 0;
 }
 
-static void trace_seqnos(char *trace_orig, int seqno_min, int seqno_max, char *filter_orig, int read_opt)
+static void trace_seqnos(char *trace_orig, long long seqno_min, long long seqno_max, char *filter_orig, int read_opt)
 {
 	struct bat_node *bat_node;
 	struct orig_event *orig_event;
@@ -1315,7 +1318,7 @@ out:
 	return;
 }
 
-static void print_rt_tables(char *rt_orig, int seqno_min, int seqno_max, char *filter_orig, int read_opt)
+static void print_rt_tables(char *rt_orig, long long seqno_min, long long seqno_max, char *filter_orig, int read_opt)
 {
 	struct bat_node *bat_node;
 	struct rt_table *rt_table;
@@ -1332,9 +1335,9 @@ static void print_rt_tables(char *rt_orig, int seqno_min, int seqno_max, char *f
 	if ((seqno_min == -1) && (seqno_max == -1))
 		printf("[all sequence numbers]");
 	else if (seqno_min == seqno_max)
-		printf("[sequence number: %i]", seqno_min);
+		printf("[sequence number: %lli]", seqno_min);
 	else
-		printf("[sequence number range: %i-%i]", seqno_min, seqno_max);
+		printf("[sequence number range: %lli-%lli]", seqno_min, seqno_max);
 
 	if (!compare_name(filter_orig, check_orig))
 		printf(" [filter originator: %s]",
@@ -1364,7 +1367,7 @@ static void print_rt_tables(char *rt_orig, int seqno_min, int seqno_max, char *f
 			continue;
 
 		if (seqno_event->seqno > -1) {
-			printf("rt change triggered by OGM from: %s (tq: %i, ttl: %i, seqno %i",
+			printf("rt change triggered by OGM from: %s (tq: %i, ttl: %i, seqno %lli",
 			       get_name_by_macstr(seqno_event->orig->name, read_opt),
 			       seqno_event->tq, seqno_event->ttl, seqno_event->seqno);
 			printf(", neigh: %s",
@@ -1443,7 +1446,7 @@ int bisect(int argc, char **argv)
 {
 	int ret = EXIT_FAILURE, res, optchar, found_args = 1;
 	int read_opt = USE_BAT_HOSTS, num_parsed_files;
-	int tmp_seqno, seqno_max = -1, seqno_min = -1;
+	long long tmp_seqno, seqno_max = -1, seqno_min = -1;
 	char *trace_orig_ptr = NULL, *rt_orig_ptr = NULL, *loop_orig_ptr = NULL;
 	char orig[NAME_LEN], filter_orig[NAME_LEN], *dash_ptr, *filter_orig_ptr = NULL;
 
@@ -1477,17 +1480,17 @@ int bisect(int argc, char **argv)
 				*dash_ptr = 0;
 
 			tmp_seqno = strtol(optarg, NULL , 10);
-			if ((tmp_seqno >= 0) && (tmp_seqno <= 65535))
+			if ((tmp_seqno >= 0) && (tmp_seqno <= UINT32_MAX))
 				seqno_min = tmp_seqno;
 			else
-				fprintf(stderr, "Warning - given sequence number is out of range: %i\n", tmp_seqno);
+				fprintf(stderr, "Warning - given sequence number is out of range: %lli\n", tmp_seqno);
 
 			if (dash_ptr) {
 				tmp_seqno = strtol(dash_ptr + 1, NULL , 10);
-				if ((tmp_seqno >= 0) && (tmp_seqno <= 65535))
+				if ((tmp_seqno >= 0) && (tmp_seqno <= UINT32_MAX))
 					seqno_max = tmp_seqno;
 				else
-					fprintf(stderr, "Warning - given sequence number is out of range: %i\n", tmp_seqno);
+					fprintf(stderr, "Warning - given sequence number is out of range: %lli\n", tmp_seqno);
 
 				*dash_ptr = '-';
 			}
@@ -1551,7 +1554,7 @@ int bisect(int argc, char **argv)
 		seqno_max = seqno_min;
 
 	if (seqno_min > seqno_max) {
-		printf("Error - the sequence range minimum (%i) should be smaller than the maximum (%i)\n",
+		printf("Error - the sequence range minimum (%lli) should be smaller than the maximum (%lli)\n",
 		       seqno_min, seqno_max);
 		goto err;
 	}
diff --git a/bisect.h b/bisect.h
index 70673e8..56cb861 100644
--- a/bisect.h
+++ b/bisect.h
@@ -76,7 +76,7 @@ struct seqno_event {
 	struct bat_node *orig;
 	struct bat_node *neigh;
 	struct bat_node *prev_sender;
-	int seqno;
+	long long seqno;
 	int tq;
 	int ttl;
 	struct rt_hist *rt_hist;
@@ -91,7 +91,7 @@ struct seqno_trace_neigh {
 
 struct seqno_trace {
 	struct list_head list;
-	int seqno;
+	long long seqno;
 	char print;
 	struct seqno_trace_neigh seqno_trace_neigh;
 };
-- 
1.7.1

