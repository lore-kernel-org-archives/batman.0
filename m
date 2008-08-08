From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] Re: A few comments on the BATMAN routing protocol
Date: Fri, 8 Aug 2008 19:25:49 +0200
References: <7itzdzzero.fsf@lanthane.pps.jussieu.fr>
	<200808061520.59927.axel@open-mesh.net>
In-Reply-To: <200808061520.59927.axel@open-mesh.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dGInIpSScAKcIl9"
Message-Id: <200808081925.49881.axel@open-mesh.net>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

--Boundary-00=_dGInIpSScAKcIl9
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> > 2. BATMAN does not contain any loop avoidance mechanisms; in the
> >    presence of so-called ``optimistic routing'', BATMAN may exhibit
> >    persistent routing loops.  Even without optimistic routing, BATMAN
> >    will exhibit transitory routing loops.
>
> Here I completely agree with what Simon Wunderlich said. Personally, I am
> not aware of any scenario that can lead to transient routing loops, not
> even to a dead node! You might know better, then pleas let me know :-)
>
> Each batman node is only supposed to rebroadcast an OGM which it has
> received from the neighbor which it has configured itself as its best
> nexthop to the destination. Therefore, the OGM itself must have travelled a
> valid path with all traversed nodes having a loop free route configured
> towards the originator of the OGM. Of course, the configured end-to-end
> route might break down somewhere along the path just after an OGM has been
> received. This will cause a temporary dead route. But not a loop. Later on,
> only a newer OGM (with a larger sequence number), and which once again must
> have traversed a functional and configured path, can reconfigure any node
> receiving this OGM.
>
> Another remark:
> The batmand-0.2 implementation is not doing this completely correct and
> thus can cause temporary routing loops. The reason is, that it also
> reconfigures its best nexthop due to new OGMs which were not received via
> its currently *best-known* nexthop.
>

Just for the record: 
Few days ago I recognized that for my gcc a 32-bit-word shifted by 32 bits is 
NOT zero. This pointed me to another bug in the batmand-0.2.x implementation 
which could cause a transient routing loop.

This and the above bug should be fixed with the attached patch. 


ciao,
axel

--Boundary-00=_dGInIpSScAKcIl9
Content-Type: text/x-diff; charset="iso 8859-15";
	name="batman-0.2.x-potential-loops.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="batman-0.2.x-potential-loops.patch"

Nur in batman-0.2.x-fixes: batmand.
diff -u batman-0.2.x/bitarray.c batman-0.2.x-fixes/bitarray.c
--- batman-0.2.x/bitarray.c	2007-06-19 20:50:16.000000000 +0200
+++ batman-0.2.x-fixes/bitarray.c	2008-08-08 19:19:20.000000000 +0200
@@ -121,9 +121,11 @@
 
 		seq_bits[i]=
 			(seq_bits[i - word_num] << word_offset) +
-					/* take the lower port from the left half, shift it left to its final position */
-			(seq_bits[i - word_num - 1] >>	(WORD_BIT_SIZE-word_offset));
-					/* and the upper part of the right half and shift it left to it's position */
+				/* take the lower port from the left half, shift it left to its final position */
+				/*fix: paradoxically uint32_t test = 1234; test<<32; 
+				 * results in: test == 1234  */
+			( ( (seq_bits[i - word_num - 1]) >> ((WORD_BIT_SIZE-word_offset)-1) ) >> 1 );
+			/* and the upper part of the right half and shift it left to it's position */
 		/* for our example that would be: word[0] = 9800 + 0076 = 9876 */
 	}
 	/* now for our last word, i==word_num, we only have the it's "left" half. that's the 1000 word in
Nur in batman-0.2.x-fixes: bitarray.c~.
diff -u batman-0.2.x/originator.c batman-0.2.x-fixes/originator.c
--- batman-0.2.x/originator.c	2007-06-19 20:50:16.000000000 +0200
+++ batman-0.2.x-fixes/originator.c	2008-08-08 18:52:31.000000000 +0200
@@ -176,7 +176,11 @@
 
 	neigh_node->packet_count = bit_packet_count( neigh_node->seq_bits );
 
-	if ( neigh_node->packet_count > max_packet_count ) {
+	
+	/* fix: a node MUST NOT reconfigures its best nexthop 
+	 * due to new OGMs which were not received via its currently 
+	 * best-known nexthop.*/
+	if ( neigh_node->packet_count > max_packet_count  &&  neigh_node->addr == neigh ) {
 
 		max_packet_count = neigh_node->packet_count;
 		best_neigh_node = neigh_node;
Nur in batman-0.2.x-fixes: originator.c~.
Gemeinsame Unterverzeichnisse: batman-0.2.x/.svn und batman-0.2.x-fixes/.svn.

--Boundary-00=_dGInIpSScAKcIl9--
