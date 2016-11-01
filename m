Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 1 Nov 2016 08:12:57 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20161101071257.GE3264@otheros>
References: <20161101061750.15995-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20161101061750.15995-1-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Deactivate __ro_after_init
 for kernels < 4.10
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

On Tue, Nov 01, 2016 at 07:17:50AM +0100, Sven Eckelmann wrote:
> The pre-4.10 kernels must write to batadv_netlink_family after the family
> was registered. Thus disabling __ro_after_init for now is required on these
> kernels.
> 
> Fixes: c776b4a071d8 ("batman-adv: genetlink: mark families as __ro_after_init")
> Reported-by: Linus Lüssing <linus.luessing@c0d3.blue>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---

That seems to work, thanks! :)

Tested-by: Linus Lüssing <linus.luessing@c0d3.blue>
