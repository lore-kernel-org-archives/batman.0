Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 28 May 2013 17:55:44 +0800
References: <1369583768-15280-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <1369583768-15280-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201305281755.44921.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Add dummy soft-interface
	rx mode handler
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

On Sunday, May 26, 2013 23:56:07 Linus L=C3=BCssing wrote:
> @@ -572,6 +584,7 @@ static const struct net_device_ops batadv_netdev_ops =
=3D
> { .ndo_get_stats =3D batadv_interface_stats,
>         .ndo_set_mac_address =3D batadv_interface_set_mac_addr,
>         .ndo_change_mtu =3D batadv_interface_change_mtu,
> +       .ndo_set_rx_mode =3D batadv_interface_set_rx_mode,
>         .ndo_start_xmit =3D batadv_interface_tx,
>         .ndo_validate_addr =3D eth_validate_addr,
>         .ndo_add_slave =3D batadv_softif_slave_add,

Do we need compat code for this API call ?

Cheers,
Marek
