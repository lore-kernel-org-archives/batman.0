Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 11 Aug 2014 23:38:20 +0200
Message-ID: <1463029.4iWUHdE7x7@prime>
In-Reply-To: <CAA51LVr2ogEGnJNCepYRm2eAZvE_TpPFTeLf6BXkVpjyFfHSFg@mail.gmail.com>
References: <CAA51LVr2ogEGnJNCepYRm2eAZvE_TpPFTeLf6BXkVpjyFfHSFg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [B.A.T.M.A.N.] Testing example of interface bonding
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hello Ray,

thanks a lot for your mail.

On Sunday 10 August 2014 15:00:51 Ray Gibson wrote:
> Hello,
> 
> Are there any documented cases (aside from the aging graph on the
> wiki) on batman-adv bonding setups?

Not as far as I know. The bonding feature does not seem to be the most popular 
one. :) (If there is anyone, please tell us!)

> 
> I'm testing batman-adv 2014.3.0 in an effort to experiment and test
> with multi-link optimizations.  There is no wifi in the picture at the
> moment, this is being done with tap interfaces right now.
> 
> My two nodes have this network config:
> lan0: bridge of eth0 and bat0, 192.168.100.1 on node1, 192.168.100.2 on
> node2 bat0: includes tap0 and tap1 active, no IP.
> eth1: "wan" link, 10.10.10.1 on node1, 10.10.10.2 on node2
> tap0/1: openvpn bridge links over eth1, no IPs assigned to these interfaces.
> 
> This is a VMware environment for testing.  With the above setup, I can
> ping/iperf/whatever back and forth on the 192.168.100.x network.  It
> works great just extending a lan transparently on a wan link.  This
> was the original idea, with redundant connections (hence the multi tap
> interfaces).
> 
> Now, I'm trying to isolate the test down to bonding.  However,
> enabling bonding in batctl on both nodes has no apparent effect
> whatsoever.  Watching an iperf session in ifstat, I will see constant
> traffic on bat0, and then either tap0 or tap1 depending on how it's
> feeling at the time.  Sometimes it will shift all the traffic to the
> other tap interface.  Sometimes the incoming traffic will be on one
> interface and the outgoing traffic will be on the other.
> 
> Note: I'm running iperf/etc on the nodes themselves, not on separate
> devices on the lan bridge.

Hmm. What you should see after enabling bonding would be a similar usage of 
both interfaces. I guess each tap interfaces of node1 is "directly connected" 
to  the other tap interface of node2, right? Could you please share your 
outputs of:

batctl originators
batctl originators -i tap0
batctl originators -i tap1

> 
> Ultimately I am looking to try bonding several 3G or 4G devices
> together with batman-adv to achieve higher throughput to a single
> destination.

Please note that the bonding will only benefit under some circumstances, as far 
as my experiments have shown:

 * since its round robin, you'll only see a benefit if the worst link does not 
have less than 50% throughput of the best one - otherwise it will slow the 
other links down.
 * different latencies or buffering delays in the links may lead to out of order 
packets, and not every payload traffic likes that.

I could see some improvement when having two equal wifi links though. In any 
case, please thoroughly test it before applying that to your 3g/4g 
application, there may be some pitfalls. I'd be also very interested in your 
findings. :)

Thanks,
    Simon
