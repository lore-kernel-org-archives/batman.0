Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 17 Oct 2012 21:55:56 +0200
Message-Id: <1350503758-20685-2-git-send-email-sven@narfation.org>
In-Reply-To: <1350503758-20685-1-git-send-email-sven@narfation.org>
References: <1350503758-20685-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/4] alfred: Fix parsing of short program
	parameter -v and -V
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/main.c b/main.c
index 0315fe3..96e401a 100644
--- a/main.c
+++ b/main.c
@@ -78,7 +78,7 @@ struct globals *alfred_init(int argc, char *argv[])
 	globals->best_server = NULL;
 	globals->clientmode_version = 0;
 
-	while ((opt = getopt_long(argc, argv, "ms:r:hi:", long_options,
+	while ((opt = getopt_long(argc, argv, "ms:r:hi:vV:", long_options,
 				  &opt_ind)) != -1) {
 		switch (opt) {
 		case 'r':
-- 
1.7.10.4

