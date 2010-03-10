Return-Path: <linus.luessing@web.de>
Date: Wed, 10 Mar 2010 15:48:51 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100310144851.GA2616@Linus-Debian>
References: <1268118917-6654-1-git-send-email-linus.luessing@web.de>
	<20100310063508.GA6312@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <20100310063508.GA6312@lunn.ch>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Add missing source-if info
 in vis raw
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Your adjusted commit message sounds good to me, sure, we can
use that one instead :).

Cheers, Linus

On Wed, Mar 10, 2010 at 07:35:08AM +0100, Andrew Lunn wrote:
> On Tue, Mar 09, 2010 at 08:15:17AM +0100, Linus L??ssing wrote:
> > With this patch, a line for each _source interface_ for every node will
> > be used in the vis raw output instead of one line per originator. This
> > stops discarding valuable information about secondary interfaces.
>=20
> Hi Linus
>=20
> Thanks for working on this bug. Since this is a bug which we want to
> fix outside of the merge window, i guess the change log entry needs to
> sound more bug like and not development work. From your comment it is
> hard to tell it is a bug. How about this which uses the word bug and
> fix.
>=20
> Staging: batman-adv: Fix VIS output bug for secondary interfaces
>=20
> TQ and HNA records for originators on secondary interfaces were
> wrongly being included on the primary interface. Ensure we output a
> line for each source interface on every node, so we correctly separate
> primary and secondary interface records.
>=20
> Since we have never submitted a bug fix out of the merge window, i've
> no idea if this is really necessary...
>=20
>    Andrew
>=20
> >=20
> > Signed-off-by: Linus L??ssing <linus.luessing@web.de>
> > ---
> >  proc.c |   33 ++++++++++++++++++++++++++-------
> >  vis.c  |   25 +++++++++----------------
> >  vis.h  |    7 +++++--
> >  3 files changed, 40 insertions(+), 25 deletions(-)
> >=20
> > diff --git a/proc.c b/proc.c
> > index 1c12613..ab5047f 100644
> > --- a/proc.c
> > +++ b/proc.c
> > @@ -370,6 +370,8 @@ static int proc_vis_data_read(struct seq_file *seq,=
 void *offset)
