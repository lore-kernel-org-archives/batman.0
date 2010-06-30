Return-Path: <linus.luessing@web.de>
Date: Wed, 30 Jun 2010 20:23:13 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100630182313.GA22565@Sellars>
References: <1277867781-10472-1-git-send-email-linus.luessing@web.de>
	<201006301221.09773.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201006301221.09773.sven.eckelmann@gmx.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Add last-seen in originator
 table
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
To: b.a.t.m.a.n@lists.open-mesh.org

On Wed, Jun 30, 2010 at 12:21:08PM +0200, Sven Eckelmann wrote:
> Linus Lüssing wrote:
> > From: mesh-node <mesh-node@mesh-node1.(none)>
> I think the person who applies this should remove the From and the next empty 
> line... or do you have a secret dwarf named mesh-node who works for you? :D
Ah no, I wanted to keep this a secret... I also just noticed this
when I reread my post here, didn't notice the wrong From in
the patch file. Hope the commiter doesn't mind changing that to
not make other kernel devs jealous about my dwarf? :)
> 
> 
> > Right now, there is no easy/intuitive way to find out whether a node
> > might have vanished. This commit adds the time when a node was last seen
> > to the originator table output, so that a common user is able to tell
> > whether a node might have gone without having to wait PURGE_TIMEOUT
> > seconds until that node gets "garbe-collected".
> 
> The rest looks good, but was a little bit irritated about the change of the 
> table header (which makes sense to split it in two lines, but didn't expected 
> that this patch does that).
Oki doki, just did that in the same patch because the extra info
made the line a little bit long. Is adding a line like this fine?

"It also puts the the versioning information in an extra line, as
the first one of this debug output would otherwise get too long."
> 
> Best regards,
> 	Sven
Thanks for reviewing, Sven

Cheers, Linus
