Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <50076056.4050907@versatic.net>
References: <50076056.4050907@versatic.net>
From: Guido Iribarren <guidoiribarren@buenosaireslibre.org>
Date: Wed, 18 Jul 2012 22:35:45 -0300
Message-ID: <CAHD-aqL+YW5Kk1LiUsLnpG07QDmQPgw5CsEoTZ++sMxzAdTH4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Internet gateway or not: dhcp or static ip?
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

Another stab at this, which solves a slightly different scenario:

https://bitbucket.org/guidoi/batmesh/raw/ee7042b01ebe/packages/batman-adv-a=
uto-gw-mode/files/etc/hotplug.d/net/99-batman-gw

This makes no assumptions about the interface (static or dhcp), but
instead asks for a lease in an alias (br-lan:ipv4)

this is part of a bigger idea
https://bitbucket.org/guidoi/batmesh/src/ee7042b01ebe/packages/batman-adv-a=
uto-gw-mode/

in a nutshell: every node is initially set to gw_mode=3Dclient, with
static ip and DHCP server (through dnsmasq) offering leases.
so if a client connects to the cloud, it gets an ipv4 and has basic
connectivity with other clients (bat cloud has no internet access)

if one node has internet connection, sets gw_mode=3Dserver, (either
manually or by some magic script) , and this is recognized by other
nodes by this hotplug.d hook, which requests an ipv4 (so that routers
can do "opkg update" and sync ntp time) and at the same time kills the
local dhcp server, so that new clients get the lease from the internet
gateway dhcp.


On Wed, Jul 18, 2012 at 10:18 PM, Genevi=C3=A8ve Bastien
<gbastien@versatic.net> wrote:
> Hi!
>
> I had a chat the other day on IRC about how to assign ip addresses whethe=
r
> there is an internet gateway available or not.
>
> Here is the problem and the solution I came up with.  Let me know if that
> makes sense or if I'm complicating my life.
>
> * Problem *
>
> Our network is still small, there may or may not be an internet gateway
> available on it, it doesn't matter.  From what I read here
> http://www.open-mesh.org/projects/batman-adv/wiki/Gateways for nodes to h=
ave
> access to the internet, the internet gateway has to be a dhcp server.
>
> The node requests an ip by dhcp and then knows what the default route is.
> But if the gateway disappears, there is no more dhcp server, the nodes do
> not have ip addresses and the mesh network is about useless.
>
> But if I set nodes with static ips, then the mesh is routable all the tim=
e,
> but nodes do not know the default route to reach the internet.
>
> Am I right so far?
>
> * Solution *
>
> Someone on irc pointed me out to this page:
> http://www.open-mesh.org/projects/batman-adv/wiki/Uevent
> I use this uevent to send a dhcp request if a gateway becomes available o=
r
> go back to a static ip if all gateways are gone.
>
> Attached is the hotplug script I use.  It is in
> /etc/hotplug.d/net/99-batman-adv-gw.  It supposes the interface is
> configured by default with a static ip.
>
> It works perfectly, but I can't believe there is no simpler solution to
> this.  Our problem should be a quite common one.  What is the general
> solution to it?
>
> Thanks,
> Genevi=C3=A8ve
