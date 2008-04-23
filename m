From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] two-radio nodes and alternative next hop
Date: Wed, 23 Apr 2008 09:54:37 +0200
References: <20080421123928.GA3483@apoderado.ometepe.net>
	<200804221601.57318.axel@open-mesh.net>
	<20080423000418.GA7368@apoderado.ometepe.net>
In-Reply-To: <20080423000418.GA7368@apoderado.ometepe.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804230954.37620.axel@open-mesh.net>
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

Hey,

> > But according to the debug output there is a direct link to x.x.4.165/24
> > (which I guess has broadcast address of x.x.4.255) and therefore the two
> > interfaces should not see each other!!??
>
> there are direct links always only in the according /24 netrange,
> because they are on different channels/ssids, so .3.160 and .4.1 cannot
> "see" each other.
> Note, NO .4.x node cannot see ANY .3.x node, even if they
> would be on the same channel/ssid!
Are you also specifying the bssid? Because in order to define different 
cells in an ad-hoc network the ssid is almost useless in most adhoc 
implementations. THe BSSID is much more important! 
(E.g. use kamikaze-etc/config/wireless style: option bssid 44:ca:ff:ee:ba:be 
or the command-line-style: iwconfig wlan0 ap 44:ca:ff:ee:ba:be ) 

Anyway, you mean a debug output on 3.16 like the following can not be correct?
Neighbor        outgoingIF     bestNextHop brc (rcvd  knownSince  lseq lvld rid sid ) [     viaIF RTQ  RQ  TQ]..
172.19.4.165    wlan0:bmx     172.19.4.165  55 (  84  0:00:28:03  9777    1   1   4 ) [ wlan0:bmx  46  76  60]  

Sorry for being stubborn: what makes you so sure that they cannot see each 
other or that the driver does not mix things up?

At least from the madwifi driver (in ad-hoc mode) I know that it tends to 
ignore its assigned *bssid* and channel and switches back and forth between the 
assigned one and others. 

Sometimes the driver hangs on a wrong bssid and 
channel, forwards the wrong IP packets, and cannot receive any packets from 
its originally assigned bssid/channel. 

One way to verify this would be to run a tcpdump on interface 3.160/wlan0 and 
see if it ever tracks a batman packet with a src address of e.g. 172.19.4.165

> i'll make some more logs when .3.137 is back up
ok.

ciao,
axel
