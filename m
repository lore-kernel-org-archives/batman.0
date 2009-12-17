Return-Path: <andrew@lunn.ch>
Date: Thu, 17 Dec 2009 13:25:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20091217122544.GM4648@lunn.ch>
References: <1261051915-13960-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1261051915-13960-1-git-send-email-sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Use forw_bcast_list_lock
 always in disabled interrupt context
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

Hi Sven

This reminds me of something i keep intending to do, but never get
around to.

It would be nice to have a LOCKING.TXT document, with the following
Table of Contents.

1) What locks we have and what they protect.

2) What different contexts different parts of the code run in.

These two sections provide the basis for the following sections.

3) Which locking primitives, ie spin_lock() or spin_lock_irqsave()
should be used for each lock.

4) A list of what order locks should be taken in, when taking multiple
locks, so as to avoid deadlocks.

When finding this bug, did you take any notes etc, which could
contribute to such a document?

	   Thanks
		Andrew
