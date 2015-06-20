Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 20 Jun 2015 10:26:31 +0200
Message-ID: <1847613.Lr5mR0jfaA@sven-edge>
In-Reply-To: <1434721827-4935-1-git-send-email-mareklindner@neomailbox.ch>
References: <1434721827-4935-1-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart179352011.yekSNJPKLH";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: protect tt request from
	double deletion
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>


--nextPart179352011.yekSNJPKLH
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 19 June 2015 21:50:27 Marek Lindner wrote:
> The list_del() call was changed to hlist_del_init() to allow
> take advantage of the hlist_unhashed() check prior to deletion
> in batadv_tt_req_node_new().
> 
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> ---
> v2: removed redundant hlist_unhashed() check & reword commit message

list_del_init would also work. It is not necessary to switch to hlists for 
this feature. It is not possible with RCU but this is not used here.

list_del_init doesn't have a special "list_empty" or (not really existing) 
"list_unhashed". It is not required because list_del_init on an initialized 
list_head which is not in a list will only access this list_head and end up 
with the same list_head.

The problem with the old code is unknown state of the tt_req_node in 
batadv_send_tt_request. This node could either be in the list (valid state) or 
already be deleted from it. The deletion state had prev and next pointer of 
this node in an undefined state (either pointing to nodes in its old list, 
"random" memory regions or at poisoned addresses). This can be avoided by 
using list_del_init  + locking for this list. All correctly initialized nodes 
will then either be inside a list or have prev+next pointing to itself. 
Calling again list_del_init on a node which has prev+next pointing to itself 
is safe and will neither change the state of the node or other objects.

Kind regards,
	Sven

[...]
> -	list_for_each_entry_safe(node, safe, &bat_priv->tt.req_list, list) {
> -		list_del(&node->list);
> +	hlist_for_each_entry_safe(node, safe, &bat_priv->tt.req_list, list) {
> +		hlist_del_init(&node->list);

This would only need a change to list_del_init

[...]
>  	spin_lock_bh(&bat_priv->tt.req_list_lock);
> -	list_for_each_entry_safe(node, safe, &bat_priv->tt.req_list, list) {
> +	hlist_for_each_entry_safe(node, safe, &bat_priv->tt.req_list, list) {
>  		if (batadv_has_timed_out(node->issued_at,
>  					 BATADV_TT_REQUEST_TIMEOUT)) {
> -			list_del(&node->list);
> +			hlist_del_init(&node->list);

Same here

[...]
> @@ -2548,7 +2550,8 @@ out:
>  		batadv_hardif_free_ref(primary_if);
>  	if (ret && tt_req_node) {
>  		spin_lock_bh(&bat_priv->tt.req_list_lock);
> -		list_del(&tt_req_node->list);
> +		/* hlist_del_init() verifies tt_req_node still is in the list */
> +		hlist_del_init(&tt_req_node->list);
>  		spin_unlock_bh(&bat_priv->tt.req_list_lock);
>  		kfree(tt_req_node);
>  	}

And here (and this is most likely the only reason why you do all this).

[...]
> @@ -2982,10 +2986,10 @@ static void batadv_handle_tt_response(struct
> batadv_priv *bat_priv,
> 
>  	/* Delete the tt_req_node from pending tt_requests list */
>  	spin_lock_bh(&bat_priv->tt.req_list_lock);
> -	list_for_each_entry_safe(node, safe, &bat_priv->tt.req_list, list) {
> +	hlist_for_each_entry_safe(node, safe, &bat_priv->tt.req_list, list) {
>  		if (!batadv_compare_eth(node->addr, resp_src))
>  			continue;
> -		list_del(&node->list);
> +		hlist_del_init(&node->list);

And here

--nextPart179352011.yekSNJPKLH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVhSO6AAoJEF2HCgfBJntGWRYP/2xHcovH53grOrUVxkwVMGy8
ZQh+t2BaVajxTbB24cnWyI/0Edl+qoU4qOI8jnj3K3DMgJocnOsN7u53Gez7ue7B
MCUrUOFv4Ni8D+/vQ1jNXqR4LNpPwcYgo287AOz8vOhVZGLq6RDtMQx/jDYQCsBr
Y3s/g3GnR82yOrFS/YZZaa2JTvJIFyMexcTFfPuzZLat2pLPtNvkediLLjXfeUzU
ENIRn24L0fN2BdJaIzsJLgS3Grk055cengOjcEQJNQqG081EMbH8WcVF3nMCc57A
SsNUZfIrK1rXunTLmxJgz7c73+35EfJPN3mNb4jwPDHP7gPbJ9gazZQLnagWBOt9
PxUnz9z6OVxup+/dzI4uPQt9aXW5tr1SOpoFwRr+7PLKVQccChQpFgLx4pMSYoas
Fz9QN+ChegrpTnodOuLObNFgpHdC7QVjm/OYxeyJ2tVeiOf6hsXIAa5ihmS+Abfi
aDQxYjdPfxodThqKGqoMEk+J95OwVxRxvkyVmEJrZC4UygPY+7PFa/5RZJ+5eaxj
+DVaZ0uwc9JXKy7OSF1wFxe0hAvJO6gCavVD5bF3lg0ZZvFvb00DqmaCzV8LpKjZ
gULmmO+daEy+AHekUlaVD4JaQvOCpTZRJAyuRHRgYf1rr3zaIeSblxXdYcI3oTY9
cSzyx7IXSboKx9WooMPC
=v7y9
-----END PGP SIGNATURE-----

--nextPart179352011.yekSNJPKLH--

