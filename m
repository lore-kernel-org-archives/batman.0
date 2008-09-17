From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Make batman timer functions thread safe
Date: Wed, 17 Sep 2008 11:00:22 +0200
References: <20080912232420.GA9669@sven-desktop.lazhur.ath.cx>
	<200809141215.05216.lindner_marek@yahoo.de>
	<907599f7f0a6782d35ea585f9cf0eb1c.squirrel@wm.ddmesh.de>
In-Reply-To: <907599f7f0a6782d35ea585f9cf0eb1c.squirrel@wm.ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809171100.22178.axel@open-mesh.net>
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

Hi

On Montag 15 September 2008, freifunk@ddmesh.de wrote:
> Hi,
>
> > Just applied your latest patches as well. Thanks for looking over the
> > code.
> > Virgin eyes stumble easier over nasty stuff.  :-)
>
> When you find some problems in batman, can you also apply those patches to
> the batman-experimental branch? At moment it is running without problems
> for freifunk dresden. But if the network is growing perhaps some issues may
> cause problems.

Over the time a reasonable part of the code structure of bmx and batman has 
forked pretty much. Therefore I am not sure if it would be easy to simply 
apply existing batman patches to the bmx branch. But be sure, whenever I am 
getting aware of critical bugs identified in the batman code which also apply 
to the bmx code, I'll fix them too. But for many current and older series of 
patches its simply not necessary. For example looking at the main recent 
bug-fixes

Regarding the debug thread:
I have removed the debug thread completely about 2 weeks ago (due to ongoing 
problems with this thing) and integrated its functionality into the main 
thread. I could not see any benefit of having this threaded except constant 
syncronization problems. Unfortunately I could not commit it yet because of 
unfinished testing. But I'll do it this week.

The gw-kernel module: There are no gw-tunnel module problems with bmx simply 
because there is no support for this feature. Most existing bmx-mesh networks 
I am aware of are using the one-way-tunnel mode. It does not implement the 
black hole detection but still allows you to dynamically change the preferred 
gw. Compared to the two-way-tunnel it has less overhead, avoids tunneling 
from the gw to the client node (no need to optimize something which does not 
exist) and allows internet access with only one level of network address 
translation.  

Packet aggregation:
Have been implemented and activated by default in bmx about a year ago and 
seem to work quite reliable since then.

Problem with timing issues have been solved individually

And very important. BMX has continued to rely on the concept of a rolling 
metric based on the number of received OGMs via the best path. Many patches 
in the batman-0.3 brach were due to changing this concept to a dedicated 
metric field carried with each OGM.


By the way, I think a number of bugs in bmx and batman have been identified 
due to your hints. Thanks for that. If you want to intensify your work on the 
code and want commit patches directly just let us know.




>
> Bye
>  Stephan
>
> ---------------------------------------
> Dipl.Informatiker(FH) Stephan Enderlein
> Freifunk Dresden
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


