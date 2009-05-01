Date: Fri, 1 May 2009 10:32:35 -0500
From: Troy Benjegerdes <hozer@hozed.org>
Message-ID: <20090501153235.GU15322@excalibur.hozed.org>
References: <200904291059.45857.lindner_marek@yahoo.de>
	<209743CECB91EB4F84169A51F300410D1F3137C403@MAIL02.ug.kth.se>
	<49FB110A.10309@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <49FB110A.10309@gmx.net>
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

I have somewhat the same opinion of simulations.. garbage in, garbage
out. HOWEVER, being that my paying job is maintaining systems that DO
large simulations, I think there would be a HUGE benefit to both the
research community and the BATMAN software development for a coherent
simulation model. 

The simulation is *deterministic*, and does not depend on whether
someone has the microwave running when you're sending packets or not.
This allows you to perform repeatable tests on a proposed routing
algorithm change.

The problem with most simulations is they take some toy algorithm, that
is never actually used in the real world, and then someone publishes a
paper saying how great it is.

Now, if you could make a simulation engine than can take as input data
probabilities of packet loss or MAC layer problems, which was gathered
from a REAL running mesh network, then you have something. Even better
if you can compile the same BATMAN routing code and move data around
with virtual machines. You *could* use something like qemu to even
emulate the embedded CPU's, but I think the computation cost would be
far too high. However, running many native linux instances (kvm, or
somthing libvirt-based .. http://libvirt.org/drvuml.html) would probably
allow a pretty large mesh (maybe over 1000 nodes) to run in pretty much
real-time on a 64-128 node cluster.

Now you have the real-world system providing data to the simulation,
which can then allow testing of new algorithm tweaks in a repeatable
manner, which is quite hard with a real network.

All that being said, if you do IPv6 instead, I would use it for my
scheme to use wireless mesh networks for smart power grid applications ;)

On Fri, May 01, 2009 at 05:11:06PM +0200, elektra wrote:
> Hello Vojislav!
>
>
> My personal and very biased opinion is that simulations suck -  
> simulating a wireless mesh in all its complexity (the complexity of RF  
> propagation and interference is the first issue that comes to my mind)  
> needs a very, very sophisticated software and a really powerful  
> computer. Not to mention simulating real CPU load in mesh nodes and real  
> problems with wireless interfaces, unexpected problems of the MAC layer  
> and so on.
>
> I'd dare to say that the computational effort of simulating what is  
> going on in a mesh for 10 seconds is higher than taking 50 real machines  
> with real wireless interfaces, running them for days and getting real  
> results. Simulation seems to be important for the scientific world,  
> though. Having a implementation for the popular simulation programs  
> could increase the interest in Batman from the scientific world, but  
> honestly I don't care much. At a unit price of 25? per mesh-capable  
> wireless router running Open-WRT (D-Link DIR-300 for example) I don't  
> think it is necessary to do simulations anymore. However such a  
> el-cheapo grid would be only capable to test algorithms running on one  
> wireless interface and up to 5 wired interfaces. There are real testbeds  
> on this planet (like the "Meraka Massive Mesh") which are idling most of  
> the time, I guess.
>
> It would be awesome to have IPv6 support in Batman, to be up to the  
> changes and challenges that are knocking at the door. Also protocol  
> improvements regarding protocol overhead and convergence speed (both  
> topics are linked to each other, of course) is something we should work  
> on - and hammering your head on algorithms is fun.
>
> Cheers,
> elektra
>
>
>
>
>
>> Hello!
>>
>> I have about 20 weeks to do the master thesis. This time includes: getting familiar with the protocol, gathering other information needed for the task, analysis, report writing, coding, presentation preparation and probably some more stuff that I can't remember right now.
>>
>> Based on this list i would say that the tasks which could fit me are IPv6 support (the other tasks in this group seem to be more development towards the OS) and "Improve Batman with regards to protocol overhead and convergence speed" (with a risk that it would only result in a report). Maybe IPv6 would be more interesting to you guys since you would get something in return for helping me out.
>>
>> Another idea that came to my mind is building a B.A.T.M.A.N. module for ns2, and I have seen it being discussed here the last couple of days.
>>
>> The easiest task for me would be IPv6 support. It would also give me the opportunity to get some in-depth knowledge about IPv6 and some hands-on experience with it. But I would need to check if my professor would accept this topic. Otherwise, I'm not a fastidious (I just learned a new word in English :) ) person, so it wouldn't be a problem for me to do any of the tasks mentioned above.
>>
>> The next step is choosing one task and then making a thesis proposal, including a rough time-plan.
>>
>> Any comments or suggestions?
>>
>> Vojislav Marinkovic
>>
>> ________________________________________
>>
>> one afternoon of work (at maximum):
>> *  Modify Batman-0.3.X code so we have an option to compile it without
>> policy routing support
>> *  Modify the way that Batman-Advanced (Layer 2) deals with
>> broadcast/multicast payload packages (on multihop wireless routes there
>> is always packet loss, protocols like DHCP use broadcast or multicast
>> messages which are not send redundantly and not acknowledged, so these
>> protocols which are not designed to deal with a high level of packetloss
>> have difficulties to work on a Layer 2 mesh as the number of hops and
>> packet loss on the media increases)
>>
>> several weeks of coding effort (including tests):
>> *  Modify Batman-0.3.X  in order to support IPv6
>> *  Get support for other operating systems working (so far it only works
>> with Linux) -> depends on your knowledge of "other" systems
>> * merge batman adv userspace & kernelland code to reduce the maintenance
>> overhead
>> * automatic interface bonding for better throughput (layer 2)
>>
>> requires in depth knowlegde about batman:
>> *  Improve Batman with regards to protocol overhead and convergence speed
>>
>> mt. everest:
>> *  Implement a minimalistic and power saving Batman client version for
>> embedded mobile devices (requires extensive knowledge of 802.11 power saving
>> mechanisms and how to bring them into the mesh)
>> * multipath routing (as it always appears over and over again:
>> http://en.wikipedia.org/wiki/Multipath_routing)
>> _______________________________________________
>> _______________________________________________
>> B.A.T.M.A.N mailing list
>> B.A.T.M.A.N@open-mesh.net
>> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>>
>>   
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n

-- 
--------------------------------------------------------------------------
Troy Benjegerdes                'da hozer'                hozer@hozed.org  

Unless hours were cups of sack, and minutes capons, and clocks the tongues
of bawds, and dials the signs of leaping houses, and the blessed sun himself
a fair, hot wench in flame-colored taffeta, I see no reason why thou shouldst
be so superfluous to demand the time of the day.  I wasted time and now doth
time waste me.                        -- William Shakespeare
