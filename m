Return-Path: <Jonathan.Haws@sdl.usu.edu>
From: Jonathan Haws <jhaws@sdl.usu.edu>
Date: Thu, 25 Aug 2016 14:30:24 -0600
Message-ID: <1472157024-17530-2-git-send-email-jhaws@sdl.usu.edu>
In-Reply-To: <1472157024-17530-1-git-send-email-jhaws@sdl.usu.edu>
References: <1472157024-17530-1-git-send-email-jhaws@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [B.A.T.M.A.N.] [PATCH 2/2] alfred: Adding time_subtract utility
	function
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
Cc: Jonathan Haws <jhaws@sdl.usu.edu>

Signed-off-by: Jonathan Haws <jhaws@sdl.usu.edu>

Added time_subtract() utility function to use for simply subtracting
one timespec from another.
---
 alfred.h |  2 ++
 server.c |  5 ++++-
 util.c   | 13 +++++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/alfred.h b/alfred.h
index 5b7e965..9d5f1e8 100644
--- a/alfred.h
+++ b/alfred.h
@@ -196,6 +196,8 @@ int netsock_own_address(const struct globals *globals,
 /* util.c */
 int time_diff(struct timespec *tv1, struct timespec *tv2,
 	      struct timespec *tvdiff);
+int time_subtract(struct timespec *tv1, struct timespec *tv2,
+	      struct timespec *tvout);
 void time_random_seed(void);
 uint16_t get_random_id(void);
 bool is_valid_ether_addr(uint8_t *addr);
diff --git a/server.c b/server.c
index c5df945..884a1a7 100644
--- a/server.c
+++ b/server.c
@@ -372,7 +372,10 @@ int alfred_server(struct globals *globals)
 
 	while (1) {
 		clock_gettime(CLOCK_MONOTONIC, &now);
-		time_diff(&now, &globals->sync_period, &now);
+
+		/* subtract the synchronization period from the current time */
+		time_subtract(&now, &globals->sync_period, &now);
+
 		if (!time_diff(&last_check, &now, &tv)) {
 			tv.tv_sec = 0;
 			tv.tv_nsec = 0;
diff --git a/util.c b/util.c
index c7e11cc..1b67f78 100644
--- a/util.c
+++ b/util.c
@@ -41,6 +41,19 @@ int time_diff(struct timespec *tv1, struct timespec *tv2,
 	return (tvdiff->tv_sec >= 0);
 }
 
+void time_subtract(struct timespec *tv1, struct timespec *tv2,
+	      struct timespec *tvout) {
+	tvout->tv_sec = tv1->tv_sec - tv2->tv_sec;
+	if (tv1->tv_nsec < tv2->tv_nsec) {
+		tvout->tv_nsec = 1000000000 + tv1->tv_nsec - tv2->tv_nsec;
+		tvout->tv_sec -= 1;
+	} else {
+		tvout->tv_nsec = tv1->tv_nsec - tv2->tv_nsec;
+	}
+
+	return;
+}
+
 void time_random_seed(void)
 {
 	struct timespec now;
-- 
2.7.4

