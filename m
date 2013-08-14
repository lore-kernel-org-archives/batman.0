Return-Path: <linus.luessing@web.de>
Date: Wed, 14 Aug 2013 17:42:19 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20130814154131.GB1162@Linus-Debian>
References: <1373242365-763-1-git-send-email-mihail.costea2005@gmail.com>
 <1373242365-763-6-git-send-email-mihail.costea2005@gmail.com>
 <20130810132043.GD849@ritirata.org>
 <CAP5XTDNHTHiU8Pak2qzj19azwCUT=qO9CHj3uv5TZXWi9-+1QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP5XTDNHTHiU8Pak2qzj19azwCUT=qO9CHj3uv5TZXWi9-+1QQ@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] [RFC 6/6] batman-adv: Adds snooping of router
 and override flags for NA creation
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
To: Mihail Costea <mihail.costea90@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Wed, Aug 14, 2013 at 06:51:32AM -0700, Mihail Costea wrote:
> On 10 August 2013 06:20, Antonio Quartulli <ordex@autistici.org> wrote:
> >>       dat_entry = kmalloc(sizeof(*dat_entry), GFP_ATOMIC);
> >>       if (!dat_entry)
> >>               goto out;
> >> +     /* some entries don't have an extra data and useful if allocation for
> >> +      * data fails */
> >
> > this comment has to be indented
> >
> > /* like
> >  * this
> >  */
> >
> >
> >
> > There are other style issues in this patch, but they mostly concern what I
> > already pointed out in the other comments.
> >
> > Remember to always check your patch with checkpatch.pl --strict in order to find
> > problems before sending the patches.
> >
> 
> I still don't know what generated some style problems. Alignments
> problems shouldn't be here because I already
> used --strict (but that didn't say anything about comments) and sent
> the patches with git mail. That is weird.
> 

These are net/ specific style requirements. Try this before
running checkpatch.pl:

sed -i "s#^--- a/#--- a/net/batman-adv/#;s#^+++ b/#+++ b/net/batman-adv/#" *.patch

Cheers, Linus
