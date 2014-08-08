Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 8 Aug 2014 16:06:00 +0200
References: <1407007130-23077-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <1407007130-23077-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201408081606.01045.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] Enhancements for Unsolicited Neigh. Adv. / grat
	ARP Reply
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

Hello Linus,

thank you very much for the patch proposal.

> Hi there,
> 
> Here's a little, rough patch to illustrate the idea we discussed a little
> at the last Wireless Battle Mesh, that is forwarding the noisy IPv6
> Unsolicited Neighbor Advertisements and gratuitous ARP Replies via unicast.
> 
> Currently these ugly unsol. NAs cause about 40% of ICMPv6 multicast
> overhead in our networks here.

I think it's quite a good idea - to motivate your proposal, I'd suggest to add 
some information on how many broadcasts you think you can save in your 
networks - 40% of ICMPv6 traffic is a little vague, since we don't know how 
much of your traffic is ICMPv6 and what you have already blocked.

> 
> A little more detailed explanation with some pictures can be found here:
> 
> https://www.open-mesh.org/projects/batman-adv/wiki/Unicasting-unsolicited-n
> eighbor-advertisements

Nice page. :)

> 
> In the few, simple scenarios with bridged-in hosts in VMs, the patch
> seemed to do what it was supposed to do uppon roaming. Unsol. NAs did only
> appear on the node the host roamed away from.
> 
> If I remember correctly, there were also some worries about how this
> might work together with BLA-II. I gave it a little more thought and
> had a look at the BLA-II source code, but couldn't find any issues.

I don't see any issues either - as you've implemented, it should be similarly 
working as the DHCP requests from client.

> 
> The only BLA-II related non-ideal thing I could think of so far is
> noted in the code of this patch at the according place (but I think
> that might not matter much in practice).

You describe that this feature could be used for hot-swapping, and as far as I 
understand, turning on that feature could break IPv6 hotswapping? I don't know 
how much this is actually used and its probably not the most common thing for 
our networks (and isn't reliable anyway), but you should make you feature 
optional with a sysfs option or similar. Then users or firmware engineers can 
turn that feature on as required, just as BLA and others. 

Thanks,
     Simon
