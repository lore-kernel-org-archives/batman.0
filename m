Message-ID: <3338.85.41.146.90.1187986937.squirrel@krisma.oltrelinux.com>
In-Reply-To: <a934d3f30708241122h4031e67di927d5523caaf5db1@mail.gmail.com>
References: <38331.85.41.146.90.1187693478.squirrel@krisma.oltrelinux.com>
	<46CF07B9.8060903@bb.banban.jp>
	<46faed20708241035n595ebaas4e45df35c3dfdff5@mail.gmail.com>
	<a934d3f30708241122h4031e67di927d5523caaf5db1@mail.gmail.com>
Date: Fri, 24 Aug 2007 22:22:17 +0200 (CEST)
Subject: Re: [B.A.T.M.A.N.] robin
From: a.anselmi@oltrelinux.com
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

The ESSID ROBIN_mac/ip is only for the public hotspotting, ROBIN works on
pseudo-IBSS mode (adhemo) without beacons (invisible), so mesh ESSID is
not necessary.

--
Antonio

> I tried ROBIN on the Meraki nodes i have,must say it really looks
> promising.
> Truly 0-config without the need of a central server this is plug-n play :)
>
> I was wondering why dont you use the same essid as ROBIN instead of the
> ROBIN_mac/ip.
> This would make a mesh repeater network and would completely emulate
> meraki.
>
> Thanks and
> Regards,
> Vinay
>
> On 8/24/07, Steven Leeman <steven@leeman.be> wrote:
>>
>> Ive allready got a  5Node fonera robin mesh and 8others are waiting to
>> be installed; first a vis-server;and the most recent updates
>>
>> 2007/8/24, Lemonde <zukky@bb.banban.jp>:
>> > Hi, all. Hi, Antonio.
>> >
>> > I've made up two ROBIN nodes on LaFoneras.
>> > They works quite well.
>> >
>> > ---node.A as gateway---
>> > root@OpenWrt:~# /sbin/brn -h
>> > usage /sbin/brn
>> >  -a : shows batmand -d 1
>> >  -b : shows neighbors
>> >  -d : shows non-direct neighbors
>> >  -g : shows: OGs using NBs with non-direct GWs
>> >  -v : shows all
>> >  -l : loop every 2 seconds
>> >  -h : shows help
>> >
>> > root@OpenWrt:~# /sbin/brn -v
>> > All Originators:
>> > 6.16.66.32           6.16.66.32 (128):      6.16.66.32 (128)
>> > NBs:
>> > 6.16.66.32           6.16.66.32 (128):      6.16.66.32 (128)
>> > NBs with non-direct GWs:
>> > OGs using NBs with non-direct GWs:
>> > root@OpenWrt:~#
>> > -------------------------
>> >
>> > ---node.B as node------
>> > root@OpenWrt:~# /sbin/brn -v
>> > All Originators:
>> > 6.16.62.172         6.16.62.172 (126):     6.16.62.172 (126)
>> > NBs:
>> > 6.16.62.172         6.16.62.172 (126):     6.16.62.172 (126)
>> > NBs with non-direct GWs:
>> > OGs using NBs with non-direct GWs:
>> > root@OpenWrt:~#
>> > -------------------------
>> >
>> > ROBIN is so 0-config that I can't understand how it woks. :-)
>> >
>> > regards,
>> >
>> > zukky
>> >
>> > P.S.
>> > Antonio, your documents are so nice.
>> >
>> >
>> > > Hi,
>> > >
>> > > I'm using BATMAN routing algorithm on an kamikaze based firwmare,
>> > > realizing ROBIN (Routing Batman Inside) MESH: a 0-config, QoS
>> capable
>> mesh
>> > > software which targets Atheros AP51 devices such as Meraki Mini or
>> Fonera.
>> > >
>> > _______________________________________________
>> > B.A.T.M.A.N mailing list
>> > B.A.T.M.A.N@open-mesh.net
>> > https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>> >
>> _______________________________________________
>> B.A.T.M.A.N mailing list
>> B.A.T.M.A.N@open-mesh.net
>> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>>
>
>
>
> --
> Vinay Menon
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>


