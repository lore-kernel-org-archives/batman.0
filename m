From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] Texas UML instances and OLSR+BATMAN tests
Date: Tue, 9 Oct 2007 09:53:43 +0200
References: <20070608201844.GM20739@localhost>
	<200710021059.06583.axel@open-mesh.net>
	<560c7c9a0710090025m4c69199dwe9759e46bae5e6ff@mail.gmail.com>
In-Reply-To: <560c7c9a0710090025m4c69199dwe9759e46bae5e6ff@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200710090953.43820.axel@open-mesh.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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

Hello

On Dienstag 09 Oktober 2007, Benjamin Henrion wrote:
> On 10/2/07, Axel Neumann <axel@open-mesh.net> wrote:
> > Hello,
> >
> > We have used OpenVZ (linux-2.6.18-openvz-028.035.1) for emulating batman
> > and olsr.
> > Further background information about the setup is given here:
> > http://open-mesh.net/batman/doc/evaluation/setup-details

[snap]

> > The following worked:
> > - On  2GHz core duo notebook (qemu using only one processor and 800MB
> > Ram) - More than 100 virtual instances idling in parrallel
> >   - About 60 virtual instances running olsr or batman in parrallel
> >
> > - use brctl, ebtables, TC, and NETEM for configuring virtual networks
> > with - dedicated links
> >   - dedicated packetloss, delay for unicast and broadcast traffic
> >
[snap]

>
> I have tested the OpenVZ livecd with a small window manager (consumes
> 128MB in RAM), and with 10 instances running batman or olsr, it works
> fine with 512MB of RAM, but my problem is that the livecd does not
> supports ebtables it seems, which I need to configure for avoiding
> bridge shortcuts between the nodes.
>
> Does anybody has experience with ebtables? Does it needs a kernel
> patch? Or it is just user-space?

If you follow the link in the above lines, you will find a line like:

... patched again to fix a bug in the ebtables part of the 2.6.18 kernel 
extracted from patch-2.6.18.8 from 
http://www.kernel.org/pub/linux/kernel/v2.6/ and downloadable here...

Why not having a look ?

>
> OpenVZ looks very promising for network simulators, it consumes very
> few memory, especially if you use a mounted HD to store the
> filesystem.
>
> --
> Benjamin Henrion <bhenrion at ffii.org>
> FFII Brussels - +32-484-566109 - +32-2-4148403
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


