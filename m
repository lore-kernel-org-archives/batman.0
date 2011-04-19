Return-Path: <gmazzurco89@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20110419132935.GA20312@Sellars>
References: <BANLkTin=6SArq_5+n7SMRHfX2p-RGgsomA@mail.gmail.com>
	<BANLkTikBcWdW==dP8BG4Ud5HjxyQ0z0n3A@mail.gmail.com>
	<20110419132935.GA20312@Sellars>
Date: Tue, 19 Apr 2011 19:44:08 +0200
Message-ID: <BANLkTi=iDC+oFgvX7DxqPhAv8gG1ftfkVw@mail.gmail.com>
From: Gioacchino Mazzurco <gmazzurco89@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] batman-adv vis_data
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

ok the node number now is increased but we have the same bug :|

>- The raw vis output from /sys/kernel/debug/batman_adv/bat0/vis_data

root@OpenWrt:~# cat /sys/kernel/debug/batman_adv/bat0/vis_data
06:15:6d:fc:71:ce,TQ 00:15:6d:7a:97:45 80, TQ 00:15:6d:7c:09:9e 236,
00:15:6d:7a:97:33,TQ 00:15:6d:7a:97:45 172, TQ 00:15:6d:fc:72:0b 172,
TQ 06:15:6d:fc:71:f6 158, HNA 0a:ee:bf:7f:e8:fd, PRIMARY,
00:15:6d:7a:97:45,TQ 00:15:6d:7a:97:33 92, TQ 00:15:6d:72:48:0d 99, TQ
00:15:6d:7c:09:9e 153, HNA f2:f8:44:0f:93:65, HNA 00:15:6d:7b:97:45,
PRIMARY,
00:15:6d:fc:72:0b,TQ 00:15:6d:7a:97:33 74,
00:15:6d:7a:97:08,TQ 06:15:6d:fc:71:f6 145, TQ 00:15:6d:7c:09:e8 207,
HNA 00:18:84:1d:fc:78, HNA 1c:65:9d:cc:5a:7e, HNA 12:da:53:a1:68:55,
HNA 00:15:6d:7b:97:08, PRIMARY,
00:15:6d:72:48:0d,TQ 00:15:6d:7a:97:45 108,
06:15:6d:fc:71:f6,TQ 00:15:6d:7a:97:33 172, TQ 00:15:6d:7a:97:08 193,
00:15:6d:7c:09:e8,TQ 00:15:6d:7a:97:08 100,
00:15:6d:7c:09:9e,TQ 06:15:6d:fc:71:ce 245, HNA 78:e4:00:83:91:f4, HNA
00:14:0b:04:32:d1, HNA 00:0c:6e:34:5a:c9, HNA 00:50:fc:f0:62:f6, HNA
00:18:84:1e:94:dd, HNA 00:1d:92:db:de:de, HNA 00:1d:92:db:de:ba, HNA
00:26:9e:13:36:d4, HNA 00:1d:7e:a1:da:5c, HNA 00:16:d3:9a:38:13, HNA
08:10:74:a2:74:68, HNA 90:27:e4:a2:86:3a, HNA 00:0c:46:db:d2:bf, HNA
00:20:1a:22:ee:8f, HNA 1c:4b:d6:b7:58:8f, HNA 00:26:5e:21:6f:73, HNA
00:1e:8c:1c:d4:89, HNA 00:15:6d:73:48:0d, HNA 00:1d:92:db:df:70, HNA
00:30:84:1d:55:27, HNA c4:17:fe:c1:dd:a8, HNA 00:1a:4b:76:72:64, HNA
58:b0:35:fd:65:b4, HNA 00:e0:4c:39:2b:0a, HNA 00:0c:46:b8:cc:2c, HNA
00:0a:5e:65:71:ff, HNA 00:1d:92:db:df:8a, HNA 00:1d:92:db:de:91, HNA
16:be:18:57:d3:24, HNA 1c:4b:d6:5c:05:f2, HNA 00:50:fc:cd:fa:c1, HNA
00:15:6d:7d:09:9e, PRIMARY,

- The originator table of the two nodes from
/sys/kernel/debug/batman_adv/bat0/originators

mmm for all nodes now is quite complex :| here is the one from the
node I use to get vis data

