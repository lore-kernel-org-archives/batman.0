Return-Path: <gmazzurco89@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201111041714.15528.lindner_marek@yahoo.de>
References: <CAOaDhSSVMx1eN1G5rZ6-zh8Kh8xoddUOiQ0ua4StaX5bLHVQ7w@mail.gmail.com>
	<201111041047.52997.lindner_marek@yahoo.de>
	<CAOaDhSR2SQUp4gj-05e0eFLGT8US_BY=yVE92GkH-h8YUPxjMw@mail.gmail.com>
	<201111041714.15528.lindner_marek@yahoo.de>
Date: Fri, 4 Nov 2011 17:40:15 +0100
Message-ID: <CAOaDhSS=Q0CHXJrpWkPfaCu+tR5GBEqYSyFS78oKd2rJ1Ri2ug@mail.gmail.com>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

because openwrt devs recommends to use manually created feeds.conf
instead to use feeds.conf.default that is ignored if feeds.conf exist
so feeds.conf.default got updated but my scripts/update -a ignored him

my feeds.conf was created before feeds.conf.default packages entry got
url changed

2011/11/4 Marek Lindner <lindner_marek@yahoo.de>:
> On Friday, November 04, 2011 10:57:19 Gioacchino Mazzurco wrote:
>> ho good notice but before that backfire and trunk shared the packages repo
>
> Thought the same. How do you get the trunk batman-adv package without noticing
> the backfire package feed ? Do you download the package feed manually (without
> using scripts/feeds) ?
>
> Regards,
> Marek
>
