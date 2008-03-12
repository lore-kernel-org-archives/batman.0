Message-ID: <49584.70.128.180.22.1205342204.squirrel@webmail.reglue.org>
Date: Wed, 12 Mar 2008 10:16:44 -0700 (PDT)
From: dondavis@reglue.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] Gateway routing / finding 
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

Yesterday, I thought I had a basic understanding of what was going on and
how to do it.

So this morning I woke up and decided to improve it with the individual
ip's for each interface.
killall batmand
iwconfig wl0 channel 10 essid project mode Ad-Hoc
ifconfig eth0 103.0.0.81 netmask 255.0.0.0 broadcast 103.255.255.255
ifconfig eth0.0 103.0.0.82 netmask 255.0.0.0 broadcast 103.255.255.255
#ifconfig eth0.1 103.0.0.83 netmask 255.0.0.0 broadcast 103.255.255.255
ifconfig wl0 103.0.0.84 netmask 255.0.0.0 broadcast 103.255.255.255
ifconfig br-lan 103.0.0.85 netmask 255.0.0.0 broadcast 103.255.255.255
iptables -t filter -I INPUT 2 -p udp --dport 4305 --sport 4305 -j ACCEPT
iptables -t filter -I INPUT 2 -p udp --dport 4306 --sport 4306 -j ACCEPT
iptables -t filter -I INPUT 2 -p udp --dport 4307 --sport 4307 -j ACCEPT
iptables -t filter -I OUTPUT 2 -p udp --dport 4305 --sport 4305 -j ACCEPT
iptables -t filter -I OUTPUT 2 -p udp --dport 4306 --sport 4306 -j ACCEPT
iptables -t filter -I OUTPUT 2 -p udp --dport 4307 --sport 4307 -j ACCEPT
batmand eth0 eth0.0 wl0 br-lan &


Yesterday I had all the batmannodes with internet connectivity.  I did
notice though that if changed gateways they weren't picking up on it; so I
was going to try out batman III once I clarified for myself what was going
on.  So I tried the aforementioned script.  It didn't work.  So I thought
"ah ha, it might help the interfaces to share ip addresses because some
piece is not being found."  So I went back to what I thought was a working
script.

killall batmand
iwconfig wl0 channel 10 essid project mode Ad-Hoc
ifconfig eth0 103.0.0.8 netmask 255.0.0.0 broadcast 103.255.255.255
ifconfig eth0.0 103.0.0.8 netmask 255.0.0.0 broadcast 103.255.255.255
# ifconfig eth0.1 103.0.0.8 netmask 255.0.0.0 broadcast 103.255.255.255
ifconfig wl0 103.0.0.8 netmask 255.0.0.0 broadcast 103.255.255.255
iptables -t filter -I INPUT 2 -p udp --dport 4305 --sport 4305 -j ACCEPT
iptables -t filter -I INPUT 2 -p udp --dport 4306 --sport 4306 -j ACCEPT
iptables -t filter -I INPUT 2 -p udp --dport 4307 --sport 4307 -j ACCEPT
iptables -t filter -I OUTPUT 2 -p udp --dport 4305 --sport 4305 -j ACCEPT
iptables -t filter -I OUTPUT 2 -p udp --dport 4306 --sport 4306 -j ACCEPT
iptables -t filter -I OUTPUT 2 -p udp --dport 4307 --sport 4307 -j ACCEPT
batmand br-lan &

that didn't work so I killalled batmand and then
 batmand -d 3 -r 3 -p 103.0.0.3 wl0 br-lan

I was wrong.

Even though I see:
Using interface wl0 with address 103.0.0.8 and broadcast address
103.255.255.255
Using interface br-lan with address 103.0.0.8 and broadcast address
103.0.0.255
debug level: 3
routing class: 3
preferred gateway: 103.0.0.3
Adding route to 103.0.0.3 via 0.0.0.0 (br-lan)
Adding route to 10.0.2.122/32 via 103.0.0.3 (br-lan)

It has found the internet gateway 10.0.2.122; it can't reach the internet.

now, I'm going to:
remove the x-wrt webif-batman stuff (just in case)
look for batman config files
reread the openmesh.net stuff
reinstall batman with the pkg's from openmesh.net
possible try out batman III

thoughts? suggestions?

cheers,

D Davis



