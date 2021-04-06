Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
References: <CAEX-Y1Z8vHvj_TD-EL-Y9AiSeKV9WHb=BxJMwJx0h5z0xfk5OA@mail.gmail.com>
 <20210406195122.GG2742@otheros>
In-Reply-To: <20210406195122.GG2742@otheros>
From: Andi Depressivum <andidepressivum@gmail.com>
Date: Tue, 6 Apr 2021 23:33:26 +0200
Message-ID: <CAEX-Y1YfhoLgcwMJAg11H7f785kum6LUrYq=YrKg0C-9vXZ-ZQ@mail.gmail.com>
Subject: Re: How to mesh over ethernet VLAN?
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

> Right, that is not supported. That goes in the direction of
> creating an encapsulating loop. It's best to avoid sharing a link for both
> the payload frames and the mesh layer.

You're right, I've missed the encapsulation loop when thinking about it

> One option could be to add an extra VLAN, like VLAN 4, dedicated
> for the mesh layer with the batman-adv frames, parallel to the
> VLAN 3.

That's the way I've configured it before thinking about VLAN-sharing.
Works as expected except the virtual interface for the mesh link needs
a different MAC address to the payload interfaces.

> Or if most/all hosts are running batman-adv, so if architecturally
> batman-adv is forming the backbone of your network, you could
> run batman-adv over this VLAN 3 only. And then either run
> batman-adv on the servers themselves or bridge the servers into the
> batman-adv mesh on their adjacent mesh router(s).

That was my very first configuration approach but it's rather slow
(about 200mbit/s over a gigabit link) compared to native VLANs. I've
tried to set the MTU size to 1536 for the mesh interface but for some
reason the MTU of the interface stays at 1500?!

config interface 'mesh_lan'
        option mtu '1536'
        option proto 'batadv_hardif'
        option master 'bat0'
        option ifname 'eth0.2'
        option macaddr 'f4:f1:6d:37:b6:85'
        option hop_penalty '5'

Kind regards, Andi
