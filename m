Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 22 Jan 2017 13:21:13 +0100
Message-Id: <20170122122113.29588-9-sven@narfation.org>
In-Reply-To: <3266034.EiLA6asg3G@sven-edge>
References: <3266034.EiLA6asg3G@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH 9/9] batctl: Allow to read list of interfaces
	as normal user
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

The list of interfaces attached to a batman-adv interface can be read by a
normal user via rtnetlink or sysfs. Only modifying this list requires more
acesss. Don't artificially restrict access to this information by the
batctl sucommand.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 interface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/interface.c b/interface.c
index 01ee6fc..5a57be6 100644
--- a/interface.c
+++ b/interface.c
@@ -324,14 +324,14 @@ int interface(char *mesh_iface, int argc, char **argv)
 		}
 	}
 
-	check_root_or_die("batctl interface");
-
 	rest_argc = argc - optind;
 	rest_argv = &argv[optind];
 
 	if (rest_argc == 0)
 		return print_interfaces(mesh_iface);
 
+	check_root_or_die("batctl interface");
+
 	if ((strcmp(rest_argv[0], "add") != 0) && (strcmp(rest_argv[0], "a") != 0) &&
 	    (strcmp(rest_argv[0], "del") != 0) && (strcmp(rest_argv[0], "d") != 0) &&
 	    (strcmp(rest_argv[0], "create") != 0) && (strcmp(rest_argv[0], "c") != 0) &&
-- 
2.11.0

