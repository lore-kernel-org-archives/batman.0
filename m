From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon,  1 Dec 2008 19:57:02 +0100
Message-Id: <1228157822-29406-8-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1228157822-29406-1-git-send-email-sven.eckelmann@gmx.de>
References: <1228157822-29406-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] Don't convert uint64_t to float when only
	comparing against 0
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

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/profile.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/batman/profile.c b/batman/profile.c
index 55b0450..d9eaf13 100644
--- a/batman/profile.c
+++ b/batman/profile.c
@@ -65,7 +65,7 @@ void prof_print(void) {
 
 	for ( index = 0; index < PROF_COUNT; index++ ) {
 
-		debug_output( 5, "   %''30s: cpu time = %10.3f, calls = %''10i, avg time per call = %4.10f \n", prof_container[index].name, (float)prof_container[index].total_time/CLOCKS_PER_SEC, prof_container[index].calls, ( (float)prof_container[index].calls == 0 ? 0.0 : ( ( (float)prof_container[index].total_time/CLOCKS_PER_SEC ) / (float)prof_container[index].calls ) ) );
+		debug_output( 5, "   %''30s: cpu time = %10.3f, calls = %''10i, avg time per call = %4.10f \n", prof_container[index].name, (float)prof_container[index].total_time/CLOCKS_PER_SEC, prof_container[index].calls, ( prof_container[index].calls == 0 ? 0.0 : ( ( (float)prof_container[index].total_time/CLOCKS_PER_SEC ) / (float)prof_container[index].calls ) ) );
 
 	}
 
-- 
1.6.0.4

