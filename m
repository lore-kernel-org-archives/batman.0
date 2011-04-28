Return-Path: <gmazzurco89@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20110428174503.GI1515@ritirata.org>
References: <1303940106-1457-1-git-send-email-ordex@autistici.org>
	<1303940106-1457-3-git-send-email-ordex@autistici.org>
	<20110428161031.GB4240@lunn.ch>
	<201104281934.30252.lindner_marek@yahoo.de>
	<20110428174503.GI1515@ritirata.org>
Date: Thu, 28 Apr 2011 19:46:25 +0200
Message-ID: <BANLkTimhkdPy7wD_bDhiNCe_6dcThZ9PVQ@mail.gmail.com>
From: Gioacchino Mazzurco <gmazzurco89@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: improved client
 announcement mechanism
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

>In my opinion it would not be so bad to include this dependency as the
>crc16 module provides this function only and no more.

+1

2011/4/28 Antonio Quartulli <ordex@autistici.org>:
> On Thu, Apr 28, 2011 at 07:34:29PM +0200, Marek Lindner wrote:
>> On Thursday 28 April 2011 18:10:31 Andrew Lunn wrote:
>> > Shouldn't this dependency be listed in the Kconfig file? I think you
>> > need to add
>> >
>> > select CRC16
>>
>> Actually, the question is whether it is a wise move to introduce this
>> dependency just for that function or whether somebody has an idea how to avoid
>> it. Obviously, copying this function into our module won't be accepted by the
>> kernel developers.
>>
>
> In my opinion it would not be so bad to include this dependency as the
> crc16 module provides this function only and no more.
> By the way any idea is welcome!
>
> --
> Antonio Quartulli
>
> ..each of us alone is worth nothing..
> Ernesto "Che" Guevara
>
