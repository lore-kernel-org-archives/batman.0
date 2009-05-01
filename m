Message-ID: <49FB110A.10309@gmx.net>
Date: Fri, 01 May 2009 17:11:06 +0200
From: elektra <onelektra@gmx.net>
MIME-Version: 1.0
References: <209743CECB91EB4F84169A51F300410D1F3137C3F9@MAIL02.ug.kth.se>,
	<200904291059.45857.lindner_marek@yahoo.de>
	<209743CECB91EB4F84169A51F300410D1F3137C403@MAIL02.ug.kth.se>
In-Reply-To: <209743CECB91EB4F84169A51F300410D1F3137C403@MAIL02.ug.kth.se>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Masters thesis
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hello Vojislav!


My personal and very biased opinion is that simulations suck -=20
simulating a wireless mesh in all its complexity (the complexity of RF=20
propagation and interference is the first issue that comes to my mind)=20
needs a very, very sophisticated software and a really powerful=20
computer. Not to mention simulating real CPU load in mesh nodes and real=20
problems with wireless interfaces, unexpected problems of the MAC layer=20
and so on.

I'd dare to say that the computational effort of simulating what is=20
going on in a mesh for 10 seconds is higher than taking 50 real machines=20
with real wireless interfaces, running them for days and getting real=20
results. Simulation seems to be important for the scientific world,=20
though. Having a implementation for the popular simulation programs=20
could increase the interest in Batman from the scientific world, but=20
honestly I don't care much. At a unit price of 25=80 per mesh-capable=20
wireless router running Open-WRT (D-Link DIR-300 for example) I don't=20
think it is necessary to do simulations anymore. However such a=20
el-cheapo grid would be only capable to test algorithms running on one=20
wireless interface and up to 5 wired interfaces. There are real testbeds=20
on this planet (like the "Meraka Massive Mesh") which are idling most of=20
the time, I guess.

It would be awesome to have IPv6 support in Batman, to be up to the=20
changes and challenges that are knocking at the door. Also protocol=20
improvements regarding protocol overhead and convergence speed (both=20
topics are linked to each other, of course) is something we should work=20
on - and hammering your head on algorithms is fun.

Cheers,
elektra





> Hello!
>
> I have about 20 weeks to do the master thesis. This time includes: gettin=
g familiar with the protocol, gathering other information needed for the ta=
sk, analysis, report writing, coding, presentation preparation and probably=
 some more stuff that I can't remember right now.
>
> Based on this list i would say that the tasks which could fit me are IPv6=
 support (the other tasks in this group seem to be more development towards=
 the OS) and "Improve Batman with regards to protocol overhead and converge=
nce speed" (with a risk that it would only result in a report). Maybe IPv6 =
would be more interesting to you guys since you would get something in retu=
rn for helping me out.
>
> Another idea that came to my mind is building a B.A.T.M.A.N. module for n=
s2, and I have seen it being discussed here the last couple of days.
>
> The easiest task for me would be IPv6 support. It would also give me the =
opportunity to get some in-depth knowledge about IPv6 and some hands-on exp=
erience with it. But I would need to check if my professor would accept thi=
s topic. Otherwise, I'm not a fastidious (I just learned a new word in Engl=
ish :) ) person, so it wouldn't be a problem for me to do any of the tasks =
mentioned above.
>
> The next step is choosing one task and then making a thesis proposal, inc=
luding a rough time-plan.
>
> Any comments or suggestions?
>
> Vojislav Marinkovic
>
> ________________________________________
>
> one afternoon of work (at maximum):
> *  Modify Batman-0.3.X code so we have an option to compile it without
> policy routing support
> *  Modify the way that Batman-Advanced (Layer 2) deals with
> broadcast/multicast payload packages (on multihop wireless routes there
> is always packet loss, protocols like DHCP use broadcast or multicast
> messages which are not send redundantly and not acknowledged, so these
> protocols which are not designed to deal with a high level of packetloss
> have difficulties to work on a Layer 2 mesh as the number of hops and
> packet loss on the media increases)
>
> several weeks of coding effort (including tests):
> *  Modify Batman-0.3.X  in order to support IPv6
> *  Get support for other operating systems working (so far it only works
> with Linux) -> depends on your knowledge of "other" systems
> * merge batman adv userspace & kernelland code to reduce the maintenance
> overhead
> * automatic interface bonding for better throughput (layer 2)
>
> requires in depth knowlegde about batman:
> *  Improve Batman with regards to protocol overhead and convergence speed
>
> mt. everest:
> *  Implement a minimalistic and power saving Batman client version for
> embedded mobile devices (requires extensive knowledge of 802.11 power sav=
ing
> mechanisms and how to bring them into the mesh)
> * multipath routing (as it always appears over and over again:
> http://en.wikipedia.org/wiki/Multipath_routing)
> _______________________________________________
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>  =20

