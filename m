From: axel@open-mesh.net
References: <200704061936.49534.lindner_marek@yahoo.de>
	<4616D64F.8080702@gmx.net>
In-Reply-To: <4616D64F.8080702@gmx.net>
MIME-Version: 1.0
Content-Disposition: inline
Date: Sun, 8 Apr 2007 12:05:38 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200704081205.38455.axel@open-mesh.net>
Subject: [B.A.T.M.A.N.] Release 0.2 beta
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

Hi -

we, the B.A.T.M.A.N. development team are happy to release
B.A.T.M.A.N.-III-0.2.0-beta.  
We are calling you to download ( http://open-mesh.net/batman/downloads ), 
update and test now!

Since our last release a lot of code has been (re-)written and intermediate 
code revisions have been tested in real-live deployments, keeping the 
responsible mesh-node administrators busy with updating, monitoring and 
writing bug reports. Many thanks to them and especially to Ludger Schmudde 
who (by constantly challenging the latest revision in an 
eight-node-16-interfaces-real-life setup) provided invaluable 
key-informations for finding the most hidden implementation and design bugs. 
Many sections in the implementation have also undergone improvements to 
reduce memory consumption and CPU-load like a new hash algorithm implemented 
by Simon Wunderlich. 

Now we believe that version 0.2 will bring major improvements in performance, 
usability and stability.  We think that our code base is - despite many
changes since version 0.1.2 - reasonably stable now and has been
thoroughly tested.

There is still no such thing like a configuration file... B.A.T.M.A.N.
does not need much tweaking for different deployment situations. This
means values for reasonable behavior of the algorithm are hard-coded in
the B.A.T.M.A.N. daemon. Of course finding the best hard-coded values to
optimize the behavior needs some playing with the algorithm.

Our last step before we release 0.2 will be to tweak the hard coded
value of the 'bidirectional link checking' algorithm and test the
results. Ranking and forwarding of B.A.T.M.A.N. packets is - of course -
different if a link between neighbors is bidirectional or
unidirectional. So far a link to a single-hop neighbor was considered
bidirectional as long as at least one out of the recently self-initiated
originator messages came back from this single-hop neighbor within the last 
*three* seconds. We are going to test the results if this bidirectional-check 
is made more strict. This release will consider a link as bidirectional as 
long as at least one of the self-initiated originator messages comes back 
from this single-hop neighbor within the last *two* seconds.

The B.A.T.M.A.N.-III algorithm does support asymmetrical routing *but* if
the bidirectional link check algorithm is not strict enough it will
prefer asymmetrical routes in the unfavorable direction. If the
bidirectional link check is strict enough it will select routes similar
to an ETX-like metrik.

*Important*

Since we are tweaking an important setting in the daemon's behavior we
raised the compatibility value -  so the new B.A.T.M.A.N.-version will
ignore packets from older versions and vice versa. It is possible that
we are performing further testing with even stricter values for
bidirectional link checking. These versions will also have different
compatibility values.

Be assured that we won't bother you with tests and updates without
reason. The 0.2-release will be available soon.

We are calling you to download ( http://open-mesh.net/batman/downloads ), 
update and test now! 

The easiest way for updating your openWrt/whiterussian based freifunk router 
is to issue an: 
# ipkg install  
http://downloads.open-mesh.net/batman/mips-whiterussian/batman_III-0.2.0b_mipsel.ipk
and restart. If are looking for a freifunk-based web interface (and have not 
already installed it) run:
# ipkg install  http://freifunk.schmudde.com/ipkg/freifunk-batman_0.83.ipk 

happy testing
the B.A.T.M.A.N. development team
