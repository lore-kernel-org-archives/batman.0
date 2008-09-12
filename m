Date: Sat, 13 Sep 2008 01:24:20 +0200
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Message-ID: <20080912232420.GA9669@sven-desktop.lazhur.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [PATCH] Make batman timer functions thread safe
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

The calculation inside of update_internal_clock aren't atomic and can lead to
bogus time informations when many threads calling get_time_msec64 or
get_time_msec.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/posix/posix.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/batman/posix/posix.c b/batman/posix/posix.c
index dd24a65..042a2b9 100644
--- a/batman/posix/posix.c
+++ b/batman/posix/posix.c
@@ -49,6 +49,7 @@ static float system_tick;
 
 uint8_t tunnel_running = 0;
 
+static pthread_mutex_t batman_clock_mutex = PTHREAD_MUTEX_INITIALIZER;
 
 void update_internal_clock()
 {
@@ -61,14 +62,26 @@ void update_internal_clock()
 
 uint32_t get_time_msec()
 {
+	uint32_t time;
+
+	pthread_mutex_lock(&batman_clock_mutex);
 	update_internal_clock();
-	return (uint32_t)(((float)(batman_clock_ticks) * 1000) / system_tick);
+	time = (uint32_t)(((float)(batman_clock_ticks) * 1000) / system_tick);
+	pthread_mutex_unlock(&batman_clock_mutex);
+
+	return time;
 }
 
 uint64_t get_time_msec64()
 {
+	uint64_t time;
+
+	pthread_mutex_lock(&batman_clock_mutex);
 	update_internal_clock();
-	return (uint64_t)(((float)(batman_clock_ticks) * 1000) / system_tick);
+	time = (uint64_t)(((float)(batman_clock_ticks) * 1000) / system_tick);
+	pthread_mutex_unlock(&batman_clock_mutex);
+
+	return time;
 }
 
 /* batman animation */
-- 
1.6.0.1


