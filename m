Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 1 Nov 2016 01:24:29 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20161101002429.GB3264@otheros>
References: <1637163.TC9CcXIrIP@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1637163.TC9CcXIrIP@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH 0/6] batman-adv: Revert coccinelle compat
 support
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

Hi Sven,

On Mon, Oct 31, 2016 at 08:35:40AM +0100, Sven Eckelmann wrote:
> Hi,
> 
> it seems that the coccinelle package in Debian Jessie is not able to parse
> semantic patches [1]. This basically breaks the batman-adv build on many
> stable systems and thus makes the out-of-tree module unusable on these
> systems.

Urgh, what a shame :-(

> 
> I have currently no better idea than reverting these patches.
> 
> Kind regards,
> 	Sven
> 
> PS: Linus, do you want to try to get rid of replacement.sh?

Have only looked at the one const case so far, but can have a look at
the others too, sure.
