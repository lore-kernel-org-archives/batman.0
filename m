Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 19 Apr 2016 04:12:57 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160419021257.GD17647@otheros>
References: <1458101205-26316-1-git-send-email-linus.luessing@c0d3.blue>
 <1458101205-26316-2-git-send-email-linus.luessing@c0d3.blue>
 <4820570.LxUU2Z3eNS@prime>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4820570.LxUU2Z3eNS@prime>
Subject: Re: [B.A.T.M.A.N.] [PATCHv12 1/4] batman-adv: Always flood IGMP/MLD
 reports
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

On Thu, Apr 07, 2016 at 03:03:11PM +0200, Simon Wunderlich wrote:
> It looks like you register two containers, one with version 1 and version 2, 
> both with the same content. Do we really need to have both containers? 
> Wouldn't it be sufficient to register only version 2 and leave version 1 out?

After a short off-list discussion with Simon, removed it now to simplify
things, avoiding minor corner case optimizations.
