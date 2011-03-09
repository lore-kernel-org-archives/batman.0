Return-Path: <onelektra@gmx.net>
From: elektra <onelektra@gmx.net>
Date: Wed, 9 Mar 2011 17:48:32 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201103091748.32512.onelektra@gmx.net>
Subject: [B.A.T.M.A.N.] [Patch] vis: Modified format of JSON output.
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
Cc: Alberto Escudero-Pascual <aep@it46.se>

The current vis server JSON output format is breaking the json_decode() 
function for PHP. 

This patch mainly:
- Removes all spaces
- Removes all the \t TABS
- Double quotes the string-variables

Reported-by:  "Alberto Escudero-Pascual" <aep@it46.se>
Signed-off-by: "elektra" <onelektra@gmx.net>


--- vis.c       2011-03-09 17:19:59.000000000 +0100
+++ new/vis.c   2011-03-09 17:15:26.000000000 +0100
@@ -88,19 +88,21 @@
        if ( fork() )
                exit(EXIT_SUCCESS);
 
-       chdir( "/" );
+       if (chdir( "/" )==0) {
 
-       if ( ( fd = open(_PATH_DEVNULL, O_RDWR, 0) ) != -1 ) {
+               if ( ( fd = open(_PATH_DEVNULL, O_RDWR, 0) ) != -1 ) {
 
-               dup2(fd, STDIN_FILENO);
-               dup2(fd, STDOUT_FILENO);
-               dup2(fd, STDERR_FILENO);
+                       dup2(fd, STDIN_FILENO);
+                       dup2(fd, STDOUT_FILENO);
+                       dup2(fd, STDERR_FILENO);
 
-               if ( fd > 2 )
-                       close(fd);
+                       if ( fd > 2 )
+                               close(fd);
 
+               }
+       } else {
+               exit_error( "Error - can't chdir\n");
        }
-
        return 0;
 }
 
@@ -395,7 +397,7 @@
                                                fillme->dot_buffer = (char 
*)debugRealloc( fillme->dot_buffer, strlen( tmp ) + strlen( fillme->dot_buffer ) + 
1, 408 );
                                                strncat( fillme->dot_buffer, 
tmp, strlen( tmp ) );
 
-                                               snprintf( tmp, sizeof( tmp ), 
"%s\t{ router : \"%s\", neighbour : \"%s\", label : %.2f }",
+                                               snprintf( tmp, sizeof( tmp ), 
"%s{\"router\":\"%s\",\"neighbour\":\"%s\",\"label\":%.2f}",
                                                        (first_line ? "" : ",
\n"), from_str, to_str, (float)( orig_node->tq_max / (float)neigh->tq_avg ) );
                                                first_line = 0;
                                                fillme->json_buffer = (char 
*)debugRealloc( fillme->json_buffer, strlen( tmp ) + strlen( fillme->json_buffer ) 
+ 1, 408 );
@@ -416,7 +418,7 @@
                                        fillme->dot_buffer = (char 
*)debugRealloc( fillme->dot_buffer, strlen( tmp ) + strlen( fillme->dot_buffer ) + 
1, 409 );
                                        strncat( fillme->dot_buffer, tmp, 
strlen( tmp ) );
 
-                                       snprintf( tmp, sizeof( tmp ), "%s\t{ 
router : \"%s\", gateway : \"%s/%s\", label : \"HNA\" }",
+                                       snprintf( tmp, sizeof( tmp ), 
"%s{\"router\":\"%s\",\"gateway\":\"%s/%s\",\"label\":\"HNA\"}",
                                                (first_line ? "" : ",\n"), 
from_str, to_str, hna_str );
                                        first_line = 0;
                                        fillme->json_buffer = (char 
*)debugRealloc( fillme->json_buffer, strlen( tmp ) + strlen( fillme->json_buffer ) 
+ 1, 409 );
@@ -432,7 +434,7 @@
                                        strncat( fillme->dot_buffer, tmp, 
strlen( tmp ) );
 
