Message-Id: <F6D9C212-B698-46E4-8AE3-FE76DAFD2C54@7degrees.co.za>
From: Antoine van Gelder <antoine@7degrees.co.za>
Content-Type: multipart/alternative; boundary=Apple-Mail-19-218420088
Mime-Version: 1.0 (Apple Message framework v935.3)
Date: Mon, 18 May 2009 19:01:48 +0200
Subject: [B.A.T.M.A.N.] [PATCH] Allow vis daemon to serve mesh topology
	simultaneously in dot_draw and JSON format
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--Apple-Mail-19-218420088
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: quoted-printable


After some great input from Marek I took a swing at rewriting my vis =20
patch to allow serving of mesh topology simultaneously in dot_draw & =20
json.


* -j enables JSON server on port 2005

* dot_draw continues to be served on port 2004 irrespective of whether =20=

-j is specified or not.


Some thoughts:

* It is not the prettiest of patches but it works. Thinking about =20
cleaner approaches makes my imagination drift in the direction of a =20
simple plugin API such as OLSRd has, anyone else having any similar =20
thoughts ? :)

* I'm serving json on port 2005 - any alternative suggestions ?


Patch attached for review, looking forward to feedback!

  - a

--
http://7degrees.co.za
"Libr=E9 software for human education."




--Apple-Mail-19-218420088
Content-Type: multipart/mixed;
	boundary=Apple-Mail-20-218420089


--Apple-Mail-20-218420089
Content-Type: text/html;
	charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; "><div><br></div><div>After some =
great input from Marek I took a swing at rewriting my vis patch to allow =
serving of mesh topology simultaneously in dot_draw &amp; =
json.</div><div><br></div><div><br></div><div>* -j enables JSON server =
on port 2005</div><div><div><br></div><div>* dot_draw continues to be =
served on port 2004 irrespective of whether -j is specified or =
not.</div><div><br></div><div><br></div></div><div>Some =
thoughts:</div><div><br></div>* It is not the prettiest of patches but =
it works. Thinking about cleaner approaches makes my imagination drift =
in the direction of a simple plugin API such as OLSRd has, anyone else =
having any similar thoughts ? :)<div><div><br></div><div>* I'm serving =
json on port 2005 - any alternative suggestions ?<br><div =
apple-content-edited=3D"true"> <span class=3D"Apple-style-span" =
style=3D"border-collapse: separate; color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: 2; text-align: auto; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-border-horizontal-spacing: 0px; -webkit-border-vertical-spacing: =
0px; -webkit-text-decorations-in-effect: none; -webkit-text-size-adjust: =
auto; -webkit-text-stroke-width: 0; "><div style=3D"word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space; "><span class=3D"Apple-style-span" =
style=3D"border-collapse: separate; color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: 2; text-indent: 0px; text-transform: none; white-space: normal; =
widows: 2; word-spacing: 0px; -webkit-border-horizontal-spacing: 0px; =
-webkit-border-vertical-spacing: 0px; =
-webkit-text-decorations-in-effect: none; -webkit-text-size-adjust: =
auto; -webkit-text-stroke-width: 0px; =
"><div><br></div><div><br></div><div>Patch attached for review, looking =
forward to feedback!</div><div><br></div><div>&nbsp;- a</div><div><br =
class=3D"Apple-interchange-newline">--</div><div><a =
href=3D"http://7degrees.co.za">http://7degrees.co.za</a></div><div><div>"L=
ibr=E9 software for human =
education."</div><div><br></div><div><br></div></div></span></div></span><=
br class=3D"Apple-interchange-newline"> </div></div></div></body></html>=

--Apple-Mail-20-218420089
Content-Disposition: attachment;
	filename=vis.diff
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="vis.diff"
Content-Transfer-Encoding: 7bit

diff --git a/Makefile b/Makefile
diff --git a/README b/README
diff --git a/allocate.c b/allocate.c
diff --git a/allocate.h b/allocate.h
diff --git a/hash.c b/hash.c
diff --git a/hash.h b/hash.h
diff --git a/list-batman.c b/list-batman.c
diff --git a/list-batman.h b/list-batman.h
diff --git a/udp_server.c b/udp_server.c
diff --git a/vis-types.h b/vis-types.h
diff --git a/vis.c b/vis.c
index 4b8a5df..d531af1 100644
--- a/vis.c
+++ b/vis.c
@@ -58,6 +58,8 @@ buffer_t *fillme = NULL;
 static int8_t stop;
 uint8_t debug_level = 0;
 
