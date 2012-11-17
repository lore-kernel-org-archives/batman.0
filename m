Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <CAHD-aqLLwTXx54gYfkJMuxqwKhvKcwNAQuO3JiwVfVJ1Qrn5tw@mail.gmail.com>
References: <CAHD-aqJFHc+YbrYTL53hX5G=mvDLrDKSn6_JfNQzEvPPU50SRA@mail.gmail.com>
 <5086BFE2.40105@nemesisdesign.net>
 <CAHD-aqJ2DNYjaaqfxO1Y2S8w3yvjctSrPyO+vJRVkKKKMsnGig@mail.gmail.com>
 <CAHD-aqLLwTXx54gYfkJMuxqwKhvKcwNAQuO3JiwVfVJ1Qrn5tw@mail.gmail.com>
From: Gui Iribarren <gui@altermundi.net>
Date: Sat, 17 Nov 2012 00:21:09 -0300
Message-ID: <CAHD-aqJdxHJsq-1MFB7RU16cTcJVywz0b-BhkvdRT8Uc_buvCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] Fwd: [Interop-dev] Web-based Visualisation Tool
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Steve Song <steve@villagetelco.org>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, nodewatcher@wlan-si.net, Corey Wallis <corey@servalproject.org>, interop-dev@lists.funkfeuer.at

Re-added several people dropped from CC, sorry

---------- Forwarded message ----------
From: Gui Iribarren <gui@altermundi.net>
Date: Fri, Nov 16, 2012 at 10:02 PM
Subject: Re: [Interop-dev] Web-based Visualisation Tool
To: interop-dev@lists.funkfeuer.at
>
>
> Hi,
>
> a precisation about nodeshot. Nodeshot does not really require the
> info about batman to be in an OLSR like format. It's just that the
> guys were lazy and outputted the topology data in an OLSR-like format
> because they didn't want to spend extra time developing another cron
> script that used another strategy.
> But it really only depends from a script that runs in a cronjob, so
> everyone can (and should with the current version) make its own
> script, infact some people in the US are working to make it work with
> another new thing called CJDNS (i don't know much about it). In the
> future version the approach will most likely be slightly different.
>
> Regarding the other things, I read a great deal of information about
> Javascript MVC frameworks, RESTful APIs and NoSQL databases. I think
> we're kinda heading in the same direction but with different
> strategies. It is good that we keep doing so, this way someone will
> surely get it right.
>
> My only worry is that some of these solutions are quite new in the
> web-dev world so they should be approached with caution.
>
> The idea of having a copy of the nodes locally is really cool.
>
> It would be good to make it possible for different Node DB apps to
> communicate to one another through some JSON Api. So +1 for having
> thought about that, if you didn't know we have been talking about it
> for quite a while.

> But i warn you, if we don't manage to lower our
> egos and agree to some compromises we'll risk to end up again with
> nothing done.

I agree, and apologize for the tone in my original email: I could have
used much less hype; thanks a lot for the comprehension!

>
> I think it's great you're experimenting with these solutions, please
> keep us updated and show us something working online when you have it
> ready.

Well, our idea was doing it the other way round :) first get an idea
of current interoperability efforts of existing solutions, and then
start to code

after the insightful discussions that went through the relevant
threads, Nico came up with a working PoC (no auth or security at all
yet, but draws nodes and links in realtime).

http://tilc.red.quintanalibre.org.ar:5984/altermap/_design/altermap/index.html

(it's ipv6 only)

It's been running since.. today! so bugs and erratic behaviour is expected.

It might be difficult to notice (given the stability of links) but all
links are redrawn when updated. I was quite impressed to see a link
blink at my browser, the moment a router sent its update.

Cheers!

Gui
