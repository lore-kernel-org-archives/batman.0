Return-Path: <hexiled@nixbits.net>
Message-ID: <50076418.80907@nixbits.net>
Date: Wed, 18 Jul 2012 21:34:16 -0400
From: HeXiLeD <hexiled@nixbits.net>
MIME-Version: 1.0
References: <50076056.4050907@versatic.net>
In-Reply-To: <50076056.4050907@versatic.net>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] Internet gateway or not: dhcp or static ip?
Reply-To: HeXileD@nixbits.net,
 The list for a Better Approach To Mobile Ad-hoc Networking
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

Have you tried to set every node with static ip but also providing dhcp 
server to a range of ips ?
For example: node 1 from 192.168.1.1 to 192.168.1.10 then node 2: 
192.168.1.11 to 192.168.1.20 and so on.

On 07/18/2012 09:18 PM, Geneviève Bastien wrote:
> Hi!
>
> I had a chat the other day on IRC about how to assign ip addresses
> whether there is an internet gateway available or not.
>
> Here is the problem and the solution I came up with. Let me know if that
> makes sense or if I'm complicating my life.
>
> * Problem *
>
> Our network is still small, there may or may not be an internet gateway
> available on it, it doesn't matter. From what I read here
> http://www.open-mesh.org/projects/batman-adv/wiki/Gateways for nodes to
> have access to the internet, the internet gateway has to be a dhcp server.
>
> The node requests an ip by dhcp and then knows what the default route
> is. But if the gateway disappears, there is no more dhcp server, the
> nodes do not have ip addresses and the mesh network is about useless.
>
> But if I set nodes with static ips, then the mesh is routable all the
> time, but nodes do not know the default route to reach the internet.
>
> Am I right so far?
>
> * Solution *
>
> Someone on irc pointed me out to this page:
> http://www.open-mesh.org/projects/batman-adv/wiki/Uevent
> I use this uevent to send a dhcp request if a gateway becomes available
> or go back to a static ip if all gateways are gone.
>
> Attached is the hotplug script I use. It is in
> /etc/hotplug.d/net/99-batman-adv-gw. It supposes the interface is
> configured by default with a static ip.
>
> It works perfectly, but I can't believe there is no simpler solution to
> this. Our problem should be a quite common one. What is the general
> solution to it?
>
> Thanks,
> Geneviève
