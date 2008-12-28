From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 28 Dec 2008 14:05:32 +0100
Message-Id: <1230469532-24319-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] Split SOURCE_VERSION in RELEASE- AND
	EXTRA_VERSION
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

RELEASE_VERSION and EXTRA_VERSION can be concatenate to a single
SOURCE_VERSION string. This makes it possible to detect unstable
versions during compile time instead of removing the unstable warning
in a seperate commit (or forget this change).
Before releasing the a new stable version the release manager must set
EXTRA_VERSION to "", check INSTALL, THANKS and README and then create
the tag in the repository.
Afterwards the development branch should change the RELEASE_VERSION to
the upcoming version number and the EXTRA_VERSION to a string which
informs the user that it is "unstable" and in development. This could be
for example "-dev", "-pre-alpha", "-beta" or "-rc1".

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/batman.h     |    5 ++++-
 batman/posix/init.c |    3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/batman/batman.h b/batman/batman.h
index 6af9136..6d1c16a 100644
--- a/batman/batman.h
+++ b/batman/batman.h
@@ -39,7 +39,8 @@
 
 
 
-#define SOURCE_VERSION "0.3.1" /* put exactly one distinct word inside the string like "0.3-pre-alpha" or "0.3-rc1" or "0.3" */
+#define RELEASE_VERSION "0.3.1" /* put exactly one distinct word inside the string like "0.3" or "0.3.1" */
+#define EXTRA_VERSION "" /* put one or less distinct words inside the string like "-pre-alpha" or "-rc1" or "" */
 #define COMPAT_VERSION 5
 #define PORT 4305
 #define GW_PORT 4306
@@ -66,6 +67,8 @@
 #define REVISION_VERSION "0"
 #endif
 
+#define SOURCE_VERSION RELEASE_VERSION""EXTRA_VERSION
+
 
 
 /*
diff --git a/batman/posix/init.c b/batman/posix/init.c
index c79c010..b850b61 100644
--- a/batman/posix/init.c
+++ b/batman/posix/init.c
@@ -249,7 +249,8 @@ void apply_init_args( int argc, char *argv[] ) {
 	stop = 0;
 	prog_name = argv[0];
 
-/*	printf( "WARNING: You are using the unstable batman branch. If you are interested in *using* batman get the latest stable release !\n" );*/
+	if (strlen(EXTRA_VERSION) > 0)
+		printf( "WARNING: You are using the unstable batman branch. If you are interested in *using* batman get the latest stable release !\n" );
 
 	while ( ( optchar = getopt_long( argc, argv, "a:A:bcd:hHio:g:p:r:s:vV", long_options, &option_index ) ) != -1 ) {
 
-- 
1.6.0.6

