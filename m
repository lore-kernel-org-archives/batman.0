Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 24 Apr 2013 03:43:06 +0800
References: <1366474654-26361-1-git-send-email-martin@hundeboll.net>
 <201304240317.27196.lindner_marek@yahoo.de>
 <20130423193004.GA16603@ritirata.org>
In-Reply-To: <20130423193004.GA16603@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201304240343.06405.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: Receive fragmented
	packets and merge
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

On Wednesday, April 24, 2013 03:30:04 Antonio Quartulli wrote:
> On Wed, Apr 24, 2013 at 03:17:26AM +0800, Marek Lindner wrote:
> > On Sunday, April 21, 2013 00:17:33 Martin Hundeb=F8ll wrote:
> > > +	/* Make room for the rest of the fragments. */
> > > +	if (pskb_expand_head(skb_out, 0, size - skb->len, GFP_ATOMIC) < 0) {
> > > +		kfree_skb(skb_out);
> > > +		goto free;
> > > +	}
> >=20
> > If pskb_expand_head() really fails this function will lead to a crash
> > because skb_out points to undefined memory.
>=20
> I'm not sure about this. pskb_expand_head() can only fail in the early
> phase and in that case it seems to return the original skb as it was.

I guess I did not make myself sufficiently clear: If pskb_expand_head() fai=
ls=20
the skb is free'd with "kfree_skb(skb_out);" followed by a jump to "free"=20
where the recently free'd buffer is returned ...


> > Btw, is pskb_expand_head() enough to handle all cases ? Did you try this
> > with a large (4000 bytes or more) packet ?
>=20
> I don't personally see any problem with this. But maybe I am overlooking
> something..however, proper testing will make everybody happy :P

Agreed. I wasn't sure there is a problem but wanted to know whether it was=
=20
tested.

Cheers,
Marek
