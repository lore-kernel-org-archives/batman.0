Return-Path: <gmazzurco89@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJA-1LhC7rbmraukXR6eoa+gr1z9TnGA86qSwcs+gG=JnWtxzw@mail.gmail.com>
References: <CAJA-1LhC7rbmraukXR6eoa+gr1z9TnGA86qSwcs+gG=JnWtxzw@mail.gmail.com>
Date: Fri, 26 Aug 2011 11:58:30 +0200
Message-ID: <CAOaDhSR4M8mnZiLGoKOg_C5hEgdrbKXF720+8Vg8O3WUkYUoxQ@mail.gmail.com>
From: Gioacchino Mazzurco <gmazzurco89@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] Avahi/zeroconf on batman-adv 2011.1.0
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

you need autoipd ( auto ip daemon ) to do this

2011/8/26 Max Ip <ipmax2011@googlemail.com>:
> Hi,
>
> I have batman-adv 2011.1.0 on two machines connected via wifi in adhoc
> mode. As expected the bat0 virtual interface can be configured to set
> an ipv4 address.
>
> I used ifconfig bat0 10.42.43.1 and ifcondif bat0 10.42.43.2 on two machines.
>
> However, the documentation says that bat0 can be assigned Avahi/zeroconf.
>
> Could anyone give me an idea how to assign via Avahi/zeroconf.
>
> Max
>
