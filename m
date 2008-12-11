From: Axel Neumann <neumann@cgws.de>
Subject: Re: [B.A.T.M.A.N.] dublicate HNAs
Date: Thu, 11 Dec 2008 11:54:31 +0100
References: <83b3410f8105237b1e68c92065dec7d0.squirrel@wm.ddmesh.de>
	<200812021306.20569.axel@open-mesh.net>
	<3ca03f2b6ae1c3c84704f2ce5e8fd89a.squirrel@wm.ddmesh.de>
In-Reply-To: <3ca03f2b6ae1c3c84704f2ce5e8fd89a.squirrel@wm.ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200812111154.31726.neumann@cgws.de>
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

Hi,

On Dienstag 09 Dezember 2008, Stephan Enderlein (Freifunk Dresden) wrote:
> -----------
> Another question: in previous versions I have seen that if two batmand
> announce the same HNA ip (-a) one of the batmand are ignored and complete
> ignored any batmand traffic. As result the node was removed from any
> batmand list and was not reachable anymore.
> -----------

And it should be also the current behavior of bmx. The background is:

BMX currently does NOT support anycast routing. 

Therefore in practical terms, if two nodes are announcing the same IP it is 
effectively an IP doubler. Such a scenario triggers the dublicate-address 
detection which results in ignoring the younger of the two nodes announcing 
this IP.

With the batman routing algorithm it is indeed difficult to do a consistent 
anycast routing. Therefore I've decided to protect against casual duplicate 
address announcements with the described behavior.
Older versions (2007 and before) tended to have chaotic routing entries due to 
duplicated entries or removals of HNA routing entries.

When dynamically adding an HNA (using e.g. bmxd -ca 1.2.3.4/32) the daemon 
checks if other nodes are already announcing this specific HNA. If this is 
the case the announcement is rejected and a warning should be given in 
debuglevel 3. You can always inspect current announcements from other nodes 
using debug-level 9.
This debug-level also differentiates between announced interfaces (e.g. 
1.2.3.4/IF) and networks (e.g. 1.2.3.4/32). ( the idea for the future was,  
that network announcements should become anycast announcements )

Indeed it is a problem when a daemon is started from the beginning with a 
duplicate HNA announcement. In this situation the daemon can hardly check if 
the network is already announced. Then, only his neighboring nodes are aware 
of the IP doubler. They will ignore everything from this node and cause a 
warning in debug level 0. 

hope this clarifies a bit.

/axel
