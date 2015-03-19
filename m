Return-Path: <APape@phoenixcontact.com>
In-Reply-To: <550AF2DD.5000707@meshcoding.com>
References: <OF5389A718.644E8229-ONC1257E0D.00566F9A-C1257E0D.0056A5A0@phoenixcontact.com>
 <550AF2DD.5000707@meshcoding.com>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OF05EC2858.5AFC84BB-ONC1257E0D.0059D034-C1257E0D.005CE3EF@phoenixcontact.com>
Date: Thu, 19 Mar 2015 17:54:36 +0100
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] Antwort: Re: [PATCH] batman-adv: bugfix for kernel
 crash in batadv_tt_local_table_free
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

Hi Antonio,

I saw the crash, but only in the case when I add the non-IP traffic using=20
VLAN ID 0. No interface of the mesh node is part of that VLAN, i.e. I=20
don't use further virtual VLAN interfaces on my mesh node. This VLAN=20
traffic shall only be transparently forwarded over the mesh which - by the=
=20
way - works flawlessly.=20

As soon as I remove the WLAN interface from bat0 (batctl if del ath0) I=20
get the following crash report:

/ # Unable to handle kernel paging request for data at address 0x00000020
Faulting instruction address: 0xc99c35a4
Oops: Kernel access of bad area, sig: 11 [#1]
MPC831x RDB
Modules linked in: batman_adv crc32c umac ath_dev(P) ath_rate_atheros(P)=20
ath_dfs(P) ath_hal(P) asf(P) adf t23xsec2 t23xrm spi_mpc8xxx ipv6
NIP: c99c35a4 LR: c99c8ca4 CTR: c00253ac
REGS: c654ddd0 TRAP: 0300   Tainted: P            (2.6.32.26-svn1313)
MSR: 00009032 <EE,ME,IR,DR>  CR: 84002082  XER: 20000000
DAR: 00000020, DSISR: 20000000
TASK =3D c68680e0[1105] 'bat_events' THREAD: c654c000
GPR00: 00000020 c654de80 c68680e0 00000000 00008000 c0355078 c797f3e5=20
00000080
GPR08: 00000001 00000000 00000001 00000000 44002088 100d5bc0 07ffa000=20
00000000
GPR16: fa3fdfef 00000000 00000000 00000000 00000000 00000000 00020000=20
07e958b0
GPR24: 00000000 00000174 c7b14320 c6d382c0 00000000 00000000 00200200=20
00000000
NIP [c99c35a4] batadv_softif_vlan_free_ref+0x18/0x98 [batman_adv]
LR [c99c8ca4] batadv_tt_free+0xc0/0x30c [batman_adv]
Call Trace:
[c654de80] [c99c6690] batadv_tt_local_entry_free_ref+0x38/0x48=20
[batman_adv] (unreliable)
[c654de90] [c99c8ca4] batadv_tt_free+0xc0/0x30c [batman_adv]
[c654dec0] [c99bdfb8] batadv_mesh_free+0x54/0x8c [batman_adv]
[c654dee0] [c99c34e8] batadv_softif_free+0x20/0x40 [batman_adv]
[c654df00] [c01fa2f0] netdev_run_todo+0x1a4/0x244
[c654df30] [c0206888] rtnl_unlock+0x10/0x20
[c654df40] [c01fad48] unregister_netdev+0x24/0x38
[c654df60] [c99c36cc] batadv_softif_destroy_finish+0x50/0x64 [batman_adv]
[c654df80] [c0031d44] worker_thread+0x108/0x1b0
[c654dfc0] [c0035ca0] kthread+0x78/0x7c
[c654dff0] [c0011444] kernel_thread+0x4c/0x68
Instruction dump:
4e800020 480088f1 7fe3fb78 3be00000 48008935 4bffffd8 9421fff0 7c0802a6
93e1000c 7c7f1b78 90010014 38030020 <7d200028> 3129ffff 7d20012d 40a2fff4
Kernel panic - not syncing: Fatal exception in interrupt
Rebooting in 180 seconds..


If I add the "if (vlan)" check, this doesn't happen anymore. The other=20
thing which prevents the crash is not using the VLAN ID 0 traffic.=20

Regards,
Andreas


"B.A.T.M.A.N" <b.a.t.m.a.n-bounces@lists.open-mesh.org> schrieb am=20
19.03.2015 17:01:33:

> Von: Antonio Quartulli <antonio@meshcoding.com>
> An: b.a.t.m.a.n@lists.open-mesh.org,=20
> Datum: 19.03.2015 17:03
> Betreff: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: bugfix for kernel=20
> crash in batadv_tt_local_table_free
> Gesendet von: "B.A.T.M.A.N" <b.a.t.m.a.n-bounces@lists.open-mesh.org>
>=20
> Hi Andreas,
>=20
> On 19/03/15 16:46, Andreas Pape wrote:
> > This missing check lead to a kernel crash when a hard_if is removed on=
=20
a=20
> > node forwarding
> > untagged and tagged traffic (VLANID 0) to and from the mesh network.
> >=20
>=20
> Did you actually see the crash? if so, can you please report the=20
stacktrace?
>=20
> When creating bat0 (untagged interface), a "fake" vlan object is created
> with vid =3D BATADV_NO_FLAGS, therefore in this context the object "vlan"
> should never be NULL because there is always an object to retrieve.
>=20
> Cheers,
>=20
> > Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
> > ---
> >  translation-table.c |    6 ++++--
> >  1 files changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/translation-table.c b/translation-table.c
> > index b20812b..4d3ab8d 100644
> > --- a/translation-table.c
> > +++ b/translation-table.c
> > @@ -1143,8 +1143,10 @@ static void batadv_tt_local_table_free(struct=20
> > batadv_priv *bat_priv)
> >                         /* decrease the reference held for this vlan=20
*/
> >                         vlan =3D batadv_softif_vlan_get(bat_priv,
> >  tt_common_entry->vid);
> > -                       batadv_softif_vlan_free_ref(vlan);
> > -                       batadv_softif_vlan_free_ref(vlan);
> > +                       if (vlan) {
> > +                               batadv_softif_vlan_free_ref(vlan);
> > +                               batadv_softif_vlan_free_ref(vlan);
> > +                       }
> >=20
> >                         batadv_tt_local_entry_free_ref(tt_local);
> >                 }
> >=20
>=20
> --=20
> Antonio Quartulli
>=20
> [Anhang "signature.asc" gel=F6scht von Andreas Pape/Phoenix Contact]=20


..................................................................
PHOENIX CONTACT ELECTRONICS GmbH

Sitz der Gesellschaft / registered office of the company: 31812 Bad Pyrmont
USt-Id-Nr.: DE811742156
Amtsgericht Hannover HRB 100528 / district court Hannover HRB 100528
Gesch=E4ftsf=FChrer / Executive Board: Roland Bent, Dr. Martin Heubeck
___________________________________________________________________
Diese E-Mail enth=E4lt vertrauliche und/oder rechtlich gesch=FCtzte Informa=
tionen. Wenn Sie nicht der richtige Adressat sind oder diese E-Mail irrt=FC=
mlich erhalten haben, informieren Sie bitte sofort den Absender und vernich=
ten Sie diese Mail. Das unerlaubte Kopieren, jegliche anderweitige Verwendu=
ng sowie die unbefugte Weitergabe dieser Mail ist nicht gestattet.
---------------------------------------------------------------------------=
-------------------------
This e-mail may contain confidential and/or privileged information. If you =
are not the intended recipient (or have received this e-mail in error) plea=
se notify the sender immediately and destroy this e-mail. Any unauthorized =
copying, disclosure, distribution or other use of the material or parts the=
reof is strictly forbidden.
___________________________________________________________________
