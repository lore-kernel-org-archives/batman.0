From: Marek Lindner <lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Disposition: inline
Date: Thu, 21 Jun 2007 15:41:43 +0200
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Message-Id: <200706211541.43331.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] Release: 0.2 final / 0.3 alpha / batman advanced &
	battools 0.1 alpha
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



Hi,

finally the big release day has come. As of this moment B.A.T.M.A.N. 0.2 final 
is released and can be downloaded from open-mesh.net/batman/downloads. The 
most important added features since the release of 0.1 include:

- many cpu and memory usage optimizations
- ability to give access to the various debug levels without restarting the 
daemon
- Big Endian / Little Endian support added
- 64 Bit compability added
- a lot of tweaks to the algorithm in order to ensure a smoother experience
- download store which automatically generates ready to install packets for 
various platforms
- support for sending neighbor-connectivity data to a central visualization 
server


Regardless of the mentioned release, the developement process didn't stop 
there. So, in addition to version 0.2 final, we are very proud to announce 
the release of B.A.T.M.A.N. 0.3 alpha. Major changes and improvements are:

- debug level 5 added which shows memory or cpu usage if the compile option 
was set
- harden batman against any clock changes whatsoever
- 3 different routing tables are used: table 65 for announced networks, table 
66 for batman host routes and table 67 for the default route
- the batman default route is not shared with other wireless nodes any longer
- a batman gateway acts as a tiny DHCP server and hands out IPs to gateway 
clients
- the gateway tunnel is now a fully enabled tunnel which transports the data 
to the gateway and back as well


Our ambition brought us even beyond this point, all the way down to layer 2. 
B.A.T.M.A.N. Advanced was created. This new approach to wireless networking 
does no longer operate on the IP basis. Instead it emulates a virtual network 
switch of all nodes participating. Therefore all nodes appear to be link 
local, thus all higher operating protocols won't be affected by any changes 
within the network. You can theoretically run almost any protocol above 
B.A.T.M.A.N. Advanced, prominent examples are: IPv4, IPv6, DHCP, IPX. Due to 
this highy developmental technique of layer 2 based routing there are no 
experiences we can build upon and hence would be very grateful for intensive 
testing and information exchange, as we do not possess the capabilty for a 
full-blown testing environment ourselves and always apreciate the input given 
by our very active community and trust the very good experiences we had.

Since the nodes participating in the B.A.T.M.A.N. Advanced switch are 
completely transparent for all protocols above layer 2, we needed to build 
our own diagnostic tools which are also released today. These tools contain a 
layer 2 version of ping, traceroute and tcpdump. Further information can be 
found in the enclosed README file.

As layer 2 routing is somewhat of a blackspot on the landscape of mesh 
networking we plan a workshop i.e. demonstration evening about how and why 
B.A.T.M.A.N. Advanced works. In order to make it a useful event for all 
parties involved we would like to decide on the topics covered not for, but 
with you. So, if you have ideas, critique or general advice please share your 
thoughts with us.

