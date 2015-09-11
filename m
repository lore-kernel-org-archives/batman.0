Return-Path: <andrew@lunn.ch>
Date: Fri, 11 Sep 2015 17:38:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20150911153847.GA4759@lunn.ch>
References: <1441980723-3805-1-git-send-email-sw@simonwunderlich.de>
 <20150911151956.GF19674@ibawizard.net> <3031965.xR9RMR6qaB@prime>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3031965.xR9RMR6qaB@prime>
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint] batman-adv: lock crc access
	in	bridge loop avoidance
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

On Fri, Sep 11, 2015 at 05:43:48PM +0200, Simon Wunderlich wrote:
>=20
> On Friday 11 September 2015 17:19:56 Petr =C5 tetiar wrote:
> > Hi,
> >=20
> > Simon Wunderlich <sw@simonwunderlich.de> [2015-09-11 16:12:03]:
> > > @@ -1669,11 +1685,15 @@ int batadv_bla_claim_table_seq_print_text(str=
uct
> > > seq_file *seq, void *offset)>=20
> > >  		hlist_for_each_entry_rcu(claim, head, hash_entry) {
> > >  	=09
> > >  			is_own =3D batadv_compare_eth(claim->backbone_gw->orig,
> > >  		=09
> > >  						    primary_addr);
> > >=20
> > > +
> > > +			spin_lock_bh(&claim->backbone_gw->crc_lock);
> > > +			backbone_crc =3D claim->backbone_gw->crc;
> > > +			spin_lock_bh(&claim->backbone_gw->crc_lock);
> >=20
> > shouldn't this be spin_unlock_bh?
>=20
> Oh my, good catch! Yes, that's right!! I'll send a revised version!

Hi Simon

make C=3D2 is a good way to catch these.=20

     Andrew
