Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 21 Aug 2016 05:35:00 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160821033500.GB29805@otheros>
References: <20160821032534.11074-1-linus.luessing@c0d3.blue>
 <20160821032534.11074-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160821032534.11074-2-linus.luessing@c0d3.blue>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: elp: skb network header
 API instead of skb->data access
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

On Sun, Aug 21, 2016 at 05:25:33AM +0200, Linus Lüssing wrote:
> Instead of playing with skb attributes directly, let's use the
> appropriate, more descriptive API instead.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---

Sorry, was on the maint branch when writing and
git-format-patch'ing this. While "git am *.patch" fails,
"git am --3way *.patch" works and looks good to me.
