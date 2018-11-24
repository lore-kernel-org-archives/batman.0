Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 Nov 2018 21:52:36 +0100
Message-ID: <2150224.WNsGD1XmFl@sven-desktop>
In-Reply-To: <20181123161359.13342-12-sven@narfation.org>
References: <20181123161359.13342-1-sven@narfation.org>
 <20181123161359.13342-12-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] [RFC v2 11/19] batman-adv: Add gateway mesh genl
 configuration
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
Cc: Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org

On Freitag, 23. November 2018 17:13:51 CET Sven Eckelmann wrote:
> +       /** @BATADV_GW_MODE_CLIENT: announce itself as gatway server */
> +       BATADV_GW_MODE_SERVER,

The kernel-doc should actually be for BATADV_GW_MODE_SERVER.

[...]
> +               if (sel_class < 1 || sel_class > sel_class_max) {
> +                       atomic_set(&bat_priv->gw.sel_class, sel_class);
> +                       batadv_gw_reselect(bat_priv);
> +               }

Should have been:

    if (sel_class >= 1 && sel_class <= sel_class_max) {

Kind regards,
	Sven


