Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 26 May 2013 06:08:49 +0800
References: <1369516631-11982-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <1369516631-11982-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201305260608.50077.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Add dummy soft-interface rx
	mode handler
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

On Sunday, May 26, 2013 05:17:11 Linus L=C3=BCssing wrote:
> diff --git a/soft-interface.c b/soft-interface.c
> index 2bad57f..e40e74f 100644
> --- a/soft-interface.c
> +++ b/soft-interface.c
> @@ -137,6 +137,10 @@ static int batadv_interface_change_mtu(struct
> net_device *dev, int new_mtu) return 0;
>  }
> =20
> +static void batadv_interface_set_rx_mode(struct net_device *dev)
> +{
> +}

=46or the kernel doc I suggest to stress the point that we only add this du=
mmy=20
handler to make multicast listeners possible.

Cheers,
Marek
