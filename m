Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 19 Apr 2016 04:28:38 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160419022838.GF17647@otheros>
References: <1461031839-31182-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1461031839-31182-1-git-send-email-linus.luessing@c0d3.blue>
Subject: Re: [B.A.T.M.A.N.] [PATCHv13 0/4] Multicast optimizations for
	bridges
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

On Tue, Apr 19, 2016 at 04:10:35AM +0200, Linus Lüssing wrote:
> Changes in v13:
> * Substituted a non-breaking space with a boring one
> * Dropped compat code for kernels < 3.2
> * Removed mcast tvlv container and handler support for v1 completely
> * Rebase to current master branch
>   (automatic 3-way merge without issues)

The last changes in v13 are just compile and not runtime tested so
far. Hopefully will do this within the next few days. But, ehm,
should be minor anyways (..., which were the last words he mumbled
before stepping on the deadly null pointer :P).

But I thought, it might be a good idea to mail them already in
case Simon wants to do his testing in parallel this weekend :).

Regards, Linus
