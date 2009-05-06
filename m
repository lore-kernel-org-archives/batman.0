Message-Id: <593D0014-6574-4B3B-9C35-4442556CC0B3@7degrees.co.za>
From: Antoine van Gelder <antoine@7degrees.co.za>
In-Reply-To: <200905061518.05597.lindner_marek@yahoo.de>
Content-Type: multipart/mixed; boundary=Apple-Mail-72--843769777
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Wed, 6 May 2009 11:58:38 +0200
References: <bad82a80905050708x1f0a75f0j27e78d72c81201bc@mail.gmail.com>
	<200905061315.09151.lindner_marek@yahoo.de>
	<08B01611-F186-4533-9CC2-AA16BF92FEF7@7degrees.co.za>
	<200905061518.05597.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] Add switch for vis daemon to serve mesh
	topology in JSON format - TAKE 2
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


--Apple-Mail-72--843769777
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit


Apologies, I'm not sure why that got mangled, let's try that again.

  - antoine

--

Patch attached for review.

NOTES

* -j turns on JSON mode and closes the socket after serving the  
browser request.

* Data is served in the format

    [ { router : "d.d.d.d", neighbour|gateway : "d.d.d.d", label :  
d.dd|"HNA" }, ... ]

  e.g.

    HTTP/1.0 200 OK
    Content-type: application/json

    [
        { router : "10.0.0.5", neighbour : "10.0.0.3", label : 1.01 },
        { router : "10.0.0.5", neighbour : "10.0.0.6", label : 1.00 },
        { router : "10.0.0.5", neighbour : "10.0.0.1", label : 1.00 },
        { router : "10.0.0.3", neighbour : "10.0.0.5", label : 1.00 },
        { router : "10.0.0.3", neighbour : "10.0.0.1", label : 1.00 },
        { router : "10.0.0.3", neighbour : "10.0.0.6", label : 1.00 },
        { router : "10.0.0.6", neighbour : "10.0.0.5", label : 1.00 },
        { router : "10.0.0.6", neighbour : "10.0.0.3", label : 1.00 },
        { router : "10.0.0.6", neighbour : "10.0.0.1", label : 1.00 },
        { router : "10.0.0.1", neighbour : "10.0.0.3", label : 1.00 },
        { router : "10.0.0.1", neighbour : "10.0.0.5", label : 1.00 },
        { router : "10.0.0.1", neighbour : "10.0.0.6", label : 1.03 },
        { router : "10.0.0.1", gateway : "0.0.0.0/0.0.0.0", label :  
"HNA" }
    ]


Thank you Marek!

- antoine



--Apple-Mail-72--843769777
Content-Disposition: attachment;
	filename=vis.diff
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="vis.diff"
Content-Transfer-Encoding: 7bit

diff --git a/vis.c b/vis.c
index 4b8a5df..9b6aeaa 100644
--- a/vis.c
+++ b/vis.c
@@ -58,6 +58,8 @@ buffer_t *fillme = NULL;
 static int8_t stop;
 uint8_t debug_level = 0;
 
+formats output_format = dot;
+
 struct hashtable_t *node_hash;
 struct hashtable_t *secif_hash;
 
