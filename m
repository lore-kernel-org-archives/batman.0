Return-Path: <ordex@autistici.org>
Date: Sun, 23 Oct 2011 11:38:03 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20111023093802.GA6828@ritirata.org>
References: <20111019082826.GA31323@pandem0nium>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20111019082826.GA31323@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: add sanity check when
 removing global tts
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hello,

On Wed, Oct 19, 2011 at 10:28:26AM +0200, Simon Wunderlich wrote:
> After removing the batman-adv module, the hash may be already gone
> when tt_global_del_orig() tries to clean the hash. This patch adds
> a sanity check to avoid this.
> 
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> ---

I got a feedback on IRC from fishor_ who said that the patch solved the kernel
panic problem on module unload and on soft_iface deactivating.

Thank you for the patch Simon!


-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
