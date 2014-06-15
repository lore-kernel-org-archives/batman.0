Return-Path: <michael.holcman1@free.fr>
Date: Sun, 15 Jun 2014 18:54:33 +0200 (CEST)
From: michael.holcman1@free.fr
Message-ID: <1894364203.65004399.1402851273141.JavaMail.root@spooler5n-g27.priv.proxad.net>
In-Reply-To: <539DB176.7050809@wirelesspt.net>
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
To: cmsv@wirelesspt.net
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Marek Lindner <mareklindner@neomailbox.ch>

Ok,
-I have the open wrt OS.If i understand, the configuration file as to be in=
 the  /etc/config/ and it started alone ?

-Is my configuration correct ?


thank's,


----- Mail original -----
De: "cmsv" <cmsv@wirelesspt.net>
=C3=80: "michael holcman1" <michael.holcman1@free.fr>
Cc: "The list for a Better Approach To Mobile Ad-hoc Networking" <b.a.t.m.a=
.n@lists.open-mesh.org>
Envoy=C3=A9: Dimanche 15 Juin 2014 16:45:10
Objet: Re: [B.A.T.M.A.N.] question about batman-adv auto run

This is available only in openwrt based systems.
It is in /etc/config/

There is no /etc/init.d for batman-adv. it is started along the network
setup.

On 06/15/2014 09:49 AM, michael.holcman1@free.fr wrote:
> Hello,
> Do you know how to auto run batman-adv, because, i have no answer where i=
 write:/etc/init.d enable ?
>=20
> Where i can located the configure fils as following ?
>=20
>=20
> config 'mesh' 'bat0'
> =09option 'interface' 'wlan0' 'bride'
> =09option 'aggregated_ogms'
> =09option 'ap_isolation'
> =09option 'bonding'
> =09option 'fragmentation'
> =09option 'gw_bandwidth'
> =09option 'gw_mode'
> =09option 'gw_sel_class'
> =09option 'log_level' 'all'
> =09option 'orig_interval' '500'
> =09option 'vis_mode'
> =09option 'bridge_loop_avoidance' '1'
> =09option 'distributed_arp_table'
> =09option 'network_coding'
> =09option 'hop_penalty'
>=20
> # yet another batX instance
> # config 'mesh' 'bat5'
> #=09option 'interfaces' 'second_mesh'
>=20
