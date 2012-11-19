Return-Path: <bhutchings@solarflare.com>
Message-ID: <1353354018.4156.13.camel@bwh-desktop.uk.solarflarecom.com>
From: Ben Hutchings <bhutchings@solarflare.com>
Date: Mon, 19 Nov 2012 19:40:18 +0000
In-Reply-To: <5268262.CIrZ93ERtB@bentobox>
References: <1353313451-2930-1-git-send-email-ordex@autistici.org>
 <1353313451-2930-5-git-send-email-ordex@autistici.org>
 <1353351150.4156.4.camel@bwh-desktop.uk.solarflarecom.com>
 <5268262.CIrZ93ERtB@bentobox>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] [PATCH 04/10] batman-adv: export compatibility
 version via debugfs
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
To: Sven Eckelmann <sven@narfation.org>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, davem@davemloft.net

On Mon, 2012-11-19 at 20:29 +0100, Sven Eckelmann wrote:
> On Monday 19 November 2012 18:52:30 Ben Hutchings wrote:
> > On Mon, 2012-11-19 at 09:24 +0100, Antonio Quartulli wrote:
> > > Different versions of the batman-adv module may use the same compatibility
> > > version, but this is not understandable at runtime (the only way is to
> > > parse the kernel log and fetch the batman-adv advertisement message on
> > > loading). The user may want to know whether two nodes using different
> > > versions can communicate or not. For this purpose the module has to
> > > export this value through debugfs.
> > [...]
> > 
> > I do hope that you're not planning to use unstable debugfs interfaces
> > indefinitely.
> 
> Why are you refering to the adding of an file as "incompatible" debugfs 
> interface? I would call it additional information. And the rest of the commit 
> message is talking about *possible* protocol incompatibilies of the network 
> protocol (which caused this uncontrolled erruption of anger in a network 
> maintainer).

I didn't say that.  But debugfs tends to be exempted from expectations
of interface stability or cleanliness (as it's for development, not
production... right?).  It's also an optional feature that might not be
enabled at compile time or run-time.  If BATMAN is ever going to be
ready for general use it will need stable interfaces that are updated in
a backward-compatible way and don't depend on debugfs.

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.

