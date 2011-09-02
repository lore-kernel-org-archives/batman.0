Return-Path: <tonyputi@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFevQmNDWyoA2PnhkRUDXV44r-LreLbjgCj=dqEggvyUbaKE1g@mail.gmail.com>
References: <CAFevQmNDWyoA2PnhkRUDXV44r-LreLbjgCj=dqEggvyUbaKE1g@mail.gmail.com>
From: Filippo Sallemi <tonyputi@gmail.com>
Date: Fri, 2 Sep 2011 13:09:44 +0200
Message-ID: <CAFevQmPHjkJqXSrFS5PHbOU3wmCMm5OLLDpyrBF_tvRLz+5r1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] batman-adv and coovachilli
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi all,
I've a little problem and i need a confirm from you.

I have 2 mesh node (gateway) with this configuration:
lan is a bridge with bat0 and wlan0 with node1 ip 10.0.1.1 netmask
255.0.0.0 and node2 ip 10.0.2.1 netmask 255.0.0.0
wan : eth0
msh : wlan1

and 3 mesh gatway (client) whit this configuration
lan is a bridge with eth0 bat0 and wlan1 with dhcp
msh is wlan1

on each gateway nodes run an istance of coovachilli that create new
interface tun0 ahead br-lan and when coovachilli start deconfig br-lan
and assign the ip of br-lan to tun0.
all other node are simple client.

Now the problem is that when coovachilli is not running i'm able to
ping node1 from node2 and viceversa but when coovachilli is running
i'm unable to comunicate with other node with ip addres not in the
same subnet.
I think that the problem is tun0 interface that block all traffic o
something. I have tried to use tap device but the problem is not
resolved.

Suggest?

--
Filippo Sallemi
