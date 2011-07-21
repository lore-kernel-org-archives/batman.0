Return-Path: <nikanas@gmail.com>
MIME-Version: 1.0
In-Reply-To: <8523816.3y33SjpCxy@sven-laptop.home.narfation.org>
References: <CA+qXHzNUGtLUpFqOmvKge05wLYyyoCpkTJG4HKwkd+Zzv81hYQ@mail.gmail.com>
	<2942004.kRGEbDgGH5@sven-laptop.home.narfation.org>
	<CA+qXHzN2x3CL7aH7T-OJKEE0tfs7kgOVoqtUpNZJyecrywRJWg@mail.gmail.com>
	<8523816.3y33SjpCxy@sven-laptop.home.narfation.org>
Date: Thu, 21 Jul 2011 17:14:28 +0800
Message-ID: <CA+qXHzOAVeGYcnqjz_=goW2Yzc+oJ5y1GpAYDcH8EeGZssL=wA@mail.gmail.com>
From: "Nik M. Anas Kamarudin" <nikanas@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] Filtering BATMAN-ADV packet
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

AP mode? Sry, forget to tell, i using in ad-hoc mode. Maybe i explain
more. I try to test batman-adv in MANET. In order to doing that, i
need to make a scenario that have changing in topology. That why i
need to filter some batman-adv packet, if not i need to move the node
myself in and out of wireless range.  So, anyone have any idea how to
filter batman-adv packet?

On 7/21/11, Sven Eckelmann <sven@narfation.org> wrote:
> On Thursday 21 July 2011 15:28:18 Nik M. Anas Kamarudin wrote:
>> I think this is misunderstanding.  This method work fine on wire
>> interface because it use ebtables to filter the batman-adv packet, and
>> ebtables need to be use with bridge interface.
>>
>> And why this method don't work on wireless, is simply because you
>> can't create bridge interface with wireless interface.  That why ask,
>> if anyone here got another idea on how to filter the batman-adv
>> packet. I provide the example above to show what i done, if others can
>> do same thing but different way.
>
> As explained in my counterexample, this statement is simply wrong. I am 100%
> sure that I use bridges together with wireless interfaces (ath9k+AP) and I
> can't take enough drugs to forget that. Either you have a specific situation
> where this is not possible (there are some of course) and have to say that
> or
> you are simply lying. But giving no information or lying will not help you
> at
> all.
>
>> About the br0, you can make the br0 work with or without IP.
>
> And now we bury the routing...
>
> I don't see that you use specific routes which are set to the correct
> device.
> So let's assume that your routing table now has two entries for 192.168.5.0
> with different outgoing devices and that it chooses (for unknown reasons) to
> use the route over br0. The target you want to reach is not only one hop
> away
> and thus the actual nic can't reach it directly, but batman-adv would be
> able
> to forward the packet correctly. And now think about how useful it was to
> give
> br0 a conflicting ip (due to the same subnets).
>
> Kind regards,
> 	Sven
