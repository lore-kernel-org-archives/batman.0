Return-Path: <me@haxwithaxe.net>
Message-ID: <4E42C417.7060909@haxwithaxe.net>
Date: Wed, 10 Aug 2011 13:47:03 -0400
From: haxwithaxe <me@haxwithaxe.net>
MIME-Version: 1.0
References: <87ipr2mjdv.fsf@trurl.pps.jussieu.fr>	<4E270F72.10900@virtadpt.net>	<7izkk8zsr4.fsf@lanthane.pps.jussieu.fr>	<4E28392B.9020209@virtadpt.net>	<7ibown8v2j.fsf@lanthane.pps.jussieu.fr>	<4E403367.4060701@virtadpt.net>
	<4E411B95.4030203@tnode.com>	<4E416584.2020701@virtadpt.net>
	<4E41A0C6.1010209@tnode.com>	<4E42B411.9050601@virtadpt.net>
	<4E42B779.70905@tnode.com>
In-Reply-To: <4E42B779.70905@tnode.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [Babel-users] [Battlemesh] Battlemesh-like
 experiment in Washington, DC
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
To: Mitar <mitar@tnode.com>
Cc: b.a.t.m.a.n@open-mesh.net, Battle of the Mesh Mailing List <battlemesh@ml.ninux.org>, babel-users@lists.alioth.debian.org

hi,
i'm one of the other byzantium developers. at some point we do intend to 
get switched over to ipv6 but for now we are using ipv4 just to simplify 
our lives during development as none of us are terribly experienced with 
ipv6.
our use case dictates that the meshes will at some point need to operate 
without being connected to the internet at all so relying on any kind of 
centralized service to configure the nodes isn't always going to work. 
also we are using x86 machines (laptops/desktops) for our nodes so we 
need to allow for tweaking given the diversity of the hardware byzantium 
will be on. we will likely have some form of graduated configuration 
which will start at the most basic level so that people don't have to 
fiddle with more settings than are required.
in addition the lack of centralized configuration mechanism prevents an 
a hostile party from spoofing control instructions and shutting down the 
network by scrambling the configs in the event byzantium is deployed in 
an environment where it may not be welcome by authorities, or if it's 
deployed in the proximity of skiddies who think it'd be funny to kill a 
community's link to each other and the internet.
also we are using ahcpd so withing the mesh it's not entirely random 
what ip one gets.


On 08/10/2011 12:53 PM, Mitar wrote:
> Hi!
>
>> The Byzantium control panel is an application which allows the user to
>> (de)configure network interfaces, add or remove them from a mesh, and
>> enable or disable services and web applications running on a node.  It
>> runs on a node (listening only on the loopback interface) and is
>> accessed with any web browser.  Technically, it is a web application,
>> but seeing as how Byzantium will package a couple of web applications
>> for public use on a mesh anyway (Etherpad-lite, crypto.cat, status.net,
>> and a few others) it made more sense to call it a control panel.
>
> Interesting. Just as an information, in our network (wlan slovenia) we
> have taken directly the opposite approach and made a centralized system
> for deploying nodes (centralized in the sense it is one of the services
> of the network, but the network itself still runs operates if this
> service is removed from operation, this server/system/service only
> streamlines node deployment (and prevents IP collisions so that it
> maintains ). The point we have seen is that web interface on the node
> takes simply too much time to maintain once you have many nodes which
> you want to configure the same (and update configuration and so on). It
> takes time to click all those things. And that it is still too technical
> for common people to use.
>
> So we have taken completely other approach: nodes without any web
> interface, where you have a service in the network which issues
> pregenerated firmware images with all configuration already in there. So
> you just select what hardware you have, where the node will be and
> everything else is done by the system (for power users you can also
> select additional OpenWrt packets and mangle with configuration, but it
> is not necessary). You flash the image, power it up and this is it.
>
> Now, the next step is to make this service distributed (like every node
> can be it) and we have best of both worlds. ;-)
>
> But currently we are making it modular, so that different networks can
> adapt it to their needs:
>
> http://dev.wlan-si.net/wiki/Nodewatcher
>
>> IPv4.  We considered IPv6, and in fact we get it for free with the Linux
>> kernel, but not all applications are aware of or play nicely with it.
>
> Yes, but if everybody just waits for applications to be ready ... ;-)
>
> I think it is crucial especially for decentralized networks to start
> using it.
>
> Maybe instead of random IP allocation you could try some distributed IP
> allocation system where you would take some temporary IP and request
> what is free (using distributed hash storage or something). But yes,
> there were already so many other ideas for this problem discussed and
> yes, there is a problem of mixing layers.
>
>> This is an interesting problem to us, and one of the things we have in
>> mind once Byzantium is stable is correcting problems with
>> interoperability.
>
> I would invite you to take part here:
>
> http://interop.wlan-si.net/
>
> It is an initiative by many networks to find some common ground. As I
> see it is a bit more centralized that your approach (we are mostly using
> centralized node databases), but probably we could also find some common
> ground with you. For example, currently we are defining a common
> database schema to be able to describe our nodes in a common way so that
> we can then have common applications working over that.
>
> You could probably use the same schema internally in your control panel
> in a distributed way so that maybe some centralized system in your
> network could still fetch this data and use it (for example to draw a
> map or something).
>
>
> Mitar
>
> _______________________________________________
> Babel-users mailing list
> Babel-users@lists.alioth.debian.org
> http://lists.alioth.debian.org/cgi-bin/mailman/listinfo/babel-users
