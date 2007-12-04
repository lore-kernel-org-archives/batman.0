From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] two-way-tunnel quirks
Date: Tue, 4 Dec 2007 11:01:06 +0100
References: <20071130232852.GC3934@apoderado.ometepe.net>
	<200712011834.54327.lindner_marek@yahoo.de>
	<20071202043216.GB3923@apoderado.ometepe.net>
In-Reply-To: <20071202043216.GB3923@apoderado.ometepe.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200712041101.06161.axel@open-mesh.net>
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

On Sonntag 02 Dezember 2007, Jan Hetges wrote:
> On Sat, Dec 01, 2007 at 06:34:54PM +0100, Marek Lindner wrote:
> > > now i found an issue which i didn't relate with batman
> > > first. I got several reports of users, hotmail/msn/live.com
> > > not being accessible anymore...
> > > Yesterday i found out theres also problems with some pop server
> > > not beeing accessible, but everything works fine directly at the
> > > upstream gw, without any batmand involved.
> >
> > Unfortunately, it is too few information to do anything about it. Could
> > you describe your experiences in more detail. Here some questions on the
> > way:
> >
> > - When did you notice the problem for the first time ?
>
> user reports for about 3 weeks
>
> > - Which revision was used ?
>
> probably rv777, i'm running batmand-exp only since then
>
> > - What exactely is your problem ?
>
> web-browsers say something like "hotmail/msn/live.com dropped the
> connection"
>
> > - Can you describe it in way that i can reproduce it ?
>
>   A---B---C
>
> A: your computer
>
> B: bmxd_rv804  client node      }
>                                  }running 2-way-tunnel
> C: bmxd_rv804    gw node        }
>
> and now try to browse www.hotmail.com, but i'm not sure if
> you can reproduce it, because the high latency (>640ms) of
> our sat-uplink might be also involved

theres nothing you cannot do with linux:

on my upstream server:
|isix:~# tc qdisc add dev eth5 root netem delay 800ms

on my notebook:
|smart linux # ping -n google.de
|PING google.de (216.239.59.104) 56(84) bytes of data.
|64 bytes from 216.239.59.104: icmp_seq=1 ttl=242 time=852 ms

the interesting:
|smart linux # ping -n msn.com
|PING msn.com (207.68.172.246) 56(84) bytes of data.
|--- msn.com ping statistics ---
|7 packets transmitted, 0 received, 100% packet loss, time 5998ms

|smart linux # ping -n live.com
|PING live.com (207.46.30.34) 56(84) bytes of data.
|--- live.com ping statistics ---
|7 packets transmitted, 0 received, 100% packet loss, time 5998ms

remove artificial delay again:
|isix:~# tc qdisc del dev eth5 root netem delay 800ms

still the problematic ones you mentioned do not reply to icmp pings.
|smart linux # ping -n live.com
|PING live.com (207.46.30.34) 56(84) bytes of data.
|--- live.com ping statistics ---
|4 packets transmitted, 0 received, 100% packet loss, time 2998ms


|smart linux # ping -n open-mesh.net
|PING open-mesh.net (88.198.145.69) 56(84) bytes of data.
|64 bytes from 88.198.145.69: icmp_seq=1 ttl=54 time=29.4 ms


Still I could not yet reproduce the problem but I am quite sure
that this has something to do with the msn&co.coms' reluctance to 
respond to icmp messages.

ciao,
axel

>
> cheers
>
>   --Jan


