Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 11 Feb 2014 18:35:52 +0100
References: <1391874306-15627-1-git-send-email-sw@simonwunderlich.de>
 <52FA5D35.6020809@meshcoding.com>
In-Reply-To: <52FA5D35.6020809@meshcoding.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201402111835.52663.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint] batman-adv: fix potential
	orig_node reference leak
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
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

> On 08/02/14 16:45, Simon Wunderlich wrote:
> > Since batadv_orig_node_new() sets the refcount to two, assuming that
> > the calling function will use a reference for putting the orig_node into
> > a hash or similar, both references must be freed if initialization of
> > the orig_node fails. Otherwise that object may be leaked in that error
> > case.
> > 
> > Reported-by: Antonio Quartulli <antonio@meshcoding.com>
> > Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> > ---
> > 
> >  bat_iv_ogm.c |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
> > index 6f4fcdc..6000337 100644
> > --- a/bat_iv_ogm.c
> > +++ b/bat_iv_ogm.c
> > @@ -256,6 +256,8 @@ batadv_iv_ogm_orig_get(struct batadv_priv *bat_priv,
> > const uint8_t *addr)
> > 
> >  free_bcast_own:
> >  	kfree(orig_node->bat_iv.bcast_own);
> >  
> >  free_orig_node:
> > +	/* free twice, as batadv_orig_node_new set refcount to 2 */
> > +	batadv_orig_node_free_ref(orig_node);
> > 
> >  	batadv_orig_node_free_ref(orig_node);
> 
> Coudln't we just invoke kfree(orig_node) here ? I think that if we hit
> this point it is because the node has not added to the hash and
> therefore it i snot used in any other context. This way we avoid the
> double free_ref() and we don't trgger the whole RCU mechanism.
> 
> Or am I missing something?

What about already allocated substructures like bat_iv.bcast_own, 
bat_iv.bacst_own_sum etc? Of course we could find out which is already 
allocated and free that too, but that orig node free function does already 
that.

Cheers,
    Simon
