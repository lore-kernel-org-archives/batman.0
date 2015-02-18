Return-Path: <APape@phoenixcontact.com>
In-Reply-To: <2282256.5kOumjqyC5@voltaire>
References: <OF6F534CD3.B9570448-ONC1257DF0.00289AC2-C1257DF0.0029BB69@phoenixcontact.com>
 <2282256.5kOumjqyC5@voltaire>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OF6FAED1E7.E0D6E49C-ONC1257DF0.0042D59F-C1257DF0.00448642@phoenixcontact.com>
Date: Wed, 18 Feb 2015 13:28:27 +0100
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] Antwort: Re: Question concerning batman-adv bug #173
	"Mesh	packets on bat0"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi,

I adapted your patch to batman-adv-2014.4.0 without success. I got the=20
additional issue that with the patched version of batman-adv I was not=20
able to destroy the virtual wireless interface anymore used fot the adhoc=20
connection over which I try to use batman-adv (error message was:=20
unregister=5Fnetdevice: waiting for ath0 to become free).=20

With the unpatched 2014.4.0 I did the following test on two of my devices:

1. created a virtual wireless interface ath0 in adhoc mode
2. iwconfig ath0 essid TEST
3. iwconfig ath0 channel 40
4. ifconfig ath0 up
5. batctl if add ath0

After this the two devices connected and I could see the repective=20
neighbor via the batctl o command on both devices. So far so good.=20
But I can see via batctl td bat0 OGM packets sent with the MAC address of=20
the wlan interface of the device itself and also from the neigbour this=20
device is connected to via wlan. Is this OK?

6. Generating a bridge interface via brctl addbr br0
7. add bat0 interface to bridge via brctl addif br0 bat0

As soon as I do this, the batadv=5Fbatman=5Fskb=5Frecv isn't called anymore=
=20
(I've put a printk at the beginning of that function for debugging).=20
Furthermore batctl o shows that the mesh communication starts timing out=20
(last seen time for the originator/neighbor exceeds the ogm send interval=20
and increases continuously).

The interesting point in this state is, that batctl td bat0 still shows=20
the reception of ogm messages from the neighbour and from the own wlan=20
interface as mentioned above.

As mentioned I use a kernel version 2.6.32.26 and batman-adv/batctl=20
versions up to 2013.1.0 work with the same configuration steps.=20

Thanks for the support,
Andreas





Von:    Marek Lindner <mareklindner@neomailbox.ch>
An:     The list for a Better Approach To Mobile Ad-hoc Networking=20
<b.a.t.m.a.n@lists.open-mesh.org>,=20
Datum:  18.02.2015 12:28
Betreff:        Re: [B.A.T.M.A.N.] Question concerning batman-adv bug #173 =

"Mesh   packets on bat0"
Gesendet von:   "B.A.T.M.A.N" <b.a.t.m.a.n-bounces@lists.open-mesh.org>



On Wednesday, February 18, 2015 08:35:49 Andreas Pape wrote:
> I'm interested if there is any progress concerning the bug entry #173 (
> http://www.open-mesh.org/issues/173).=20
>=20
> I'm currently observing something similiar on an embedded system running =


> an older kernel 2.6.32.26. Batman-adv versions up to 2013.1.0 work=20
> flawlessly out of the box. All newer versions show the phenomenon=20
> described in bug #173.=20
> In my case I found out, that the batadv=5Fbatman=5Fskb=5Frecv function is=
=20
never=20
> called again as soon as I add bat0 to the bridge interface I use.=20
> If I use the bat0 interface outside a bridge, everything works fine up=20
to=20
> the latest version I tested (which was 2014.4.0) even with the old=20
kernel=20
> version.=20

Can you please try the attached patch and check whether it makes any=20
difference? If the symptoms are the same, please provide step-by-step=20
instructions how you create / configure your interfaces.

Thanks,
Marek
[Anhang "0001-do-not-call-master-netdev=5Fops-ndo=5Finit.patch" gel=F6scht =
von=20
Andreas Pape/Phoenix Contact] [Anhang "signature.asc" gel=F6scht von Andrea=
s=20
Pape/Phoenix Contact]=20

