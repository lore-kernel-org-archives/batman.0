Return-Path: <linus.luessing@c0d3.blue>
Date: Thu, 16 Feb 2017 07:56:13 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20170216065613.GB24635@otheros>
References: <lsq.1487198490.691915840@decadent.org.uk>
 <lsq.1487198494.509932883@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <lsq.1487198494.509932883@decadent.org.uk>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3.2 049/126] batman-adv: fix splat on
 disabling an interface
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, akpm@linux-foundation.org

On Wed, Feb 15, 2017 at 10:41:34PM +0000, Ben Hutchings wrote:
> 3.2.85-rc1 review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Linus Lüssing <linus.luessing@c0d3.blue>
> 
> commit 9799c50372b23ed774791bdb87d700f1286ee8a9 upstream.

Hi Ben,

This commit was reverted in
27915aa61060fd8954a68a86657784705955088a
('batman-adv: Revert "fix splat on disabling an interface"').

Greg dropped this patch from his stable queue back then, too [0].

Regards, Linus

[0]: https://marc.info/?l=linux-kernel&m=147938417410032
