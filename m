Message-ID: <20080212094759.vx84kym5c0oowok0@webmail.ddmesh.de>
Date: Tue, 12 Feb 2008 09:47:59 +0100
From: Freifunk Dresden <freifunk@ddmesh.de>
Subject: Re: [B.A.T.M.A.N.] Rev 972: batmand -c -d n hangs sometimes
References: <20080203125031.37lz3lkn0gsc0ooc@webmail.ddmesh.de>
	<200802111304.42349.axel@open-mesh.net>
In-Reply-To: <200802111304.42349.axel@open-mesh.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

Hi Axel,

> I have several WRT54GL here and I can execute something like
> "batmand -cbd8"
> as often as I want. It never hangs.
> Can you attach the cron file that is executed and that causes the problem?
The crontab contains an entry such like:
0-59/1 * * * * /etc/init.d/S53batmand check

this calles the following commands after another:
batmand -cb -d2 >/tmp/batmand_gateway
batmand -cb -d7 >/tmp/batmand_gateway
batmand -cb -d8 >/tmp/batmand_gateway
batmand -cb -d9 >/tmp/batmand_gateway

But I also did put these commands into an loop:
while true; do batmand -cb -d2;....;done

I have also disabled this "logging" completely and let only run batmand to
build up the net. I can not say if the access to the debug output leads to
blocking the batmand faster.I also have seen that batmand blocks after  
awhile if
it is only running for building the network.

I have put a logfile on my webpage.
http://www.ddmesh.de/batmand-hanglog.txt

In one of the previous threads someone had a problem with "batmand  
going crazy".
I'm not sure to remember right. But I think that it had to do with  
sequence number that's wrapping around.
The logfile ends at the time batmand stopps. At the end of this log you
will find something like "prevRxSeqno: 0, currRxSeqno-prevRxSeqno 0," perhabs
it is the same reason.

batmand is currently started with two interfaces eth1 and tbb. eth1 is  
the wireless interface and tbb is a tun/tap device that is used by vpn  
tincd.
tincd has got invalid hostnames, so it never creates a connection.
Perhabs batmand has a problem with this kind of "dead" interfaces.
I have tried to remove this tbb interface when starting batmand.  
batmand was running at least for two days. But the "dead" interface  
may also have no influence to this problem.
Currently batmand is running since 10 hours with eth1 and tbb (dead  
interface).

I never have seen this problem with the WRT54GS, only with GL.

/Stephan




