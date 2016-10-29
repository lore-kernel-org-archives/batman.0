Return-Path: <joe@perches.com>
Message-ID: <1477706184.23018.3.camel@perches.com>
From: Joe Perches <joe@perches.com>
Date: Fri, 28 Oct 2016 18:56:24 -0700
In-Reply-To: <4261316.fWqmHPy2zE@sven-edge>
References: <20161027190150.7880-1-sw@simonwunderlich.de>
 <20161027190150.7880-18-sw@simonwunderlich.de>
 <1477689186.23018.1.camel@perches.com> <4261316.fWqmHPy2zE@sven-edge>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 17/17] batman-adv: Avoid precedence
	issues in macros
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, davem@davemloft.net

On Fri, 2016-10-28 at 23:27 +0200, Sven Eckelmann wrote:
> On Freitag, 28. Oktober 2016 14:13:06 CEST Joe Perches wrote:
> > On Thu, 2016-10-27 at 21:01 +0200, Simon Wunderlich wrote:
> > > From: Sven Eckelmann <sven@narfation.org>
> > > 
> > > It must be avoided that arguments to a macro are evaluated ungrouped (which
> > > enforces normal operator precendence). Otherwise the result of the macro
> > > is not well defined.
> > 
> > Curiosity:
> > 
> > in net/batman-adv/tp_meter.c
> 
> [...]
> > 	orig_node = batadv_orig_hash_find(bat_priv, tp_vars->other_end);
> > 	if (unlikely(!orig_node)) {
> > 		err = BATADV_TP_REASON_DST_UNREACHABLE;
> > 		tp_vars->reason = err;
> > 		goto out;
> > 	}
> > 
> > 	primary_if = batadv_primary_if_get_selected(bat_priv);
> > 	if (unlikely(!primary_if)) {
> > 		err = BATADV_TP_REASON_DST_UNREACHABLE;
> > 		goto out;
> > 	}
> > 
> > err is not used in the out block
> > 
> > Is the last if block supposed to set tp_vars->reason to err?
> 
> This seems to be unrelated to this patch.

Kinda.  I was looking at how the one instance of
batadv_tp_is_error was used and it's in this file.

> But yes, looks to me like it is missing. Do you want to propose a patch or
> should I do?

As you are working on this file, perhaps you should.

cheers, Joe

