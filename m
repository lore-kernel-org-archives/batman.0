Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 15 Jun 2014 22:41:57 +0800
Message-ID: <1841389.FSiWv9YRfC@diderot>
In-Reply-To: <1923128878.64697034.1402840175117.JavaMail.root@spooler5n-g27.priv.proxad.net>
References: <1923128878.64697034.1402840175117.JavaMail.root@spooler5n-g27.priv.proxad.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1928841.TOoSMLvCQs";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: michael.holcman1@free.fr, martin@hundeboll.net


--nextPart1928841.TOoSMLvCQs
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 15 June 2014 15:49:35 michael.holcman1@free.fr wrote:
> Do you know how to auto run batman-adv, because, i have no answer where i
> write:/etc/init.d enable ?
> 
> Where i can located the configure fils as following ?
> 
> 
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

Are we talking about batman-adv on OpenWrt ? If so, you can read our 
documentation: 
http://www.open-mesh.org/projects/batman-adv/wiki/Batman-adv-openwrt-config


Cheers,
Marek

--nextPart1928841.TOoSMLvCQs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJTnbC5AAoJEFNVTo/uthzAp8sH/3H1sXB24zDmLozIXRP4LXyh
F1id+HTXXrNZw2cq2Uvj/fw4//Xj9OToKsn51k/SP857vGeYsI8EEhGPNqo/KnDv
SJ4cS+CNfJP+TbuKF4hBO7Dzif0fpCtBpEUrCMOB9XrvZF/pJH7YEJVpQoWoohEU
9KZkMn4yURtErDF11Sz4yERoDLXxArM7bqJnyjxoNQyX+rEwqFyJF3N34/3mBH2i
ioI1IBczLi1g9lVcbG42kZ3KGJMvgXdq5yrmROLWF39ftiNdmfvmikIY4BXUb+zb
YDKICH8tw+mlJfQJit4bSSS8kwtJ63PPE1xKIWFQBIP8R7Nj32kUXmEBzbDiow4=
=ZPjJ
-----END PGP SIGNATURE-----

--nextPart1928841.TOoSMLvCQs--

