Return-Path: <davem@davemloft.net>
Date: Tue, 18 Feb 2014 13:22:21 -0500 (EST)
Message-Id: <20140218.132221.1485466625541655137.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <53030165.2050404@meshcoding.com>
References: <1392670129-2498-2-git-send-email-antonio@meshcoding.com>
 <20140217.161314.741869447870850076.davem@davemloft.net>
 <53030165.2050404@meshcoding.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 01/10] batman-adv: fix soft-interface MTU
 computation
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, mareklindner@neomailbox.ch

From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 18 Feb 2014 07:44:53 +0100

> Unfortunately this is not the only "fake-atomic" variable we have.

:-(

> We'll send a change for this later within our pull request for net-next, ok?

Fair enough.
