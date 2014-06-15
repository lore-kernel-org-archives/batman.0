Return-Path: <michael.holcman1@free.fr>
Date: Sun, 15 Jun 2014 18:45:54 +0200 (CEST)
From: michael.holcman1@free.fr
Message-ID: <210461182.64990752.1402850754296.JavaMail.root@spooler5n-g27.priv.proxad.net>
In-Reply-To: <1841389.FSiWv9YRfC@diderot>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] question about batman-adv auto run
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
To: Marek Lindner <mareklindner@neomailbox.ch>
Cc: martin@hundeboll.net, b a t m a n <b.a.t.m.a.n@lists.open-mesh.org>

Yes, this on open wrt.

----- Mail original -----
De: "Marek Lindner" <mareklindner@neomailbox.ch>
=C3=80: "b a t m a n" <b.a.t.m.a.n@lists.open-mesh.org>
Cc: "michael holcman1" <michael.holcman1@free.fr>, martin@hundeboll.net
Envoy=C3=A9: Dimanche 15 Juin 2014 16:41:57
Objet: Re: [B.A.T.M.A.N.] question about batman-adv auto run

On Sunday 15 June 2014 15:49:35 michael.holcman1@free.fr wrote:
> Do you know how to auto run batman-adv, because, i have no answer where i
> write:/etc/init.d enable ?
>=20
> Where i can located the configure fils as following ?
>=20
>=20
> config 'mesh' 'bat0'
>         option 'interface' 'wlan0' 'bride'
>         option 'aggregated_ogms'
>         option 'ap_isolation'
>         option 'bonding'
>         option 'fragmentation'
>         option 'gw_bandwidth'
>         option 'gw_mode'
>         option 'gw_sel_class'
>         option 'log_level' 'all'
>         option 'orig_interval' '500'
>         option 'vis_mode'
>         option 'bridge_loop_avoidance' '1'
>         option 'distributed_arp_table'
>         option 'network_coding'
>         option 'hop_penalty'

Are we talking about batman-adv on OpenWrt ? If so, you can read our=20
documentation:=20
http://www.open-mesh.org/projects/batman-adv/wiki/Batman-adv-openwrt-config


Cheers,
Marek
