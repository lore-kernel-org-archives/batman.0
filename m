Return-Path: <gmazzurco89@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1352247.13aSduvyXD@sven-laptop.home.narfation.org>
References: <CAOaDhSS0-EP6bPM+2kho3h9u8aGJXsP0QmaqFMAhHa_4Y=MA4Q@mail.gmail.com>
	<1352247.13aSduvyXD@sven-laptop.home.narfation.org>
Date: Tue, 5 Jul 2011 16:15:22 +0200
Message-ID: <CAOaDhSR8JLKWHUY_YV6nwK0vXEPc5mGMTD0nLRdHKuWvfRwA+A@mail.gmail.com>
From: Gioacchino Mazzurco <gmazzurco89@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] batctl vd dot buggy
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

you are right I can provide you an ssh access
I know personally Antonio and Marek so if you are trusted by them i
can trust you and give you access to our server so you can do every
check you want ;)

eigenServer gioacchino # cat /sys/kernel/debug/batman_adv/bat0/vis_data
7a:ea:3a:b6:49:cc,TQ 00:15:6d:7a:96:7a 206, HNA 00:26:5e:1e:d5:b8, HNA
00:18:f3:87:94:94, HNA 00:15:6d:ae:46:6c, HNA ce:ee:a6:b8:6e:ea,
PRIMARY,
06:15:6d:7c:09:d8,TQ 00:15:6d:7a:96:7a 221, TQ 00:15:6d:fc:72:0b 243,
00:15:6d:7a:97:33,TQ 00:15:6d:7a:96:7a 82, TQ 00:15:6d:7a:97:45 155,
TQ 00:15:6d:fc:72:0b 191, TQ 06:15:6d:fc:71:f6 175, HNA
9e:62:5e:51:2e:9a, PRIMARY,
00:15:6d:7a:97:45,TQ 06:15:6d:fc:71:f6 177, TQ 00:15:6d:7a:97:33 150,
TQ 00:15:6d:7c:09:9e 223, TQ 06:15:6d:72:48:0d 246, HNA
22:86:17:2d:42:dd, PRIMARY,
06:15:6d:fc:71:ce,TQ 00:15:6d:7c:09:9e 233,
00:15:6d:fc:72:0b,TQ 00:15:6d:7a:97:33 180, TQ 06:15:6d:7c:09:d8 212,
00:15:6d:73:48:0d,TQ 00:23:7d:29:13:fa 255, TQ 00:15:6d:7d:09:9e 250,
HNA cc:08:e0:fc:8e:47, HNA 62:b0:58:e5:63:ba, HNA f8:db:7f:80:1e:f2,
HNA 00:15:6d:72:48:0d, HNA 00:26:68:15:a8:77, PRIMARY,
92:17:8d:21:e4:a5,TQ 2a:11:49:e1:1e:64 220,
00:15:6d:7a:96:7a,TQ 00:15:6d:7a:97:33 143, TQ 06:15:6d:7c:09:d8 169,
TQ 7a:ea:3a:b6:49:cc 254,
06:15:6d:fc:71:f6,TQ 00:15:6d:7a:97:45 135, TQ 00:15:6d:7c:09:e8 8, TQ
00:15:6d:7a:97:33 202,
2a:11:49:e1:1e:64,TQ 92:17:8d:21:e4:a5 254,
00:23:7d:29:13:fa,TQ 00:15:6d:73:48:0d 255, TQ 00:15:6d:7d:09:9e 241,
HNA 5a:61:e5:74:a5:da, SEC 2a:11:49:e1:1e:64, PRIMARY,
00:15:6d:7d:09:9e,TQ 00:23:7d:29:13:fa 255, TQ 00:15:6d:73:48:0d 251,
HNA ca:07:b3:65:e6:51, PRIMARY, SEC 00:15:6d:7c:09:9e,
00:15:6d:7c:09:9e,TQ 00:15:6d:7a:97:45 196, TQ 06:15:6d:fc:71:ce 251,

2011/7/5 Sven Eckelmann <sven@narfation.org>:
> On Tuesday 05 July 2011 15:56:37 Gioacchino Mazzurco wrote:
>> on our server we have batman-adv from 2.6.38 kernel
>>
>> the output of batctl vd dot results buggy
>>
>> eigenServer gioacchino # batctl -v
>> batctl 2011.1.0
>>
>> as you can see here http://eigenlab.org/status.php a lot of blue
>> cluster are missing also on node with multiple interfaces so the
>> topology draw is badly affected by this :|
>
> What about providing the output of /sys/kernel/debug/batman_adv/bat0/vis_=
data
> and giving a better explanation what is missing? Showing some pictures an=
d say
> that something is missing without any details will not help anyone. And n=
o, I
> can't read italian.
>
> Kind regards,
> =A0 =A0 =A0 =A0Sven
