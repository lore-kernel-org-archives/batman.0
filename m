Return-Path: <lambertarthur22@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20120704102155.GA10503@pandem0nium>
References: <CAGpqJgoJ2V5TNcr5j+c=y88Vj4ipE0ke=y9ZDKqOvsaci+u54A@mail.gmail.com>
	<20120704092052.GB10142@pandem0nium>
	<CAGpqJgoZz+m9d41L2rVtOUzenzue_BjCt+YQ8h_TSEi7QbxwoQ@mail.gmail.com>
	<20120704102155.GA10503@pandem0nium>
From: Arthur Lambert <lambertarthur22@gmail.com>
Date: Wed, 4 Jul 2012 14:05:16 +0200
Message-ID: <CAGpqJgo3OBq0Aa5SmSs5KSdm-3cX_dwV7nV6+UmvvvesyftgPA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] [B.A.T.M.A.N] OGM problem and documentation
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hey again,

> That's pretty interesting! I don't know if we have something like
> an architecture illustration (but haven't see any recently).  If you get
> anything interesting out of that (illustration, performance insights,
> etc), please tell us.

I am trying to draw some illustration like the document that I show to you. But
I am not sure of the validity of them and there are not finish. I have
the first that I
show you that is a king of global architecture. I have a Data path
which follow the
same design of the first. And a third will follow which describe the
temporal organization.

I have also a first study which measure the signaling of topology like
before with different size
(4, 9, 36, 25, 36, 49, 81 nodes). I measure the signaling in bytes by
seconds on all the topology.

And all of this work is also done for an other protocol to compare them.

But as I say its to soon to show you something. At this moment, my new
way to test is better I think,
I want measure the received and sent packets on each node of my
topology and not only for all the topology
to have a better way to measure the cost of the signaling.



> Ah ok. Is it a self-written tool or something public? We usually use
> vde/wirefilter to build up different topologies, see:
>
> http://www.open-mesh.org/wiki/open-mesh/Emulation
>
> Would be interesting if there are other possibilities :)

Yes this tool is Cloonix : http://clownix.net/. You are lucky, you
will not find a lot of
documentation but its is in English. This tool use a system of socket
to encapsulate
the flow. But with this tol you have not a wireless network, only
wired network. You
can also simulate lost packet during communication.

I am using this tool because I know the creator of the project so it's
really convenient for
me to use it.

>
> Good luck!
>
> Cheers
>         Simon


Thank you
           Arthur.
