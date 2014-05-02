Return-Path: <linus.luessing@web.de>
Date: Fri, 2 May 2014 07:34:25 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20140502053425.GU4593@Linus-Debian>
References: <1394568273-1117-1-git-send-email-linus.luessing@web.de>
 <1411989.q42HG6dQ0k@diderot> <20140421015821.GP5762@Linus-Debian>
 <1673142.EzxFvMW6vz@diderot> <20140421104257.GQ5762@Linus-Debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20140421104257.GQ5762@Linus-Debian>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 2/2] batctl: add unicast/multicast
 address filter option for TT output
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

On Mon, Apr 21, 2014 at 12:42:57PM +0200, Linus Lüssing wrote:
> 
> 
> On Mon, Apr 21, 2014 at 11:27:23AM +0800, Marek Lindner wrote:
> > On Monday 21 April 2014 03:58:21 Linus Lüssing wrote:
> > > Hm, was it? Can't find it - am I looking at the wrong places?
> > 
> > Where are you looking ? 
> > 
> > git show 6202831
> > 
> > 
> 
> git show 6202831 does indeed show it for me. However this one
> doesn't:
> 
> $ git branch --contains 6202831
> 
> Also on http://git.open-mesh.org/batctl.git I don't seem to be
> able to find it, like:
> 
> http://git.open-mesh.org/batctl.git?a=search&h=HEAD&st=commit&s=multicast+address+filter+option
> 
> Cheers, Linus

Doing a clean git clone: The change is there, but - git blame/diff
tell me it's actually in 6a0489b4. Did this patch accidentally
get squashed into 6a0489b4 ("batctl: add switch for setting
multicast_mode")?
