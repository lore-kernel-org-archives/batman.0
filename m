Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
References: <CADg1mwL-H_PULsXqVb0r58k0_zkAYWTOm=cM5QZrDoqRxKqdLw@mail.gmail.com>
 <2538029.hbpEtBUb1E@prime>
In-Reply-To: <2538029.hbpEtBUb1E@prime>
From: Mark Birss <markbirss@gmail.com>
Date: Thu, 25 Jun 2020 14:35:37 +0200
Message-ID: <CADg1mwLp=nk5W4L47P-4qvTKB9wyiL9wO7vSR7pqjhhSwaDnSw@mail.gmail.com>
Subject: Re: Batman-adv Tweaking - bonding
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Ah, okay understood. Thank you for the explanation.

My focus currently is on batman-adv over ethernet.
I will get around to see how this works out

Regards

On Thu, Jun 25, 2020 at 2:23 PM Simon Wunderlich <sw@simonwunderlich.de> wrote:
>
> On Thursday, June 25, 2020 2:14:06 PM CEST Mark Birss wrote:
> > Hi
> >
> > With reference to the wiki topic at
> > https://www.open-mesh.org/projects/batman-adv/wiki/Tweaking
> > bonding
> >
> > Available since: batman-adv 2010.1.0
> >
> > When running the mesh over multiple WiFi interfaces per node
> > batman-adv is capable of optimizing the traffic flow to gain maximum
> > performance. Per default it operates in the "interface alternating"
> > mode (which is suitable for most situations) that switches the WiFi
> > interface with each hop to avoid store & forward. Alternatively,
> > batman-adv can be switched into "bonding mode" in which batman-adv is
> > using all interfaces at the same time to send & receive data. However,
> > this mode is only recommended in special one-hop cases. You can read
> > about our alternatebonding test results to see what suits you best.
> >
> >
> > The wiki shows that this is the only change required on both nodes to
> > use it in default interface alternating mode
> >
> > batctl meshif bat0 bonding enabled
> >
> > The wiki does not say how the throughput was measured after bonding was
> > enabled
> >
> > Will batctl tp be ok?
>
> Hi Mark,
>
> bonding was measured on 802.11a/g routers (yes, before there was 11n) back in
> the day using iperf. There was no throughput meter at this point, but it might
> work just as well. In general, there were many situations where bonding
> actually decreased the throughput because the buffers of the radios were not
> synchronized, causing packet re-ordering on the receiver which TCP is very
> sensitive to. In general, I can't really recommend to activate bonding at this
> point, but you can enable it and see if it helps you.
>
> Cheers,
>       Simon