@@ -328,7 +330,7 @@ void write_data_in_buffer() {
 	struct list_head *list_pos, *list_pos_tmp, *prev_list_head;
 	struct hash_it_t *hashit = NULL;
 	char from_str[16], to_str[16], hna_str[16], tmp[100];
-
+  char first = 1;
 
 	memset( tmp, 0, sizeof(tmp) );
 
@@ -384,7 +386,15 @@ void write_data_in_buffer() {
 
 						}
 
-						snprintf( tmp, sizeof( tmp ), "\"%s\" -> \"%s\"[label=\"%.2f\"]\n", from_str, to_str, (float)( orig_node->tq_max / (float)neigh->tq_avg ) );
+            if ( output_format == json ) {
+              snprintf( tmp, sizeof( tmp ),
+                        "%s\t{ router : \"%s\", neighbour : \"%s\", label : %.2f }",
+                        (first ? "" : ",\n"), from_str, to_str, (float)( orig_node->tq_max / (float)neigh->tq_avg ) );
+              first = 0;
+            } else {
+              snprintf( tmp, sizeof( tmp ), "\"%s\" -> \"%s\"[label=\"%.2f\"]\n", from_str, to_str, (float)( orig_node->tq_max / (float)neigh->tq_avg ) );
+            }
+
 						fillme->buffer = (char *)debugRealloc( fillme->buffer, strlen( tmp ) + strlen( fillme->buffer ) + 1, 408 );
 
 						strncat( fillme->buffer, tmp, strlen( tmp ) );
@@ -400,7 +410,16 @@ void write_data_in_buffer() {
 					addr_to_string( hna->addr, to_str, sizeof( to_str ) );
 					addr_to_string( ( hna->netmask == 32 ? 0xffffffff : htonl( ~ ( 0xffffffff >> hna->netmask ) ) ), hna_str, sizeof( hna_str ) );
 
-					snprintf( tmp, sizeof( tmp ), "\"%s\" -> \"%s/%s\"[label=\"HNA\"]\n", from_str, to_str, hna_str );
+          if ( output_format == json ) {
+            snprintf( tmp, sizeof( tmp ),
+                      "%s\t{ router : \"%s\", gateway : \"%s/%s\", label : \"HNA\" }",
+                      (first ? "" : ",\n"), from_str, to_str, hna_str );
+            first = 0;
+          } else {
+            snprintf( tmp, sizeof( tmp ), "\"%s\" -> \"%s/%s\"[label=\"HNA\"]\n", from_str, to_str, hna_str );
+          }
+
+
 					fillme->buffer = (char *)debugRealloc( fillme->buffer, strlen( tmp ) + strlen( fillme->buffer ) + 1, 409 );
 
 					strncat( fillme->buffer, tmp, strlen( tmp ) );
@@ -410,7 +429,14 @@ void write_data_in_buffer() {
 				/*printf("gw_class %d\n",(unsigned int)orig_node->gw_class);*/
 				if ( orig_node->gw_class != 0 ) {
 
-					snprintf( tmp, sizeof( tmp ), "\"%s\" -> \"0.0.0.0/0.0.0.0\"[label=\"HNA\"]\n", from_str );
+          if ( output_format == json ) {
+            snprintf( tmp, sizeof( tmp ),
+                      "%s\t{ router : \"%s\", gateway : \"%s\", label : \"%s\" }",
+                      (first ? "" : ",\n"), from_str, "0.0.0.0/0.0.0.0", "HNA" );
+            first = 0;
+          } else {
+            snprintf( tmp, sizeof( tmp ), "\"%s\" -> \"0.0.0.0/0.0.0.0\"[label=\"HNA\"]\n", from_str );
+          }
 					fillme->buffer = (char *)debugRealloc( fillme->buffer, strlen( tmp ) + strlen( fillme->buffer ) + 1, 410 );
 					strncat( fillme->buffer, tmp, strlen( tmp ) );
 
@@ -541,7 +567,7 @@ void *tcp_server( void *arg ) {
 
 	struct thread_data *thread_data = ((struct thread_data*) arg);
 	buffer_t *last_send = NULL;
-	ssize_t ret;
+	size_t ret;
 
 
 	while ( !is_aborted() ) {
@@ -552,9 +578,8 @@ void *tcp_server( void *arg ) {
 			current->counter = current->counter == -1 ? 1 : current->counter + 1;
 			pthread_mutex_unlock( &current->mutex );
 			ret = write( thread_data->socket, current->buffer, strlen( current->buffer ) );
-			if( ret != strlen( current->buffer ) )
+      if ( ret != strlen( current->buffer ) || (output_format == json) ) 
 			{
-
 				pthread_mutex_lock( &current->mutex );
 				current->counter--;
 				pthread_mutex_unlock( &current->mutex );
@@ -586,8 +611,16 @@ void *tcp_server( void *arg ) {
 void *master() {
 
 	buffer_t *new, *tmp;
-	char begin[] = "digraph topology\n{\n";
-	char end[] = "}\n";
+	char* begin;
+	char* end;
+  if ( output_format == json ) {
+    begin = "HTTP/1.0 200 OK\nContent-type: application/json\n\n[\n";
+    end = "\n]\n";
+  } else {
+    begin = "digraph topology\n{\n";
+    end = "}\n";
+  }
+
 
 	while ( !is_aborted() ) {
 
@@ -643,6 +676,7 @@ void print_usage() {
 
 	printf( "B.A.T.M.A.N. visualisation server %s\n", SOURCE_VERSION );
 	printf( "Usage: vis <interface(s)> \n" );
+  printf( "\t-j output mesh topology as json\n" );
 	printf( "\t-d debug level\n" );
 	printf( "\t-h help\n" );
 	printf( "\t-v Version\n\n" );
@@ -669,7 +703,7 @@ int main( int argc, char **argv ) {
 	pthread_t tcp_server_thread;
 
 
-	while ( ( optchar = getopt ( argc, argv, "d:hv" ) ) != -1 ) {
+	while ( ( optchar = getopt ( argc, argv, "jd:hv" ) ) != -1 ) {
 
 		switch( optchar ) {
 
@@ -700,6 +734,11 @@ int main( int argc, char **argv ) {
 				exit(EXIT_SUCCESS);
 				break;
 
+      case 'j':
+        output_format = json;
+        found_args++;
+        break;
+
 			default:
 				print_usage();
 				exit(EXIT_SUCCESS);
diff --git a/vis.h b/vis.h
index f082700..bae6220 100644
--- a/vis.h
+++ b/vis.h
@@ -64,7 +64,8 @@ extern struct hashtable_t *secif_hash;
 
 extern uint8_t debug_level;
 
-
+typedef enum { dot, json } formats;
+extern formats output_format;
 
 struct thread_data {
 	int socket;

--Apple-Mail-72--843769777--
