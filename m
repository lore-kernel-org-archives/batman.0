Return-Path: <glider@google.com>
MIME-Version: 1.0
References: <0000000000006120c905952febbd@google.com>
 <5289022.tfFiBPLraV@bentobox>
In-Reply-To: <5289022.tfFiBPLraV@bentobox>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 18 Oct 2019 16:34:02 +0200
Message-ID: <CAG_fn=VFnPmhupvPLZMZWJP6U_-w=fxoZd+R668rzBeCGh+S3A@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in batadv_hard_if_event
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: syzbot <syzbot+0183453ce4de8bdf9214@syzkaller.appspotmail.com>, a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, David Miller <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>, mareklindner@neomailbox.ch, Networking <netdev@vger.kernel.org>, sw@simonwunderlich.de, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Petko Manolov <petkan@nucleusys.com>, USB list <linux-usb@vger.kernel.org>

On Fri, Oct 18, 2019 at 4:32 PM Sven Eckelmann <sven@narfation.org> wrote:
>
> Hi,
>
> not sure whether this is now a bug in batman-adv or in the rtl8150 driver=
. See
> my comments inline.
>
> On Friday, 18 October 2019 16:12:08 CEST syzbot wrote:
> [...]
> > usb 1-1: config 0 has no interface number 0
> > usb 1-1: New USB device found, idVendor=3D0411, idProduct=3D0012,
> > bcdDevice=3D56.5f
> > usb 1-1: New USB device strings: Mfr=3D0, Product=3D0, SerialNumber=3D0
> > usb 1-1: config 0 descriptor??
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > BUG: KMSAN: uninit-value in batadv_check_known_mac_addr
> > net/batman-adv/hard-interface.c:511 [inline]
> > BUG: KMSAN: uninit-value in batadv_hardif_add_interface
> > net/batman-adv/hard-interface.c:942 [inline]
> > BUG: KMSAN: uninit-value in batadv_hard_if_event+0x23c0/0x3260
> > net/batman-adv/hard-interface.c:1032
> > CPU: 0 PID: 13223 Comm: kworker/0:3 Not tainted 5.4.0-rc3+ #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Workqueue: usb_hub_wq hub_event
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0x191/0x1f0 lib/dump_stack.c:113
> >   kmsan_report+0x14a/0x2f0 mm/kmsan/kmsan_report.c:109
> >   __msan_warning+0x73/0xf0 mm/kmsan/kmsan_instr.c:245
> >   batadv_check_known_mac_addr net/batman-adv/hard-interface.c:511 [inli=
ne]
> >   batadv_hardif_add_interface net/batman-adv/hard-interface.c:942 [inli=
ne]
> >   batadv_hard_if_event+0x23c0/0x3260 net/batman-adv/hard-interface.c:10=
32
> >   notifier_call_chain kernel/notifier.c:95 [inline]
> [...]
>
> The line in batman-adv is (batadv_check_known_mac_addr):
>
>                 if (!batadv_compare_eth(hard_iface->net_dev->dev_addr,
>                                         net_dev->dev_addr))
>
> So it goes through the list of ethernet interfaces (which are currently
> attached to a batadv interface) and compares it with the new device's MAC
> address. And it seems like the new device doesn't have the mac address pa=
rt
> initialized yet.
>
> Is this allowed in NETDEV_REGISTER/NETDEV_POST_TYPE_CHANGE?
>
> > Uninit was stored to memory at:
> >   kmsan_save_stack_with_flags mm/kmsan/kmsan.c:150 [inline]
> >   kmsan_internal_chain_origin+0xbd/0x170 mm/kmsan/kmsan.c:317
> >   kmsan_memcpy_memmove_metadata+0x25c/0x2e0 mm/kmsan/kmsan.c:253
> >   kmsan_memcpy_metadata+0xb/0x10 mm/kmsan/kmsan.c:273
> >   __msan_memcpy+0x56/0x70 mm/kmsan/kmsan_instr.c:129
> >   set_ethernet_addr drivers/net/usb/rtl8150.c:282 [inline]
> >   rtl8150_probe+0x1143/0x14a0 drivers/net/usb/rtl8150.c:912
>
> This looks like it should store the mac address at this point.
>
>     static inline void set_ethernet_addr(rtl8150_t * dev)
>     {
>         u8 node_id[6];
>
>         get_registers(dev, IDR, sizeof(node_id), node_id);
>         memcpy(dev->netdev->dev_addr, node_id, sizeof(node_id));
>     }
>
> But it seems more like get_registers failed and the uninitialized was sti=
ll
> copied to the mac address. Thus causing the KMSAN error in batman-adv.
Yes, most of such reports is usually because functions like
get_registers() fail or read 0 bytes.

> Is this interpretation of the KMSAN output correct or do I miss something=
?
>
> Kind regards,
>         Sven



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
