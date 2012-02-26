Return-Path: <tonyputi@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201202111808.54341.lindner_marek@yahoo.de>
References: <CAFevQmN-RVQookzL-M9_G0xGKJJvAp5QXCqRfwf+X8dvWM9-Pw@mail.gmail.com>
	<201202100053.46289.lindner_marek@yahoo.de>
	<CAFevQmP9EDXbAVeO+9cvfhJ2i8rWeNo3PW8uTcUZkpazohsj3A@mail.gmail.com>
	<201202111808.54341.lindner_marek@yahoo.de>
From: Filippo Sallemi <tonyputi@gmail.com>
Date: Sun, 26 Feb 2012 18:49:44 +0100
Message-ID: <CAFevQmN7t5R52R6dmzz630OHi1g=5z01-q-UTMMR04iJFWXtbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] Fwd: /lib/batman-adv/config.sh
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

Ok in this email my proposal patch.
I've to sleep 4s if you have an ap + adhoc vifs.

[ "$(echo $interface | awk '$0 ~ /^wlan[0-9]*/')" ] && sleep 4s

For convenience I sleep only if an wlan was triggered. If you have
only one interface in adhoc mode per radio 3 seconds are enought.

bye

---------- Messaggio inoltrato ----------
Da: Marek Lindner <lindner_marek@yahoo.de>
Date: 11 febbraio 2012 11:08
Oggetto: Re: /lib/batman-adv/config.sh
A: Filippo Sallemi <tonyputi@gmail.com>


On Friday, February 10, 2012 01:21:21 you wrote:
> > Yeah - looks good.
> > I still don't get why we don't need to wait 3/5 seconds anymore. Can yo=
u
> > explain this ?
>
> No i'm wrong we need to wait 3 seconds... i think that the sleep call
> could be moved to hotplug.d/99-batman-adv when an interface is added
> to mesh interface.
> I need some time.

Ok - I left the "sleep 3s" in the file. I applied your config_bat/bat_confi=
g
as well as the forgotten ap_isolation config fix.

Since the for loop does not fix the wait problem why do you wish to change =
it?
I am referring to your suggested change:

# Load network config here just in case!
config_load network
for iface in $interfaces; do
=C2=A0 =C2=A0 =C2=A0 =C2=A0# copy iface into ifname
=C2=A0 =C2=A0 =C2=A0 =C2=A0local ifname=3D$iface
=C2=A0 =C2=A0 =C2=A0 =C2=A0[ -f "/sys/class/net/$ifname/batman_adv/mesh_ifa=
ce" ] || {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# if ifname was not =
found try to find it via uci config
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config_get ifname $i=
face ifname
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[ -f "/sys/class/net=
/$ifname/batman_adv/mesh_iface" ] ||
continue
=C2=A0 =C2=A0 =C2=A0 =C2=A0}

=C2=A0 =C2=A0 =C2=A0 =C2=A0[ "$ifname" =3D "$interface" ] && echo $mesh >
/sys/class/net/$ifname/batman_adv/mesh_iface
done

bat_add_interface() and bat_del_interface() have the same loop but we only
change one ? The only difference I can see is another added variable and no=
t
calling "uci -q -P/var/state get network.$iface.ifname". Why ?

Cheers,
Marek


--=20
Filippo Sallemi
