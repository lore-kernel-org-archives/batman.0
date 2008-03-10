Subject: Re: [B.A.T.M.A.N.] b.a.t.m.a.n. + wrt54gl + OpenWrt Kamikaze +    
	X-wrt]
From: Donald Davis <dondavis@reglue.org>
Content-Type: text/plain
Date: Mon, 10 Mar 2008 12:02:34 -0500
Message-Id: <1205168554.21990.1.camel@krupskaya.is-a-geek.net.is-a-geek.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: dondavis@reglue.org,
	The list for a Better Approach To Mobile Ad-hoc Networking
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

Thank you very much.  Now I have an ad-hoc network if not a batman adhoc
network.
They all report no nodes in range.
In x-wrt I changed all the channels to 10, mode ad-hoc, essid project. I
set the lan i.p. to 103.0.0.* (the number of the router).

I also added a startup script but it doesn't seem to be run.  I have to
login via ssh and basically copy it:

iwconfig wl0 channel 10 essid project mode Ad-Hoc
ifconfig eth0.0 103.0.0.6 netmask 255.0.0.0 broadcast 103.255.255.255
ifconfig eth0.1 103.0.0.6 netmask 255.0.0.0 broadcast 103.255.255.255
ifconfig wl0 103.0.0.6 netmask 255.0.0.0 broadcast 103.255.255.255
iptables -t filter -I INPUT 2 -p udp --dport 4305 --sport 4305 -j ACCEPT
iptables -t filter -I INPUT 2 -p udp --dport 4306 --sport 4306 -j ACCEPT
iptables -t filter -I INPUT 2 -p udp --dport 4307 --sport 4307 -j ACCEPT
iptables -t filter -I OUTPUT 2 -p udp --dport 4305 --sport 4305 -j
ACCEPT
iptables -t filter -I OUTPUT 2 -p udp --dport 4306 --sport 4306 -j
ACCEPT
iptables -t filter -I OUTPUT 2 -p udp --dport 4307 --sport 4307 -j
ACCEPT
batmand eth0.0 eth0.1 wl0 &


batman is then running and x-wrt (the web gui sees it's running)

However, it reports no nodes in sight.  If I run batman -d 4 eth0.0
eth0.1
wl0 I am only receiving data from that machine (same ip) if I grep -v
its
ip there's nothing except for "no nodes in range."

The routers are all connected I can ssh into any of them 3-8 but I can
only get internet if I'm attached to the router plugged in to the
internet.  I tried changing the preferred gateway to the machine
103.0.0.3
with an internet connection but it didn't work.

I didn't change the bssids as you recommended, but it seems there is no
bssid splitting.  (Oh, it reports 11 clients, I'm running six routers
right now...)

What should I see?  what should the ip range be?

&#9474; Name    : project                                           
&#9474; &#9474;
&#9474; &#9474;
  &#9474; &#9474;
&#9474; &#9474; SSID    : project
  &#9474; &#9474;
&#9474; &#9474; Server  : localhost:2501
  &#9474; &#9474;
&#9474; &#9474; BSSID   : 92:6E:ED:16:90:48
  &#9474; &#9474;
&#9474; &#9474; Carrier : IEEE 802.11g
  &#9474; &#9474;
&#9474; &#9474; Manuf   : Unknown
  &#9474; &#9474;
&#9474; &#9474; Max Rate: 54.0
 Clients : 11                                                 &#9474;
&#9474;
&#9474; &#9474; Type    : Ad-hoc
  &#9474; &#9474;
&#9474; &#9474; Info    :
  &#9474; &#9474;
&#9474; &#9474; Channel : 10
  &#9474; &#9474;
&#9474; &#9474; Privacy : No
  &#9474; &#9474;
&#9474; &#9474; Encrypt : None
  &#9474; &#9474;
&#9474; &#9474; Beacon  : 25600 (26.214400 sec)
 IP Type : UDP (4 octets)                                     &#9474;
&#9474;
&#9474; &#9474; IP Range: 103.0.0.5



