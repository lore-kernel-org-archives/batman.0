Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 18 Oct 2016 23:24:42 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20161018212442.GG6366@otheros>
References: <20161018212125.32010-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20161018212125.32010-1-linus.luessing@c0d3.blue>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: compat: Substitute compat
 code for netlink constification
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

On Tue, Oct 18, 2016 at 11:21:25PM +0200, Linus Lüssing wrote:
> Substitutes the compat-patches approach for the netlink const changes to
> the prefered way of using compat-includes.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---

Actually, it isn't a substitution yet, the compat-patches thing is
still there.

Let me know what you think about this approach and if you like it
what I should do about the replacements.sh.
