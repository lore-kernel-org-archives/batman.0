From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] Rev 972: batmand -c -d n hangs sometimes
Date: Tue, 12 Feb 2008 20:34:21 +0100
References: <20080203125031.37lz3lkn0gsc0ooc@webmail.ddmesh.de>
	<200802111304.42349.axel@open-mesh.net>
	<20080212094759.vx84kym5c0oowok0@webmail.ddmesh.de>
In-Reply-To: <20080212094759.vx84kym5c0oowok0@webmail.ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200802122034.21957.axel@open-mesh.net>
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

Hello,

On Dienstag 12 Februar 2008, Freifunk Dresden wrote:
> I have also disabled this "logging" completely and let only run batmand to
> build up the net. I can not say if the access to the debug output leads to
> blocking the batmand faster.I also have seen that batmand blocks after
> awhile if it is only running for building the network.
Ok, then it does not strictly depend on the logging.

>
> I have put a logfile on my webpage.
> http://www.ddmesh.de/batmand-hanglog.txt
>
> In one of the previous threads someone had a problem with "batmand
> going crazy".
> I'm not sure to remember right. But I think that it had to do with
> sequence number that's wrapping around.
> The logfile ends at the time batmand stopps. At the end of this log you
> will find something like "prevRxSeqno: 0, currRxSeqno-prevRxSeqno 0,"
> perhabs it is the same reason.
I checked the log file.
the "prevRxSeqno: 0..." line is no problem. The "0" comes from a bad debug 
statement. If you search your debug log you'll see many of these lines.
The "going crazy..." thing was related to overlapping uptime - thats also 
another story. 

>
> batmand is currently started with two interfaces eth1 and tbb. eth1 is
> the wireless interface and tbb is a tun/tap device that is used by vpn
> tincd.
> tincd has got invalid hostnames, so it never creates a connection.
> Perhabs batmand has a problem with this kind of "dead" interfaces.
> I have tried to remove this tbb interface when starting batmand.
> batmand was running at least for two days. But the "dead" interface
> may also have no influence to this problem.
> Currently batmand is running since 10 hours with eth1 and tbb (dead
> interface).
Can you verify if the problem also occures if batmand is started without any 
tap devices? 
Can you check for other syslog messages that might be related to the stopping 
batmand? What does logread say ?

The strange thing is that the debug-level-4 output stops in the middle of an 
action. Can you also check for the number of batmand processes before and 
after the stopped batmand process?

Have you ever tried what happens if you connect the tap interface to a bridge 
and bind batmand to the bridge device instead?

Last but not least: have you observed (or explicitly not observed) this 
phenomenon also with previous revisions in the same scenario ? 

>
> I never have seen this problem with the WRT54GS, only with GL.
Is the batmand on the WRT54GS also bound to a tinc interface ?

ciao,
axel


>
> /Stephan
>
>
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


