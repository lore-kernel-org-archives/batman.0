Return-Path: <hw@haveyouseenthiscat.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 17 Jun 2015 23:33:02 +0200
From: Hans-Werner Hilse <hw@haveyouseenthiscat.de>
In-Reply-To: <CALaFpeV+fto4F2iNFZT=VXdX9ZdK-XfyP2Kpyv++eFCBiS0FuA@mail.gmail.com>
References: <CALaFpeXinpuqi_5tZoih9jm77Ed0WsP_soZm3RbTpOmpzqWPSg@mail.gmail.com>
 <ba0c1c011cd6fb42c76276ec510c9acc@hilses.de>
 <CALaFpeV+fto4F2iNFZT=VXdX9ZdK-XfyP2Kpyv++eFCBiS0FuA@mail.gmail.com>
Message-ID: <813bd8ec467de7c4e3a5283962d1d73b@hilses.de>
Subject: Re: [B.A.T.M.A.N.] [BATMAN] batman-adv PING layer 3
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi,

Am 2015-06-17 23:09, schrieb Carlos Meralto:
> 2015-06-17 21:34 GMT+01:00 Hans-Werner Hilse 
> <hw@haveyouseenthiscat.de>:
>> a batman interface is being set up, but left unconfigured.
> 
> Why you say that has not been configured?

Because you configure the adhoc network, but a setup for bat0 is nowhere 
to be seen. Yes, bat0 is set as the mesh network on the adhoc net. But 
this is *not* the same as a config for bat0. Setting up mesh networking 
on adhoc will leave the adhoc net in place and does not change anything 
about that. There only is an additional interface that will use the 
adhoc network, too.

So - why do you think it has been configured? I'm just guessing above.

> What I want is to have an IP that allows me to ping from node A to
> node C. So join adhoc0 the bridge?

If you really just want to ping from A to C (which I find a use case 
that sound more academic than practical), it is enough to configure an 
address for bat0. Or, as I said, use IPv6, which does link-level 
autoconfig on bat0.

If however you want to use this to bridge things attached to the LAN 
interface of the devices, I advise to attach it to the bridge (except if 
this creates a loop - you said nothing about the topology outside the 
devices).

-hwh
