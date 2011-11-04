Return-Path: <gmazzurco89@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOaDhSR2SQUp4gj-05e0eFLGT8US_BY=yVE92GkH-h8YUPxjMw@mail.gmail.com>
References: <CAOaDhSSVMx1eN1G5rZ6-zh8Kh8xoddUOiQ0ua4StaX5bLHVQ7w@mail.gmail.com>
	<201110311048.50063.lindner_marek@yahoo.de>
	<201111041047.52997.lindner_marek@yahoo.de>
	<CAOaDhSR2SQUp4gj-05e0eFLGT8US_BY=yVE92GkH-h8YUPxjMw@mail.gmail.com>
Date: Fri, 4 Nov 2011 11:06:25 +0100
Message-ID: <CAOaDhSR_ipC3d0DVX7P4q6SbRKwSq-0_0oQSQGWe=8MwPX4WLA@mail.gmail.com>
From: Gioacchino Mazzurco <gmazzurco89@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] batman miss crc16 module after nico commit
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

2011.2.0

2011/11/4 Gioacchino Mazzurco <gmazzurco89@gmail.com>:
> ho good notice but before that backfire and trunk shared the packages rep=
o
>
> what is the version of batman-adv on the backfire packages branch ?
>
> 2011/11/4 Marek Lindner <lindner_marek@yahoo.de>:
>> On Monday, October 31, 2011 10:48:49 Marek Lindner wrote:
>>> > https://dev.openwrt.org/changeset/28657/packages/net/batman-adv/Makef=
ile
>>>
>>> the OpenWrt developers have renamed the package dependency. Unless you =
are
>>> using the OpenWrt trunk after revision 28656 the package dependency
>>> selection =A0won't work anymore.
>>>
>>> Maybe you should ask them about their concept of backward compatibility=
.
>>
>> I have to roll back here. You are using backfire while grabbing the pack=
ages
>> from trunk. You are not supposed to do that. There is a specific backfir=
e
>> branch maintained by the OpenWrt developers which is kept compatible (I =
wasn't
>> aware of that).
>>
>> If you mix backfire and trunk you have to deal with the consequences you=
rself.
>>
>> Regards,
>> Marek
>>
>
