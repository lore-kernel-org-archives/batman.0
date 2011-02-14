Return-Path: <linus.luessing@web.de>
Date: Mon, 14 Feb 2011 14:36:15 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20110214133615.GA11244@Sellars>
References: <1297550891-18231-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1297550891-18231-1-git-send-email-linus.luessing@ascom.ch>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix possible buffer overflow
 in softif neigh list output
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

On Sat, Feb 12, 2011 at 11:48:11PM +0100, Linus Lüssing wrote:
> For another, only 30 Bytes per soft interface neighbor are allocated,
> but up to 31 Bytes get copied into the buffer which leads to a buffer
> overflow again if the vid needs more than one digit.
Argh, just noticed I had the snprintf() wrong in my mind, I forgot
that the count is including the \0 character.

Will correct the wording of that patch.

Cheers, Linus
