Return-Path: <ryan@iheartryan.com>
Date: Sat, 6 Aug 2011 10:19:28 -0400 (EDT)
From: Ryan Hughes <ryan@iheartryan.com>
Message-ID: <alpine.DEB.2.02.1108060959150.9094@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1312640737-22103-60"
Subject: [B.A.T.M.A.N.] "Distributed" DHCP vs gateway
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

This is a multi-part message in MIME format...

------------=_1312640737-22103-60
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Content-Disposition: inline

So, I had a crazy idea the other day:

Normally, when I talk to people about mesh networks, they assume that 
there is some central authority assigning IP addresses to nodes 
intelligently.

I was thinking, though, that I'd rather have it so that every node could 
have the same firmware, and you'd just throw the node up and it'd 
negotiate everything for itself, including its IP address.

So I was thinking:  What if each node in the network was using 
batman-adv, and ran a DHCP client and a DHCP server? 
It'd try to get an address thru DHCP.  If it failed, it'd choose an 
address at random from the network range.  Then, any time someone threw up 
a new node in range, the new node would try to get an address, and it 
would succeed in getting an address from the first node.

Multiple DHCP servers can serve the same, overlapping IP ranges.  However, 
this depends on the DHCPOFFER and DHCPREQUEST being broadcast to the 
network.  This is how we avoid having the same IP address assigned to 
multiple nodes -- DHCP servers overhear what was assigned to whom by other 
DHCP servers, and make a note to themselves not to assign that address 
themselves.

So it seems that a "distributed" DHCP system could work.

The problem is, doesn't Batman-adv munge the DHCP that flows though it, 
for its gateway logic?  So that the DHCPREQUESTs are unicast?  That's 
great for gateway logic.  But I also want nodes to have IP addresses for 
internal communication.

I was thinking of running it like this:  Each node has two virtual 
interfaces - the mesh interface, running in adhoc mode.  Routers use this 
interface, and this is where the distributed DHCP runs.

Another wifi interface runs in host mode.  This is what laptops and so 
forth will connect to.

Once a router gets an ip address from this distributed DHCP nonsense, then 
it determines a longer network prefix for its clients on the host-mode 
interface.  It sets up its HNAs and starts serving DHCP with this longer 
prefix to its clients.  The machines on the inside run webservers and so 
forth that should be available to the inside of the mesh.


Now, what if the network is fractured and the same IP address gets 
assigned to a router (and thus is used as a prefix for that router's 
clients) on each side of the split?  When the segments join up, we'll have 
multiple nodes with the same IP address and this will cause problems.

Yes.  The lease times will be very short, so this type of problem should 
resolve itself quickly.


But, what do I do about how the gateway business interferes with DHCP? 
Could I somehow have two DHCP servers serving the same interface?  One 
that serves out IP addresses and one that deals only with gateways?


Is this idea just too crazy?  Why?

--Ryan

------------=_1312640737-22103-60
Content-Type: text/plain; name="SpamAssassinReport.txt"
Content-Disposition: inline; filename="SpamAssassinReport.txt"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.427 (Entity 5.427)

Spam detection software, running on the system "dedicated37.virtbiz.com", has
identified this incoming email as possible spam.  The original message
has been attached to this so you can view it (if it isn't spam) or label
similar future email.  If you have any questions, see
the administrator of that system for details.

Content preview:  So, I had a crazy idea the other day: Normally, when I talk
   to people about mesh networks, they assume that there is some central authority
   assigning IP addresses to nodes intelligently. I was thinking, though, that
   I'd rather have it so that every node could have the same firmware, and you'd
   just throw the node up and it'd negotiate everything for itself, including
   its IP address. [...] 

Content analysis details:   (10.3 points, 5.0 required)

 pts rule name              description
---- ---------------------- --------------------------------------------------
 0.5 HELO_LH_HOME           HELO_LH_HOME
 3.1 AXB_HELO_HOME_UN       HELO from home  - untrusted
-1.5 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                            [score: 0.0000]
 1.2 RDNS_NONE              Delivered to internal network by a host with no rDNS
 4.3 TO_NO_BRKTS_DIRECT     To: misformatted and direct-to-MX
 2.6 TO_NO_BRKTS_NOTLIST    To: misformatted and not a mailing list



------------=_1312640737-22103-60--
