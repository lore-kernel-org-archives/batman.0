Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] batctl: Don't stop when create_interface detected existing interface
Date: Fri, 15 Jan 2021 23:38:31 +0100
Message-Id: <20210115223831.18027-1-sven@narfation.org>
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

"batctl meshif bat0 interface add ..." should never be called in parallel.
But when something still does this, it could be that the code first detects
the missing meshif and then tries to create it - which fails when another
process requested the creation of the same interface slightly before batctl
did it.

But this should not prevent batctl to add the lower interface to the
meshif. It is not really important that the batctl process was the one
which created it - only that it exists is important.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/interface.c b/interface.c
index 77ca1a0..7f77459 100644
--- a/interface.c
+++ b/interface.c
@@ -526,7 +526,7 @@ static int interface(struct state *state, int argc, char **argv)
 	ifmaster = if_nametoindex(state->mesh_iface);
 	if (!manual_mode && !ifmaster && rest_argv[0][0] == 'a') {
 		ret = create_interface(state->mesh_iface, &create_params);
-		if (ret < 0) {
+		if (ret < 0 && ret != -EEXIST) {
 			fprintf(stderr,
 				"Error - failed to create batman-adv interface: %s\n",
 				strerror(-ret));
-- 
2.29.2

