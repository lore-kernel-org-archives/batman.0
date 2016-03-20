Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 20 Mar 2016 18:45:29 +0800
Message-ID: <9014983.RsdMSR9Elr@voltaire>
In-Reply-To: <1457189627-8839-1-git-send-email-sven@narfation.org>
References: <1457189627-8839-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1980324.JmLi8GshWB";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Reduce refcnt of
	removed router when updating route
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

--nextPart1980324.JmLi8GshWB
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, March 05, 2016 15:53:47 Sven Eckelmann wrote:
> --- a/net/batman-adv/routing.c
> +++ b/net/batman-adv/routing.c
> @@ -104,6 +104,8 @@ static void _batadv_update_route(struct batadv_priv
> *bat_priv, neigh_node = NULL;
>  
>         spin_lock_bh(&orig_node->neigh_list_lock);
> +       curr_router = rcu_dereference_protected(orig_ifinfo->router, true);
> +
>         rcu_assign_pointer(orig_ifinfo->router, neigh_node);
>         spin_unlock_bh(&orig_node->neigh_list_lock);
>         batadv_orig_ifinfo_free_ref(orig_ifinfo);

Don't we also need to check for curr_router->refcount > 0 to mimic the check 
above ? Maybe a negative refcount does not hurt or is it unsigned ?

Cheers,
Marek

--nextPart1980324.JmLi8GshWB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW7n9JAAoJEFNVTo/uthzAixIIAIU2IEATiEzKWE2RX30DLoB4
DxxYI/oUprJvWRZ8IDr38tcL8sQq1aqvGWsY1JuRjlAw/WLKvsWxHe/W8BpKDF8B
8H98HhkrW4ppOhocaiXmkaEudE+oRGmXTXtA6w6w5Czd34bTgdFL0LoYfcZPEHQ9
tKw2X1cD+bj8kJ9JPVQdf+gvQL/LRMh7MKBs4D4cYY7t8UCb/AYr5Tu8GlS+F3oN
hUsduGarFiYjdePqPFbl5WwV+nYOQH1M93UusClbQPhiIEzqcGOMOEzOEkRG9OaU
NnBH76Nwjuoo1bQf8j7Gjo6A5s0mJaDLFSXiJHkSd+WsZ1GWh69KvWOJjwFiu/8=
=eeMr
-----END PGP SIGNATURE-----

--nextPart1980324.JmLi8GshWB--

