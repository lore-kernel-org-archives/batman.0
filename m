Return-Path: <gtolon@inti.gob.ar>
Message-ID: <51AD0277.1060907@inti.gob.ar>
Date: Mon, 03 Jun 2013 17:54:15 -0300
From: =?UTF-8?B?R2FicmllbCBUb2zDs24=?= <gtolon@inti.gob.ar>
MIME-Version: 1.0
References: <51A3C7E9.7080208@inti.gob.ar>
 <20130528070057.GC3333@ritirata.org> <51ACBCE4.8000506@inti.gob.ar>
 <20130603160813.GC1226@ritirata.org>
In-Reply-To: <20130603160813.GC1226@ritirata.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] batctl bw performance
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
To: Antonio Quartulli <ordex@autistici.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi Antonio,


El 03/06/13 13:08, Antonio Quartulli escribió:
> Hello Gabriel,
>
> first of all thank you very much for testing the bw meter :-)
> answers follow inline.

You're welcome, I think it's an interesting idea.

>
> On Mon, Jun 03, 2013 at 12:57:24PM -0300, Gabriel Tolón wrote:
>>     Hi Antonio,
>>
>>     As you suggested, I've tested the bandwidth meter with batman-adv-devel
>>     38a1b72. I've installed it on two TP-Link WDR-3500 routers.
>>
>
> oky. However, since the bw_meter has not been merged yet, its branch changes
> from time to time because it gets rebased on top of the very latest development
> code. Therefore, when you decide to update your testbed, I'd suggest you to look
> at: http://git.open-mesh.org/batman-adv.git/shortlog/refs/heads/ordex/bw_meter
> and pick the commit ID of the last patch at the top.
>
> If you have problems in doing this, please ask.

I don't understand what commit ids should I use. For example, how could 
I find the ones you suggested me before for batman (38a1b72b6) and for 
batctl (eebba0bfb). Because on the top of the git I see for example the 
commit d672369c3476f002662fa7e83b76ee56a93a76db for "batman-adv: set 
maximum number of BW session", which seems in a different format, right?

>
>>     Running normal iperf inside the routers, and without unloading any kernel
>>     module, I get 60 Mbps using UDP, 80 Mbps using TCP (I don't understand why
>>     TCP works better), and about 4 Mbps with batctl bw -t 10000. Any ideas? By
>>     the way, the batctl ping between routers doesn't  work, I get time-out.
>>     Besides, there's another strange behaviour, when I try to pass traffic
>>     from a PC client connected to one router, to the other router using iperf,
>>     if I use UDP values of about 100 Mbps, the router that receives the
>>     traffic and redirects it, reboots. Thanks.
>>
>
> Ok..well, first of all I'd rather check what is wrong in the mesh. If batctl
> ping does not work, then it means that there is something else which is not
> working/configured properly.

Yes, it's weird, specially because there's connectivity between routers 
thanks to batman-adv.

>
> For this reason I'll first suggest you to update to this commit id: d672369 .
> Then, does "batctl o" properly shows the other node with a "reasonable TQ"?

So, in menuconfig I should select that id for batman-adv-devel right? I 
wanted to see that  commit on the git page using the search field but I 
couldn't. By the way, how to know which batctl version use with each 
batman-adv-devel commit? Sorry if all these questions are too basic, but 
I've tried to compile with this d672369 version and I got some errors, 
so I'd like to understand if it was related to these things.

>
>
> By the way, your iperf tests have been done on top of batman-adv? or directly on
> the wifi interface?
>
> Cheers,
>

I got the results mentioned using interfaces managed by batman-adv.

Regards

Gabriel
