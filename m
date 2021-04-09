Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Date: Fri, 9 Apr 2021 13:24:32 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: How to mesh over ethernet VLAN?
Message-ID: <20210409112432.GJ2742@otheros>
References: <CAEX-Y1Z8vHvj_TD-EL-Y9AiSeKV9WHb=BxJMwJx0h5z0xfk5OA@mail.gmail.com>
 <20210406195122.GG2742@otheros>
 <CAEX-Y1YfhoLgcwMJAg11H7f785kum6LUrYq=YrKg0C-9vXZ-ZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEX-Y1YfhoLgcwMJAg11H7f785kum6LUrYq=YrKg0C-9vXZ-ZQ@mail.gmail.com>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Tue, Apr 06, 2021 at 11:33:26PM +0200, Andi Depressivum wrote:
> That was my very first configuration approach but it's rather slow
> (about 200mbit/s over a gigabit link) compared to native VLANs. I've
> tried to set the MTU size to 1536 for the mesh interface but for some
> reason the MTU of the interface stays at 1500?!

The MTU of eth0.2 or bat0?

One of the performance penalties might occur when batman-adv needs
to use fragmentation. batman-adv is going to add its own header
on top of the 1500 byte frames received on bat0.

1536 on eth0.2 looks good though. Then 1500 bytes should fit
without fragmentation on bat0. You can check with "batctl
td" or Wireshark if you see batman-adv fragments on eth0.2.

If 1536 is somehow not applied to eth0.2, might be a driver issue
then. You can check wether you can manually alter an interface MTU
with "ip link dev eth0.2 set mtu 1536", for instance.

Regards, Linus
