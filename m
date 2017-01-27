Return-Path: <Jonathan.Haws@sdl.usu.edu>
From: Jonathan Haws <jhaws@sdl.usu.edu>
Date: Thu, 26 Jan 2017 19:23:09 -0700
Message-ID: <1485483789-5327-1-git-send-email-jhaws@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [B.A.T.M.A.N.] [PATCH v1] alfred: Formatting patch for sync-period
	casts
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

---
 main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/main.c b/main.c
index 1cabe15..446eecf 100644
--- a/main.c
+++ b/main.c
@@ -276,8 +276,8 @@ static struct globals *alfred_init(int argc, char *argv[])
 			return NULL;
 		case 'p':
 			sync_period = strtod(optarg, NULL);
-			globals->sync_period.tv_sec = (int) sync_period;
-			globals->sync_period.tv_nsec = (double) (sync_period - (int) sync_period) * 1e9;
+			globals->sync_period.tv_sec = (int)sync_period;
+			globals->sync_period.tv_nsec = (double)(sync_period - (int)sync_period) * 1e9;
 			printf(" ** Setting sync interval to: %.9f seconds (%ld.%09ld)\n", sync_period, globals->sync_period.tv_sec, globals->sync_period.tv_nsec);
 			break;
 		case '4':
-- 
2.7.4

