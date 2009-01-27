MIME-Version: 1.0
In-Reply-To: <20090126212412.GA16326@pandem0nium>
References: <238a15490901231630s7d460687x6a95238f7308998a@mail.gmail.com>
	<200901240942.07893.lindner_marek@yahoo.de>
	<238a15490901260934i1f4dcd30u7404cd79fff7a29c@mail.gmail.com>
	<200901270341.31896.lindner_marek@yahoo.de>
	<238a15490901261228t3b1ae9d1l1ced88b416698731@mail.gmail.com>
	<20090126212412.GA16326@pandem0nium>
Date: Mon, 26 Jan 2009 19:41:38 -0600
Message-ID: <238a15490901261741tc7f7382r8769ee42b2fa6f8c@mail.gmail.com>
From: Gargi Purohit <gaargie@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Help in batman advanced configuration
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

On Mon, Jan 26, 2009 at 3:24 PM, Simon Wunderlich
<simon.wunderlich@s2003.tu-chemnitz.de> wrote:
> Hello Gargi,
>
> your setup looks correct from what you've pasted. Some questions to find
> the reason:


Thanks a lot for your hints.  Really appreciate!!
> 1. Have you set "up" all the interfaces by doing "ifconfig <dev> up"?
>

I screwed up here ... bat0 was not up...i brought it up on both
openmesh1 and openmesh2 and
i got an IP for openmesh2


I hope likewise a client of openmesh2 would too get an IP...I would
check that soon....just wanted
to thank you first :D

> 2. If you set IPs on br0 of open-mesh1 and br0 of open-mesh2 manually,
> can they ping each other?
>
> 3. If yes (and configured within the subnet of PIX):
> Can you ping PIX from open-mesh2?
>
> 4. If you do udhcpc on open-mesh2, do you receive the packet on br0 on
> open-mesh1? Please check with tcpdump, this should work. If yes, do you
> also receive it on the PIX? (Maybe the answer is getting lost somewhere).
>
> BTW, i've set up similar scenarios yet, this is supposed to work. ;)
>
> best regards,
>        Simon
>
>
>
> On Mon, Jan 26, 2009 at 02:28:44PM -0600, Gargi Purohit wrote:
>> On Mon, Jan 26, 2009 at 1:41 PM, Marek Lindner <lindner_marek@yahoo.de> wrote:
>> > On Tuesday 27 January 2009 01:34:16 Gargi Purohit wrote:
>> >> I hope other than setting the interface "ath0" in
>> >> /proc/net/batman-advanced/interfaces - i dont
>> >> need any other configuration changes.
>> >>
>> >> Since I can batping between the two routers i guess the layer 2
>> >> connectivity is established between
>> >> these guys - am just wondering if they should be able to forward
>> >> requests like dhcp over multiple hop
>> >> (1 hop and above)....
>> >
>> > Yes, a working batping indicates that the connection between both modules is
>> > given. The DHCP request should be forwarded without problems. Your setup is
>> > misconfigured somewhere.
>> >
>> > Could you please show the output of "brctl show br0" and "cat
>> > /proc/net/batman-adv/interfaces" on both nodes. You can check where the dhcp
>> > request dies by using tcpdump or batdump.
>>
>> On node 1 (Which is wired)
>> ---------------------------------------
>>
>> root@open-mesh:~# brctl show br0
>> bridge name     bridge id               STP enabled     interfaces
>> br0             8000.00180a0145b0       no              bat0
>>                                                         ath1
>>                                                         ath2
>>                                                         eth0
>> root@open-mesh:~# cat /proc/net/batman-adv/interfaces
>> ath0
>>
>> root@open-mesh:~# cat /proc/net/batman-adv/originators
>>   Originator     (#/255)           Nexthop [outgoingIF]:   Potential
>> nexthops ... [B.A.T.M.A.N. Adv 0.1-beta rv1103, MainIF/MAC:
>> ath0/00:18:0a:01:45:b0]
>> 00:18:0a:01:44:d0  (255) 00:18:0a:01:44:d0 [      ath0]: 00:18:0a:01:44:d0 (255)
>>
>> On node 2 (Which is connected wirelessly to node 1 - eth0 is down)
>> --------------------------------------------------------------------------------------------------
>> root@open-mesh:/proc/net# brctl show br0
>> bridge name     bridge id               STP enabled     interfaces
>> br0             8000.00ff678aa75f       no                    ath1
>>                                                         bat0
>>                                                         ath2
>> root@open-mesh:/proc/net# cat /proc/net/batman-adv/interfaces
>> ath0
>>
>> root@open-mesh:/proc/net# cat /proc/net/batman-adv/originators
>>   Originator     (#/255)           Nexthop [outgoingIF]:   Potential nexthops ..
>> . [B.A.T.M.A.N. Adv 0.1-beta rv1103, MainIF/MAC: ath0/00:18:0a:01:44:d0]
>> 00:18:0a:01:45:b0  (255) 00:18:0a:01:45:b0 [      ath0]: 00:18:0a:01:45:b0 (255)
>>
>> root@open-mesh:/proc/net#
>>
>>
>>
>> > Regards,
>> > Marek
>> >
>> > _______________________________________________
>> > B.A.T.M.A.N mailing list
>> > B.A.T.M.A.N@open-mesh.net
>> > https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>> >
>> _______________________________________________
>> B.A.T.M.A.N mailing list
>> B.A.T.M.A.N@open-mesh.net
>> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>>
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.6 (GNU/Linux)
>
> iD8DBQFJfin8rzg/fFk7axYRArD6AJsFopD8+ZhlwhJWN6jNnGAo83qHPgCdFgHp
> t/I6o0/TASreYNzzrjw65fY=
> =rn7h
> -----END PGP SIGNATURE-----
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>
