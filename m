Return-Path: <linus.luessing@web.de>
Date: Tue, 10 Sep 2013 01:16:27 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20130909231626.GB6492@Linus-Debian>
References: <1378690742-19656-1-git-send-email-nils@nilsschneider.net>
 <20130909150831.GA11737@pandem0nium>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130909150831.GA11737@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: free globals. Fixes memory leak
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Mon, Sep 09, 2013 at 05:08:31PM +0200, Simon Wunderlich wrote:
> Hrm, apart from that this patch lacks a commit message and signoff, what does it help
> freeing stuff just before the program exits? This will free anything automatically
> anyway ...
> 

Hm, the advantage of freeing such memory in the code is that
for one thing it makes valgrind happy :P. And this in turn makes
finding "real" memory leaks easier. And besides, isn't it a better
coding style to free such global variables, too?

I think I'd love seeing a PATCHv2 of this one. And I guess only a
short, two sentence commit message should be sufficient as this
isn't a very invasive patch. For instance:

"This patch fixes a non-serious memory leak on program exit by
freeing the memory allocated for the globals variables. This makes
valgrind happy, too.

Signed-off-by: ..."


Cheers, Linus


PS: Sorry, I had a glance over this patch before it got submitted
but even though I should be somehow familiar with the prefered
coding style, I didn't object.
