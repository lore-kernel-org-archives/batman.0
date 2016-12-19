Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 19 Dec 2016 11:50:27 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20161219105027.GL6323@otheros>
References: <20161006064142.20003-1-linus.luessing@c0d3.blue>
 <20161006064142.20003-4-linus.luessing@c0d3.blue>
 <9817609.KyospJ5FZq@sven-edge> <31536424.nRq5nXL76i@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31536424.nRq5nXL76i@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 3/4] batman-adv: Introduce packet type
 independent TVLV handler API
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

On Wed, Dec 14, 2016 at 09:12:00PM +0100, Sven Eckelmann wrote:
> On Mittwoch, 14. Dezember 2016 21:03:05 CET Sven Eckelmann wrote:
> > On Donnerstag, 6. Oktober 2016 08:41:40 CET Linus Lüssing wrote:
> > > +       void *ctx = batadv_tvlv_ogm_pack_ctx(orig_node);
> > > +       const struct ethhdr *ethhdr = eth_hdr(skb);
> > > +       unsigned int tvlv_offset = sizeof(*ogm2);
> > 
> > Haven't checked the complete code yet but isn't an increase of the
> > reference counter for orig_node missing here? Things like
> > batadv_gw_tvlv_ogm_handler would then have to take care of dropping
> > the reference.
> 
> Ok, forget that. batadv_tvlv_containers_process2 (which is the only user of
> ctx) is directly calling the function and not delaying anything. I was under
> the impression that their might be an delay.
> 
> But I am really not sure why you are using batadv_tvlv_ogm_pack_ctx anyway.
> You should be able to use "void *ctx" in batadv_tvlv_ogm_pack_ctx parameter
> and then give it an struct batadv_orig_node *. Or is is just for the WARN_ON?

Hm, no, had nothing to do with the WARN_ON. The idea was to have
the nasty (void *) casting at least at some well-defined place.

And didn't use "void *ctx" as a parameter of _pack_ctx() directly,
to have at least some compile-time verification regarding the
types.


I wanted to have something a little similar to the way icmp_hdr(), icmp6_hdr(),
ipv6_hdr() etc. do the casting, for instance, hm.

(or maybe I should add something like a "struct batadv_tvlv_ctx {
void *ctx };" then, to really get rid of the void pointers in the
functions calling the _pack()/_unpack() ones?)
