Return-Path: <ylonen@gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 20 Jan 2010 15:05:30 +0100
From: =?iso-8859-1?Q?=22Juha_Yl=F6nen=22?= <ylonen@gmx.net>
In-Reply-To: <20100119193701.GA18515@pandem0nium>
Message-ID: <20100120140530.4750@gmx.net>
MIME-Version: 1.0
References: <20100118112706.91160@gmx.net>
	<201001182138.32432.lindner_marek@yahoo.de>	<20100119074334.275290@gmx.net>
	<201001192007.38210.lindner_marek@yahoo.de>	<20100119145151.294630@gmx.net>
	<20100119193701.GA18515@pandem0nium>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] batman-adv on different archs
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


-------- Original-Nachricht --------
> Datum: Tue, 19 Jan 2010 20:37:01 +0100
> Von: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
>
> just as a side note, would you mind sharing your changes which were
> required to cross compile=20
> for ARM? batman-adv is supposed to support 2.6.24, and if there is any
> trouble with this
> on ARM i'd like to add support for it.

Hi,

I just took a fresh checkout and now it compiles without problems. The erro=
rs I got were in gateway functionality, so I guess they were under developm=
ent?

It's still complining about the bat_printk:
make[2]: *** No rule to make target `/home/ylo/batman-adv/trunk/batman-adv-=
kernelland-ARM/bat_printk.o', needed by `/home/ylo/batman-adv/trunk/batman-=
adv-kernelland-ARM/batman-adv.o'. Stop.

but that's the same on x86, and I just removed bat_printk.o from the target=
s.

-Juha
--=20
Hilfe f=FCr Haiti! Spende per SMS: Sende UI HAITI an die Nummer 81190.
Von 5 Euro je SMS (zzgl. SMS-Geb=FChr) gehen 4,83 Euro an UNICEF.
