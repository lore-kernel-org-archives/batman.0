Return-Path: <tonyputi@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201202281621.13484.lindner_marek@yahoo.de>
References: <CAFevQmN-RVQookzL-M9_G0xGKJJvAp5QXCqRfwf+X8dvWM9-Pw@mail.gmail.com>
	<201202281344.35368.lindner_marek@yahoo.de>
	<CAFevQmN-DuWC=zmfj3S8yLH9tE3cVZkZVJRvHtOvrzCTGqpdtA@mail.gmail.com>
	<201202281621.13484.lindner_marek@yahoo.de>
From: Filippo Sallemi <tonyputi@gmail.com>
Date: Tue, 28 Feb 2012 11:36:58 +0100
Message-ID: <CAFevQmNR2MBGuvXjxZg_0CYvv2+LZOUORGBV=WtLuSsGYTVBvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Fwd: /lib/batman-adv/config.sh
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

Il 28 febbraio 2012 09:21, Marek Lindner <lindner_marek@yahoo.de> ha scritt=
o:
> On Tuesday, February 28, 2012 16:06:44 Filippo Sallemi wrote:
>> Ok but i' dont wait for this. Hotplug was called when a new interface
>> is added. msh0 is no a real interface so when wlan0 is added I sleep 4
>> seconds and check if wlan0 is part o batman-adv interfaces.
>
> Sorry, I don't understand. What do you mean with "msh0" is not a real
> interface ?
That msh0 is the name of logical network and wlan0 is the real name of
physical interface.
The part about wlan0 I understand - the question was what happens
> if the interface is not named wlan0?
yes. if in your batman-adv interface you put wlan0 (the real interface
name) you don't have to sleep.
The problem is that hotplug.d, when a new interface was added, at
99-batman-adv script time it try to check if the new interface (es.
wlan0) is part of batman-adv interface definitions so now if in your
batman-adv config file you have msh0, the script try to find the real
interface name of msh0 and it fail because it is not be knowned at
this time. The only way to get it to work properly is to wait for some
seconds (3 seconds if you have only one vif, 4 for 2 interface es
adhoc + ap).
>
> This could be your wireless config file:
> config 'wifi-iface'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0option 'device' 'radio0'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0option 'ifname' 'msh0'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0option 'mode' 'adhoc'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0option 'ssid' 'mesh'
>
> Cheers,
> Marek

Bye

--=20
Filippo Sallemi
