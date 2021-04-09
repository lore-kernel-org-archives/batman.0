Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
References: <CAEX-Y1Z8vHvj_TD-EL-Y9AiSeKV9WHb=BxJMwJx0h5z0xfk5OA@mail.gmail.com>
 <20210406195122.GG2742@otheros> <CAEX-Y1YfhoLgcwMJAg11H7f785kum6LUrYq=YrKg0C-9vXZ-ZQ@mail.gmail.com>
 <20210409112432.GJ2742@otheros>
In-Reply-To: <20210409112432.GJ2742@otheros>
From: Andi Depressivum <andidepressivum@gmail.com>
Date: Fri, 9 Apr 2021 15:38:15 +0200
Message-ID: <CAEX-Y1ZnouWOpjrT4n8q4BVaRWSP30GLMbT_78Kn3_KoFELp9g@mail.gmail.com>
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

> The MTU of eth0.2 or bat0?

It doesn't matter, I cannot set the MTU of eth0.2, eth0 or eth1 to
something higher than 1500

> One of the performance penalties might occur when batman-adv needs
> to use fragmentation. batman-adv is going to add its own header
> on top of the 1500 byte frames received on bat0.

That's why I'm trying to increase the MTU

> 1536 on eth0.2 looks good though. Then 1500 bytes should fit
> without fragmentation on bat0. You can check with "batctl
> td" or Wireshark if you see batman-adv fragments on eth0.2.

That's only the config. IP LINK still showing 1500.

> If 1536 is somehow not applied to eth0.2, might be a driver issue
> then. You can check wether you can manually alter an interface MTU
> with "ip link dev eth0.2 set mtu 1536", for instance.

Actual OpenWRT trunk on TP-Link C7 / C2600 devices. Can decrease to
anything lower than 1500 but cannot raise above 1500.

Thanks,
Andi
