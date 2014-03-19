Return-Path: <linus.luessing@web.de>
Date: Wed, 19 Mar 2014 10:38:25 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20140319093825.GI5208@Linus-Debian>
References: <1395216532-31099-1-git-send-email-antonio@meshcoding.com>
 <1395216532-31099-3-git-send-email-antonio@meshcoding.com>
 <20140319090316.GH5208@Linus-Debian>
 <53295F85.9000508@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53295F85.9000508@meshcoding.com>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 next 03/11] batman-adv: fix multicast
	kerneldoc
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

On Wed, Mar 19, 2014 at 10:12:37AM +0100, Antonio Quartulli wrote:
> Hi Linus,
> 
> On 19/03/14 10:03, Linus Lüssing wrote:
> > Hi Antonio,
> > 
> > Two things are confusing me, firstly:
> > 
> > On Wed, Mar 19, 2014 at 09:08:44AM +0100, Antonio Quartulli wrote:
> >> The kerneldoc should always use the third person singular in
> >> the long function description.
> >> Moreover it should always try use up to 80 chars per line.
> > 
> > vs.
> > 
> > On Sun, May 12, 2013 at 12:55:25AM +0200, Antonio Quartulli wrote:
> >> For some reason we agreed on not using the third person while describing the
> >> function. For consistency I'd suggest you to do the same your kernel doc.
> 
> I think the situation is a little confusing because there is no clear
> statement anywhere.
> We agreed on not using the third person in the function description, but
> we use it in the function "long" description (the one after the arguments).

I'm not quite sure about that. I specifically asked for
clarification back then and got this reply which clearly
references the longer function description:

On Thu, May 16, 2013 at 09:36:37PM +0200, Antonio Quartulli wrote:
> On Thu, May 16, 2013 at 08:16:40PM +0200, Linus Lüssing wrote:
> > > > +/**
> > > > + * batadv_mcast_mla_tt_update - Updates the own MLAs
> > > > + * @bat_priv: the bat priv with all the soft interface information
> > > > + *
> > > > + * Updates the own multicast listener announcements in the translation
> > > 
> > > For some reason we agreed on not using the third person while describing the
> > > function. For consistency I'd suggest you to do the same your kernel doc.
> > 
> > I don't quite understand what you mean, talking in the first or
> > second person seems strange, like "I update the multicast..." or
> > "You update the multicast...". Do you have an example?
> 
> It should look like:
> "Update the own multicast listener announcements in the translation"

well, but nevermind

> 
> >>
> > 
> > Secondly:
> > 
> > Why do you only change it in multicast.{c,h}, why not changing
> > things everywhere? For instance translation-table.c sometimes uses
> > "Returns", sometimes "Return".
> 
> Because these patches are meant to be squashed with what you already
> sent before I send them to David (this is why I have create dos many
> patches with different Introduced-by clauses and this is also why the
> patches are targeting next). They are not going to be sent ad a
> standalone set of changes.

Okay that makes sense then if things are getting squashed before
submission. And actually, I'd be very happy to return to the
third-person singular again, the first-person version always
sounded a little strange to me :).

What do you and others think about using third-person in the
short description, too?

Cheers, Linus
