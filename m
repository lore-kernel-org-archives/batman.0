Return-Path: <rbates@freewave.com>
From: Robert Bates <rbates@freewave.com>
Date: Fri, 5 Jan 2018 01:16:32 +0000
Message-ID: <e4bb792ab8264961a4ecb1921abd4cca@MB82.inbox01.com>
References: <08d40a5302ac411895c49cf6b7e17d5b@MB82.inbox01.com>
 <1824062.p4cHhaC8Qk@prime>
In-Reply-To: <1824062.p4cHhaC8Qk@prime>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Can b.a.t.m.a.n. be configured to ARP for
 unknown clients?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>, "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

Hi Simon,

Thanks for the reply.  I'd already proposed changing the timer value to my =
team (e.g., to 1 hour), and we're likely going to get that done (again, we =
license this product from another developer, and don't even have direct acc=
ess to the code under our current arrangement).  I agree that it seems to b=
e the most straight-forward solution, but others in the team feel that the =
desired fix will involve either some type of "ARP if unknown", or timer-bas=
ed ARP mechanism on the part of some other component/piece of software.  I =
like your idea of periodically reading tt_local and pinging the clients.  I=
'm going to bring that up when we have the next in-person discussion about =
a fix (a few people are still out on holiday vacation).  I like the fact th=
at with that approach, the additional traffic introduced is only toward loc=
ally connected clients, and not over the mesh.  Each node is doing this wit=
h its locally connected clients, circumventing timeout and removal.  I like=
 it.  You mentioned some potential pitfalls.  We will talk through what tho=
se might look like in our customer environments, but my sense is that there=
 is no significant downside.  I could wrong.

Thanks again.

Robert



-----Original Message-----
From: Simon Wunderlich [mailto:sw@simonwunderlich.de]
Sent: Sunday, December 31, 2017 6:19 AM
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Robert Bates <rbates@freewave.com>
Subject: Re: [B.A.T.M.A.N.] Can b.a.t.m.a.n. be configured to ARP for unkno=
wn clients?

On Friday, December 29, 2017 5:01:23 PM CET Robert Bates wrote:
> Hello,
>
> Is it possible to have b.a.t.m.a.n. ARP if packets are received at
> bat0 for a client which has been removed/deleted due to timeout, and
> is therefore no longer in the translation tables?
>
> In one customer application of a product of ours (a mesh AP we've
> licensed from another vendor/developer, which is based on
> openWRT/b.a.t.m.a.n.), we are being adversely affected by the 10 minute i=
nactivity timer on
> transtable_local.   The clients in this customer's network/application ar=
e
> stationary devices which basically do not speak unless spoken to (e.g.
> when they are polled for data).  They are periodically polled by a
> management platform, using an upper layer protocol running over TCP.
> The problem is that this customer's polling cycle time is variable,
> and occasionally it is taking longer than 10 minutes between
> successive polls of a given client/device.  When this happens, that
> client is of course removed from transtable_local, and transtable_global =
on the other nodes in the mesh.
> Meanwhile, the polling/management platform has a very long ARP cache
> life, so it never ARPs (and apparently it is not possible on this
> platform to have the customer implement dynamic, rather than static
> ARP table entries, in which it would ARP upon polling failure).  So
> once we get into this state, polls to this client device which has
> dropped out of the mesh are not possible, and their management
> platform throws alarms, etc.  To bring it back in service at that
> point requires an ARP, which the customer is manually triggering with a p=
ing, whenever one of these "outages" occurs.
>
> We know that the transtable_local inactivity/removal timer value can
> be extended, and we will probably do that, but we would also like to
> know if it is possible to have b.a.t.m.a.n. ARP for the removed client
> in this case.  We prefer this approach, rather than arbitrarily
> changing the tt_local timer to some value which may not work well in
> some other customer's network/application.  I know that there is a
> statistically valid underlying assumption with this 10 minute
> inactivity timer on transtable_local, that clients will typically be
> "chatty".  But again, that is not the case in this application, which
> is a very common one in the industry in which we operate, where
> clients are very often fixed devices which only respond to explicit
> queries or commands.  This is a new product and protocol for us, and
> this could beg the question of whether or not b.a.t.man.-based meshing is=
 the right solution in this type of application.
>  We believe it can be; it would just be helpful if we can configure it
> to ARP in this type of scenario.
>
> Can you please comment on how this might be possible (config or otherwise=
)?

Hi Robert,

batman-adv does not ARP on its own, so there is no way to configure this.

You should either increase the timer from 10 minutes to something (reasonab=
ly) high, or have another program sending some frames to refresh the ARP on=
 behalf of the client - e.g. every 5 minutes, read the transtable local, se=
nd a packet for each MAC. However, in my opinion, this is just a more round=
-abot way with possibly more pitfalls on its own.

A general way to handle this would be to send those unicasts unknown to bat=
man-adv  as broadcasts. However, this would be problematic for networks wit=
h big broadcasts domains which already suffer from too high broadcast load,=
 but have a sane ARP mechanism in place otherwise.

So long story short, increasing the timeout seems to be the most easy and e=
ffective solution to me.

Cheers,
     Simon
IMPORTANT NOTICE:  This communication, including any attachments, is the pr=
operty of FreeWave Technologies, Inc. and may contain proprietary, confiden=
tial, or privileged information. Unauthorized use or disclosure of this com=
munication is strictly prohibited and may be unlawful. Information containe=
d herein may be subject to a Proprietary Information / Non-Disclosure Agree=
ment and shall be maintained in confidence and not disclosed to third parti=
es without the written consent of FreeWave Technologies, Inc. If you have r=
eceived this communication in error, please immediately notify the sender a=
nd destroy all copies of the communication and any attachments.
