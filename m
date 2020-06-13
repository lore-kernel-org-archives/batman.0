Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 2/2] batctl: Disable automatic destruction of empty meshifs
Date: Sat, 13 Jun 2020 17:59:35 +0200
Message-Id: <20200613155935.8934-2-sven@narfation.org>
In-Reply-To: <20200613155935.8934-1-sven@narfation.org>
References: <20200613155935.8934-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Sven Eckelmann <sven@narfation.org>

The sysfs interface of batman-adv used an automatic drop of empty batadv
meshifs. This was necessary because no other method to remove this type
of interface was available. The same behavior was tried to emulate in the
batctl rtnetlink implementation to make the migration easier.

But this caused problems with both (rtnetlink/sysfs) backends because the
caller might not be aware of the current state of hardifs list for the
current meshif. The meshif might therefore be deleted accidentally (and its
configuration lost) even when the caller only wanted to swap some devices
around.

Instead print information about the necessary addition steps to drop the
empty meshif instead of performing it automatically.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 interface.c  | 5 +++--
 man/batctl.8 | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/interface.c b/interface.c
index ac4d883..d0d9435 100644
--- a/interface.c
+++ b/interface.c
@@ -31,7 +31,7 @@ static void interface_usage(void)
 	fprintf(stderr, "Usage: batctl [options] interface [parameters] [add|del iface(s)]\n");
 	fprintf(stderr, "       batctl [options] interface [parameters] [create|destroy]\n");
 	fprintf(stderr, "parameters:\n");
-	fprintf(stderr, " \t -M disable automatic creation/removal of batman-adv interface\n");
+	fprintf(stderr, " \t -M disable automatic creation of batman-adv interface\n");
 	fprintf(stderr, " \t -h print this help\n");
 }
 
@@ -535,7 +535,8 @@ static int interface(struct state *state, int argc, char **argv)
 	if (!manual_mode && rest_argv[0][0] == 'd') {
 		cnt = count_interfaces(state->mesh_iface);
 		if (cnt == 0 && pre_cnt > 0)
-			destroy_interface(state->mesh_iface);
+			fprintf(stderr, "Warning: %s has no interfaces and can be destroyed with: batctl meshif %s interface destroy\n",
+				state->mesh_iface, state->mesh_iface);
 	}
 
 	return EXIT_SUCCESS;
diff --git a/man/batctl.8 b/man/batctl.8
index 6e75cdd..fedfb21 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -58,8 +58,8 @@ performances, is also included.
 If no parameter is given or the first parameter is neither "add" nor "del" the current interface settings are displayed.
 In order to add or delete interfaces specify "add" or "del" as first argument and append the interface names you wish to
 add or delete. Multiple interfaces can be specified.
-The "\-M" option tells batctl to not automatically create the batman-adv interface on "add" or to destroy it when "del"
-removed all interfaces which belonged to it.
+The "\-M" option tells batctl to not automatically create the batman-adv interface on "add". It can also be used to
+suppress the warning about the manual destruction when "del" removed all interfaces which belonged to it.
 .IP "[\fBmeshif <netdev>\fP] \fBinterface\fP|\fBif\fP [\fBcreate\fP|\fBdestroy\fP]"
 A batman-adv interface without attached interfaces can be created using "create". The parameter "destroy" can be used to
 free all attached interfaces and remove batman-adv interface.
-- 
2.20.1

