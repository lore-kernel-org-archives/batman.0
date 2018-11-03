Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 03 Nov 2018 13:51:20 +0100
Message-ID: <1939071.oNHTCgFBiP@sven-desktop>
In-Reply-To: <20181025162245.19389-1-sven@narfation.org>
References: <20181025162245.19389-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 00/42] batctl: pre-netlink
 restructuring, part 1
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

On Donnerstag, 25. Oktober 2018 18:22:03 CET Sven Eckelmann wrote:
> the batctl command already has support to get (previously debugfs) tables
> via netlink. It does this while still being able to fall back to the old
> debugfs tables on kernels which don't support the new generic netlink
> family.
> 
> Something similar should be done in the future for the settings which
> are currently part of sysfs. But we can already see that the current
> integration of netlink in batctl only done in a single file - netlink.c
> But this file is already starting to be so big that working with it
> is rather cumbersome.
> 
> So as first steps:
> 
> * restructure command registration
> * move commands in separate files (which should store their actual implementation)
> * add a new helper command to receive multicast group messages from the kernel

Added as 0a201c2..2f5dbd0 [1]

Kind regards,
	Sven

[1] https://git.open-mesh.org/batctl.git/log/2f5dbd056b8be344b5492835b0924f6cf463ba4d



