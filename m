From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] two-way-tunnel quirks
Date: Tue, 4 Dec 2007 16:05:51 +0100
References: <20071130232852.GC3934@apoderado.ometepe.net>
	<200712041005.46329.axel@open-mesh.net>
	<20071204130004.GA3907@apoderado.ometepe.net>
In-Reply-To: <20071204130004.GA3907@apoderado.ometepe.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200712041605.51587.axel@open-mesh.net>
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

Hi,

> > > > >
> > > > >   A---B---C
> > > > >
> > > > > A: your computer
> > > > >
> > > > > B: bmxd_rv804  client node      }
> > > > >                                  }running 2-way-tunnel
> > > > > C: bmxd_rv804    gw node        }
> > > >
> > > > I am just curious, can you confirm if the following correctly
> > > > describes the HNA/SNAT of your setup:
> > > >
> > > > for the two-way-tunnel setup:
> > > >  - you were doing SNAT at Cs' upstream interface AND at Bs' bat0
> > > > interface
> > >
> > > MASQUERADE
> > >
> > > > for the one-way tunnel setup:
> > > >  - you are only doing SNAT at Cs' upstream interface
> > >
> > > no, i still do MASQUERADE also on Bs' bat0, because i was too lazy to
> > > comment it out ;-)
> >
> > Interesting to know that this is possible, because (as I understand):
> >
> > - Internet Uplink packets are MASQUERADEd (*) when being entunnelled at
> > Bs' bat0 interface and a second time at your upstream GW interface
> >
> >  A          B                C
> > eth0    eth0 bat0        bat0 dsl0   Internet
> >
> >  >---------->*===============>*--------->
> >
> >         MASQUERADE       MASQUERADE
> >
> >
> > - Downlink packets are de-MASQUERADED (*) at Cs' upstream interface
> > (dsl0). But using one-way-tunnel, the Downlink packets are NOT routed via
> > the bat-tunnel, therefore downlick packets will not come out of Bs' bat0
> > interface and (I thought) would not be de-MASQERADEd (?) !
> >
> >  A          B                C
> > eth0    eth0 wlan0      wlan0 dsl0   Internet
> >  <----------<?---------------<*---------<
> >        de-MASQUERDE?   de-MASQUERADE
> >
> >
> > catched my draft ? Please correct me if I misunderstood!
>
> completley correct, the thing is, if i understand right, the good old
> one-way-tunnel doesn't do anything with virtual IPs, but just uses
> the real IPs so it doesn't matter.

It doesn't matter for B but it should matter for A

Assuming:

As' eth0  has IP 10.0.1.1
Bs' eth0  has IP 10.0.1.2
Bs' wlan0 has IP 10.0.0.2
with onw-way-tunnel 
Bs' bat0 also has IP 10.0.0.2

if A sends a packet along the default route the packet is routed into Bs' bat0 
and MASQUERADEd from 10.0.1.1 to 10.0.0.2 .

Now what happens when the packets comes back? I think,  in order to get 
delivered to A, it must be de-MASQUERADEd from 10.0.0.2 to 10.0.1.1

ciao
/axel

>
> cheers
>
>   --Jan


