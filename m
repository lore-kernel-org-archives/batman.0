Message-ID: <fcd11f054a43f09a9bac569c394d0d85.squirrel@wm.ddmesh.de>
In-Reply-To: <200809211558.54635.axel@open-mesh.net>
References: <20080912232420.GA9669@sven-desktop.lazhur.ath.cx>
	<200809171100.22178.axel@open-mesh.net>
	<11de18502b175436206cf97736ac12af.squirrel@wm.ddmesh.de>
	<200809211558.54635.axel@open-mesh.net>
Date: Thu, 18 Dec 2008 12:25:17 +0100 (CET)
From: "Stephan Enderlein (Freifunk Dresden)" <freifunk@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] policy-routing-script issues
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

Hi Axel,

sorry for the late response. I missed the email and found it today.
I understand your concerns and agree with that.
The reason for all this was to get the information on every gateway change.
I need the node ip of the gateway node at the time when the gateway is selected
or deselected. At moment I have modified the batmand to call a script in both
cases to setup /etc/resolv.conf which is important to always have a valid dns
server. the main publich dns servers often are not accessible from different
provider networks.

/stephan

> Hi,
>
> I can understand your need and agree that your idea with the return value
> makes the hole thing very flexible. But i am not sure if it makes sense to
> call the policy routing script even more than once because system calls like
> that can be quite expensive. And another problem i see comes with the return
> values itself.  Currently the policy-routing feature is not aware of the
> return value of the called script. One reason for this is that the
> policy-routing-script is essentially operating in a loop waiting to be feeded
> with new commands via a pipe. Therefore the script itself does not terminate
> after being feeded and does not return anything. Another problem is that the
> C-function execv() (which is currently used) does not really support return
> values except in case of an error. As you suggested, the function system()
> could be used instead, but the manpage suggests to not use this function with
> suid privileges.
>
> Regarding the cost (in terms of processing-time) i did some small experiences
> on a netgear wgt634u and a linksys WRT with openwrt which showed that
> configuring a route via a bash script (using the ip command) or by using
> system() to execute the ip command is up to 50 times more expensive than
> doing it directly (using netlink sockets).
> In my test adding and removing 100 route entries using netlink sockets took
> about 200ms while using the ip command it takes about 6-10 seconds.
> Even just calling a script with system() which does nothing else than return 0
> takes about 50ms per call.
>
> Therefore I am not sure if using the policy routing script in a large network
> and with slow devices is a good idea at all. And if the threat must be
> blocked during the execution of the script to wait for the return value it
> would be even worse.
>
> What about introducing the possibility to define that the routing information
> which is forwarded to the policy routing script is only informative and is
> still applied by the daemon itself?
>
> ciao,
> axel
>
>
> On Donnerstag 18 September 2008, Stephan Enderlein (Freifunk Dresden) wrote:
>> Hi Axel,
>>
>> thanks for your comments. At moment I have no much time to spend for
>> batman development. We got a son two month ago and I'm currently enjoy
>> him much.
>> But I have a good idea concerning the routing script.
>> The problem is that I like batman-exp to setup all routes as defined by
>> parameters, but also want batman-exp to call the script.
>> Batman may call the script twice. One call before and one after setting
>> the routes. All should depend on the return code of the first call of the
>> script.
>> If the script returns "0", then batman should not set routes and also
>> there is no need to call the script a second time.
>> If the first call of the script returns "1", then batman should set the
>> routes as defined by parameters and after it should call the script a
>> second time (like pre/post scripts).
>>
>> This allows me to get the routing information without need to setup all
>> routings per hand.
>> Bye setting a environment variable you can distingnuish if the script is
>> called as pre or post script.
>> This leads to the next solution/patch:
>>
>> You should also add information about the gateway
>> selection/changes/deselection to this script. Together with the
>> modification above you can let batmand set the routes and update your
>> resolv.conf to find the correct router that knows how to resolve dns
>> requests.
>> At moment you have to get the dns ip from dhcp or you should enter this
>> as a fix value. But a fix value for this is bad if you build a firmware
>> with a simple user interface. Many people don't know how dns works and
>> what ip they should enter. If you have different ISP some dns server are
>> not
>> accessible.
>>
>> At moment I have added my own patch where I call (system("gateway_scirpt"))
>> each time the gateway tunnel is created or deleted. this is working
>> perfectly.
>>
>> /Stephan
>>
>> > Hi
>> >
>> > On Montag 15 September 2008, freifunk@ddmesh.de wrote:
>> >> Hi,
>> >>
>> >> > Just applied your latest patches as well. Thanks for looking over the
>> >> > code.
>> >> > Virgin eyes stumble easier over nasty stuff.  :-)
>> >>
>> >> When you find some problems in batman, can you also apply those patches
>> >> to
>> >> the batman-experimental branch? At moment it is running without problems
>> >> for freifunk dresden. But if the network is growing perhaps some issues
>> >> may
>> >> cause problems.
>> >
>> > Over the time a reasonable part of the code structure of bmx and batman
>> > has
>> > forked pretty much. Therefore I am not sure if it would be easy to simply
>> > apply existing batman patches to the bmx branch. But be sure, whenever I
>> > am
>> > getting aware of critical bugs identified in the batman code which also
>> > apply
>> > to the bmx code, I'll fix them too. But for many current and older series
>> > of
>> > patches its simply not necessary. For example looking at the main recent
>> > bug-fixes
>> >
>> > Regarding the debug thread:
>> > I have removed the debug thread completely about 2 weeks ago (due to
>> > ongoing
>> > problems with this thing) and integrated its functionality into the main
>> > thread. I could not see any benefit of having this threaded except
>> > constant
>> > syncronization problems. Unfortunately I could not commit it yet because
>> > of
>> > unfinished testing. But I'll do it this week.
>> >
>> > The gw-kernel module: There are no gw-tunnel module problems with bmx
>> > simply
>> > because there is no support for this feature. Most existing bmx-mesh
>> > networks
>> > I am aware of are using the one-way-tunnel mode. It does not implement
>> > the black hole detection but still allows you to dynamically change the
>> > preferred
>> > gw. Compared to the two-way-tunnel it has less overhead, avoids tunneling
>> > from the gw to the client node (no need to optimize something which does
>> > not
>> > exist) and allows internet access with only one level of network address
>> > translation.
>> >
>> > Packet aggregation:
>> > Have been implemented and activated by default in bmx about a year ago
>> > and seem to work quite reliable since then.
>> >
>> > Problem with timing issues have been solved individually
>> >
>> > And very important. BMX has continued to rely on the concept of a rolling
>> > metric based on the number of received OGMs via the best path. Many
>> > patches
>> > in the batman-0.3 brach were due to changing this concept to a dedicated
>> > metric field carried with each OGM.
>> >
>> >
>> > By the way, I think a number of bugs in bmx and batman have been
>> > identified
>> > due to your hints. Thanks for that. If you want to intensify your work on
>> > the
>> > code and want commit patches directly just let us know.
>> >
>> >> Bye
>> >>  Stephan
>> >>
>> >> ---------------------------------------
>> >> Dipl.Informatiker(FH) Stephan Enderlein
>> >> Freifunk Dresden
>> >>
>> >>
>> >> _______________________________________________
>> >> B.A.T.M.A.N mailing list
>> >> B.A.T.M.A.N@open-mesh.net
>> >> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>> >
>> > _______________________________________________
>> > B.A.T.M.A.N mailing list
>> > B.A.T.M.A.N@open-mesh.net
>> > https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>>
>> ---------------------------------------
>> Dipl.Informatiker(FH) Stephan Enderlein
>> Freifunk Dresden
>>
>>
>> _______________________________________________
>> B.A.T.M.A.N mailing list
>> B.A.T.M.A.N@open-mesh.net
>> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>


---------------------------------------
Dipl.Informatiker(FH) Stephan Enderlein
Freifunk Dresden


