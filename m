Message-ID: <4801C1DF.5080600@gmail.com>
Date: Sun, 13 Apr 2008 03:18:39 -0500
From: Tim LePes <luvdownbabylon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Suitability of B.A.T.M.A.N. protocol to my disaster
 relief network project
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

Greetings!

If this list is the wrong place to be asking about this, please let me
apologize up front.  :)

I am working on a project based around the Genesi EFIKA 5200B SoC
development board.  You can find more details about the board by
visiting "http://www.genesi-usa.com/efika.php".  The basic idea for my
project is that of an ad-hoc long-range wireless mesh network
infrastructure that can be easily set up by disaster relief workers.
The inspiration came from stories out of the hurricane Katrina disaster
in Louisiana and Alabama.

Please let me tell you about the project a little, and hopefully you may
be able to give me some advice - both general and specific to the
suitability of using the B.A.T.M.A.N. protocol.  I understand that you
have far more experience with real-world applications of wireless mesh
networking than I, so any feedback will be greatly appreciated!

In the scenarios I imagine, a relief effort could quickly erect a series
of towers (telescoping poles?) with a wireless mesh node at the top, in
a weatherproof case.  The mesh node can be powered by a generator or
whatever other means available.  The purpose of the mesh is to provide a
network infrastructure out to areas that may have lost all traditional
connectivity and infrastructure.  Generally, the idea is to bring
connectivity from one or more internet-connected points out to the areas
where you would have shelters set up, such as a Red Cross tent or other
similar congregation point for disaster victims.  The mesh node would
connect them to each other (other sites in the field) and, ideally, back
to the internet.  However in the event that it is not easy to get
internet connectivity to the mesh, it will still be useful for sites in
the field to communicate and coordinate with each other.

At the shelter, then, would be a mesh node up on a pole.  The device
would act as a gateway, offering network  connectivity to anything
attached to it's 10/100 ethernet port.  It would be a DHCP server and
could provide connectivity to one or more computers (with the help of a
hub).  The computer(s) would be used to access web-based services for
things such as logistics, people-finding service, access to government
and/or NGO relief agency web sites and services, etc.

There is another project I found that I hope to tie into my project, and
that is SAHANA.  From their web site, "Sahana is a Free and Open Source
Disaster Management system. It is a web based collaboration tool that
addresses the common coordination problems during a disaster from
finding missing people, managing aid, managing volunteers, tracking
camps effectively between Government groups, the civil society (NGOs)
and the victims themselves."  Their web site is "http://www.sahana.lk/".


The main consideration is that it be as easy as possible for emergency
response and other disaster relief workers to physically set up this
network.  So my hope is that the network can be largely
self-configuring, self-monitoring, and self-healing.  Thus an ad-hoc
mesh design.  I would imagine that in some situations, the network would
be a simple mesh cloud connecting people on the ground to each other.
In other situations, and ideally, connectivity to the internet would be
established through one or more nodes in the mesh.  I could see that
sometimes certain nodes may not really play the role of a mesh node so
much as a repeater, to get the connectivity strung out over some distance.

I am thinking of putting WiMAX radios in the mesh nodes, for the
purported range.  There are several things that I am unsure of, so any
suggestions or comments on any points are more than welcome.  Forgive me
if I just ramble out some of my thoughts/questions here...

Is WiMAX a good choice for this?  I have not really seen a lot of WiMAX
hardware.  The SoC board will be running Linux and is a PowerPC
architecture, so drivers will of course be important with whatever
radios go in the device.

Would it be best to have two radios in the mesh nodes?  If only one is
needed, then perhaps I can put one WiMAX for the backhaul and one
regular WiFi 802.11a/b/g and provide a WAP for the downlink sites.  Or
simply save on the BoM by only using single radios.  Or maybe single
radios would work for the nodes comfortably "meshed" with others, but
dual-radios could be used in a directional repeater node specifically
made to extend the mesh connectivity over distances?  Or do I have that
backwards?  Maybe multiple radios would be better for the chatty
meshed-up nodes versus the far-flung nodes making a chain back to the
internet connectivity points at the periphery of a disaster area.  I am
certainly open to any suggestions on other technologies to consider, too.

How well do BATMAN or other meshes scale?  What is the ideal density for
nodes in the mesh, and how much better does it get with more node
density before you have a diminishing return?

How bad is the latency?  Is VoIP do-able?  Is it do-able for a few hops
(like between field sites) but simply not do-able for longer trips out
to the periphery of the mesh, where the internet connectivity is likely
to be?

Is this even the right approach to this sort of connectivity problem?  I
can see a mesh being useful for field-sites communicating with each
other.  But often I have seen that the ideal with a mesh is to have the
internet-connected nodes be in the center of the mesh whereas in this
scenario, typically, the internet connection is only to be had at the
periphery.  Would it be better to have a split role system where
long-range internet connectivity is brought out over distance using some
long-range repeater set-up, and the mesh spawned off from the end-point
of this line? (Or multiple such lines)?

How much does the actual routing of traffic tax the processor in a mesh
node?  These boxes have 128Mb and can have a hard drive or SSD in them.
They run a fairly complete Linux on them.  I am already imagining they
can be managed via http with a web interface fairly easily.  But I am
curious to find out how much more room I have to run other softwares.  I
have thought of them having the ability to boot found/donated PCs over
PXE and bootstrapping Linux on the computers, served by the mesh node
(now a pxe/bootp server in addition to dhcp), to make quick and easy
internet terminals/kiosks.

Other possibilities include running squid caches on the nodes to reduce
back-haul traffic when many folks are visiting the same sites, or even
having them optionally be able to block traffic based on either white or
black lists, and since the SoC boards have audio in/out, they could be
used as a VoIP phone over the network.  Besides having a data network
for email and web access, simply being able to simply talk to each other
between sites using the device could be very valuable.  Especially when
traditional communications such as cell phone and land-line networks are
down.  And being built into the mesh node, there would be at least voice
communications available immediately that way, even before other devices
are networked to the mesh nodes.  There is a serial port, so keypads are
a possibility.

I would like to make the network as dead-simple to set up as possible.
Emergency workers have enough to worry about without having to become
network experts.  At most I would expect that they could connect a
laptop to the Ethernet port and configure the devices with a web
interface.  But ideally I would like there to be zero configuration
on-site, if possible.  Plug and go, so long as you're in range.  Of
course there would have to be some management console (probably web
based) to get an idea of signal strengths, network performance, etc. for
troubleshooting and fine tuning the network.

Well anyway I have several ideas running around for this project,
including other devices that would network in and serve different
roles.  But it all depends on the feasibility of constructing a wireless
networking infrastructure.  I don't want to take up too much of your
time rambling on, so as I said, any feedback is welcome.  As are any
questions you may have.

Genesi have been gracious enough to give me the development board for my
project, so I am anxious to make some headway.

Thanks so much!

Tim LePes (a.k.a. Mojo)

