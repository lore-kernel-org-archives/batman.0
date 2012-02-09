Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu,  9 Feb 2012 18:02:13 +0800
Message-Id: <1328781734-2792-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batctl: restate missing sysfs folder
	error message
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 functions.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/functions.c b/functions.c
index 0729f15..69a1385 100644
--- a/functions.c
+++ b/functions.c
@@ -113,7 +113,8 @@ static int check_sys_dir(char *dir)
 		return EXIT_SUCCESS;
 
 	printf("Error - the folder '%s' was not found within the sys filesystem\n", dir);
-	printf("Please make sure that the batman-adv kernel module is loaded\n");
+	printf("Please make sure that the batman-adv kernel module is loaded and\n");
+	printf("that you have activated your mesh by adding interfaces to batman-adv\n");
 	return EXIT_FAILURE;
 }
 
-- 
1.7.5.4

