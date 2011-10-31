Return-Path: <gmazzurco89@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201110311048.50063.lindner_marek@yahoo.de>
References: <CAOaDhSSVMx1eN1G5rZ6-zh8Kh8xoddUOiQ0ua4StaX5bLHVQ7w@mail.gmail.com>
	<201110311048.50063.lindner_marek@yahoo.de>
Date: Mon, 31 Oct 2011 11:39:17 +0100
Message-ID: <CAOaDhSSpYGNmZVsD4vSxYLqUtfqw4wHgTt_r4pbDL_ikP96fXw@mail.gmail.com>
From: Gioacchino Mazzurco <gmazzurco89@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Marek Lindner <lindner_marek@yahoo.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Nodi Roma List <nodi-roma@ml.ninux.org>, riot-workshop@googlegroups.com

More over backfire is not an old release but the stable one, aka the
one people should use...

2011/10/31 Marek Lindner <lindner_marek@yahoo.de>:
>
> Hi,
>
>> After nico commit [0] batman-adv stopped working in openwrt backfire (
>> the crc16 modules is still kmod-crc16 in openwrt stable )
>>
>> the batman-adv module refuse to load without error message on stdout
>> but saying that crc16 is missing on dmesg
>>
>>
>> selecting manually kernel modules -> other modules -> kmod-crc16 it work
>> again
>>
>> [0]
>> https://dev.openwrt.org/changeset/28657/packages/net/batman-adv/Makefile
>
> the OpenWrt developers have renamed the package dependency. Unless you are
> using the OpenWrt trunk after revision 28656 the package dependency selection
> won't work anymore.
>
> Maybe you should ask them about their concept of backward compatibility.
>
> Cheers,
> Marek
>
