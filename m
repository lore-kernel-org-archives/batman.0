Return-Path: <tonyputi@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201202271611.19158.lindner_marek@yahoo.de>
References: <CAFevQmN-RVQookzL-M9_G0xGKJJvAp5QXCqRfwf+X8dvWM9-Pw@mail.gmail.com>
	<201202111808.54341.lindner_marek@yahoo.de>
	<CAFevQmN7t5R52R6dmzz630OHi1g=5z01-q-UTMMR04iJFWXtbw@mail.gmail.com>
	<201202271611.19158.lindner_marek@yahoo.de>
From: Filippo Sallemi <tonyputi@gmail.com>
Date: Mon, 27 Feb 2012 13:42:58 +0100
Message-ID: <CAFevQmOO+kmXqyt769tdk5j4VY+6dJW9TGDV45rvN6HyT2Ps9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

Il 27 febbraio 2012 09:11, Marek Lindner <lindner_marek@yahoo.de> ha scritto:
> On Monday, February 27, 2012 01:49:44 Filippo Sallemi wrote:
>> Ok in this email my proposal patch.
>> I've to sleep 4s if you have an ap + adhoc vifs.
>>
>> [ "$(echo $interface | awk '$0 ~ /^wlan[0-9]*/')" ] && sleep 4s
>>
>> For convenience I sleep only if an wlan was triggered. If you have
>> only one interface in adhoc mode per radio 3 seconds are enought.
>
> What if somebody calls his interfaces in a different way ? As you know the
> name can freely be chosen.
You can chose another name instead of wlan0 wlan0-1 wlan1 wlan1-1 eth0 eth1 ...?
This line is executed only when hotplug is called on network restart
and so when every interface is triggered.
when eth0 is added we don't sleep but when if wlan0 is triggered then
we sleep 4 seconds because the real state of the interface and so the
real name of your logical network take some time to be ready.
>
> Regards,
> Marek


Rgds
-- 
Filippo Sallemi
