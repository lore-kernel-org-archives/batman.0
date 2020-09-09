Return-Path: <abolletta@netter.io>
MIME-Version: 1.0
References: <CADJ1cUTq=Bpj9SQdS5Y6aXKcPR9XqkxKn_Sj5sRMmN1R=qX_2g@mail.gmail.com>
 <17582207.Wjj8Q8S2kB@ripper> <CADJ1cUSNtDrR-C-L7MHXF3JohbkmBbQBsFzBvBxE2WntUd9Yqw@mail.gmail.com>
 <34120415.8pMx1AJBNe@ripper>
In-Reply-To: <34120415.8pMx1AJBNe@ripper>
From: Alessandro Bolletta <abolletta@netter.io>
Date: Wed, 9 Sep 2020 10:50:24 +0200
Message-ID: <CADJ1cUSff_g-tB28HHeR5GrYHHtch7f+bdQQ85HdZx4dhLdTvw@mail.gmail.com>
Subject: Re: Running multiple batman-adv namespaces on the same broadcast domain
Content-Type: text/plain; charset="UTF-8"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Il giorno mer 9 set 2020 alle ore 10:30 Sven Eckelmann
<sven@narfation.org> ha scritto:
>
> On Wednesday, 9 September 2020 10:20:20 CEST Alessandro Bolletta wrote:
> > Just one more info: is there an hard limit for the number of "bat"
> > interfaces on the same host?
>
> But yes, running multiple batman-adv interfaces on the same host works fine. I
> am currently using 8 in parallel. The lower/hardif/slave interfaces are using
> VXLAN (to connect some servers in other datacenters), fastd (to connect remote
> "clients") and some other "ethernet" protocol compatible things.

Great, this is exactly what I'm looking for! I'm running this for some
experimental purposes. Are you running VXLANs in multicast modes?

>
> And the hard limit is most likely the number of netdev's the Linux kernel can
> create (id wise and memory wise).
>
> > Moreover, is the multiple batX namespaces a scenario that it is
> > supposed to work fine, is it well tested or it still does need some
> > love?
>
> I don't like the word "namespaces" here. Because this reverse to a completely
> different concept in the linux kernel.
>

Yeah, I'm sorry but I didn't know how to call them. "Mesh clouds" is a
more exact term to call our batX?

> And I don't know what you will end using - so I cannot say if this will work
> or is tested.
>

I will use them in a scenario where a have 3 hosts connected by an
ethernet card each and a switch. Then, I have to connect at layer 2
these hosts to batman, but I need to separate their traffic through
different batman-adv "mesh clouds" (in my case I can't use VLANs, QinQ
or stuff like that to do so)

> Kind regards,
>         Sven
