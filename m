Return-Path: <davem@davemloft.net>
Date: Wed, 16 Dec 2015 11:10:22 -0500 (EST)
Message-Id: <20151216.111022.886656501693915984.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1450252173-20949-1-git-send-email-antonio@meshcoding.com>
References: <1450252173-20949-1-git-send-email-antonio@meshcoding.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 20151216
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: antonio@meshcoding.com
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed, 16 Dec 2015 15:49:21 +0800

> here you have our batch of patches intended for net-next.
> 
> Marek Lindner is introducing a list of direct neighbours per interface
> and is exporting it via debugfs. This comes very handy in case of
> network debugging or simple topology analysis.
> 
> Add lock protection for CRC computation in the Bridge Loop Avoidance
> code to prevent racy updates, by Simon Wunderlich.
> 
> Update my email address in the relevant files.
> 
> Other than those changes you also have some code restyling, cleanups
> and minor fixes..
> 
> Please pull or let me know of any problem!

Pulled, thanks Antonio.
