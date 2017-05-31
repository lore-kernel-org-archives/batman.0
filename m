Return-Path: <linus.luessing@c0d3.blue>
Date: Wed, 31 May 2017 17:56:31 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20170531155631.GG29826@otheros>
References: <OF367AF97D.9569B75C-ONC1258131.00480417-C1258131.00491EA2@phoenixcontact.com>
 <13855542.45yYzsjnKj@prime> <20170531142013.GD29826@otheros>
 <8268015.CIqWAenRvX@prime>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8268015.CIqWAenRvX@prime>
Subject: Re: [B.A.T.M.A.N.] MAC addresses of loop detect frames in global
 translation-table
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

On Wed, May 31, 2017 at 04:40:56PM +0200, Simon Wunderlich wrote:
> we actually want those frames to pass through the mesh - otherwise we can't 
> find out if "regular" packets would loop through the mesh, so we have handle 
> those special packets like regular ones.

Ah, okay, thanks for the clarification! :)

> If we don't want to see them, we have to hide them, but we can't remove the 
> packet without hurting the functionality. :)

Yes, then filtering in batadv_tt_global_add() makes sense.

Although, sending these mesh wide sounds like it could create quite
some overhead? Is this new to BLA2?

Regards, Linus
