Return-Path: <leftbydefault@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Date: Wed, 28 Sep 2016 16:57:12 +0530
From: leftbydefault@riseup.net
In-Reply-To: <20160926230741.GC6995@otheros>
References: <dbe677b5597c50f4f97171b59752af6b@riseup.net>
 <20160926230741.GC6995@otheros>
Message-ID: <488d615eac8b5f7f9e2d902d0d99532b@riseup.net>
Subject: Re: [B.A.T.M.A.N.] Interested in contributing
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hello again,

On 2016-09-27 04:37, Linus Lüssing wrote:
> Hi!
> 
> We had been discussing priorities at the last Wireless Battlemesh
> and the top ones are currently:
> 
> 1) Implementing aggregation for BATMAN V
>    (or better, implement some routing algorithm independent
>    aggregation)
> 2) Then the "Dead node fast path switching/invalidating" point
>    (current codename: "RIP") to increase scalibility/responsiveness
>    through such a reactive addition to the protocol

Both of these 2 problems seems interesting.

> 
> 
> Regarding larger community mesh networks, it also seems that we
> need some deeper evaluation and maybe improvements for DAT. At
> least some statistics indicate that larger, open mesh networks
> still have a non-negligable amount of broadcast traffic caused by
> ARP.
> 
> Then there were also some discussions about some "Privacy
> Extension" for clients, but there is no easy or even satisfying
> concept yet.
> 
> I personally would love to improve the current multicast
> optimizations to allow real multicast streaming, but we came to
> the conclusion at WBM, that this is a "nice-to-have" for now until
> 1)+2) are done.
> 
> 
> Of course, priorities depend on real use-cases, so other people
> can probably throw in other ideas or preferences. Or, asking
> you, what are the scenarios and use-cases you would like to
> improve and feel motivated to work on :-)?

I am currently undergoing a masters degree on Networks & Internet 
Engineering from India. Also we are actively trying to establish a 
wireless community Network in our place (https://pymeshnet.gitlab.io). 
We have done few exercises like flashing the router with OpenWRT 
firmware and installing batman-adv & batctl 2016 on it and have 
successfully meshed them both in range via ad-hoc mode.

I am particularly interested with b.a.t.m.a.n-adv as a routing protocol 
itself and so I am starting to understand the internals of this 
protocol. So consider myself as a beginner.

As a community volunteer, we wanted to deploy a wireless mesh routing 
protocol and as a academic student, I am interested in studying the 
protocol and trying to figure out limitations or issues with the 
protocol & identify a solution.

> Regards, Linus
> 
> PS: Also something, if you might already have some experience with
> kernel code, would be to simply help in reviewing pending patches.

I have very little experience trying to learn to write modules for linux 
kernel, nevertheless I can learn it.

> 
> PPS: Great that you want to contribute! :-)

Very glad to see b.a.t.m.a.n list is open to new comers like me. 
Currently, I am going through the wiki pages 
(https://www.open-mesh.org/projects/batman-adv/wiki/Wiki). I request you 
people to help me get clarified certain things, when I am in doubt. I 
will definitely pick up.
