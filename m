Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 10 Sep 2013 23:11:59 +0200
Message-Id: <1378847522-13776-9-git-send-email-sven@narfation.org>
In-Reply-To: <1378847522-13776-1-git-send-email-sven@narfation.org>
References: <1378847522-13776-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 08/11] batctl: Fix error handling jump in
	interface when batadv not loaded
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
Cc: Sven Eckelmann <sven@narfation.org>

The jump to the path_buffer free must be taken when batman-adv was not loaded
because it has to free path_buff which was allocated earlier

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys.c b/sys.c
index 2fcd67b..7539f76 100644
--- a/sys.c
+++ b/sys.c
@@ -230,7 +230,7 @@ int interface(char *mesh_iface, int argc, char **argv)
 
 			if (!file_exists(module_ver_path)) {
 				fprintf(stderr, "Error - batman-adv module has not been loaded\n");
-				goto err;
+				goto err_buff;
 			}
 
 			fprintf(stderr, "Error - interface type not supported by batman-adv: %s\n", argv[i]);
-- 
1.8.4.rc3

