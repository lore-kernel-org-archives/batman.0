Return-Path: <linus.luessing@web.de>
Date: Mon, 21 Apr 2014 03:58:21 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20140421015821.GP5762@Linus-Debian>
References: <1394568273-1117-1-git-send-email-linus.luessing@web.de>
 <1394568273-1117-2-git-send-email-linus.luessing@web.de>
 <1411989.q42HG6dQ0k@diderot>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1411989.q42HG6dQ0k@diderot>
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
To: Marek Lindner <mareklindner@neomailbox.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Wed, Mar 12, 2014 at 03:32:37PM +0800, Marek Lindner wrote:
> On Tuesday 11 March 2014 21:04:33 Linus Lüssing wrote:
> > This patch adds the new "-u" and "-m" options for the local and global
> > translation table output to only display announced unicast or multicast
> > mac addresses to enhance readability.
> > 
> > Signed-off-by: Linus Lüssing <linus.luessing@web.de>
> > ---
> > v3: unchanged
> > 
> >  debug.c      |   32 +++++++++++++++++++++++++++++++-
> >  functions.c  |   22 ++++++++++++++++++++++
> >  functions.h  |    2 ++
> >  man/batctl.8 |    2 ++
> >  4 files changed, 57 insertions(+), 1 deletion(-)
> 
> Applied in revision 6202831.
> 
> Thanks,
> Marek

Hi Marek,

Hm, was it? Can't find it - am I looking at the wrong places?

Cheers, Linus
