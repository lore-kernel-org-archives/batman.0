Return-Path: <gbastien@versatic.net>
MIME-version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Message-id: <4FE4BF45.3050705@versatic.net>
Date: Fri, 22 Jun 2012 14:53:57 -0400
From: =?ISO-8859-1?Q?Genevi=E8ve_Bastien?= <gbastien@versatic.net>
References: <4FE1350E.9040807@versatic.net>
	<201206211028.18281.lindner_marek@yahoo.de>
	<4FE3DA9B.9040401@versatic.net>
	<4FE3E069.1090309@universe-factory.net>
In-reply-to: <4FE3E069.1090309@universe-factory.net>
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

Wow!  It works!  I just added the line
option 'type' 'bridge'
to my mesh1 interface and my whole mesh is now working.  Thanks!

Was that documented somewhere?  It gave me quite a headache for such a=20
simple solution.

Thanks,
Genevi=E8ve


On 12-06-21 11:03 PM, Matthias Schiffer wrote:
> Hi,
> it might be your VLAN configuration - as far as I know, 0 is not a valid
> VLAN id.
>
> But I also found that batman-adv doesn't work on VLAN interfaces on my
> OpenWRT routers. As a workaround you can create a new bridge that only
> contains the VLAN interface and add the bridge to bat0 instead.
>
> Regards,
> Matthias
>
>
> On 06/22/2012 04:38 AM, Genevi=E8ve Bastien wrote:
>> Hi,
>>
>> On 12-06-21 04:28 AM, Marek Lindner wrote:
>>> Hi,
>>>
>>>> I talked to marec last week on irc (I'm tahini).  I have a linksys
>>>> router that runs batman on the eth0 interface and other routers or
>>>> laptops are connected to it.  Problem is, even though the batman packe=
ts
>>>> pass from the other machines to the linksys, it seems something weird
>>>> happens on the linksys and the interface is not recognized as a batman
>>>> neighbor.
>>> the problem is that leon does not receive any packets from its
>>> neighbors. Its
>>> log only repeatedly states "Sending own packet" but no information about
>>> incoming packets is printed. If you compare it with the other logs you
>>> will
>>> see what I mean.
>> But doesn't the 'batctl td eth0' output show it receives the packets
>> from the neighbors?  What happens to those packets?
>>
>>> A common mistake leading to this symptom is a bridge misconfiguration.
>>> Is eth0
>>> on leon part of a bridge ?
>> No, the bat0 interface is on the bridge, but eth0 is a vlan, I think.
>> Maybe it is a vlan misconfiguration?
>> Attached are some outputs and config files from leon.  What other
>> commands should I look for to help find the problem?
>>
>> Thanks,
>> Genevi=E8ve
>
>

