From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 28 Dec 2008 17:33:02 +0100
Message-Id: <1230481982-8960-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <200812281730.53628.sven.eckelmann@gmx.de>
References: <200812281730.53628.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] Detect unstable version in SOURCE_VERSION
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

The SOURCE_VERSION consists of a version part and the actual status of
this version (called postfix). Both parts are seperated by a dash.
This seperator dash can be detected during runtime and can enable the
unstable warning instead of removing this warning in every release.
Before releasing the a new stable version the release manager must
remove the postfix of SOURCE_VERSION in batman.h, check INSTALL,
THANKS and README and then create the tag in the repository as usual.
Afterwards the development branch should change the SOURCE_VERSION to
the upcoming version number including a postfix starting with a dash
that informs the user that it is "unstable" and in development. This
could be for example "-dev", "-pre-alpha", "-beta" or "-rc1".

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/posix/init.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/batman/posix/init.c b/batman/posix/init.c
index c79c010..1447178 100644
--- a/batman/posix/init.c
+++ b/batman/posix/init.c
@@ -249,7 +249,8 @@ void apply_init_args( int argc, char *argv[] ) {
 	stop = 0;
 	prog_name = argv[0];
 
-/*	printf( "WARNING: You are using the unstable batman branch. If you are interested in *using* batman get the latest stable release !\n" );*/
+	if ( strstr( SOURCE_VERSION, "-" ) != NULL )
+		printf( "WARNING: You are using the unstable batman branch. If you are interested in *using* batman get the latest stable release !\n" );
 
 	while ( ( optchar = getopt_long( argc, argv, "a:A:bcd:hHio:g:p:r:s:vV", long_options, &option_index ) ) != -1 ) {
 
-- 
1.6.0.6

