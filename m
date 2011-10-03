Return-Path: <ordex@autistici.org>
Date: Tue, 4 Oct 2011 01:16:23 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20111003231622.GB13562@ritirata.org>
References: <1316858526-6963-1-git-send-email-lindner_marek@yahoo.de>
	<1317418754-31223-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1317418754-31223-1-git-send-email-lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: refactoring gateway
 handling code
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

On Fri, Sep 30, 2011 at 11:39:14 +0200, Marek Lindner wrote:
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> ---
>  Fixed the open TODO from v1 with Antonio's help.


I just finished to test the patch in a simple scenario and everything went fine.
Therefore I can say:

Acked-by: Antonio Quartulli <ordex@autistici.org>

Test explained:
---------------

CLIENT |----> NODE_A <----> NODE_B

Node B is the only GW at the beginning, CLIENT issues a DHCP request which is
correctly forwarded to NODE_B that correctly replies. Then the link between A
and B falls down.
In the meanwhile NODE_A becomes a GW and later the link comes up again causing a
TQ decrease in both directions (nodes will detect a gap in the orig seqno).
The lease time expires for CLIENT (it was set
to 120secs) and a DHCP RENEWAL is issued but NODE_A will drop it as there is a
better GW (NODE_A) than the old one (NODE_B). Gw propagation rulez!


Cheers,

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
