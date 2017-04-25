Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 25 Apr 2017 02:53:27 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20170425005327.GA18045@otheros>
References: <20170205064550.30262-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170205064550.30262-1-linus.luessing@c0d3.blue>
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 0/4] Broadcast Avoidances,
 Neighborhood Hash
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

On Sun, Feb 05, 2017 at 07:45:46AM +0100, Linus Lüssing wrote:
> Known limitations: Avoidance potential is not fully detected in a setup with
> a mix of 100MBit/s and 1000MBit/s capable, wired nodes.

I'm currently a little annoyed that I did not anticipate this
limitation before implementing this approach.

So I'm currently thinking about scratching this approach for now
(and maybe go for a different one, after RIP was implemented)...


I guess it makes sense to postpone this one for further
discussions at the next Battlemesh :/.

Cheers, Linus