root@OpenWrt:~# cat /sys/kernel/debug/batman_adv/bat0/originators
[B.A.T.M.A.N. adv 2011.0.0, MainIF/MAC: wlan0/00:15:6d:7c:09:9e (bat0)]
  Originator      last-seen (#/255)           Nexthop [outgoingIF]:
Potential nexthops ...
00:15:6d:7a:97:45    0.710s   ( 84) 06:15:6d:fc:71:ce [     wlan0]:
00:15:6d:7a:97:45 ( 69) 06:15:6d:fc:71:ce ( 84)
00:15:6d:7d:09:e8    1.450s   ( 11) 06:15:6d:fc:71:ce [     wlan0]:
00:15:6d:7a:97:45 (  9) 06:15:6d:fc:71:ce ( 11)
00:15:6d:fc:72:0b    2.790s   ( 15) 00:15:6d:7a:97:45 [     wlan0]:
00:15:6d:7a:97:45 ( 15)
06:15:6d:fc:71:ce    0.240s   (245) 06:15:6d:fc:71:ce [     wlan0]:
06:15:6d:fc:71:ce (245) 00:15:6d:7a:97:45 ( 41)
00:15:6d:73:48:0d    0.310s   ( 49) 06:15:6d:fc:71:ce [     wlan0]:
00:15:6d:7a:97:45 ( 38) 06:15:6d:fc:71:ce ( 49)
06:15:6d:fc:71:f6    0.410s   ( 18) 00:15:6d:7a:97:45 [     wlan0]:
00:15:6d:7a:97:45 ( 18)
00:15:6d:fd:71:f6    0.260s   ( 24) 06:15:6d:fc:71:ce [     wlan0]:
00:15:6d:7a:97:45 ( 19) 06:15:6d:fc:71:ce ( 24)
00:15:6d:fd:71:ce    0.310s   (245) 06:15:6d:fc:71:ce [     wlan0]:
06:15:6d:fc:71:ce (245)
00:15:6d:7a:97:33    1.330s   ( 35) 06:15:6d:fc:71:ce [     wlan0]:
00:15:6d:7a:97:33 (  0) 00:15:6d:7a:97:45 ( 29) 06:15:6d:fc:71:ce (
35)
00:15:6d:72:48:0d    0.080s   ( 45) 06:15:6d:fc:71:ce [     wlan0]:
00:15:6d:72:48:0d (  0) 00:15:6d:7a:97:45 ( 37) 06:15:6d:fc:71:ce (
45)
00:15:6d:fd:72:0b    1.330s   ( 19) 06:15:6d:fc:71:ce [     wlan0]:
00:15:6d:7a:97:45 ( 14) 06:15:6d:fc:71:ce ( 19)
00:15:6d:7a:97:08    0.970s   ( 14) 06:15:6d:fc:71:ce [     wlan0]:
00:15:6d:7a:97:45 ( 11) 06:15:6d:fc:71:ce ( 14)


root@OpenWrt:~# batctl o
[B.A.T.M.A.N. adv 2011.0.0, MainIF/MAC: wlan0/00:15:6d:7c:09:9e (bat0)]
  Originator      last-seen (#/255)           Nexthop [outgoingIF]:
Potential nexthops ...
00:15:6d:7a:97:45    0.270s   (120) 06:15:6d:fc:71:ce [     wlan0]:
00:15:6d:7a:97:45 (102) 06:15:6d:fc:71:ce (120)
00:15:6d:7d:09:e8    6.960s   ( 19) 00:15:6d:7a:97:45 [     wlan0]:
00:15:6d:7a:97:45 ( 19) 06:15:6d:fc:71:ce ( 18)
00:15:6d:fc:72:0b    6.690s   ( 38) 00:15:6d:7a:97:45 [     wlan0]:
00:15:6d:7a:97:45 ( 38)
06:15:6d:fc:71:ce    0.130s   (255) 06:15:6d:fc:71:ce [     wlan0]:
06:15:6d:fc:71:ce (255) 00:15:6d:7a:97:45 ( 82)
06:15:6d:fc:71:f6    0.400s   ( 45) 00:15:6d:7a:97:45 [     wlan0]:
00:15:6d:7a:97:45 ( 45)
00:15:6d:fd:71:f6    0.370s   ( 41) 06:15:6d:fc:71:ce [     wlan0]:
00:15:6d:7a:97:45 ( 38) 06:15:6d:fc:71:ce ( 41)
00:15:6d:fd:71:ce    0.370s   (255) 06:15:6d:fc:71:ce [     wlan0]:
06:15:6d:fc:71:ce (255)
00:15:6d:7a:97:33    0.890s   ( 84) 06:15:6d:fc:71:ce [     wlan0]:
00:15:6d:7a:97:33 (  0) 00:15:6d:7a:97:45 ( 74) 06:15:6d:fc:71:ce (
84)
00:15:6d:fd:72:0b    1.160s   ( 61) 06:15:6d:fc:71:ce [     wlan0]:
00:15:6d:7a:97:45 ( 56) 06:15:6d:fc:71:ce ( 61)
00:15:6d:7a:97:08    1.560s   ( 31) 06:15:6d:fc:71:ce [     wlan0]:
00:15:6d:7a:97:45 ( 28) 06:15:6d:fc:71:ce ( 31)



2011/4/19 Linus L=FCssing <linus.luessing@web.de>:
> On Tue, Apr 19, 2011 at 09:46:10AM +0200, Gioacchino Mazzurco wrote:
>> moreover the two node have two interfaces used by batman-adv but only
>> one is displayed!
>>
>> 2011/4/19 Gioacchino Mazzurco <gmazzurco89@gmail.com>:
>> > Hi!
>> >
>> > In Pisa we are switching to batman-adv for our mesh, we use the
>> > version packaged in openwrt.
>> >
>> > But it seems that the output of vd is not conform to specification in
>> > this page =A0http://www.open-mesh.org/wiki/batman-adv/VisAdv
>> >
>> > especially the box representing a node is painted only for the node
>> > where you call 'batctl vd dot'
>> >
>> > here you can see what is happening
>> > http://eigenlab.org/batman-adv_status.php to simplify visualization i
>> > am generating it with 'batctl vd dot -H'
>> >
>>
>
> Hi Gioacchino,
>
> As far as I know the format for the batman-adv vis output has not
> been changed on purpose and the wiki page should reflect the current
> specification. So you might possibly have found a bug.
>
> So guessing from the link, you are testing this with two nodes
> (with two interfaces as you said) with perfect link qualities and
> the issue already comes up, correct?
>
> It would be great if you could provide the following additional
> data from this two node setup:
> - The raw vis output from /sys/kernel/debug/batman_adv/bat0/vis_data
> - The originator table of the two nodes from
> =A0/sys/kernel/debug/batman_adv/bat0/originators
>
> Cheers, Linus
>
