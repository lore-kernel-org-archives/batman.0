Return-Path: <nikanas@gmail.com>
MIME-Version: 1.0
In-Reply-To: <2942004.kRGEbDgGH5@sven-laptop.home.narfation.org>
References: <CA+qXHzNUGtLUpFqOmvKge05wLYyyoCpkTJG4HKwkd+Zzv81hYQ@mail.gmail.com>
	<2942004.kRGEbDgGH5@sven-laptop.home.narfation.org>
Date: Thu, 21 Jul 2011 15:28:18 +0800
Message-ID: <CA+qXHzN2x3CL7aH7T-OJKEE0tfs7kgOVoqtUpNZJyecrywRJWg@mail.gmail.com>
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

I think this is misunderstanding.  This method work fine on wire
interface because it use ebtables to filter the batman-adv packet, and
ebtables need to be use with bridge interface.

And why this method don't work on wireless, is simply because you
can't create bridge interface with wireless interface.  That why ask,
if anyone here got another idea on how to filter the batman-adv
packet. I provide the example above to show what i done, if others can
do same thing but different way.

About the br0, you can make the br0 work with or without IP.

On 7/21/11, Sven Eckelmann <sven@narfation.org> wrote:
> On Thursday 21 July 2011 11:33:55 Nik M. Anas Kamarudin wrote:
> [...]
>> /sbin/modprobe /lib/modules/`2.6.35.13/batman-adv/batman-adv.ko
>> /usr/sbin/batctl if add br0
>> /sbin/ifconfig bat0 192.168.5.41 up
>> /sbin/ifconfig br0 192.168.5.1 up
>
> Why has br0 an IP address (and one which seems to be in the same subnet
> like the one from bat0)?
>
>> and filter up the batman-adv packet using etables like this:
>> `/usr/sbin/ebtables -A INPUT -s AA:AA:AA:AA:AA -j DROP`
>>
>> BUT, this only work for Ethernet interface/ wire.. i need to do this
>> same thing using wireless interface. Anyone got any ideas?
>
> Why shouldn't that work on wireless interfaces? Maybe you should provide
> more
> information about your problem or your statement is just wrong. Just to
> provide a easy to reproduce counterexample: Take your standard ath9k master
> interface, add it to a bridge and add the correct ebtables filter rules
> (depends on the actual scenario, but just assume INPUT, FORWARD and OUTPUT
> of of the filter table with the source/destination macs and DROP target).
>
> And there is still the possibility to revert and extend
> http://git.open-mesh.org/?p=batman-adv.git;a=commit;h=660d20261343e0b2ff57e51e50d7eb0e557d5e5b
>
> Kind regards,
> 	Sven
