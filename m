Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 24 Jan 2013 21:59:51 +0800
References: <1358763746-16742-1-git-send-email-martin@hundeboll.net>
 <1358763746-16742-3-git-send-email-martin@hundeboll.net>
In-Reply-To: <1358763746-16742-3-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201301242159.51246.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 2/6] batman-adv: Detect coding nodes
	and remove these after timeout
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

On Monday, January 21, 2013 18:22:22 Martin Hundeb=C3=B8ll wrote:
> @@ -430,9 +440,12 @@ struct batadv_priv_dat {
>  /**
>   * struct batadv_priv_nc - per mesh interface network coding private data
>   * @work: work queue callback item for cleanup
> + * @min_tq: only consider neighbors for encoding if neigh_tq > min_tq
>   */
>  struct batadv_priv_nc {
>         struct delayed_work work;
> +       struct dentry *debug_dir;
> +       u8 min_tq;
>  };
> =20

Kernel doc for debug_dir ?

Cheers,
Marek
