Return-Path: <gbastien@versatic.net>
MIME-version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Message-id: <4FE53344.5080508@versatic.net>
Date: Fri, 22 Jun 2012 23:08:52 -0400
From: =?ISO-8859-1?Q?Genevi=E8ve_Bastien?= <gbastien@versatic.net>
References: <4FE1350E.9040807@versatic.net>
	<4FE3E069.1090309@universe-factory.net> <4FE4BF45.3050705@versatic.net>
	<201206222108.16918.lindner_marek@yahoo.de>
In-reply-to: <201206222108.16918.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] packets not processed by batman on eth0
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
To: b.a.t.m.a.n@lists.open-mesh.org

On 12-06-22 03:08 PM, Marek Lindner wrote:
> On Friday, June 22, 2012 20:53:57 Genevi=E8ve Bastien wrote:
>> Wow!  It works!  I just added the line
>> option 'type' 'bridge'
>> to my mesh1 interface and my whole mesh is now working.  Thanks!
>>
>> Was that documented somewhere?  It gave me quite a headache for such a
>> simple solution.
> Do you mind explaining your solution in greater detail ? So far, I don't =
quite
> follow your approach.
>
> Cheers,
> Marek
As Matthias suggested, I just changed my mesh1 interface, which was just=20
using the eth0 vlan interface, to a bridged interface.  So my mesh1 is=20
now a bridge interface with only eth0 on it.  (mesh1 is the interface I=20
add to the batman-adv file.)

In my /etc/config/network file, my mesh1 interface now looks like this

config interface 'mesh1'
     option proto 'none'
     option type 'bridge'  # this line added from before, nothing else=20
changed
     option ifname 'eth0'
     option mtu '1528'

It seems batman-adv really does have a problem with vlans on openwrt. =20
Why?  I don't know...

Cheers,
Genevi=E8ve
