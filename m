Return-Path: <tonyputi@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20111004214811.GE28555@ritirata.org>
References: <mailman.54.1312831773.1125.b.a.t.m.a.n@lists.open-mesh.org>
	<CAFevQmNuUV-FebLq5nuD=iqX24xqEiBxaxd9nTja3O4XewHKFA@mail.gmail.com>
	<201108161311.27235.lindner_marek@yahoo.de>
	<CAFevQmMuk16mnWhsZibwiRe5Kdo4aNfu_1XZmBEigX5SBU8HTQ@mail.gmail.com>
	<20111004214811.GE28555@ritirata.org>
From: Filippo Sallemi <tonyputi@gmail.com>
Date: Wed, 5 Oct 2011 10:25:08 +0200
Message-ID: <CAFevQmM4SPz+8chA79Bsa0=Rt492jeK6QTCxMpmCGeKAi8wOtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] Batman-adv secure
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

Hi,
after some hours spend to find another threads talking about this
topic I'm not able to resolve my problem but I have another two
question about this.
1. Can I user macfilter option in wireless config without decerase performance?
2. Exists another tool such ebtables but that work on a simple interface?

Rgds

2011/10/4 Antonio Quartulli <ordex@autistici.org>:
> Hi Filippo,
>
> On Tue, Oct 04, 2011 at 11:39:04PM +0200, Filippo Sallemi wrote:
>> Hi guys,
>> I've read the open-mesh FAQ but I'm not able to resolve my problem.
>> I understood that the mesh network is a public network and that every
>> user have to make sure their connection is secure but i don't want
>> that another node (alien) can connect to my network so i thinked about
>> use ebables to block all traffic (such as policy DROP of iptables) and
>> allow only certain nodes to comunicate with other.
>>
>> I need some like this
>> ebtables -i wlan0 DROP
>> ebtables -i wlan0 --src <node mac> ACCEPT
>>
>> but don't work for me
>>
>> Any suggest?
>>
>
> If you dig a bit in the mailing list archive you can probably find some other
> threads talking about this topic. ebtables only work on bridges, therefore it
> won't work on simple interfaces like wlan0..
>
>
>> Rgds
>> 2011/8/16 Marek Lindner <lindner_marek@yahoo.de>:
>> >
>> > Hi,
>> >
>> >> I don't known if this is a old argument but exsist the possibility to
>> >> implement a secure mesh network?
>> >> For example a tecnique that crypt batman-adv traffic with a preshare
>> >> key or similar or
>> >> using ebtables to block all INPUT and OUTPUT traffic and allow only
>> >> the specified nodes mac?
>> >
>> > Please consult our FAQ and feel free to ask unanswered questions afterwards:
>> > http://www.open-mesh.org/wiki/open-mesh/FAQ
>> >
>> >
>> > Regards,
>> > Marek
>> >
>>
>>
>>
>> --
>> Filippo Sallemi
>
> --
> Antonio Quartulli
>
> ..each of us alone is worth nothing..
> Ernesto "Che" Guevara
>



-- 
Filippo Sallemi
