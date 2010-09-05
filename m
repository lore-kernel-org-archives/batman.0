Return-Path: <greg@kroah.com>
Date: Sun, 5 Sep 2010 00:33:00 -0700
From: Greg KH <greg@kroah.com>
Message-ID: <20100905073300.GA15860@kroah.com>
References: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Staging: batman-adv for 2.6.37 (1)
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
Cc: b.a.t.m.a.n@lists.open-mesh.net

On Sun, Sep 05, 2010 at 01:58:17AM +0200, Sven Eckelmann wrote:
> Hi,
> 
> I hope that the fever-induced dreams are over now. Otherwise I will try to
> write my mails also as little tales. ;)
> 
> Nevertheless, I would like to send some patches for 2.6.37. That is not
> 100% true. We would also like to see the revert
> 'Revert: "Staging: batman-adv: Adding netfilter-bridge hooks"' too in 2.6.36.
> It fixes a bug introduced by the commit we revert here.

Ok, I've applied this to both trees to make everything work properly.

> The rest is more or less the usual stuff, but more feature patches this time.
> All patches we depend on are already part of 2.6.36-rc3.

All queued up now, thanks.

greg k-h
