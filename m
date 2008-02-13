Message-ID: <20080213174817.nutikha74k88ko8o@webmail.ddmesh.de>
Date: Wed, 13 Feb 2008 17:48:17 +0100
From: Freifunk Dresden <freifunk@ddmesh.de>
Subject: Re: [B.A.T.M.A.N.] Rev 972: batmand -c -d n hangs sometimes
References: <20080203125031.37lz3lkn0gsc0ooc@webmail.ddmesh.de>
	<200802111304.42349.axel@open-mesh.net>
	<20080212094759.vx84kym5c0oowok0@webmail.ddmesh.de>
	<200802122034.21957.axel@open-mesh.net>
In-Reply-To: <200802122034.21957.axel@open-mesh.net>
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

Hello,

> Can you verify if the problem also occures if batmand is started without any
> tap devices?
my last 10h log (with tap dev) was also crashing. I'm currently let run
without the tap dev since few hours. I like to run it longer.

> Can you check for other syslog messages that might be related to the stopping
> batmand? What does logread say ?
I have looked at that, but did not find any strange log


> The strange thing is that the debug-level-4 output stops in the middle of an
> action. Can you also check for the number of batmand processes before and
> after the stopped batmand process?
The number of task are the same.
But I have seen, that when the -d4 output stopps and I keep this  
batmand running
when accessing an different log level from another terminal, I see the
socket-connection logs in -d4 output.

Also I still can just call "batmand -c" to see the parameters and  
current gateway settings. I also can change the gateway settings.

The batmand seems to stop processing any OGMs.

> Have you ever tried what happens if you connect the tap interface to a bridge
> and bind batmand to the bridge device instead?
I haven't tried it, yet. but this also came in my mind. I will this  
check after
finishing the "no-tap-dev-test"

> Last but not least: have you observed (or explicitly not observed) this
> phenomenon also with previous revisions in the same scenario ?
I can not say, because implementing tinc and updateing the batmand  
version was at same time.

>> I never have seen this problem with the WRT54GS, only with GL.
> Is the batmand on the WRT54GS also bound to a tinc interface ?
Yes, the GL is running standalone with stubid tincsetup and also the  
GS was running with same parameters and standalone (no network cable).

Perhaps it is more random and is depending on speed of the router when the
event occurs.

bye Stephan


