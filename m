Return-Path: <davem@davemloft.net>
Date: Tue, 09 Jun 2015 20:24:23 -0700 (PDT)
Message-Id: <20150609.202423.333671059701531273.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1433847020-1427-1-git-send-email-antonio@meshcoding.com>
References: <1433847020-1427-1-git-send-email-antonio@meshcoding.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 20150609
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Date: Tue,  9 Jun 2015 12:50:13 +0200

> this is our last batch of patches intended for net-next.
> 
> You have 4 patches from Sven Eckelmann, most notably: 1/7 changes
> our hash implementation to use the Jenkins one provided by the kernel;
> 4/7 reorganizes the way we include headers so that each .c file has
> all it requires without relying on any fancy including order.
> 
> Then there are three patches from me: 2/7 is slightly changing the
> macros we use to handle sysfs files to make them more flexible for
> future uses; 3/7 is extending the "routing protocol API" so that new
> implementations can have more control over
> the neigh_node internal structures; 7/7 ensures that all the per-VLAN
> internal structures are updated when the MAC address is changed by the
> user.
> 
> Please pull if everything is fine!

Pulled, thanks Antonio.
