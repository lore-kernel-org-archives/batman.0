From: Axel Neumann <neumann@cgws.de>
Subject: Re: [B.A.T.M.A.N.] dublicate HNAs
Date: Fri, 12 Dec 2008 11:46:26 +0100
References: <83b3410f8105237b1e68c92065dec7d0.squirrel@wm.ddmesh.de>
	<200812111154.31726.neumann@cgws.de> <49411D3D.90301@ddmesh.de>
In-Reply-To: <49411D3D.90301@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200812121146.26579.neumann@cgws.de>
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
On Donnerstag 11 Dezember 2008, Freifunk wrote:
> Hi Axel,
>
> thanks for your description. Would it be better to only ignore the HNA that
> is already received from another node instead of ignoring the node
> completely? 
Sounds reasonable. What were the consideratios from those days - there were a 
number of reasons for the current approach but meanwhile some things have 
changed.

1. The hope to find a consistent anycast routing approach soon which would 
eliminate the duplicate HNA problem.

2. Secondary interfaces were conceptually announced in the same way as HNAs. 
The signaling of secondary-interface information to all other nodes was 
essential for many scenarios. This is because traffic originated and leaving 
the node via a secondary interface usually had the ip address of the 
secondary interface as src-address. Though, corresponding nodes could not 
reply if not having a correct HNA route to the originating src.
This has changed some time ago. Now the bmx daemon sets the ip of the primary 
interface as preferred src address for all interfaces, making the interface 
announcement non-obligatory.
You can see this by looking at the default bmx routing table ip r ls t 64 
which should always show the primary-interface ip as src address.

3. I think there were theoretical scenarios for routing loops if the routing 
entries in different nodes for a given HNAs point to different destination 
nodes. But currently I can not remember.


so far,
/axel

> I currently use one node that is connected to icvpn (inter-city 
> vpn) that connects different freifunk cities together. The network runs bgp
> and allows to setup a second server that also initiates a connection to the
> icvpn. both server would then announce the same ip addresses.
> In this case the batman notes only should ignore the HNA if they are
> injected by different icvpn servers and keep the server still in network.
>
> Bye
>  stephan
>
> Axel Neumann schrieb:
> > Hi,
> >
> > On Dienstag 09 Dezember 2008, Stephan Enderlein (Freifunk Dresden) wrote:
> >> -----------
> >> Another question: in previous versions I have seen that if two batmand
> >> announce the same HNA ip (-a) one of the batmand are ignored and
> >> complete ignored any batmand traffic. As result the node was removed
> >> from any batmand list and was not reachable anymore.
> >> -----------
> >
> > And it should be also the current behavior of bmx. The background is:
> >
> > BMX currently does NOT support anycast routing.
> >
> > Therefore in practical terms, if two nodes are announcing the same IP it
> > is effectively an IP doubler. Such a scenario triggers the
> > dublicate-address detection which results in ignoring the younger of the
> > two nodes announcing this IP.
> >
> > With the batman routing algorithm it is indeed difficult to do a
> > consistent anycast routing. Therefore I've decided to protect against
> > casual duplicate address announcements with the described behavior.
> > Older versions (2007 and before) tended to have chaotic routing entries
> > due to duplicated entries or removals of HNA routing entries.
> >
> > When dynamically adding an HNA (using e.g. bmxd -ca 1.2.3.4/32) the
> > daemon checks if other nodes are already announcing this specific HNA. If
> > this is the case the announcement is rejected and a warning should be
> > given in debuglevel 3. You can always inspect current announcements from
> > other nodes using debug-level 9.
> > This debug-level also differentiates between announced interfaces (e.g.
> > 1.2.3.4/IF) and networks (e.g. 1.2.3.4/32). ( the idea for the future
> > was, that network announcements should become anycast announcements )
> >
> > Indeed it is a problem when a daemon is started from the beginning with a
> > duplicate HNA announcement. In this situation the daemon can hardly check
> > if the network is already announced. Then, only his neighboring nodes are
> > aware of the IP doubler. They will ignore everything from this node and
> > cause a warning in debug level 0.
> >
> > hope this clarifies a bit.
> >
> > /axel
> > _______________________________________________
> > B.A.T.M.A.N mailing list
> > B.A.T.M.A.N@open-mesh.net
> > https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


