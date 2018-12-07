Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  7 Dec 2018 22:46:29 +0100
Message-Id: <20181207214629.30307-2-sven@narfation.org>
In-Reply-To: <20181207214629.30307-1-sven@narfation.org>
References: <20181207214629.30307-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batctl: Drop incorrect check for
 existing meshif directory
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

The (not silenced) read_file/write_file functions will check whether the
directory of a file exists. This is used to determine whether the mesh
interface was created. In that case, it will print:

  Error - mesh has not been enabled yet
  Activate your mesh by adding interfaces to batman-adv

This is most of the time wrong because only a limited number of commands
will call these function:

* gw_mode
* log
* loglevel
* routing_algo
* backbonetable
* claimtable
* dat_cache
* gateways
* mcast_flags
* nc_nodes
* neighbors
* originators
* transglobal
* translocal

Beside routing_algo, every command is marked as COMMAND_FLAG_MESH_IFACE and
therefore already requested a check to make sure that the specified meshif
existed at some point.

This message is especially confusing because debugfs can be disabled in
batman-adv. If it was compiled without debugfs and the user tries to still
use `batctl log`, the log command will fail with an incorrect error message
instead of showing a more detailed (and more correct):

  Error - can't open file '/sys/kernel/debug//batman_adv/bat0/log': No such file or directory
  The option you called seems not to be compiled into your batman-adv kernel module.
  Consult the README if you wish to learn more about compiling options into batman-adv.

And for routing_algo, the problem of the missing batman-adv module should
already be catched when the batman-adv module version path is checked.

Reported-by: Andre Kasper <andre.kasper@gmx.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/functions.c b/functions.c
index 9a130e1..9d64c62 100644
--- a/functions.c
+++ b/functions.c
@@ -149,12 +149,6 @@ static void file_open_problem_dbg(const char *dir, const char *full_path)
 		return;
 	}
 
-	if (!file_exists(dir)) {
-		fprintf(stderr, "Error - mesh has not been enabled yet\n");
-		fprintf(stderr, "Activate your mesh by adding interfaces to batman-adv\n");
-		return;
-	}
-
 	fprintf(stderr, "Error - can't open file '%s': %s\n", full_path, strerror(errno));
 	fprintf(stderr, "The option you called seems not to be compiled into your batman-adv kernel module.\n");
 	fprintf(stderr, "Consult the README if you wish to learn more about compiling options into batman-adv.\n");
-- 
2.19.2