> >  	struct vis_info *info;
> >  	struct vis_info_entry *entries;
> >  	HLIST_HEAD(vis_if_list);
> > +	struct if_list_entry *entry;
> > +	struct hlist_node *pos, *n;
> >  	int i;
> >  	char tmp_addr_str[ETH_STR_LEN];
> >  	unsigned long flags;
> > @@ -388,17 +390,34 @@ static int proc_vis_data_read(struct seq_file *se=
q, void *offset)
> >  		info =3D hashit.bucket->data;
> >  		entries =3D (struct vis_info_entry *)
> >  			((char *)info + sizeof(struct vis_info));
> > -		addr_to_string(tmp_addr_str, info->packet.vis_orig);
> > -		seq_printf(seq, "%s,", tmp_addr_str);
> > =20
> >  		for (i =3D 0; i < info->packet.entries; i++) {
> > -			proc_vis_read_entry(seq, &entries[i], &vis_if_list,
> > -					    info->packet.vis_orig);
> > +			if (entries[i].quality =3D=3D 0)
> > +				continue;
> > +			proc_vis_insert_interface(entries[i].src, &vis_if_list,
> > +				compare_orig(entries[i].src,
> > +						info->packet.vis_orig));
> >  		}
> > =20
> > -		/* add primary/secondary records */
> > -		proc_vis_read_prim_sec(seq, &vis_if_list);
> > -		seq_printf(seq, "\n");
> > +		hlist_for_each_entry(entry, pos, &vis_if_list, list) {
> > +			addr_to_string(tmp_addr_str, entry->addr);
> > +			seq_printf(seq, "%s,", tmp_addr_str);
> > +
> > +			for (i =3D 0; i < info->packet.entries; i++)
> > +				proc_vis_read_entry(seq, &entries[i],
> > +						entry->addr, entry->primary);
> > +
> > +			/* add primary/secondary records */
> > +			if (compare_orig(entry->addr, info->packet.vis_orig))
> > +				proc_vis_read_prim_sec(seq, &vis_if_list);
> > +
> > +			seq_printf(seq, "\n");
> > +		}
> > +
> > +		hlist_for_each_entry_safe(entry, pos, n, &vis_if_list, list) {
> > +			hlist_del(&entry->list);
> > +			kfree(entry);
> > +		}
> >  	}
> >  	spin_unlock_irqrestore(&vis_hash_lock, flags);
> > =20
> > diff --git a/vis.c b/vis.c
> > index 4f1339a..fa8a487 100644
> > --- a/vis.c
> > +++ b/vis.c
> > @@ -87,7 +87,7 @@ static int vis_info_choose(void *data, int size)
> > =20
> >  /* insert interface to the list of interfaces of one originator, if it
> >   * does not already exist in the list */
> > -static void proc_vis_insert_interface(const uint8_t *interface,
> > +void proc_vis_insert_interface(const uint8_t *interface,
> >  				      struct hlist_head *if_list,
> >  				      bool primary)
> >  {
> > @@ -112,39 +112,32 @@ void proc_vis_read_prim_sec(struct seq_file *seq,
> >  			    struct hlist_head *if_list)
> >  {
> >  	struct if_list_entry *entry;
> > -	struct hlist_node *pos, *n;
> > +	struct hlist_node *pos;
> >  	char tmp_addr_str[ETH_STR_LEN];
> > =20
> > -	hlist_for_each_entry_safe(entry, pos, n, if_list, list) {
> > -		if (entry->primary) {
> > +	hlist_for_each_entry(entry, pos, if_list, list) {
> > +		if (entry->primary)
> >  			seq_printf(seq, "PRIMARY, ");
> > -		} else {
> > +		else {
> >  			addr_to_string(tmp_addr_str, entry->addr);
> >  			seq_printf(seq, "SEC %s, ", tmp_addr_str);
> >  		}
> > -
> > -		hlist_del(&entry->list);
> > -		kfree(entry);
> >  	}
> >  }
> > =20
> >  /* read an entry  */
> >  void proc_vis_read_entry(struct seq_file *seq,
> >  				struct vis_info_entry *entry,
> > -				struct hlist_head *if_list,
> > -				uint8_t *vis_orig)
> > +				uint8_t *src,
> > +				bool primary)
> >  {
> >  	char to[40];
> > =20
> >  	addr_to_string(to, entry->dest);
> > -	if (entry->quality =3D=3D 0) {
> > -		proc_vis_insert_interface(vis_orig, if_list, true);
> > +	if (primary && entry->quality =3D=3D 0)
> >  		seq_printf(seq, "HNA %s, ", to);
> > -	} else {
> > -		proc_vis_insert_interface(entry->src, if_list,
> > -					  compare_orig(entry->src, vis_orig));
> > +	else if (compare_orig(entry->src, src))
> >  		seq_printf(seq, "TQ %s %d, ", to, entry->quality);
> > -	}
> >  }
> > =20
> >  /* add the info packet to the send list, if it was not
> > diff --git a/vis.h b/vis.h
> > index 465da47..a1f92a4 100644
> > --- a/vis.h
> > +++ b/vis.h
> > @@ -49,10 +49,13 @@ struct recvlist_node {
> >  extern struct hashtable_t *vis_hash;
> >  extern spinlock_t vis_hash_lock;
> > =20
> > +void proc_vis_insert_interface(const uint8_t *interface,
> > +				      struct hlist_head *if_list,
> > +				      bool primary);
> >  void proc_vis_read_entry(struct seq_file *seq,
> >  				struct vis_info_entry *entry,
> > -				struct hlist_head *if_list,
> > -				uint8_t *vis_orig);
> > +				uint8_t *src,
> > +				bool primary);
> >  void proc_vis_read_prim_sec(struct seq_file *seq,
> >  			    struct hlist_head *if_list);
> >  void receive_server_sync_packet(struct vis_packet *vis_packet,
> > --=20
> > 1.7.0
> >=20
>=20

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLl7FTAAoJEBKw7u43QNpfwaYQAI/E9/6PLlIeErnxcA1GRMDg
Z/dGjAkChdXNRITs6vGWLBYvGp0yWvFfMUsrhH00UuVVwuttplvuWOQPbut1cLuI
fjSZnVtew5J8MuZ5+y5UqZAIcMEWaxGODs0cKaNh02nK/aQXdPR/SNYJ3XQD+7Vn
huPHrhZnN7hrwrwTAKHH0OPbLntI2jec1hqvbdeLgWQMWGpvxEWJ7ueE/blTn49V
7PVWJJY/d3HPgD4Uztnp4Sswu0MpsiTuDIWdRve1b5D+bHXfRjuPiv1B1oOSz87S
EJGz6dzuEB+NwVvBG/bcPAgx5PcFcMy03ITCnFeGrnqF/tJ12l0F700UPqcWm94u
chzSS1RBZnB/XWXt00kDwRzZ65zVIkJTlvtdwdJyZRFPzpgwv3PSneL0WoHTZWS+
rPpgle+YtGSe4uTXm9AS01MCYRtSqB9zOUrC8i/brHUzIj2T69RyDNCxBG6QH3wX
X8vsrY9qZ3rvrPrMgZ8AKtbQt5txaStvZgWJSFyVSG7Wwfy1dCmsGeRoErNhVZl0
q2SsBodKsA/y0dM4aBoN8tpReF5PIIVtUA4jry6i3PpU1aDvSa8Ihd2uYYk1Tgbn
seJdTt6DE7iHMWPFolHGrKuzJlX7rJcYDJd9k805UOHqlY9pVx1iml10QovT7h7R
HdsQWIzBv2LD/C6IKWIi
=B0Ew
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
