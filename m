Return-Path: <linus.luessing@c0d3.blue>
Date: Sat, 1 Jul 2017 18:47:11 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20170701164711.GA13650@otheros>
References: <20170623154826.7792-1-linus.luessing@c0d3.blue>
 <3606832.Ug1eaxX1Ot@lafayette>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3606832.Ug1eaxX1Ot@lafayette>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix TT sync flag
 inconsistencies
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

Hi Marek,

Thanks for having a first glance at this patch!

On Sat, Jul 01, 2017 at 11:34:37PM +0800, Marek Lindner wrote:
> On Friday, June 23, 2017 5:48:26 PM HKT Linus Lüssing wrote:
> > @@ -1946,6 +1977,7 @@ batadv_tt_global_dump_subentry(struct sk_buff *msg,
> > u32 portid, u32 seq, struct batadv_tt_orig_list_entry *orig, bool best)
> >  {
> > +       u16 flags = (common->flags & (~BATADV_TT_SYNC_MASK)) | orig->flags;
> 
> Why do we need to output the combined global (partially masked) and the flags 
> propagated by originator ? Shouldn't writing orig->flags be what we want ?

I thought it'd be helpful to be able to look at the sync flags
on a per originator basis. So that users can more easily spot nodes with
broken flags and can take action sooner.

Next to Simon's report we have had two more, independent reporters
stumbling over the same issue later. This would help people to more
easily identify which nodes and maybe what kind of nodes are usually
sending broken packets. Parsing the "batctl log" for that is also
possible for this, but not as easy as looking at "batctl tg". And
"batctl log" isn't available in a batman-adv default build anyway.

Does that make sense?

Regards, Linus
