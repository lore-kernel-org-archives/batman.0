Return-Path: <gmazzurco89@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJA-1Ljpew4y6EjR9823V533ssC-DpirPkNpBbFzULZGvmw_jg@mail.gmail.com>
References: <CAJA-1Lijvt9hZVTP0QXi81bk061A54tRs=quUyztzo2_cM-LNw@mail.gmail.com>
	<201107041455.33023.lindner_marek@yahoo.de>
	<CAJA-1Ljmeqym_Sj4zqSEqaJtVvGf3brFQPtghYYi2QT5PFLYHw@mail.gmail.com>
	<20110704182256.GB26734@autistici.org>
	<20110704182914.GA4362@sven-atom.home.narfation.org>
	<20110704183941.GC26734@autistici.org>
	<CAJA-1Ljpew4y6EjR9823V533ssC-DpirPkNpBbFzULZGvmw_jg@mail.gmail.com>
Date: Wed, 6 Jul 2011 11:47:36 +0200
Message-ID: <CAOaDhSQ7yxeA_mx7NEYobChpvLZ9yjipBJu9rrpgh2SF0uNv3g@mail.gmail.com>
From: Gioacchino Mazzurco <gmazzurco89@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] Disconnecting the nodes in batman-adv 2011.1.0
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

This one is useless because batman-adv use broadcast as destination
and moreover your are dropping a mac address that is not on your
machine as source in OUTPUT chain this doesn't make sense
>sudo ebtables -I OUTPUT -s 00:1b:77:06:1c:15 -j DROP

you can use also iptables that is already installed do to this with
--mac-source option without installing ebtables

2011/7/6 Max Ip <ipmax2011@googlemail.com>:
> I tried ebtables to block the mac address of the neighboring node.
>
> sudo ebtables -I OUTPUT -s 00:1b:77:06:1c:15 -j DROP
> sudo ebtables -I INPUT -s 00:1b:77:06:1c:15 -j DROP
>
> But the batctl o command still shows 00:1b:77:06:1c:15 as one of the
> originators.
>
> My question is won't the enslaving wlan0 to br0 have the same problem
> because the mac address for both br0 and wlan0 will be the same?
>
> On Mon, Jul 4, 2011 at 8:39 PM, Antonio Quartulli <ordex@autistici.org> wrote:
>> On Mon, Jul 04, 2011 at 08:29:14PM +0200, Sven Eckelmann wrote:
>>> > As Marek suggested, you should use something like ebtables. But honestly I
>>> > remember that ebtables support has been removed from batman some time
>>> > ago.
>>>
>>> What about using a bridge over the actual device to simulate the bad link
>>> together with ebtables? This would resolve the problem that batman-adv must be
>>> ebtables aware.
>>
>>
>> You mean enslave wlan0 (e.g.) to br0 and then put br0 into bat0?
>> If so, it sounds good, because at that point you can use ebtables
>> against frames going through br0.
>>
>>
>> Regards,
>>
>> --
>> Antonio Quartulli
>>
>> ..each of us alone is worth nothing..
>> Ernesto "Che" Guevara
>>
>
