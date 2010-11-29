Return-Path: <greg@kroah.com>
Date: Mon, 29 Nov 2010 10:55:31 -0800
From: Greg KH <greg@kroah.com>
Message-ID: <20101129185531.GA32202@kroah.com>
References: <201011221129.06220.sven.eckelmann@gmx.de>
	<1290425690-5119-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1290425690-5119-1-git-send-email-sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Staging: batman-adv for 2.6.37 (6)
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
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Mon, Nov 22, 2010 at 12:34:47PM +0100, Sven Eckelmann wrote:
> 
> Hi,
> 
> I would like to propose following two patches which were already send to you
> for 2.6.38 also for 2.6.37. These should be unchanged and you are free to
> decide how you want to apply those to get them in both kernel version.
> 
> [PATCH 1/2] Staging: batman-adv: ensure that eth_type_trans gets linear memory
> [PATCH 2/2] Staging: batman-adv: Don't remove interface with spinlock held

I've applied these to the .37 branch to go to Linus later this week.

> Following patch (backported version of patch 1/2) would be a candidate for
> 2.6.36 to fix a kernel Oops on Intel 3945ABG and Intel Corporation PRO/Wireless
> 4965 AG or AGN.
> 
> [PATCH-stable] Staging: batman-adv: ensure that eth_type_trans gets linear memory

Thanks, I'll save that for when these patches get into Linus's tree.

greg k-h