+formats selected_formats = dot_draw;
+
 struct hashtable_t *node_hash;
 struct hashtable_t *secif_hash;
 
@@ -145,7 +147,6 @@ void restore_defaults() {
 	struct vis_if *vis_if;
 	struct list_head *list_pos, *list_pos_tmp;
 
-
 	if ( udp_server_thread != 0 )
 		pthread_join( udp_server_thread, NULL );
 
@@ -159,8 +160,11 @@ void restore_defaults() {
 		if ( vis_if->udp_sock )
 			close( vis_if->udp_sock );
 
-		if ( vis_if->tcp_sock )
-			close( vis_if->tcp_sock );
+    if ( vis_if->dot_tcp_sock )
+      close( vis_if->dot_tcp_sock );
+
+    if ( vis_if->json_tcp_sock )
+      close( vis_if->json_tcp_sock );
 
 		debugFree( vis_if, 2000 );
 
@@ -309,7 +313,8 @@ void clean_buffer() {
 
 		rm = i;
 		i = i->next;
-		debugFree( rm->buffer, 2004 );
+		debugFree( rm->dot_buffer, 2004 );
+		debugFree( rm->json_buffer, 2018 );
 		debugFree( rm, 2005 );
 
 	}
@@ -328,7 +333,7 @@ void write_data_in_buffer() {
 	struct list_head *list_pos, *list_pos_tmp, *prev_list_head;
 	struct hash_it_t *hashit = NULL;
 	char from_str[16], to_str[16], hna_str[16], tmp[100];
-
+  char first_line = 1;
 
 	memset( tmp, 0, sizeof(tmp) );
 
@@ -385,9 +390,14 @@ void write_data_in_buffer() {
 						}
 
 						snprintf( tmp, sizeof( tmp ), "\"%s\" -> \"%s\"[label=\"%.2f\"]\n", from_str, to_str, (float)( orig_node->tq_max / (float)neigh->tq_avg ) );
-						fillme->buffer = (char *)debugRealloc( fillme->buffer, strlen( tmp ) + strlen( fillme->buffer ) + 1, 408 );
+						fillme->dot_buffer = (char *)debugRealloc( fillme->dot_buffer, strlen( tmp ) + strlen( fillme->dot_buffer ) + 1, 408 );
+						strncat( fillme->dot_buffer, tmp, strlen( tmp ) );
 
-						strncat( fillme->buffer, tmp, strlen( tmp ) );
+            snprintf( tmp, sizeof( tmp ), "%s\t{ router : \"%s\", neighbour : \"%s\", label : %.2f }",
+                      (first_line ? "" : ",\n"), from_str, to_str, (float)( orig_node->tq_max / (float)neigh->tq_avg ) );
+            first_line = 0;
+						fillme->json_buffer = (char *)debugRealloc( fillme->json_buffer, strlen( tmp ) + strlen( fillme->json_buffer ) + 1, 408 );
+						strncat( fillme->json_buffer, tmp, strlen( tmp ) );
 
 					}
 
@@ -401,9 +411,14 @@ void write_data_in_buffer() {
 					addr_to_string( ( hna->netmask == 32 ? 0xffffffff : htonl( ~ ( 0xffffffff >> hna->netmask ) ) ), hna_str, sizeof( hna_str ) );
 
 					snprintf( tmp, sizeof( tmp ), "\"%s\" -> \"%s/%s\"[label=\"HNA\"]\n", from_str, to_str, hna_str );
-					fillme->buffer = (char *)debugRealloc( fillme->buffer, strlen( tmp ) + strlen( fillme->buffer ) + 1, 409 );
+					fillme->dot_buffer = (char *)debugRealloc( fillme->dot_buffer, strlen( tmp ) + strlen( fillme->dot_buffer ) + 1, 409 );
+					strncat( fillme->dot_buffer, tmp, strlen( tmp ) );
 
-					strncat( fillme->buffer, tmp, strlen( tmp ) );
+          snprintf( tmp, sizeof( tmp ), "%s\t{ router : \"%s\", gateway : \"%s/%s\", label : \"HNA\" }",
+                    (first_line ? "" : ",\n"), from_str, to_str, hna_str );
+          first_line = 0;
+          fillme->json_buffer = (char *)debugRealloc( fillme->json_buffer, strlen( tmp ) + strlen( fillme->json_buffer ) + 1, 409 );
+					strncat( fillme->json_buffer, tmp, strlen( tmp ) );
 
 				}
 
@@ -411,8 +426,15 @@ void write_data_in_buffer() {
 				if ( orig_node->gw_class != 0 ) {
 
 					snprintf( tmp, sizeof( tmp ), "\"%s\" -> \"0.0.0.0/0.0.0.0\"[label=\"HNA\"]\n", from_str );
-					fillme->buffer = (char *)debugRealloc( fillme->buffer, strlen( tmp ) + strlen( fillme->buffer ) + 1, 410 );
-					strncat( fillme->buffer, tmp, strlen( tmp ) );
+					fillme->dot_buffer = (char *)debugRealloc( fillme->dot_buffer, strlen( tmp ) + strlen( fillme->dot_buffer ) + 1, 410 );
+					strncat( fillme->dot_buffer, tmp, strlen( tmp ) );
+
+          snprintf( tmp, sizeof( tmp ),
+                    "%s\t{ router : \"%s\", gateway : \"%s\", label : \"%s\" }",
+                    (first_line ? "" : ",\n"), from_str, "0.0.0.0/0.0.0.0", "HNA" );
+          first_line = 0;
+					fillme->json_buffer = (char *)debugRealloc( fillme->json_buffer, strlen( tmp ) + strlen( fillme->json_buffer ) + 1, 410 );
+					strncat( fillme->json_buffer, tmp, strlen( tmp ) );
 
 				}
 
@@ -541,8 +563,8 @@ void *tcp_server( void *arg ) {
 
 	struct thread_data *thread_data = ((struct thread_data*) arg);
 	buffer_t *last_send = NULL;
-	ssize_t ret;
-
+	size_t ret;
+  char* send_buffer = NULL;
 
 	while ( !is_aborted() ) {
 
@@ -551,10 +573,16 @@ void *tcp_server( void *arg ) {
 			pthread_mutex_lock( &current->mutex );
 			current->counter = current->counter == -1 ? 1 : current->counter + 1;
 			pthread_mutex_unlock( &current->mutex );
-			ret = write( thread_data->socket, current->buffer, strlen( current->buffer ) );
-			if( ret != strlen( current->buffer ) )
-			{
 
+      if (thread_data->format == dot_draw) {
+        send_buffer = current->dot_buffer;
+      } else if (thread_data->format == json) {
+        send_buffer = current->json_buffer;
+      }
+
+			ret = write( thread_data->socket, send_buffer, strlen( send_buffer ) );
+			if( ret != strlen( send_buffer ) || (thread_data->format == json) )
+			{
 				pthread_mutex_lock( &current->mutex );
 				current->counter--;
 				pthread_mutex_unlock( &current->mutex );
@@ -583,11 +611,44 @@ void *tcp_server( void *arg ) {
 
 
 
+void create_tcp_server ( int32_t socket, formats format ) {
+
+  struct thread_data *thread_data;
+  pthread_t tcp_server_thread;
+  struct sockaddr_in addr_client;
+	int32_t unix_opts;
+  socklen_t len_inet;
+
+  thread_data = debugMalloc( sizeof(struct thread_data), 1003 );
+
+  thread_data->format = format;
+
+  len_inet = sizeof(addr_client);
+  thread_data->socket = accept( socket, (struct sockaddr*)&addr_client, &len_inet );
+
+  addr_to_string( addr_client.sin_addr.s_addr, thread_data->ip, sizeof(thread_data->ip) );
+
+  if ( debug_level > 0 )
+    debug_output( "New TCP client connected: %s \n", thread_data->ip );
+
+  /* make tcp socket non blocking */
+  unix_opts = fcntl( thread_data->socket, F_GETFL, 0 );
+  fcntl( thread_data->socket, F_SETFL, unix_opts | O_NONBLOCK );
+
+  pthread_create( &tcp_server_thread, NULL, &tcp_server, thread_data );
+  pthread_detach( tcp_server_thread );
+}
+
+
+
 void *master() {
 
 	buffer_t *new, *tmp;
-	char begin[] = "digraph topology\n{\n";
-	char end[] = "}\n";
+	char dot_begin [] = "digraph topology\n{\n";
+	char dot_end   [] = "}\n";
+  char json_begin[] = "HTTP/1.0 200 OK\nContent-type: application/json\n\n[\n";
+  char json_end  [] = "\n]\n";
+
 
 	while ( !is_aborted() ) {
 
@@ -599,7 +660,8 @@ void *master() {
 				break;
 
 			first = tmp->next;
-			debugFree( tmp->buffer, 2012 );
+			debugFree( tmp->dot_buffer, 2012 );
+			debugFree( tmp->json_buffer, 2019 );
 			debugFree( tmp, 2013 );
 			tmp = first;
 
@@ -610,17 +672,25 @@ void *master() {
 		new->next = NULL;
 		pthread_mutex_init( &new->mutex, NULL );
 
-		new->buffer = (char *)debugMalloc( strlen( begin ) + 1, 1001 );
-		memset( new->buffer, 0, strlen( begin ) );
-		strncpy( new->buffer, begin, strlen( begin ) + 1);
+		new->dot_buffer = (char *)debugMalloc( strlen( dot_begin ) + 1, 1001 );
+		memset( new->dot_buffer, 0, strlen( dot_begin ) );
+		strncpy( new->dot_buffer, dot_begin, strlen( dot_begin ) + 1);
 
-		/* printf( "vis.c buffer: %s\n-----Ende-----\n", new->buffer ); */
+		new->json_buffer = (char *)debugMalloc( strlen( json_begin ) + 1, 1001 );
+		memset( new->json_buffer, 0, strlen( json_begin ) );
+		strncpy( new->json_buffer, json_begin, strlen( json_begin ) + 1);
+
+		/* printf( "vis.c dot  buffer: %s\n-----Ende-----\n", new->dot_buffer ); */
+		/* printf( "vis.c json buffer: %s\n-----Ende-----\n", new->json_buffer ); */
 		fillme = new;
 
 		write_data_in_buffer();
 
-		new->buffer = (char *)debugRealloc( new->buffer, strlen( new->buffer ) + strlen( end ) + 1, 407 );
-		strncat( new->buffer, end, strlen( end ) );
+		new->dot_buffer = (char *)debugRealloc( new->dot_buffer, strlen( new->dot_buffer ) + strlen( dot_end ) + 1, 407 );
+		strncat( new->dot_buffer, dot_end, strlen( dot_end ) );
+
+		new->json_buffer = (char *)debugRealloc( new->json_buffer, strlen( new->json_buffer ) + strlen( json_end ) + 1, 407 );
+		strncat( new->json_buffer, json_end, strlen( json_end ) );
 
 		if ( first == NULL )
 			first = new;
@@ -643,6 +713,7 @@ void print_usage() {
 
 	printf( "B.A.T.M.A.N. visualisation server %s\n", SOURCE_VERSION );
 	printf( "Usage: vis <interface(s)> \n" );
+  printf( "\t-j output mesh topology as json on port %d\n", JSON_PORT );
 	printf( "\t-d debug level\n" );
 	printf( "\t-h help\n" );
 	printf( "\t-v Version\n\n" );
@@ -657,19 +728,14 @@ int main( int argc, char **argv ) {
 	char ip_str[ADDR_STR_LEN];
 	int max_sock = 0, optchar, on = 1, debug_level_max = 1;
 	uint8_t found_args = 1;
-	int32_t unix_opts;
-	struct sockaddr_in addr_client;
 	struct ifreq int_req;
 	struct vis_if *vis_if;
 	struct list_head *list_pos;
-	struct thread_data *thread_data;
 	struct timeval tv;
 	fd_set wait_sockets, tmp_wait_sockets;
-	socklen_t len_inet;
-	pthread_t tcp_server_thread;
 
 
-	while ( ( optchar = getopt ( argc, argv, "d:hv" ) ) != -1 ) {
+	while ( ( optchar = getopt ( argc, argv, "jd:hv" ) ) != -1 ) {
 
 		switch( optchar ) {
 
@@ -700,6 +766,11 @@ int main( int argc, char **argv ) {
 				exit(EXIT_SUCCESS);
 				break;
 
+			case 'j':
+				selected_formats |= json;
+				found_args++;
+				break;      
+
 			default:
 				print_usage();
 				exit(EXIT_SUCCESS);
@@ -709,7 +780,6 @@ int main( int argc, char **argv ) {
 
 	}
 
-
 	stop = 0;
 
 	signal( SIGINT, handler );
@@ -746,7 +816,7 @@ int main( int argc, char **argv ) {
 		if ( ( vis_if->udp_sock = socket( PF_INET, SOCK_DGRAM, 0 ) ) < 0 )
 			exit_error( "Error - could not create udp socket for interface %s: %s\n", vis_if->dev, strerror( errno ) );
 
-		if ( ( vis_if->tcp_sock = socket( AF_INET, SOCK_STREAM, 0 ) ) < 0 )
+    if ( ( vis_if->dot_tcp_sock = socket( AF_INET, SOCK_STREAM, 0 ) ) < 0 )
 			exit_error( "Error - could not create tcp socket for interface %s: %s\n", vis_if->dev, strerror( errno ) );
 
 		memset( &int_req, 0, sizeof ( struct ifreq ) );
@@ -759,31 +829,56 @@ int main( int argc, char **argv ) {
 		vis_if->udp_addr.sin_port = htons(VIS_PORT);
 		vis_if->udp_addr.sin_addr.s_addr = ((struct sockaddr_in *)&int_req.ifr_addr)->sin_addr.s_addr;
 
-		vis_if->tcp_addr.sin_family = AF_INET;
-		vis_if->tcp_addr.sin_port = htons(DOT_DRAW_PORT);
-		vis_if->tcp_addr.sin_addr.s_addr = ((struct sockaddr_in *)&int_req.ifr_addr)->sin_addr.s_addr;
+		vis_if->dot_tcp_addr.sin_family = AF_INET;
+		vis_if->dot_tcp_addr.sin_port = htons(DOT_DRAW_PORT);
+		vis_if->dot_tcp_addr.sin_addr.s_addr = ((struct sockaddr_in *)&int_req.ifr_addr)->sin_addr.s_addr;
 
 		addr_to_string( vis_if->udp_addr.sin_addr.s_addr, ip_str, sizeof (ip_str) );
 
 		if ( vis_if->udp_addr.sin_addr.s_addr == INADDR_NONE )
 			exit_error( "Error - interface %s has invalid address: %s\n", vis_if->dev, ip_str );
 
-		if ( setsockopt( vis_if->tcp_sock, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(int) ) < 0 )
+		if ( setsockopt( vis_if->dot_tcp_sock, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(int) ) < 0 )
 			exit_error( "Error - ioctl SO_REUSEADDR on interface %s failed: %s\n", vis_if->dev, strerror( errno ) );
 
 		if ( bind( vis_if->udp_sock, (struct sockaddr*)&vis_if->udp_addr, sizeof(struct sockaddr_in) ) < 0 )
 			exit_error( "Error - could not bind to interface (udp) %s: %s\n", vis_if->dev, strerror( errno ) );
 
-		if ( bind( vis_if->tcp_sock, (struct sockaddr*)&vis_if->tcp_addr, sizeof(struct sockaddr_in) ) < 0 )
+		if ( bind( vis_if->dot_tcp_sock, (struct sockaddr*)&vis_if->dot_tcp_addr, sizeof(struct sockaddr_in) ) < 0 )
+			exit_error( "Error - could not bind to interface (tcp) %s: %s\n", vis_if->dev, strerror( errno ) );
+
+		if ( listen( vis_if->dot_tcp_sock, 32 ) < 0 )
+			exit_error( "Error - could not start listening on interface %s: %s\n", vis_if->dev, strerror( errno ) );
+
+		if ( vis_if->dot_tcp_sock > max_sock )
+			max_sock = vis_if->dot_tcp_sock;
+
+		FD_SET(vis_if->dot_tcp_sock, &wait_sockets);
+
+    /* enable any other vis output formats specified on the command line */
+    if ( selected_formats & json ) {
+
+      if ( ( vis_if->json_tcp_sock = socket( AF_INET, SOCK_STREAM, 0 ) ) < 0 )
+        exit_error( "Error - could not create tcp socket for interface %s: %s\n", vis_if->dev, strerror( errno ) );
+
+      vis_if->json_tcp_addr.sin_family = AF_INET;
+      vis_if->json_tcp_addr.sin_port = htons(JSON_PORT);
+      vis_if->json_tcp_addr.sin_addr.s_addr = ((struct sockaddr_in *)&int_req.ifr_addr)->sin_addr.s_addr;
+      
+      if ( setsockopt( vis_if->json_tcp_sock, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(int) ) < 0 )
+        exit_error( "Error - ioctl SO_REUSEADDR on interface %s failed: %s\n", vis_if->dev, strerror( errno ) );
+      
+      if ( bind( vis_if->json_tcp_sock, (struct sockaddr*)&vis_if->json_tcp_addr, sizeof(struct sockaddr_in) ) < 0 )
 			exit_error( "Error - could not bind to interface (tcp) %s: %s\n", vis_if->dev, strerror( errno ) );
 
-		if ( listen( vis_if->tcp_sock, 32 ) < 0 )
+      if ( listen( vis_if->json_tcp_sock, 32 ) < 0 )
 			exit_error( "Error - could not start listening on interface %s: %s\n", vis_if->dev, strerror( errno ) );
 
-		if ( vis_if->tcp_sock > max_sock )
-			max_sock = vis_if->tcp_sock;
+      if ( vis_if->json_tcp_sock > max_sock && vis_if->json_tcp_sock > vis_if->dot_tcp_sock )
+        max_sock = vis_if->json_tcp_sock;
 
-		FD_SET(vis_if->tcp_sock, &wait_sockets);
+      FD_SET(vis_if->json_tcp_sock, &wait_sockets);
+    }
 
 		list_add_tail( &vis_if->list, &vis_if_list );
 
@@ -817,8 +912,6 @@ int main( int argc, char **argv ) {
 		tv.tv_sec = 1;
 		tv.tv_usec = 0;
 
-		len_inet = sizeof(addr_client);
-
  		/*checkIntegrity();*/
 
 		if ( select( max_sock + 1, &tmp_wait_sockets, NULL, NULL, &tv ) > 0 ) {
@@ -827,23 +920,13 @@ int main( int argc, char **argv ) {
 
 				vis_if = list_entry( list_pos, struct vis_if, list );
 
-				if ( FD_ISSET( vis_if->tcp_sock, &tmp_wait_sockets ) ) {
+				if ( FD_ISSET( vis_if->dot_tcp_sock, &tmp_wait_sockets ) ) {
 
-					thread_data = debugMalloc( sizeof(struct thread_data), 1003 );
+          create_tcp_server( vis_if->dot_tcp_sock, dot_draw );
 
-					thread_data->socket = accept( vis_if->tcp_sock, (struct sockaddr*)&addr_client, &len_inet );
-
-					addr_to_string( addr_client.sin_addr.s_addr, thread_data->ip, sizeof(thread_data->ip) );
+				} else if ( FD_ISSET( vis_if->json_tcp_sock, &tmp_wait_sockets )  ) { 
 
-					if ( debug_level > 0 )
-						debug_output( "New TCP client connected: %s \n", thread_data->ip );
-
-					/* make tcp socket non blocking */
-					unix_opts = fcntl( thread_data->socket, F_GETFL, 0 );
-					fcntl( thread_data->socket, F_SETFL, unix_opts | O_NONBLOCK );
-
-					pthread_create( &tcp_server_thread, NULL, &tcp_server, thread_data );
-					pthread_detach( tcp_server_thread );
+          create_tcp_server( vis_if->json_tcp_sock, json );
 
 				}
 
diff --git a/vis.h b/vis.h
index f082700..654e187 100644
--- a/vis.h
+++ b/vis.h
@@ -43,6 +43,7 @@
 
 #define VIS_PORT 4307
 #define DOT_DRAW_PORT 2004
+#define JSON_PORT 2005
 
 #define ADDR_STR_LEN 16
 
@@ -64,11 +65,13 @@ extern struct hashtable_t *secif_hash;
 
 extern uint8_t debug_level;
 
-
+typedef enum { dot_draw = 1, json = 2, last = 4 } formats;
+extern formats selected_formats;
 
 struct thread_data {
 	int socket;
 	char ip[ADDR_STR_LEN];
+  formats format;
 };
 
 struct neighbour {
@@ -107,7 +110,8 @@ struct secif_lst {
 };
 
 typedef struct _buffer {
-	char *buffer;
+	char *dot_buffer;
+	char *json_buffer;
 	int counter;
 	struct _buffer *next;
 	pthread_mutex_t mutex;
@@ -117,9 +121,11 @@ struct vis_if {
 	struct list_head list;
 	char *dev;
 	int32_t udp_sock;
-	int32_t tcp_sock;
+	int32_t dot_tcp_sock;
+	int32_t json_tcp_sock;
 	struct sockaddr_in udp_addr;
-	struct sockaddr_in tcp_addr;
+	struct sockaddr_in dot_tcp_addr;
+	struct sockaddr_in json_tcp_addr;
 };
 
 void clean_secif_hash();

--Apple-Mail-20-218420089
Content-Type: text/html;
	charset=US-ASCII
Content-Transfer-Encoding: 7bit

<html><body style="word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space; "><div><div></div></div></body></html>
--Apple-Mail-20-218420089--

--Apple-Mail-19-218420088--
